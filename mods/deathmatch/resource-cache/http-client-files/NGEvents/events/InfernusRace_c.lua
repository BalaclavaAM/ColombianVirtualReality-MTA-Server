local track = {
     { -2686.299, 1593.5, 63.799 }, 
     { -2692, 2165.2, 55.2 }, 
     { -2772.399, 2362.9, 76 }, 
     { -2743.8, 2604.899, 91.599 }, 
     { -2303.099, 2675.5, 56.299 }, 
     { -2001.799, 2621.9, 50.5 }, 
     { -1804.599, 2687.399, 56.599 }, 
	 { -1623.7, 2725.299, 57.5 }, 
     { -1424.699, 2720.199, 62.099 }, 
     { -1320.599, 2651.2, 49.7 }, 
     { -1125.5, 2699.3, 45.7 }, 
     { -733.2, 2730.199, 47.099 }, 
     { -582.9, 2745.899, 61.099 }, 
     { -369.299, 2675.5, 64.5 }, 
	 { -182.4, 2635, 63.099 }, 
     { 60.2, 2667, 54.099 }, 
     { 250.1, 2743.399, 59.5 }, 
     { 435.5, 2671, 59.299 }, 
     { 924.4, 2592.899, 10.199 }, 
     { 1166.4, 2426.4, 10.5 }, 
     { 1413.9, 2439.399, 6.5 }, 
	 { 1575.4, 2466, 6.5 }, 
     { 1825.4, 2510.1, 6.599 }, 
     { 2229.199, 2617.5, 6.599 }, 
     { 2514.1, 2593.399, 4.599 }, 
     { 2693.4, 2390, 6.5 }, 
     { 2694.2, 2229.299, 6.5 }, 
     { 2620.699, 2111.8, 10.5 },
     { 2552.699, 2114.699, 10.5},	 
     { 2514.399, 2136.199, 10.5 },
	 { 2355.3, 2137, 10.5 },
	 { 2137.399, 2140.399, 10.5 },
}
addEvent ( "NGEvents:Modules->InfernusStreetRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->InfernusStreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnInfernusRaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
		InfernusRace_LoadMarkerId ( 1 )
	else
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnInfernusRaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
	end
end )

function InfernusRace_LoadMarkerId ( i, isWin )
	if ( isElement ( track8TrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnInfernusRaceMarkerHit )
		destroyElement ( track8TrackMarker )
		destroyElement ( track8TrackBlip )
	end
	local x, y, z = track[i][1], track[i][2], track[i][3]
	if ( not isWin ) then
		track8TrackBlip = createBlip ( x, y, z, 0, 3, 255, 255, 0 )
		track8TrackMarker = createMarker ( x, y, z, "checkpoint", 9, 255, 255, 0, 120 )
	else
		track8TrackBlip = createBlip ( x, y, z, 0, 3, 0, 255, 0 )
		track8TrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
	end
	
	setElementDimension ( track8TrackMarker, RaceDimension )
	setElementDimension ( track8TrackBlip, RaceDimension )
	setElementInterior(track8TrackMarker,7)
	setElementInterior(track8TrackBlip,7)
	addEventHandler ( "onClientMarkerHit", track8TrackMarker, OnInfernusRaceMarkerHit )
end

function OnInfernusRaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		InfernusRace_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->InfernusRace:ThisPlayerWinsRace", localPlayer )
end