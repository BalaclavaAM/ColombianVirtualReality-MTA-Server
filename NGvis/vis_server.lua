-- Vehicle Interaction System v2 by Sam@ke --

--[[
addEventHandler("onResourceStart", resourceRoot, function()
	outputChatBox("(VIS) Vehicle Interaction System was started.", root, 255, 220, 90, true)
end)


addEventHandler("onResourceStop", resourceRoot, function()
	outputChatBox("(VIS) Vehicle Interaction System was stopped.", root, 255, 90, 45, true)
end)
]]

function doServerInteractions(door)
	if (source) and (door) then
		local lookAtVehicle = source:getTarget()
		
		if (lookAtVehicle) and (lookAtVehicle:getType() == "vehicle" ) then
			local doorRatio = lookAtVehicle:getDoorOpenRatio(door)
			local doorStateS = lookAtVehicle:getData(tostring(door), true)
			
			if (not doorStateS) then
				lookAtVehicle:setData(door, "closed", true)
			end
			
			interactWith(source, lookAtVehicle, door)    
		end
	end
end
addEvent("onInteractVehicleDoor", true)
addEventHandler("onInteractVehicleDoor", root, doServerInteractions)


function interactWith(source, vehicle, door)
	if (source) and (vehicle) and (door) then
		if (isElement(source)) and (isElement(vehicle)) then
			 source:setAnimation("Ped", "CAR_open_LHS", 300, false, false, true, false)
			 
			local doorRatio = vehicle:getDoorOpenRatio(door)
			local canInterActWith = vehicle:getData(tostring(door) .. "INTERACT")
			local pos = vehicle:getPosition()

			if (doorRatio <= 0) then
				doorState = "closed"
			elseif (doorRatio > 0) then
				doorState = "open"
			end
			
			if (not canInterActWith) then canInterActWith = "true" end
			
			if (canInterActWith == "true") then
				canInterActWith = "false"
				vehicle:setData(tostring(door) .. "INTERACT", canInterActWith)
				
				if (doorState == "closed") then
					triggerClientEvent(root, "onDoorOpened", root, pos.x, pos.y, pos.z)
					
					setTimer(function()
						canInterActWith = "false"
						
						if (doorRatio <= 1) then
							doorRatio = doorRatio + 0.2
							if (doorRatio >= 1) then
								doorRatio = 1
								vehicle:setData(door, "open", true)
								triggerOpenEvents(source, door)
								canInterActWith = "true"
								vehicle:setData(tostring(door) .. "INTERACT", canInterActWith)
							end
						end
						vehicle:setData(door, "closed", true)
						vehicle:setDoorOpenRatio(door, doorRatio)        
					end, 50, 6)
					
				elseif (doorState == "open") then
					setTimer(function()
						canInterActWith = "false"
						
						if (doorRatio > 0) then
							doorRatio = doorRatio - 0.2
							
							if (doorRatio <= 0) then
								doorRatio = 0
								vehicle:setData(door, "closed", true)
								triggerCloseEvents(source, door)
								canInterActWith = "true"
								vehicle:setData(tostring(door) .. "INTERACT", canInterActWith)
							end                
						end
						vehicle:setData(door, "open", true)
						vehicle:setDoorOpenRatio(door, doorRatio)
					end, 50, 6)
				end
			end
		end
	end
end


function triggerOpenEvents(source, door)
    -- 0 (hood), 1 (trunk), 2 (front left), 3 (front right), 4 (rear left), 5 (rear right)
    if (source) and (door) then   
        if (door == 0) then
            triggerClientEvent(source, "onHoodOpened", root)
        elseif (door == 1) then
            triggerClientEvent(source, "onTrunkOpened", root)
        elseif (door == 2) then
            triggerClientEvent(source, "onLeftFrontDoorOpened", root)
        elseif (door == 3) then
            triggerClientEvent(source, "onRightFrontDoorOpened", root)
        elseif (door == 4) then
            triggerClientEvent(source, "onLeftRearDoorOpened", root)
        elseif (door == 5) then
            triggerClientEvent(source, "onRightRearDoorOpened", root)  			
        end
    end
end


function triggerCloseEvents(source, door)
    -- 0 (hood), 1 (trunk), 2 (front left), 3 (front right), 4 (rear left), 5 (rear right)
    if (source) and (door) then
        local pos = source:getPosition()
        
        if (door == 0) then
            triggerClientEvent(source, "onHoodClosed", root)
            triggerClientEvent(root, "onDoorClosed", root, pos.x, pos.y, pos.z)
        elseif (door == 1) then
            triggerClientEvent(source, "onTrunkClosed", root)
            triggerClientEvent(root, "onDoorClosed", root, pos.x, pos.y, pos.z)
        elseif (door == 2) then
            triggerClientEvent(source, "onLeftFrontDoorClosed", root)
            triggerClientEvent(root, "onDoorClosed", root, pos.x, pos.y, pos.z)
        elseif (door == 3) then
            triggerClientEvent(source, "onRightFrontDoorClosed", root)
            triggerClientEvent(root, "onDoorClosed", root, pos.x, pos.y, pos.z)
        elseif (door == 4) then
            triggerClientEvent(source, "onLeftRearDoorClosed", root)
            triggerClientEvent(root, "onDoorClosed", root, pos.x, pos.y, pos.z)
        elseif (door == 5) then
            triggerClientEvent(source, "onRightRearDoorClosed", root)
            triggerClientEvent(root, "onDoorClosed", root, pos.x, pos.y, pos.z)            
        end
    end
end