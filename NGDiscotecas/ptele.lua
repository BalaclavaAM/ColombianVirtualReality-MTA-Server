
function teleport()
Teleport1 = createMarker ( 815.99542236328, -1386.0865478516, 14.596995353699 , "arrow", 2, 0, 252, 255, 0, getRootElement() )


function MarkerHit( hitElement, matchingDimension )
    setElementPosition ( hitElement, 493.55368041992, -22.766534805298, 1000.6796875 )
	setElementDimension ( hitElement, 0)  
	setElementInterior ( hitElement, 17 )
	setElementRotation(hitElement, 0, 0, 180) 
end
addEventHandler( "onMarkerHit", Teleport1, MarkerHit )

end
addEventHandler ( "onResourceStart", getRootElement (), teleport )




function teleport()
Teleport2 = createMarker ( 493.48483276367, -24.950477600098, 1001.671875 , "arrow", 2, 0, 252, 255, 0, getRootElement() )
setElementDimension ( Teleport2, 0 )  
setElementInterior ( Teleport2, 17 )

function MarkerHit( hitElement, matchingDimension )
    setElementPosition ( hitElement, 815.73297119141, -1387.9300537109, 13.613039016724 )
	setElementDimension ( hitElement, 0)  
	setElementInterior ( hitElement, 0 )
	setElementRotation(hitElement, 0, 0, 180) 
end
addEventHandler( "onMarkerHit", Teleport2, MarkerHit )

end
addEventHandler ( "onResourceStart", getRootElement (), teleport )


