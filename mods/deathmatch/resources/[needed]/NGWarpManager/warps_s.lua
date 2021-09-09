addEvent ( "NGWarpManager->SetPlayerPositionInteriorDimension", true )
addEventHandler ( "NGWarpManager->SetPlayerPositionInteriorDimension", root, function ( x, y, z, int, dim )
	setElementPosition ( source, x, y, z, true )
	source.dimension = dim
	source.interior = int
end )