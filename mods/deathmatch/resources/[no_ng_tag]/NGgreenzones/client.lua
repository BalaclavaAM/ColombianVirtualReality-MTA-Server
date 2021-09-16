-- Protect greenzone'd players from getting attacked etcetera
function onDamage()
	if getElementData(source, "greenzone") then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, onDamage)

-- Prevent people from being knifed while in greenzone
function onStealthKill(target)
	if getElementData(target, "greenzone") then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerStealthKill", localPlayer, onStealthKill)

-- Render the "Greenzone protected" text above their heads
function renderGreenzoneTag()
	local streamedPlayers = getElementsByType("player", root, true)
	if streamedPlayers and #streamedPlayers ~= 0 then
		local lpos = {getElementPosition(localPlayer)}
		for _, p in ipairs(streamedPlayers) do
			if p and isElement(p) then
				if getElementData(p, "greenzone") then
					local ppos = {getElementPosition(p)}
					if getDistanceBetweenPoints3D(lpos[1], lpos[2], lpos[3], ppos[1], ppos[2], ppos[3]) <= 20 then
						local x, y = getScreenFromWorldPosition(ppos[1], ppos[2], ppos[3] + 1.2)
						if x and y then
							dxDrawText("Protegido por la zona verde", x + 1, y + 1, x, y, tocolor(0, 0, 0), 0.5, "bankgothic", "center")
							dxDrawText("Protegido por la zona verde", x, y, x, y, tocolor(0, 220, 0), 0.5, "bankgothic", "center")
						end
					end
				end
			end
		end
	end
end
--addEventHandler("onClientRender", root, renderGreenzoneTag)

-- The next 4 functions are for ghostmode (vehicles ramming greenzone'd players on foot, lifting them off, etcetera)
-- This protection is important; they usually try to forklift you out of greenzone, spawn a vehicle on you and catch you inside/annoy-ram you, then TP off to a clear zone to kill you, etcetera.
function onStreamIn()
	if not getElementData(localPlayer, "greenzone") then
		return
	end
	if getElementType(source) == "vehicle" then
		setElementCollidableWith(localPlayer, source, false)
	end
end
addEventHandler("onClientElementStreamIn", root, onStreamIn)

--Drift Function
function onStreamInDrift()
	if not getElementData(localPlayer, "redzone") then
		return
	end
	local car = getPedOccupiedVehicle(localPlayer)
	if getElementType(source) == "vehicle" and car and isElementCollidableWith(car, source) == true then
		setElementCollidableWith(car, source, false)
	end
end
addEventHandler("onClientElementStreamIn", root, onStreamInDrift)
-- end

function cleanUp()
	if not getElementData(source, "greenzoneveh") then
		return
	end
	if getElementType(source) == "vehicle" and isElementCollidableWith(localPlayer, source) == false then
		setElementCollidableWith(localPlayer, source, true)
	end
end
addEventHandler("onClientElementStreamOut", resourceRoot, cleanUp)
--DriftFunction
function cleanUpDrift()
	if not getElementData(source, "redzoneveh") then
		return
	end
	local car = getPedOccupiedVehicle(localPlayer)
	if getElementType(source) == "vehicle" and car and isElementCollidableWith(car, source) == false then
		setElementCollidableWith(car, source, true)
	end
end
addEventHandler("onClientElementStreamOut", resourceRoot, cleanUpDrift)
--end
function enterGreenzone()
	local x, y, z = getElementPosition(localPlayer)
	local nearbyVehicles = getElementsWithinRange(x, y, z, 300, "vehicle")

	for i, v in ipairs(nearbyVehicles) do
		setElementCollidableWith(localPlayer, v, false)
	end
end
addEvent("onEnterGreenzone", true)
addEventHandler("onEnterGreenzone", localPlayer, enterGreenzone)

function leaveGreenzone(p)
	local x, y, z = getElementPosition(localPlayer)
	local nearbyVehicles = getElementsWithinRange(x, y, z, 300, "vehicle")

	for i, v in ipairs(nearbyVehicles) do
		setElementCollidableWith(localPlayer, v, true)
	end
end
addEvent("onLeaveGreenzone", true)
addEventHandler("onLeaveGreenzone", localPlayer, leaveGreenzone)

function godCar()
	if getElementData(source,"greenzoneveh") then
		cancelEvent()
	end
end
addEventHandler("onClientVehicleDamage",root,godCar)
-- This 'bug' is not expected to happen without some sort of interference, but is a generic safeguard.
-- If player exits the greenzone after incidentally having the bugfix applied to them, all controls will be automatically re-enabled anyways (that mechanism is in serverside).
function antiGreenzoneBug()
	if getElementData(localPlayer, "greenzone") then
		toggleControl("fire", false)
		toggleControl("action", false)
		toggleControl("aim_weapon", false)
		toggleControl("vehicle_fire", false)
		toggleControl("vehicle_secondary_fire", false)
	end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, antiGreenzoneBug)

function antiColision(v)
	if isElement(v) then
		local vehicles = getElementsByType ( "vehicle" )
		for theKey,vehicle in ipairs(vehicles) do
			if getElementData(vehicle,"redzoneveh") then
				setElementCollidableWith(v,vehicle,false)
			end
		end
	end
end
addEvent("onVehicleEnterRedzone", true)
addEventHandler("onVehicleEnterRedzone", localPlayer, antiColision)

function disableAntiColision(v)
	if isElement(v) then
		local vehicles = getElementsByType ( "vehicle" )
		for theKey,vehicle in ipairs(vehicles) do
			if getElementData(vehicle,"redzoneveh") then
				setElementCollidableWith(v,vehicle,true)
			end
		end
	end
end
addEvent("onVehicleExitRedzone", true)
addEventHandler("onVehicleExitRedzone", localPlayer, disableAntiColision)


function enterRedzone()
	setCameraClip ( true,false ) 
end
addEvent("onEnterRedzone", true)
addEventHandler("onEnterRedzone", localPlayer, enterRedzone)


function exitRedzone()
	setCameraClip ( false,false ) 
end
addEvent("onExitRedzone", true)
addEventHandler("onExitRedzone", localPlayer, exitRedzone)

function getElementSpeed(theElement, unit)
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
end

function setElementSpeed(element, unit, speed)
    local unit    = unit or 0
    local speed   = tonumber(speed) or 0
	local acSpeed = getElementSpeed(element, unit)
	if acSpeed and acSpeed~=0 then -- if true - element is valid, no need to check again
		local diff = speed/acSpeed
		if diff ~= diff then return false end -- if the number is a 'NaN' return false.
        	local x, y, z = getElementVelocity(element)
		return setElementVelocity(element, x*diff, y*diff, z*diff)
	end
	return false
end

function calcularCoordsCercanas(zona,x,y,z)
	local nx,ny = x,y
	local iteraciones=0
	while (getDistanceBetweenPoints2D(nx,ny,x,y)<6.0 or isInsideColShape(zona,nx,ny,z)) do
		local xd=math.random(0,1)
		if xd==0 then
			nx=x+math.random(-5,5)
		else
			ny=y+math.random(-5,5)
		end
		iteraciones=iteraciones+1
	end
	if getPedOccupiedVehicle(localPlayer) then
		setElementPosition(getPedOccupiedVehicle(localPlayer),nx,ny,z)
		setElementSpeed(getPedOccupiedVehicle(localPlayer),0)
	else
		setElementPosition(localPlayer,nx,ny,z)
	end
end
addEvent("NGgreenzones->CalcularCoords",true)
addEventHandler("NGgreenzones->CalcularCoords",root,calcularCoordsCercanas)


