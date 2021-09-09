addEventHandler ( 'onClientPlayerDamage', root, function ( attacker )
	if ( isElement ( source, attacker ) and getElementType(source)=="player" ) then
		if (getElementData ( source, "isPassive" ) or getTeamName(getPlayerTeam(source))=="Services") then
            cancelEvent()
        end
        if (attacker) and isElement(attacker) and getElementType(attacker)=="player" then
            if (getElementData(attacker, "isPassive")) or (getTeamName(getPlayerTeam(attacker))=="Services") then
                cancelEvent()
            end
        end
	end
end )


function nodamage(theAttacker)
	if(theAttacker and isElement(theAttacker) and getElementType(theAttacker)=="player") then
        if getElementData(theAttacker,"isPassive") or getTeamName(getPlayerTeam(theAttacker))=="Services" then
            cancelEvent()
        end
    end
    if (getVehicleOccupant(source,0)) then
        if getElementData(getVehicleOccupant(source,0),"isPassive") or getTeamName(getPlayerTeam(getVehicleOccupant(source,0)))=="Services" then
            cancelEvent()
        end
    end
end
addEventHandler("onClientVehicleDamage", getRootElement(), nodamage)

function activarmodo()
    triggerServerEvent("makeItToServer4", resourceRoot, localPlayer)
end