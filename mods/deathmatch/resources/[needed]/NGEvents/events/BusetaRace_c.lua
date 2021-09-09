local track = {
     { 1264.12, -1400.44, 13.02 }, 
     { 1135.74, -1400.94, 13.16 }, 
     { 899.71, -1400.83, 12.81 }, 
     { 669.74, -1400.9, 13.08 }, 
     { 631.96, -1373.45, 13.18 }, 
     { 629.49, -1243.49, 17.32 }, 
     { 596.44, -1222.64, 17.58 }, 
     { 482.47, -1294.85, 15.12 }, 
     { 349.34, -1381.39, 13.96 }, 
     { 157.37, -1552.34, 10.58 }, 
     { 126.75, -1590.88, 10.34 }, 
     { 120.18, -1695.26, 9.05 }, 
     { 181.82, -1734.86, 3.87 }, 
     { 307.15, -1737.14, 4.02 }, 
     { 346.62, -1770.4, 4.74 }, 
     { 425.4, -1771.8, 4.96 }, 
     { 458.19, -1737.74, 8.84 }, 
     { 477.75, -1723.41, 10.67 }, 
     { 597.64, -1740.01, 12.97 }, 
     { 630.32, -1706.95, 14.2 }, 
     { 664.98, -1672.4, 13.42 }, 
     { 792.48, -1674.55, 13.01 }, 
     { 810.57, -1653.66, 13.07 }, 
     { 863.36, -1587.36, 13.06 }, 
     { 933.52, -1571.73, 13.06 }, 
     { 1052.78, -1571.86, 13.07 }, 
     { 1215.23, -1571.73, 13.07 }, 
     { 1297.67, -1556.94, 13.07 }, 
     { 1339, -1449.62, 13.06 }, 
     { 1342.2, -1401.75, 12.99 }, 
}
addEvent ( "NGEvents:Modules->BusetaStreetRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->BusetaStreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( LSTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBusetaRaceMarkerHit )
			destroyElement ( LSTrackMarker )
			destroyElement ( LSTrackBlip )
		end
		BusetaRace_LoadMarkerId ( 1 )
	else
		if ( isElement ( LSTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBusetaRaceMarkerHit )
			destroyElement ( LSTrackMarker )
			destroyElement ( LSTrackBlip )
		end
	end
end )

function BusetaRace_LoadMarkerId ( i, isWin )
	if ( isElement ( LSTrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBusetaRaceMarkerHit )
		destroyElement ( LSTrackMarker )
		destroyElement ( LSTrackBlip )
	end
	local x, y, z = track[i][1], track[i][2], track[i][3]
	if ( not isWin ) then
		LSTrackBlip = createBlip ( x, y, z, 0, 3, 255, 255, 0 )
		LSTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 255, 255, 0, 120 )
	else
		LSTrackBlip = createBlip ( x, y, z, 0, 4, 0, 255, 0 )
		LSTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
	end
	
	setElementDimension ( LSTrackMarker, RaceDimension )
	setElementDimension ( LSTrackBlip, RaceDimension )
	addEventHandler ( "onClientMarkerHit", LSTrackMarker, OnBusetaRaceMarkerHit )
end

function OnBusetaRaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		BusetaRace_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->BusetaRace:ThisPlayerWinsRace", localPlayer )
end