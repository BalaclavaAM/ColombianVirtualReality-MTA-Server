medTimers = {}
contador = {}

addEvent ( "NGJobs:Medic.onPlayerHealPlayer", true )
addEventHandler ( "NGJobs:Medic.onPlayerHealPlayer", root, function ( client, medic ) 

	if not(medTimers[client]) or ((getTickCount(  )) - (medTimers[client])  >= 300000) then
		setElementData(client,"cured", nil)
		if ( getElementHealth ( client ) < 100 ) then
			setElementHealth ( client, getElementHealth ( client ) + 0.9 )
			if ( getElementHealth ( client ) >= 100 ) then
				setElementHealth ( client, 100 )
				if getElementData(client, "cured") ~= medic then  
					givePlayerMoney ( medic, 8000 )
					exports['NGMessages']:sendClientMessage ( "Te pagamos 8000 por curar a "..getPlayerName(client)..". Recuerda que puedes volver a curarlo en 5 minutos.", medic, 255, 0, 0 )
					setElementData(client,"cured",medic)
				end
				updateJobColumn ( getAccountName ( getPlayerAccount ( medic ) ), "HealedPlayers", "AddOne" )
				medTimers[client] = getTickCount(  )
			end
		end
	elseif not contador[client] or contador[client]== 0 then
		local tiempo = ((300000-(getTickCount() - medTimers[client]))/1000)/60
		exports['NGMessages']:sendClientMessage ( "Ya has curado a esta persona, espera "..tostring(tiempo).." min para curarla de nuevo.", medic, 255, 0, 0 )
		contador[client] = 1 
		setTimer( function() contador[client] = 0  end , 10000, 1)
	end

end )



