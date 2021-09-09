local track = {
     { 1323.52, -2056.66, 57.63 }, 
     { 1407.84, -2039.37, 53.77 }, 
     { 1397.38, -1970.7, 39.06 }, 
     { 1250.89, -1920.14, 31.1 }, 
     { 1338.76, -1917.46, 22.66 }, 
     { 1425.79, -1890.7, 14.62 }, 
     { 1307.7, -1852.67, 14.4 }, 
     { 1078.57, -1852.91, 14.4 }, 
     { 942.47, -1792.1, 14.83 }, 
     { 627.36, -1730.26, 14.86 }, 
     { 632.22, -1476.35, 15.46 }, 
     { 531.69, -1415.73, 16.97 }, 
     { 362.39, -1517.86, 33.94 }, 
     { 281.2, -1579.82, 33.85 }, 
     { 269.32, -1517.69, 33.13 }, 
     { 285.55, -1487.59, 33.6 }, 
     { 241, -1498.42, 23.86 }, 
     { 184.18, -1517.38, 13.44 }, 
     { 264.22, -1427.53, 14.58 }, 
     { 458.69, -1318.16, 16.17 }, 
     { 653.73, -1196.25, 19.03 }, 
     { 787.12, -1048.95, 25.64 }, 
     { 955.23, -968.64, 39.74 }, 
     { 1216.94, -938.72, 43.67 }, 
     { 1343.89, -934.16, 36.18 }, 
     { 1354.65, -1036.69, 27.16 }, 
     { 1343.52, -1236.42, 14.6 }, 
     { 1340.4, -1446.36, 14.4 }, 
     { 1298.1, -1599.77, 14.39 }, 
     { 1322.39, -1851.89, 14.39 }, 
     { 1409.49, -1870.94, 14.39 }, 
     { 1423.64, -1922.8, 16.05 }, 
     { 1332.57, -1917.31, 23.1 }, 
     { 1251.31, -1921.59, 32.17 }, 
     { 1334.58, -1961.86, 31.03 }, 
     { 1430.57, -2014.89, 52.51 }, 
     { 1351.44, -2055.36, 57.69 }, 
	 { 1280.46, -2056.97, 59.88 },
}
addEvent ( "NGEvents:Modules->MonsterStreetRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->MonsterStreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( LSTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnMonsterRaceMarkerHit )
			destroyElement ( LSTrackMarker )
			destroyElement ( LSTrackBlip )
		end
		MonsterRace_LoadMarkerId ( 1 )
	else
		if ( isElement ( LSTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnMonsterRaceMarkerHit )
			destroyElement ( LSTrackMarker )
			destroyElement ( LSTrackBlip )
		end
	end
end )

function MonsterRace_LoadMarkerId ( i, isWin )
	if ( isElement ( LSTrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnMonsterRaceMarkerHit )
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
	addEventHandler ( "onClientMarkerHit", LSTrackMarker, OnMonsterRaceMarkerHit )
end

function OnMonsterRaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		MonsterRace_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->MonsterRace:ThisPlayerWinsRace", localPlayer )
end