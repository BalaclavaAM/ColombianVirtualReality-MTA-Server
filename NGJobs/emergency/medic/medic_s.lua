medTimers = {}

addEvent ( "NGJobs:Medic.onPlayerHealPlayer", true )
addEventHandler ( "NGJobs:Medic.onPlayerHealPlayer", root, function ( client, medic ) 
	if ( getElementHealth ( client ) >= 95 ) then
		setElementHealth ( client, 100 )
		return exports['NGMessages']:sendClientMessage ( "This player doesn't need healing.", medic, 255, 0, 0 )
	end
	if ( getElementHealth ( client ) < 100 ) then
		setElementHealth ( client, getElementHealth ( client ) + 10 )
		if ( getElementHealth ( client ) >= 100 ) then
			setElementHealth ( client, 100 )
			if getElementData(client, "cured") ~= medic then  
				givePlayerMoney ( medic, 8000 )
				setElementData(client,"cured",medic)
			end
			updateJobColumn ( getAccountName ( getPlayerAccount ( medic ) ), "HealedPlayers", "AddOne" )
			if not isTimer(medTimers[client]) then
					medTimers[client] = setTimer(function() setElementData(client,"cured", nil) end, 300000, 1)
			end
		end
	end
end )
