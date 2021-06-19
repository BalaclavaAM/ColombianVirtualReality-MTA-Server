addEvent("paintjob->Manage", true)
addEventHandler("paintjob->Manage", root, function(vehicle, paintjobID)
	if vehicle and paintjobID then
		triggerClientEvent(root, "paintjob->TryToAddToVehicle", root, vehicle, paintjobID)
	end
end)