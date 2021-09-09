----------------------
--Datos Busetero --
----------------------
addEvent ( "NGJobs->Module->Job->Busetero->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Busetero->OnClientRequestF5Data", root, function ( )
	local data = { }
	local ruticas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "Busetero" ))

	data.ruticas = ruticas or 0
	data.nextRankBusetero= "None"
	data.requiredRutas = 0
	data.RankBusetero= getElementData ( source, "Job Rank" ) or jobRanks [ 'busetero'] [ 0 ];
	
	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'busetero'] ) ) do 
		if ( isNext ) then 
			data.nextRankBusetero= v[2];
			data.requiredRutas = v[1] - data.ruticas;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankBusetero:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Busetero->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos Camionero --
----------------------
addEvent ( "NGJobs->Module->Job->Camionero->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Camionero->OnClientRequestF5Data", root, function ( )
	local data = { }
	local entreguitas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "Camionero" ) )

	data.entreguitas = entreguitas or 0
	data.nextRankCamionero= "None"
	data.requiredEntregas = 0
	data.RankCamionero= getElementData ( source, "Job Rank" ) or jobRanks [ 'camionero'] [ 0 ];
	
	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'camionero'] ) ) do 
		if ( isNext ) then 
			data.nextRankCamionero= v[2];
			data.requiredEntregas = v[1] - data.entreguitas;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankCamionero:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Camionero->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos stunter --
----------------------
addEvent ( "NGJobs->Module->Job->stunter->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->stunter->OnClientRequestF5Data", root, function ( )
	local data = { }
	local stuntscitos = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "Stunter" ) )

	data.stuntscitos = stuntscitos or 100
	data.nextRankstunter= "None"
	data.requiredStunts = 0
	data.Rankstunter= getElementData ( source, "Job Rank" ) or jobRanks [ 'stunter'] [ 0 ];
	
	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'stunter'] ) ) do 
		if ( isNext ) then 
			data.nextRankstunter= v[2];
			data.requiredStunts = v[1] - data.stuntscitos;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.Rankstunter:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->stunter->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos Taxista --
----------------------
addEvent ( "NGJobs->Module->Job->Taxista->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Taxista->OnClientRequestF5Data", root, function ( )
	local data = { }
	local carreritas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "Taxista" ) )

	data.carreritas = carreritas or 0
	data.nextRankTaxista= "None"
	data.requiredCarreras = 0
	data.RankTaxista= getElementData ( source, "Job Rank" ) or jobRanks [ 'taxista'] [ 0 ];
	
	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'taxista'] ) ) do 
		if ( isNext ) then 
			data.nextRankTaxista= v[2];
			data.requiredCarreras = v[1] - data.carreritas;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankTaxista:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Taxista->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos mechanic --
----------------------
addEvent ( "NGJobs->Module->Job->mechanic->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->mechanic->OnClientRequestF5Data", root, function ( )
	local data = { }
	local reparacioncitas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "mechanic" ) )
	local decomisitos = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), "TowedVehicles" )

	data.reparacioncitas = reparacioncitas or 0
	data.decomisitos = decomisitos or 0
	data.nextRankmechanic= "None"
	data.requiredReparaciones = 0
	data.Rankmechanic= getElementData ( source, "Job Rank" ) or jobRanks [ 'mechanic'] [ 0 ];
	
	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'mechanic'] ) ) do 
		if ( isNext ) then 
			data.nextRankmechanic= v[2];
			data.requiredReparaciones = v[1] - data.reparacioncitas;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.Rankmechanic:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->mechanic->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos Basurero --
----------------------
addEvent ( "NGJobs->Module->Job->Basurero->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Basurero->OnClientRequestF5Data", root, function ( )
	local data = { }
	local reparticos = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "Basurero" ) )

	data.reparticos = reparticos or 0
	data.nextRankBasurero= "None"
	data.requiredRepartos = 0
	data.RankBasurero= getElementData ( source, "Job Rank" ) or jobRanks [ 'Basurero'] [ 0 ];

	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'Basurero'] ) ) do 
		if ( isNext ) then 
			data.nextRankBasurero= v[2];
			data.requiredRepartos = v[1] - data.reparticos;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankBasurero:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Basurero->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos Medic --
----------------------
addEvent ( "NGJobs->Module->Job->Medic->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Medic->OnClientRequestF5Data", root, function ( )
	local data = { }
	local curaditos = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "medic" ) )

	data.curaditos = curaditos or 0
	data.nextRankMedic= "None"
	data.requiredCurados = 0
	data.RankMedic= getElementData ( source, "Job Rank" ) or jobRanks [ 'medic'] [ 0 ];

	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'medic'] ) ) do 
		if ( isNext ) then 
			data.nextRankMedic= v[2];
			data.requiredCurados = v[1] - data.curaditos;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankMedic:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Medic->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos Criminal --
----------------------
addEvent ( "NGJobs->Module->Job->Criminal->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Criminal->OnClientRequestF5Data", root, function ( )
	local data = { }
	local killcitas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "criminal" ) )

	data.killcitas = killcitas or 0
	data.nextRankCriminal= "None"
	data.requiredKills = 0
	data.RankCriminal= getElementData ( source, "Job Rank" ) or jobRanks [ 'criminal'] [ 0 ];

	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'criminal'] ) ) do 
		if ( isNext ) then 
			data.nextRankCriminal= v[2];
			data.requiredKills = v[1] - data.killcitas;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankCriminal:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Criminal->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos Drifter --
----------------------
addEvent ( "NGJobs->Module->Job->Drifter->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Drifter->OnClientRequestF5Data", root, function ( )
	local data = { }
	local accioncitas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "drifter" ) )

	data.accioncitas = accioncitas or 0
	data.nextRankDrifter= "None"
	data.requiredAcciones = 0
	data.RankDrifter= getElementData ( source, "Job Rank" ) or jobRanks [ 'drifter'] [ 0 ];

	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'drifter'] ) ) do 
		if ( isNext ) then 
			data.nextRankDrifter= v[2];
			data.requiredAcciones = v[1] - data.accioncitas;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankDrifter:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Drifter->onServerSendClientJobInfo", source, data );
end )
----------------------
--Datos Militar --
----------------------
addEvent ( "NGJobs->Module->Job->Militar->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->Militar->OnClientRequestF5Data", root, function ( )
	local data = { }
	local falsosposi = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "Militar" ) )

	data.falsosposi = falsosposi or 0
	data.nextRankMilitar= "None"
	data.requiredFalsosPositivos = 0
	data.RankMilitar= getElementData ( source, "Job Rank" ) or jobRanks [ 'militar'] [ 0 ];

	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'militar'] ) ) do 
		if ( isNext ) then 
			data.nextRankMilitar= v[2];
			data.requiredFalsosPositivos = v[1] - data.falsosposi;
			isNext = false;
			break;
		end 
		if ( v[2]:lower() == data.RankMilitar:lower() ) then 
			isNext = true;
		end 
	end 
	triggerClientEvent ( source, "NGJobs->Module->Job->Militar->onServerSendClientJobInfo", source, data );
end )



function addruta(player)
	local job = getElementData ( player, "Job" )
	local column = "None"
	local job = tostring ( job ):lower ( )
	outputChatBox("job:"..job)
	if ( job == "criminal" ) then
		column="CriminalActions"
	elseif ( job == "drifter" ) then
		column = "DriftPoints"
	elseif ( job == "mechanic" ) then
		column = "FixedVehicles"
	elseif ( job == "police officer" ) then
		column = "Arrests"
	elseif ( job == "medic" ) then
		column = "HealedPlayers"
	elseif ( job == "fisherman" ) then
		column = "CaughtFish"
	elseif ( job == "detective" ) then
		column = "SolvedCrims"
	elseif ( job == "pilot" ) then
		column = "completeflights"
	elseif ( job == "stunter" ) then
		column = "stunts"
	elseif ( job == "camionero" ) then
		column = "entregas"
	elseif ( job == "busetero" ) then
		column = "completeroutes"
	elseif ( job == "Taxista" ) then
		column = "carreras"
	elseif ( job == "basurero" ) then
		column = "repartos"
	elseif ( job == "militar" ) then
		column = "Falsospositivos"
	else 
		return false
	end
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, "AddOne" )
	outputChatBox( "agregada 10 entregas a :"..job )
end
addCommandHandler ( "add", addruta )