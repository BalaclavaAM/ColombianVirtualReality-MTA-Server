function player_Wasted ( ammo, attacker, weapon, bodypart )
	-- if there was an attacker
	
	if ( attacker and getElementType(attacker) == "player" and weapon == 9 ) then
		local teamAtt = getTeamName(getPlayerTeam(attacker))
		local teamSource = getTeamName(getPlayerTeam(source))
		
		if teamAtt == "Fuerzas Armadas" then
			exports['NGMessages']:sendClientMessage ( "Has ganado 50000 por hacer un falso positivo con "..getPlayerName(source).."", attacker, 0, 255, 0 )
			givePlayerMoney( attacker, 5000)
			updateJobColumn ( getAccountName ( getPlayerAccount ( attacker) ), "CriminalActions", "AddOne" )
		end
		

	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player_Wasted )