local track = {
     { 144.199, -1570.599, 10.80 }, 
     { 261, -1694.9, 8.3 }, 
     { 398.6, -1716.4, 267 }, 
     { 559.599, -1734.099, 12.6 }, 
     { 770.9, -1781.4, 12.699 }, 
     { 940.799, -1790.9, 13.6 }, 
     { 1074.699, -1852.3, 13.199 }, 
	 { 1202.3, -1852, 13.199 }, 
     { 1314.199, -1839, 13.199 }, 
     { 1316.4, -1537.3, 13.199 }, 
     { 1358.099, -1337.599, 13.199 }, 
     { 1328.5, -1144.699, 23.399 }, 
     { 1107, -1145.199, 23.399 }, 
     { 836.099, -1146.199, 23.399 }, 
	 { 725.799, -1193.199, 19.2 }, 
     { 664.2, -1280.9, 13.3 }, 
     { 632.4, -1321, 13.3 }, 
     { 447.1, -1372.8, 24.799 }, 
     { 273.399, -1514.3, 32 }, 
     { 257.399, -1627.5, 32.9 }, 
     { 370, -1665.599, 32.5 }, 
	 { 370.299, -1809.4, 7.5 }, 
     { 370.299, -2025.099, 7.5 }, 
}
addEvent ( "NGEvents:Modules->SuperGtStreetRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->SuperGtStreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnSuperGtRaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
		SuperGtRace_LoadMarkerId ( 1 )
	else
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnSuperGtRaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
	end
end )

function SuperGtRace_LoadMarkerId ( i, isWin )
	if ( isElement ( track8TrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", track8TrackMarker, OnSuperGtRaceMarkerHit )
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
	addEventHandler ( "onClientMarkerHit", track8TrackMarker, OnSuperGtRaceMarkerHit )
end

function OnSuperGtRaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		SuperGtRace_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->SuperGtRace:ThisPlayerWinsRace", localPlayer )
end