function ghostmode_on()
	local v = getPedOccupiedVehicle(localPlayer)
	for index,vehicle in ipairs(getElementsByType("vehicle")) do 
		setElementCollidableWith(vehicle, v, false)
	end
	outputChatBox("Buena pa, ahora no se puede chocar con nadie",thePlayer)
end
addCommandHandler("ghostmode", ghostmode_on)
