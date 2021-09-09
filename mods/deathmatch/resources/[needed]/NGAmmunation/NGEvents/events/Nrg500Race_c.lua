local track = {
     { -2751.5, 1154.699, 50.2 }, 
     { -2712.1, 1099.199, 45.299 }, 
     { -2611.699, 1200, 34.7 }, 
     { -2464.799, 1209, 34.7 }, 
     { -2382.5, 1177, 39.2 }, 
     { -2261, 1152.4, 59.5 }, 
     { -2259.3, 1016, 83.3 }, 
	 { -2262.3, 868.599, 66.199 }, 
     { -2287.699, 726.299, 49.099 }, 
     { -2441.7, 725.799, 34.7 }, 
     { -2550.399, 710.299, 27.5 }, 
     { -2606.6, 674.799, 27.1 }, 
     { -2606.1, 570.5, 14.1 }, 
     { -2606.899, 469.899, 14.1 }, 
	 { -2590.6, 347.899, 4.5 }, 
     { -2526.199, 345.1, 19.6 }, 
     { -2496.699, 396.6, 27.7 }, 
     { -2458.899, 392.399, 34.599 }, 
     { -2411.1, 426.5, 34.599 }, 
     { -2349.699, 377.1, 34.7 }, 
     { -2294.3, 404.7, 34.7 }, 
	 { -2239.1, 320.7, 34.799 }, 
     { -2101.799, 320.299, 34.7 },
     { -2004.099, 340.299, 34.7 },	 
     { -2003.9, 503.299, 34.5 }, 
     { -2005.34, 728.222, 44.9 },
     { -2004, 959.2, 45 },
     { -2028.3, 1056.8, 55.2 }, 
     { -2159.799, 1059.2, 55.2 }, 
     { -2515.099, 1091.599, 55.2 },
     { -2664.899, 1181.7, 55.099 },
}
addEvent ( "NGEvents:Modules->Nrg500StreetRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->Nrg500StreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnNrg500RaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
		Nrg500Race_LoadMarkerId ( 1 )
	else
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnNrg500RaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
	end
end )

function Nrg500Race_LoadMarkerId ( i, isWin )
	if ( isElement ( track8TrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnNrg500RaceMarkerHit )
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
	addEventHandler ( "onClientMarkerHit", track8TrackMarker, OnNrg500RaceMarkerHit )
end

function OnNrg500RaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		Nrg500Race_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->Nrg500Race:ThisPlayerWinsRace", localPlayer )
end