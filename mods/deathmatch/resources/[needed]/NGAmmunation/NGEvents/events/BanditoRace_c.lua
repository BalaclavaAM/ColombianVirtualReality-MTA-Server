local track = {
     { -754.27, 2344.72, 123.09 }, 
     { -825.47, 2358.09, 120.7 }, 
     { -832.06, 2461.83, 112.81 }, 
     { -788.29, 2511.94, 95.79 }, 
     { -773.04, 2559.1, 85.69 }, 
     { -722.82, 2519.03, 74.95 }, 
     { -717.73, 2544.1, 72.97 }, 
     { -741, 2642.26, 64.79 }, 
     { -698.68, 2688.82, 56 }, 
     { -770.53, 2693.53, 46.97 }, 
     { -797.2, 2729.92, 45.02 }, 
     { -945.64, 2718.06, 45.54 }, 
     { -1204.7, 2688.07, 45.63 }, 
     { -1216.95, 2658.91, 46.09 }, 
     { -1151.78, 2578.64, 69.1 }, 
     { -1109.76, 2470.15, 80.45 }, 
     { -1098.73, 2347.23, 85.55 }, 
     { -1076.71, 2245.58, 87.8 }, 
     { -1062.23, 2130.99, 87.4 }, 
     { -1108.76, 2109.3, 86.48 }, 
     { -1202.57, 2081.88, 80.12 }, 
     { -1272.27, 2011.15, 67 }, 
     { -1233.06, 1931.31, 42.38 }, 
     { -1239.83, 1903.21, 41.95 }, 
     { -1180.56, 1816.47, 40.83 }, 
     { -1150.92, 1799.08, 39.85 }, 
     { -994.86, 1851.09, 62.72 }, 
     { -881.62, 1798.02, 59.85 }, 
     { -868.36, 1911.56, 59.86 }, 
     { -844.8, 2016.34, 60.06 }, 
     { -480.53, 2001.42, 59.86 }, 
     { -465.3, 2048.24, 60.55 }, 
     { -431.97, 2132.38, 45.4 }, 
     { -396.56, 2153.29, 43.07 }, 
     { -380.53, 2223.71, 41.77 }, 
     { -420.42, 2290.25, 41.89 }, 
     { -504.29, 2325.78, 66.78 }, 
	 { -606.69, 2398.52, 89.63 },
	 { -721.2, 2451.08, 124.6 },
	 { -693.02, 2379.55, 129.79 },
	 { -717.23, 2319.55, 127.06 },
}
addEvent ( "NGEvents:Modules->BanditoDesertRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->BanditoDesertRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( LSTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBanditoRaceMarkerHit )
			destroyElement ( LSTrackMarker )
			destroyElement ( LSTrackBlip )
		end
		BanditoRace_LoadMarkerId ( 1 )
	else
		if ( isElement ( LSTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBanditoRaceMarkerHit )
			destroyElement ( LSTrackMarker )
			destroyElement ( LSTrackBlip )
		end
	end
end )

function BanditoRace_LoadMarkerId ( i, isWin )
	if ( isElement ( LSTrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBanditoRaceMarkerHit )
		destroyElement ( LSTrackMarker )
		destroyElement ( LSTrackBlip )
	end
	local x, y, z = track[i][1], track[i][2], track[i][3]
	if ( not isWin ) then
		LSTrackBlip = createBlip ( x, y, z, 0, 3, 255, 255, 0 )
		LSTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 255, 255, 0, 120 )
	else
		LSTrackBlip = createBlip ( x, y, z, 0, 3, 0, 255, 0 )
		LSTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
	end
	
	setElementDimension ( LSTrackMarker, RaceDimension )
	setElementDimension ( LSTrackBlip, RaceDimension )
	addEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBanditoRaceMarkerHit )
end

function OnBanditoRaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		BanditoRace_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->BanditoRace:ThisPlayerWinsRace", localPlayer )
end