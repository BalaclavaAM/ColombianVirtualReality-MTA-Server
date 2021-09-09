function setPlayerFreecamEnabled(player, x, y, z, dontChangeFixedMode)
	return triggerClientEvent(player,"doSetFreecamEnabled", getRootElement(), x, y, z, dontChangeFixedMode)
end

function setPlayerFreecamDisabled(player, dontChangeFixedMode)
	return triggerClientEvent(player,"doSetFreecamDisabled", getRootElement(), dontChangeFixedMode)
end

function setPlayerFreecamOption(player, theOption, value)
	return triggerClientEvent(player,"doSetFreecamOption", getRootElement(), theOption, value)
end

function isPlayerFreecamEnabled(player)
	return getElementData(player,"freecam:state")
end

function enableFreecam (player) 
	local cuenta = getPlayerAccount(player)
	local accName = getAccountName(cuenta) 
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Productores" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 4" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 3" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 2" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 1" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 0" )) then
		if (not isPlayerFreecamEnabled (player)) then 
			local x, y, z = getElementPosition (player) 
			setPlayerFreecamEnabled (player, x, y, z) 
		else 
			setPlayerFreecamDisabled (player) 
		end
	end 
end 
addCommandHandler ('freecam', enableFreecam) 