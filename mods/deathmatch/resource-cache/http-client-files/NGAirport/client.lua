local airPrice = 10000
local gR = getRootElement()
local gRR = getResourceRootElement( getThisResource() )
local gMe = getLocalPlayer()

local plane = createObject(1681,1480.6881103516,1896.1604003906,46.635292053223,0,0,180)
local thing = createObject( 3803,1503.2192382813,1730.5847167969,12.067991256714,0,0,316.32998657227)

local plane2 = createObject(1681,2175.23, -2496.49, 53.86,0,0,90)
local thing2 = createObject( 3803,1973.92, -2445.24, 13.55,0,0,316.32998657227)

local plane3 = createObject(1681,-1068.23, 423.68, 48.15,0,0,139.65)
local thing3 = createObject( 3803,-1165.06, 367.48, 14.15,0,0,316.32998657227)


setElementDimension( plane, 1 )
setElementDimension( plane2, 1 )
setElementDimension( plane3, 1 )
-- Guis
airWindow = guiCreateWindow(636, 324, 223, 233, "VivaColombia", false)
guiWindowSetSizable(airWindow, false)
guiSetProperty(airWindow, "CaptionColour", "FFE0F305")

label = guiCreateLabel(13, 23, 200, 36, "Viaja entre ciudades con la tarifa\neconomica de VivaColombia ("..tostring(airPrice).."$)", false, airWindow)
lsRadio = guiCreateRadioButton(27, 70, 176, 15, "Los Santos (LS)", false, airWindow)
guiSetProperty(lsRadio, "NormalTextColour", "FFFD0000")
guiRadioButtonSetSelected(lsRadio, true)
sfRadio = guiCreateRadioButton(27, 104, 176, 15, "San Fierro (SF)", false, airWindow)
guiSetProperty(sfRadio, "NormalTextColour", "FF12CCE8")
lvRadio = guiCreateRadioButton(27, 136, 176, 15, "Las Venturas (LV)", false, airWindow)
guiSetProperty(lvRadio, "NormalTextColour", "FF04F515")
goBtn = guiCreateButton(9, 180, 94, 35, "Tomar vuelo", false, airWindow)
exitBtn = guiCreateButton(113, 180, 94, 35, "Cancelar", false, airWindow)
guiSetVisible(airWindow,false)

function closeAirPanel()
showCursor(false)
guiSetEnabled(lsRadio,true)
guiSetEnabled(sfRadio,true)
guiSetEnabled(lvRadio,true)
guiSetVisible(airWindow,false)
end
addEventHandler ( "onClientGUIClick", exitBtn, closeAirPanel, false )

function takeFly()
	if getPlayerMoney(localPlayer) >= airPrice then
		if guiRadioButtonGetSelected(lsRadio) then
			showintro2()
		elseif guiRadioButtonGetSelected(sfRadio) then
			showintro3()
		elseif guiRadioButtonGetSelected(lvRadio) then
			showintro()
		else
			exports.NGMessages:sendClientMessage ("Selecciona una opcion",255,0,0)
		end
		guiSetEnabled(lsRadio,true)
		guiSetEnabled(sfRadio,true)
		guiSetEnabled(lvRadio,true)
		guiSetVisible(airWindow,false)
		showCursor(false)
	else
		exports.NGMessages:sendClientMessage ("No tienes el dinero suficiente.",255,0,0)
	end
	
end
addEventHandler ( "onClientGUIClick", goBtn, takeFly, false )
local markers = {
	{1685.77, -2237.54, 12.55}, --LS
	{-1421.2, -286.95, 13.15},
	{1672.54, 1447.83, 9.79}
}


function showAirPanel(hitPlayer, matchingDimension)
	if hitPlayer == localPlayer then
		if getPedOccupiedVehicle ( hitPlayer ) then return end
		local x,y,z = getElementPosition(hitPlayer) 
		local location = getZoneName ( x, y, z, true ) 
			if ( location == "Los Santos" ) then 
				guiSetVisible(airWindow,true)
				showCursor(true)
				guiRadioButtonSetSelected(sfRadio,true)
				guiSetEnabled(lsRadio,false)
			elseif ( location == "Las Venturas" ) then
				guiSetVisible(airWindow,true)
				showCursor(true)
				guiRadioButtonSetSelected(lsRadio,true)
				guiSetEnabled(lvRadio,false)
			elseif ( location == "San Fierro" ) then
				guiSetVisible(airWindow,true)
				showCursor(true)
				guiRadioButtonSetSelected(lsRadio,true)
				guiSetEnabled(sfRadio,false)
			end 
	end
end

for k,v in ipairs(markers) do
	local markerAir = createMarker ( v[1], v[2], v[3], "cylinder", 1.5, 255, 255, 0, 170 )
	--createBlipAttachedTo(markerAir, 5,2,0,0,0,0,0)
	addEventHandler ( "onClientMarkerHit", markerAir, showAirPanel )
end

function showintro()
  fadeCamera( false, 0.5, 0, 0, 0 )
  setTimer(
    function ()
		setElementDimension(gMe, 1)
		fadeCamera( true, 1.2, 0, 0, 0 )
		moveObject( plane, 9000, 1477.4921875,1621.83203125, 12.011219978333)
		addEventHandler( 'onClientPreRender', gR, updateCam1 )
		setTimer( function() removeEventHandler( 'onClientPreRender', root, updateCam1 ) setCameraTarget( gMe, gMe )  setElementDimension(gMe, 0)  moveObject( plane, 1, 1480.6881103516,1896.1604003906,46.635292053223) triggerServerEvent("serverTeleport",getLocalPlayer(),3,airPrice)end, 8900, 1 )
	end
  , 1000, 1 )
end



function showintro2()
  fadeCamera( false, 0.5, 0, 0, 0 )
  setTimer(
    function ()
		setElementDimension(gMe, 1)
		fadeCamera( true, 1.2, 0, 0, 0 )
		moveObject( plane2, 9000, 1922.2, -2493.39, 13.54)
		addEventHandler( 'onClientPreRender', gR, updateCam2 )
		setTimer( function() removeEventHandler( 'onClientPreRender', root, updateCam2 ) setCameraTarget( gMe, gMe )  setElementDimension(gMe, 0)  moveObject( plane2, 1, 2175.23, -2496.49, 53.86) triggerServerEvent("serverTeleport",getLocalPlayer(),1,airPrice) end, 8900, 1 )
	end
  , 1000, 1 )
end



function showintro3()
  fadeCamera( false, 0.5, 0, 0, 0 )
  setTimer(
    function ()
		setElementDimension(gMe, 1)
		fadeCamera( true, 1.2, 0, 0, 0 )
		moveObject( plane3, 9000, -1216.99, 275.52, 14.15)
		addEventHandler( 'onClientPreRender', gR, updateCam3 )
		setTimer( function() removeEventHandler( 'onClientPreRender', root, updateCam3 ) setCameraTarget( gMe, gMe )  setElementDimension(gMe, 0)  moveObject( plane3, 1, -1068.23, 423.68, 48.15) triggerServerEvent("serverTeleport",getLocalPlayer(),2,airPrice)end, 8900, 1 )
	end
  , 1000, 1 )
end




function updateCam1()
  local cx, cy, cz = getElementPosition( thing )
  local tx, ty, tz = getElementPosition( plane )
  setCameraMatrix ( cx, cy, cz, tx, ty, tz )
end

function updateCam2()
  local cx, cy, cz = getElementPosition( thing2 )
  local tx, ty, tz = getElementPosition( plane2 )
  setCameraMatrix ( cx, cy, cz, tx, ty, tz )
end

function updateCam3()
  local cx, cy, cz = getElementPosition( thing3 )
  local tx, ty, tz = getElementPosition( plane3 )
  setCameraMatrix ( cx, cy, cz, tx, ty, tz )
end




