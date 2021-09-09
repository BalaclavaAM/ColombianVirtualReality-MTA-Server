addEventHandler ( "onClientPlayerDamage", root, function ( att, weap, loss )
	if ( isElement ( att ) and weap and att == localPlayer and source ~= localPlayer ) then
		local job = tostring ( getElementData ( att, "Job" ) or "" )
		if ( job == "Medic" and weap == 42 ) then
			cancelEvent ( )
			setElementHealth ( source, getElementHealth ( source ) + loss )

			triggerServerEvent ( "NGJobs:Medic.onPlayerHealPlayer", localPlayer, source, att )
		end
	end
end )
function cancelTearGasChoking(weaponID)
	if (weaponID==42) or (weaponID==41) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerChoke", getLocalPlayer(), cancelTearGasChoking)

function stopExtintorDamage ( attacker, weapon, bodypart )
	if ( weapon == 42 ) or ( weapon == 41 ) then 
		cancelEvent() 
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopExtintorDamage )