function player_Wasted ( ammo, attacker, weapon, bodypart )
	-- if there was an attacker
	
	if ( attacker and getElementType(attacker) == "player" and weapon == 9 ) then
		local teamAtt = getTeamName(getPlayerTeam(attacker))
		local teamSource = getTeamName(getPlayerTeam(source))
		
		if teamAtt == "Fuerzas Armadas" then
			exports['NGMessages']:sendClientMessage ( "Has ganado 5000 por hacer un falso positivo con "..getPlayerName(source).."", attacker, 0, 255, 0 )
			givePlayerMoney( attacker, 5000)
			updateJobColumn ( getAccountName ( getPlayerAccount ( attacker) ), "CriminalActions", "AddOne" )
		end
		

	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player_Wasted )

addEvent ( "NGJobs->Module->Job->militar->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->militar->OnClientRequestF5Data", root, function ( )
	local data = { }
	local bajas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "criminal" ) )
	data.bajas = bajas or 0
	data.nextRank = "None"
	data.requiredBajas = 0
	data.rank = getElementData ( source, "Job Rank" ) or jobRanks [ 'militar'] [ 0 ];

	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'militar'] ) ) do 
		if ( isNext ) then 
			data.nextRank = v[2];
			data.requiredBajas = v[1] - data.bajas;
			isNext = false;
			break;
		end 
		
		if ( v[2]:lower() == data.rank:lower() ) then 
			isNext = true;
		end 
	end 
	
	
	triggerClientEvent ( source, "NGJobs->Module->Job->militar->onServerSendClientJobInfo", source, data );
	
end )