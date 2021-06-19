local vehiclesWithPaintjob = {}

addCommandHandler("pj", function(command, id)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	
	if vehicle then
		if id and tonumber(id) then
			if getAvailablePaintjobs(getElementModel(vehicle))[tonumber(id)] or tonumber(id) == 0 then
				triggerServerEvent("paintjob->Manage", localPlayer, vehicle, tonumber(id)) -- add paintjob, when id is 0 => remove paintjob
				setElementData(vehicle, "vehicle.paintjob", tonumber(id))
			else
				outputChatBox("#d75959[Paintjob]: #ffffffThis paintjob doesn't exists!", 255, 255, 255, true)
			end
		else
			triggerServerEvent("paintjob->Manage", localPlayer, vehicle, 0) -- remove paintjob
			setElementData(vehicle, "vehicle.paintjob", 0)
		end
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, vehicle in ipairs(getElementsByType("vehicle", root, true)) do
		local isVehicleHavePaintjob = getElementData(vehicle, "vehicle.paintjob") or 0
		
		if isVehicleHavePaintjob ~= 0 then
			addVehiclePaintjob(vehicle, isVehicleHavePaintjob)
		end
	end
end)

addEvent("paintjob->TryToAddToVehicle", true)
addEventHandler("paintjob->TryToAddToVehicle", root, function(vehicle, paintjobID)
	if vehicle then
		if paintjobID and paintjobID ~= 0 then
			addVehiclePaintjob(vehicle, paintjobID)
		else
			removeVehiclePaintjob(vehicle)
		end
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
		local isVehicleHavePaintjob = getElementData(source, "vehicle.paintjob") or 0
		
		if isVehicleHavePaintjob ~= 0 then
			addVehiclePaintjob(source, isVehicleHavePaintjob)
		end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
		local isVehicleHavePaintjob = getElementData(source, "vehicle.paintjob") or 0
		
		if isVehicleHavePaintjob ~= 0 then
			removeVehiclePaintjob(source)
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		local isVehicleHavePaintjob = getElementData(source, "vehicle.paintjob") or 0
		
		if isVehicleHavePaintjob ~= 0 then
			removeVehiclePaintjob(source)
		end
	end
end)

function addVehiclePaintjob(vehicle, paintjobID)
	if vehicle and paintjobID then
		local availablePaintjobs = getAvailablePaintjobs(getElementModel(vehicle))
		
		if availablePaintjobs[paintjobID] then
			removeVehiclePaintjob(vehicle)
			
			vehiclesWithPaintjob[vehicle] = {}
			vehiclesWithPaintjob[vehicle][1] = dxCreateShader("files/textureChanger.fx", 0, 100, false, "vehicle")
			vehiclesWithPaintjob[vehicle][2] = dxCreateTexture("files/paintjobs/" .. availablePaintjobs[paintjobID][2])
			
			if vehiclesWithPaintjob[vehicle][1] and vehiclesWithPaintjob[vehicle][2] then
				dxSetShaderValue(vehiclesWithPaintjob[vehicle][1], "TEXTURE", vehiclesWithPaintjob[vehicle][2])
				engineApplyShaderToWorldTexture(vehiclesWithPaintjob[vehicle][1], availablePaintjobs[paintjobID][1], vehicle)
			else
				outputDebugString("[PAINTJOB]: Shader or Texture create failed!", 3)
			end
		end
	end
end

function removeVehiclePaintjob(vehicle)
	if vehicle then
		if vehiclesWithPaintjob[vehicle] then
			destroyElement(vehiclesWithPaintjob[vehicle][1])
			destroyElement(vehiclesWithPaintjob[vehicle][2])
			vehiclesWithPaintjob[vehicle] = nil
		end
	end
end