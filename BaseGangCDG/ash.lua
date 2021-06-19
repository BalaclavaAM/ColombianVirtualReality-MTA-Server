
MarkerAfuera=createMarker( 2793.42, -1087.59, 29.5 , "cylinder",2 ,255, 255,0, 30 )
MarkerAdentro= createMarker( 2725.55, -1066.72, 763.5 , "cylinder",2 ,255, 255,0, 30 )
MarkerBodegaAfuera = createMarker( 2700.1916503906,-1096.0070800781,763.5, "cylinder",1.5 ,255, 255,0, 30 )
MarkerBodegaAdentro = createMarker( 2714.7846679688,-1074.5042724609,753.8, "cylinder",1.5 ,255, 255,0, 30 )
MarkerAcensorAbajo = createMarker( 2712.3640136719,-1069.4541015625,770.2, "cylinder",1.5 ,255, 255,0, 30 )
MarkerAcensorArriba = createMarker( 2792.4440917969,-1109.9532470703,93, "cylinder",1.5 ,255, 255,0, 30 )
MarkerTortura = createMarker( 2719.4091796875,-1091.2459716797,749.9814453125, "cylinder",1 ,0, 0,0, 0 )
MarkerTorturaE = createMarker( 2684.5034179688,-1066.927734375,751.5, "cylinder",1 ,255, 255,0, 30 )
MarkerDiscoAfuera = createMarker( 2712.9655761719,-1070.205078125,767, "cylinder",1.5 ,255, 255,0, 30 )
MarkerDiscoAdentro = createMarker(2702.5986328125,-1128.6981201172,728.5, "cylinder",1.5 ,255, 255,0, 30 )


setElementDimension( MarkerAdentro, 1)
setElementDimension( MarkerBodegaAfuera , 1)
setElementDimension( MarkerBodegaAdentro , 1)
setElementDimension( MarkerAcensorAbajo , 1)
setElementDimension( MarkerTortura , 1)
setElementDimension( MarkerTorturaE , 1)
setElementDimension( MarkerDiscoAfuera , 1)
setElementDimension( MarkerDiscoAdentro , 1)

setElementInterior( MarkerAdentro, 1, 2725.55, -1066.72, 764.33)
setElementInterior( MarkerBodegaAfuera , 1, 2700.1916503906,-1096.0070800781,763.5)
setElementInterior( MarkerBodegaAdentro , 1, 2714.7846679688,-1074.5042724609,754.80993652344)
setElementInterior( MarkerAcensorAbajo , 1, 2712.3640136719,-1069.4541015625,770.2)
setElementInterior( MarkerTortura , 1, 2719.4091796875,-1091.2459716797,749.9814453125)
setElementInterior( MarkerTorturaE , 1, 2684.5034179688,-1066.927734375,752.25)
setElementInterior( MarkerDiscoAfuera , 1,2712.9655761719,-1070.205078125,767)
setElementInterior( MarkerDiscoAdentro , 1,2702.5986328125,-1128.6981201172,728.5)
Entrada1 = createColCuboid( 2810.38, -1072.18, 25,12,13,8 )
Entrada2 = createColCuboid( 2810.38, -1110.18, 25,12,13,8 )
Entrada3 = createColCuboid(2715.49, -1099.98, 740.22, 5.5,5.5,4)


function entrada1(thePlayer,md)
	if (md and ((getElementData ( thePlayer, "Group" )=="ClanD'Golfo") or getAccountName( getPlayerAccount( thePlayer ) ) == "AshTheLynx.")) then
		if source == Entrada1 then
			moveObject( Puerta1, 2000, 2815.20, -1067.5, 25)
		elseif source == Entrada2 then
			moveObject( Puerta2, 2000, 2816.5, -1103.2, 23.9)
		elseif source == Entrada3 then
			moveObject( Puerta3, 2000, 2718.3,-1097.6,738.59998)
		end
    else
		outputChatBox( "Usted no es miembro de CDG",thePlayer, 0,0,255)
	end
end

addEventHandler ( "onColShapeHit", Entrada1, entrada1 )
addEventHandler ( "onColShapeHit", Entrada2, entrada1 )
addEventHandler ( "onColShapeHit", Entrada3, entrada1 )
function salida1(thePlayer,md)
	if (md and ((getElementData ( thePlayer, "Group" )=="ClanD'Golfo") or getAccountName( getPlayerAccount( thePlayer ) ) == "AshTheLynx.")) then
		if source == Entrada1 then
			moveObject( Puerta1, 2000, 2815.20, -1067.5, 32.8)
		elseif source == Entrada2 then
			moveObject( Puerta2, 2000, 2816.5, -1103.2, 31.7)
		elseif source == Entrada3 then
			moveObject( Puerta3, 2000,2718.3,-1097.6,742.59998)
		end
    end
  end
addEventHandler ( "onColShapeLeave", Entrada1, salida1 )
addEventHandler ( "onColShapeLeave", Entrada2, salida1 )
addEventHandler ( "onColShapeLeave", Entrada3, salida1 )


function loadMapObjects()
	-- create an object at a specified position with a specified rotation
	Puerta1 = createObject(2990, 2815.20, -1067.5, 32.8, 0, 0, 0)
	Puerta2 = createObject( 2990, 2816.5, -1103.2, 31.7,0,0,0 )
	Puerta3 = createObject( 2634, 2718.3,-1097.6,742.59998 )
	setObjectScale( Puerta3, 1.3 )
	setElementDimension( Puerta3, 1 )
	setElementInterior( Puerta3,1)


	--    <object id="object (ab_vaultDoor) (2)" breakable="true" interior="1" alpha="255" dimension="1" model="2634" scale="1.3" doublesided="false" collisions="false" posX="2718.3" posY="-1097.6" posZ="742.59998" rotX="0" rotY="0" rotZ="0"></object>

 end
 addEventHandler("onResourceStart", resourceRoot, loadMapObjects)

function tpz(HE,md)
	if md and isElement(HE) and getElementType(HE)=="player" then
		if(source==MarkerAfuera) then
			setElementDimension( HE, 1 )
			setElementInterior( HE, 1, 2725.17, -1070, 764.33 )
			setElementRotation( HE, 0, 0, 180 , "default", true )
		elseif(source==MarkerAdentro)then
			setElementDimension( HE, 0 )
			setElementInterior( HE, 0, 2800.81, -1087.44, 30.72 )
			setElementRotation( HE, 0, 0, 270 , "default", true )
		elseif(source==MarkerBodegaAfuera)then
			setElementPosition( HE, 2714.732421875,-1071.2384033203,754.16558837891 )
			setElementRotation( HE, 0, 0, 0 , "default", true )
		elseif(source==MarkerBodegaAdentro)then
			setElementPosition( HE, 2704.9575195312,-1095.5355224609,764.33087158203 )
			setElementRotation( HE, 0, 0, 270 , "default", true )
		elseif(source==MarkerAcensorAbajo)then
			setElementDimension( HE, 0 )
			setElementInterior( HE, 0,2792.2727050781,-1106.2425537109,94.187072753906)
			setElementRotation( HE, 0, 0, 0 , "default", true )
		elseif(source==MarkerAcensorArriba)then
			setElementDimension( HE, 1 )
			setElementInterior( HE, 1, 2710.783203125,-1073.6390380859,771.30645751953)
			setElementRotation( HE, 0, 0, 210 , "default", true )
		elseif(source==MarkerTortura)then
			setElementPosition( HE,2679.0275878906,-1063.3735351562,752.25)
			setElementRotation( HE, 0, 0, 210 , "default", true )
		elseif(source==MarkerTorturaE)then
			setElementPosition( HE,2713.8869628906,-1073.5274658203,750.60986328125)
			setElementRotation( HE, 0, 0, 270 , "default", true )
		elseif(source==MarkerDiscoAfuera)then
			setElementPosition( HE,2702.7976074219,-1125.1820068359,729.453125)
			setElementRotation( HE, 0, 0, 0 , "default", true )
		elseif(source==MarkerDiscoAdentro)then
			setElementPosition( HE,2710.2182617188,-1072.6741943359,767.79260253906)
			setElementRotation( HE, 0, 0, 210 , "default", true )
		end
	end
end
addEventHandler("onMarkerHit", MarkerAfuera, tpz)
addEventHandler("onMarkerHit", MarkerAdentro, tpz)
addEventHandler("onMarkerHit", MarkerBodegaAfuera, tpz)
addEventHandler("onMarkerHit", MarkerBodegaAdentro, tpz)
addEventHandler("onMarkerHit", MarkerAcensorAbajo, tpz)
addEventHandler("onMarkerHit", MarkerAcensorArriba, tpz)
addEventHandler("onMarkerHit", MarkerTortura, tpz)
addEventHandler("onMarkerHit", MarkerTorturaE, tpz)
addEventHandler("onMarkerHit", MarkerDiscoAfuera, tpz)
addEventHandler("onMarkerHit", MarkerDiscoAdentro, tpz)
