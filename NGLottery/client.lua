local locs = {
	{ 1072.6, -1385.51, 13.88, 139 }
}

local peds = { }
for i, v in ipairs ( locs ) do
	local x, y, z, rot = unpack ( v )
	peds[i] = createPed ( 57, x, y, z, rot )
	exports.NGJobs:create3DText ( "Loteria", { x, y, z }, { 255, 255, 0 }, nil, { } )
	exports.customblips:createCustomBlip ( x, y, 2, 2, "icon.png", 245 )
	setElementFrozen ( peds[i], true )
	addEventHandler ( "onClientPedDamage", peds[i], cancelEvent )


	local m = createMarker ( x, y, z - 1, "cylinder", 1.5, 0, 0, 0, 0 )
	addEventHandler ( "onClientMarkerHit", m, function ( p ) 
		if ( p == localPlayer and not isPedInVehicle ( p ) and not isElement ( window ) ) then
			createLotteryGUI ( )
		end
	end )
end



--------------------------
-- GUI					--
--------------------------
local sx, sy = guiGetScreenSize ( )
function createLotteryGUI ( )
	window = guiCreateWindow((sx/2-373/2), (sy/2-158/2), 373, 158, "Loteria de Medellin", false)
	guiWindowSetSizable(window, false)
	lbl1 = guiCreateLabel(94, 26, 264, 21, "Escoje un numero del 1 al 100.", false, window)
	lbl2 = guiCreateLabel(94, 47, 264, 44, "Cargando datos... Espera", false, window)
	num = guiCreateEdit(94, 91, 162, 28, "", false, window)
	img = guiCreateStaticImage(14, 47, 70, 65, ":NGLottery/icon.png", false, window)
	buy = guiCreateButton(256, 91, 58, 28, "Comprar", false, window)
	exit  = guiCreateButton(320, 91, 58, 28, "Cerrar", false, window)
	lbl4 = guiCreateLabel(93, 123, 163, 21, "Costo:$50000", false, window)    
	addEventHandler ( "onClientGUIClick", root, onClientGUIModify )
	showCursor ( true )
	triggerServerEvent ( "NGLotter->onClientRequestTimerDetails", localPlayer )
end

addEvent ( "NGLottery->onServerSendClientTimerDetails", true )
addEventHandler ( "NGLottery->onServerSendClientTimerDetails", root, function ( t ) 
	guiSetText ( lbl2, "Next lottery drawing time in\n"..tostring ( t ) )
end )

function onClientGUIModify( )
	local e = tostring ( eventName ):lower ( )
	if ( e == "onclientguiclick" ) then
		if ( source == buy ) then
			local n = tonumber ( guiGetText ( num ) )
			if ( n and n >= 1 and n <= 100 ) then
				triggerServerEvent ( "NGLottery->onClientAttemptToBuyLotteryTicket", localPlayer, n )
				destroyElement ( window )
				showCursor ( false )
				removeEventHandler ( "onClientGUIClick", root, onClientGUIModify )
			else
				return exports.NGMessages:sendClientMessage ( "\""..tostring ( n ) .."\" Es un numero invalido.", 255, 255, 0 )
			end
		elseif ( source == exit ) then
			destroyElement ( window )
			showCursor ( false )
			removeEventHandler ( "onClientGUIClick", root, onClientGUIModify )
		end
	end
end
