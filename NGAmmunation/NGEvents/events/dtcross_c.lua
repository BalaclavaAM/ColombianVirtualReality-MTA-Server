local track = {
	{-1470.49, -655.93, 1053.03},
	{-1486.16, -625.95, 1052.7},
	{-1450.53, -614.45, 1052.44},
	{-1425.01, -625.27, 1050.61},
	{-1437.79, -670.64, 1053.29},
	{-1426.44, -718.74, 1056.27},
	{-1337.64, -715.42, 1056.1},
	{-1348.68, -690.51, 1055.88},
	{-1404.59, -665.73, 1051.97},
	{-1382.52, -621.11, 1051.91},
	{-1300.58, -648.76, 1056.32},
	{-1354.99, -591.15, 1056.03},
	{-1506.41, -593.96, 1056.13},
	{-1517.44, -665.51, 1051.05},
	{-1480.13, -728.88, 1050.13},
	{-1320.23, -742.74, 1052.06},
	{-1308.49, -687.81, 1056.32},
	{-1345.05, -670.23, 1056},
	{-1470.49, -655.93, 1053.03},
	{-1486.16, -625.95, 1052.7},
	{-1450.53, -614.45, 1052.44},
	{-1425.01, -625.27, 1050.61},
	{-1437.79, -670.64, 1053.29},
	{-1426.44, -718.74, 1056.27},
	{-1337.64, -715.42, 1056.1},
	{-1348.68, -690.51, 1055.88},
	{-1404.59, -665.73, 1051.97},
	{-1382.52, -621.11, 1051.91},
	{-1300.58, -648.76, 1056.32},
	{-1354.99, -591.15, 1056.03},
	{-1506.41, -593.96, 1056.13},
	{-1517.44, -665.51, 1051.05},
	{-1480.13, -728.88, 1050.13},
	{-1320.23, -742.74, 1052.06},
	{-1308.49, -687.81, 1056.32},
	{-1345.05, -670.23, 1056},
	{-1470.49, -655.93, 1053.03},
	{-1486.16, -625.95, 1052.7},
	{-1450.53, -614.45, 1052.44},
	{-1425.01, -625.27, 1050.61},
	{-1437.79, -670.64, 1053.29},
	{-1426.44, -718.74, 1056.27},
	{-1337.64, -715.42, 1056.1},
	{-1348.68, -690.51, 1055.88},
	{-1404.59, -665.73, 1051.97},
	{-1382.52, -621.11, 1051.91},
	{-1300.58, -648.76, 1056.32},
	{-1354.99, -591.15, 1056.03},
	{-1506.41, -593.96, 1056.13},
	{-1517.44, -665.51, 1051.05},
	{-1480.13, -728.88, 1050.13},
	{-1320.23, -742.74, 1052.06},
	{-1308.49, -687.81, 1056.32},
	{-1345.05, -670.23, 1056},
	{-1452.84, -661.29, 1054.38},
    
}
addEvent ( "NGEvents:Modules->dtStreetRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->dtStreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( dtTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", dtTrackMarker, OndtRaceMarkerHit )
			destroyElement ( dtTrackMarker )
			destroyElement ( dtTrackBlip )
		end
		dtRace_LoadMarkerId ( 1 )
	else
		if ( isElement ( dtTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", dtTrackMarker, OndtRaceMarkerHit )
			destroyElement ( dtTrackMarker )
			destroyElement ( dtTrackBlip )
		end
	end
end )

function dtRace_LoadMarkerId ( i, isWin )
	if ( isElement ( dtTrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", dtTrackMarker, OndtRaceMarkerHit )
		destroyElement ( dtTrackMarker )
		destroyElement ( dtTrackBlip )
	end
	local x, y, z = track[i][1], track[i][2], track[i][3]
	if ( not isWin ) then
		dtTrackBlip = createBlip ( x, y, z, 0, 3, 255, 255, 0 )
		dtTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 255, 255, 0, 120 )
	else
		dtTrackBlip = createBlip ( x, y, z, 0, 3, 0, 255, 0 )
		dtTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
	end
	
	setElementDimension ( dtTrackMarker, RaceDimension )
	setElementDimension ( dtTrackBlip, RaceDimension )
	setElementInterior(dtTrackMarker,7)
	setElementInterior(dtTrackBlip,7)
	addEventHandler ( "onClientMarkerHit", dtTrackMarker, OndtRaceMarkerHit )
end

function OndtRaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		dtRace_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->dtRace:ThisPlayerWinsRace", localPlayer )
end