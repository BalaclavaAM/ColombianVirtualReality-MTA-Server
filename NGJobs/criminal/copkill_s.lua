function player_Wasted ( ammo, attacker, weapon, bodypart )
	-- if there was an attacker
	
	if ( attacker and getElementType(attacker) == "player" ) then
		local teamAtt = getTeamName(getPlayerTeam(attacker))
		local teamSource = getTeamName(getPlayerTeam(source))
		if getElementDimension(source) == 40 then return end
		
		if getElementData(attacker,"Job")=="Criminal" and teamAtt == "Criminals" and teamSource == "Law Enforcement" then
			exports['NGMessages']:sendClientMessage ( "Has ganado 8000 por matar al policia "..getPlayerName(source).."", attacker, 0, 255, 0 )
			givePlayerMoney( attacker, 8000)
			updateJobColumn ( getAccountName ( getPlayerAccount ( attacker) ), "CriminalActions", "AddOne" )
		end
		

	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player_Wasted )