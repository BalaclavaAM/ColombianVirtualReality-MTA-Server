--[[
    This file handles loading and setting of data to speed challenges when resource is started.
]]--

local cooldown_minutes = 0 -- Players can only do challenge once per 5 minutes by default.

addEventHandler("onResourceStart", resourceRoot, function() 
  -- Create SQL table if we don't have one yet (e.g. the first time we run the script on a fresh server.)
  executeSQLQuery("CREATE TABLE IF NOT EXISTS `bib_speedchallenges` (`topscore_player` TEXT, `topscore_speed` TEXT, `coordinates` TEXT)")
  -- Loop through the locations found in data.lua
  for i,loc in ipairs(locations_map) do 
    local x,y,z = unpack(loc,1,4)
    local coordinates = table.concat({x,y,z},',')
    local colshape = createColSphere(x,y,z-1,5)

    -- Let's check if we have a top score set for recently created location.
    local query = executeSQLQuery("SELECT `topscore_player`,`topscore_speed` FROM `bib_speedchallenges` WHERE `coordinates`=?", coordinates)
    if (#query == 0) then
      setElementData(colshape, 'bib_speedchallenges.topscore_player', '-')
      setElementData(colshape, 'bib_speedchallenges.topscore_speed', 70)
      setElementData(colshape, 'bib_speedchallenges.coordinates', coordinates)
      executeSQLQuery("INSERT INTO `bib_speedchallenges` (`topscore_player`,`topscore_speed`,`coordinates`) VALUES(?,?,?)", '-', '70', coordinates)
    else
      setElementData(colshape, 'bib_speedchallenges.topscore_player', query[1].topscore_player)
      setElementData(colshape, 'bib_speedchallenges.topscore_speed', tonumber(query[1].topscore_speed))
      setElementData(colshape, 'bib_speedchallenges.coordinates', coordinates)
    end
    
    addEventHandler("onColShapeHit", colshape, function(element, dimension)
      if not dimension then return false end
      if getElementType(element) == "vehicle" then
        local vehicle_driver = getVehicleOccupants(element)[0] or nil
        if not vehicle_driver then return end 

        local driver_cooldown = getElementData(vehicle_driver, 'bib_speedchallenges.cooldown') or 0
        if driver_cooldown ~= nil and driver_cooldown > 0 then
          outputChatBox("Espera " .. driver_cooldown .. ' minutos para completar otra trampa de velocidad.', vehicle_driver)
          return
        end
        if getElementSpeed(element, 'mph') == nil then return end
        local vehicle_speed = math.floor(getElementSpeed(element, 'mph'))
        local required_speed = getElementData(source, 'bib_speedchallenges.topscore_speed') or 70
        local minimum_speed = math.floor(required_speed * 0.9)


        -- Setting up a new highscore
        if vehicle_speed > required_speed then
          local driver_name = string.gsub(getPlayerName(vehicle_driver), "#%x%x%x%x%x%x", "")
          setElementData(source, 'bib_speedchallenges.topscore_speed', vehicle_speed)
          setElementData(source, 'bib_speedchallenges.topscore_player', driver_name)
          outputChatBox('Nuevo record de ' .. vehicle_speed .. 'mph!', vehicle_driver)
          local dinero = vehicle_speed*150
          exports['NGMessages']:sendClientMessage ("#81F7F3El drifter #5882FA"..getPlayerName(vehicle_driver).." #81F7F3venció un record de velocidad a #5882FA " ..vehicle_speed.."mph #81F7F3ganando así!#5882FA "..dinero.."$",root,255,0,0)
          givePlayerMoney(vehicle_driver, vehicle_speed*150)
          local wp = getElementData(vehicle_driver,"WantedPoints")
          setElementData ( vehicle_driver, "WantedPoints", wp+300 )

          local coordinates = getElementData(source, 'bib_speedchallenges.coordinates')
          executeSQLQuery("UPDATE `bib_speedchallenges` SET `topscore_player`=?,`topscore_speed`=? WHERE `coordinates`=?", driver_name, vehicle_speed, coordinates)
          
        -- Almost passing the highscore gets you a reward
        elseif vehicle_speed >= minimum_speed then
          givePlayerMoney(vehicle_driver, vehicle_speed*40)
          local wp = getElementData(vehicle_driver,"WantedPoints")
          setElementData ( vehicle_driver, "WantedPoints", wp+300 )

          outputChatBox('Superaste el record de velocidad por ' .. vehicle_speed .. 'mph!', vehicle_driver)
        else
          outputChatBox('Muy lento! Tu velocidad fue solo de ' .. vehicle_speed .. 'mph ', vehicle_driver)
        end
        
        -- We set cooldown only if driver passed highscore or gained reward
        if vehicle_speed >= minimum_speed then
          setElementData(vehicle_driver, 'bib_speedchallenges.cooldown', cooldown_minutes)
          setTimer(function(plr)
            local current_time = getElementData(plr, 'bib_speedchallenges.cooldown') or 0
            local new_time = current_time - 1
            if new_time == 0 then removeElementData(plr, 'bib_speedchallenges.cooldown') end
          end, 60000, cooldown_minutes, vehicle_driver)
        end
        
      end
    end)
  end
end)

--[[ Utility function from https://wiki.multitheftauto.com/wiki/GetElementSpeed ]]--
function getElementSpeed(theElement, unit)
  local vehicle_driver = getVehicleOccupants(theElement)[0] or nil
  if getElementData(vehicle_driver,"Job") == "Drifter" then 
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
  else
    exports['NGMessages']:sendClientMessage ("Tienes que ser del trabajo DRIFTER para obtener dinero con esta trampa de velocidad",vehicle_driver,255,0,0)
  end
end