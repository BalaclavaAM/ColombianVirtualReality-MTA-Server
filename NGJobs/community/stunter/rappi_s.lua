addEvent ( "NGJobs->Module->Job->stunter->OnClientRequestF5Data", true )
addEventHandler ( "NGJobs->Module->Job->stunter->OnClientRequestF5Data", root, function ( )
	local data = { }
	local entregas = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "stunter" ) )
	data.entregas = entregas or 0
	data.nextRank = "None"
	data.requiredEntregas = 0
	data.rank = getElementData ( source, "Job Rank" ) or jobRanks [ 'stunter'] [ 0 ];

	local rankTable = { }
	local isNext = false;
	for i, v in pairs ( foreachinorder ( jobRanks [ 'stunter'] ) ) do 
		if ( isNext ) then 
			data.nextRank = v[2];
			data.requiredEntregas = v[1] - data.entregas;
			isNext = false;
			break;
		end 
		
		if ( v[2]:lower() == data.rank:lower() ) then 
			isNext = true;
		end 
	end 
	
	
	triggerClientEvent ( source, "NGJobs->Module->Job->stunter->onServerSendClientJobInfo", source, data );
	
end )