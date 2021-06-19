local track = {
     { -1388.05, -148.85, 1050.72 }, 
     { -1271.16, -173.68, 1050.28 }, 
     { -1348.17, -281.79, 1045.8 }, 
     { -1402.24, -164.9, 1043.2 }, 
     { -1525.53, -177.46, 1050.44 }, 
     { -1485.08, -272.57, 1049.75 }, 
     { -1398.98, -221.28, 1050.69 }, 
	 { -1388.05, -148.85, 1050.72 }, 
     { -1271.16, -173.68, 1050.28 }, 
     { -1348.17, -281.79, 1045.8 }, 
     { -1402.24, -164.9, 1043.2 }, 
     { -1525.53, -177.46, 1050.44 }, 
     { -1485.08, -272.57, 1049.75 }, 
     { -1398.98, -221.28, 1050.69 }, 
	 { -1388.05, -148.85, 1050.72 }, 
     { -1271.16, -173.68, 1050.28 }, 
     { -1348.17, -281.79, 1045.8 }, 
     { -1402.24, -164.9, 1043.2 }, 
     { -1525.53, -177.46, 1050.44 }, 
     { -1485.08, -272.57, 1049.75 }, 
     { -1398.98, -221.28, 1050.69 }, 
	 { -1388.05, -148.85, 1050.72 }, 
     { -1271.16, -173.68, 1050.28 }, 
     { -1348.17, -281.79, 1045.8 }, 
     { -1402.24, -164.9, 1043.2 }, 
     { -1525.53, -177.46, 1050.44 }, 
     { -1485.08, -272.57, 1049.75 }, 
     { -1398.98, -221.28, 1050.69 }, 
    
}
addEvent ( "NGEvents:Modules->track8StreetRace:CreateCheckpoints", true )
addEventHandler ( "NGEvents:Modules->track8StreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
		track8Race_LoadMarkerId ( 1 )
	else
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
	end
end )

function track8Race_LoadMarkerId ( i, isWin )
	if ( isElement ( track8TrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
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
	addEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
end

function Ontrack8RaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		track8Race_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "NGEvents:Modules->track8Race:ThisPlayerWinsRace", localPlayer )
end