Markers = {{{2793.42, -1087.59, 29.5},{1, 2725.17, -1070, 764.33,180},false},
{{2725.55, -1066.72, 763.5},{0,2800.81, -1087.44, 30.72,270},true},
{{2700.1916503906,-1096.0070800781,763.5},{1,2714.732421875,-1071.2384033203,754.16558837891,0},true},
{{2714.7846679688,-1074.5042724609,753.8},{1,2704.9575195312,-1095.5355224609,764.33087158203,270},true},
{{2712.3640136719,-1069.4541015625,770.2},{0,2792.2727050781,-1106.2425537109,94.187072753906,0},true},
{{2792.4440917969,-1109.9532470703,93},{1,2710.783203125,-1073.6390380859,771.30645751953,210},false},
{{2719.4091796875,-1091.2459716797,749.9814453125},{1,2679.0275878906,-1063.3735351562,752.25,210},true},
{{2684.5034179688,-1066.927734375,751.5},{1,2713.8869628906,-1073.5274658203,750.60986328125,270},true},
{{2712.9655761719,-1070.205078125,767},{1,2702.7976074219,-1125.1820068359,729.453125,0},true},
{{2702.5986328125,-1128.6981201172,728.5},{1,2710.2182617188,-1072.6741943359,767.79260253906,210},true}}
for k,v in pairs(Markers)do
	local TempMark=createMarker( v[1][1], v[1][2], v[1][3] , "cylinder",2 ,255, 255,0, 30 )
	if v[3] then setElementDimension( TempMark, 1) setElementInterior( TempMark, 1) end
	addEventHandler("onMarkerHit", TempMark, function(HE,md) 
		if md and isElement(HE) and getElementType(HE)=="player" then
			if v[2][1] ~= getElementDimension(HE) then
				setElementDimension( HE, v[2][1] )
				setElementInterior( HE, v[2][1], v[2][2], v[2][3], v[2][4] )
			else
				setElementPosition( HE, v[2][2], v[2][3], v[2][4] )
			end
			setElementRotation( HE, 0, 0,v[2][5] , "default", true )
		end
	end)
end
puertas = {{{2990, 2815.20, -1067.5, 32.8},{2810.38, -1072.18, 25,12,13,8},{2815.20, -1067.5, 25}},
		  {{2990, 2816.5, -1103.2, 31.7},{2810.38, -1110.18, 25,12,13,8},{2816.5, -1103.2, 23.9}},	
		  {{2634, 2718.3,-1097.6,742.59998},{2715.49, -1099.98, 740.22, 5.5,5.5,4},{2718.3,-1097.6,738.59998}}}

function loadMapObjects()
	for k,v in pairs(puertas)do
		local x = createObject(v[1][1], v[1][2], v[1][3], v[1][4])
		local y = createColCuboid(v[2][1],v[2][2],v[2][3],v[2][4],v[2][5],v[2][6])
		if k == 3 then
			setObjectScale( x, 1.3 )
			setElementDimension( x, 1 )
			setElementInterior( x,1)
			setElementDimension(y,1)
		end
		addEventHandler ( "onColShapeHit", y, function(thePlayer,md)
			if (md and ((getElementData ( thePlayer, "Group" )=="GTS") or getAccountName( getPlayerAccount( thePlayer ) ) == "AshTheLynx.")) then
				moveObject(x,2000,v[3][1],v[3][2],v[3][3])
			else
				outputChatBox( "Usted no es miembro de GTS",thePlayer, 0,0,255)
			end
		end )
		addEventHandler ( "onColShapeLeave", y, function(thePlayer,md)
				moveObject(x,2000,v[1][2],v[1][3],v[1][4])
		end )
	end
 end
 addEventHandler("onResourceStart", resourceRoot, loadMapObjects)




