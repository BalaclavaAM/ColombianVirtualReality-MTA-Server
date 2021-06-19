local fuelPrice = nil
local createBlips = true
local BuyCan = { }
local sx, sy = guiGetScreenSize ( )

setTimer ( function ( )

createBlips = exports.NGPhone:getSetting ( "usersetting_display_createfuelblips" )

addEvent ( "NGVehicles:Fuel:OnFuelPriceChange", true )
addEventHandler ( "NGVehicles:Fuel:OnFuelPriceChange", root, function ( p )
	fuelPrice = p
end )

local isRendering = false
local fuelingMarker = nil
function onFuelMarkerHit ( p )
	if ( p == localPlayer ) then
		local x, y, z = getElementPosition ( source )
		local px, py, pz = getElementPosition ( p )
		if ( getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) < 5) then
			if ( eventName == 'onClientMarkerHit' ) then
				if ( isPedInVehicle ( p ) ) then
					isRendering = true
					fuelingMarker = source
					addEventHandler ( "onClientRender", root, onFuelTextRender )
				else 
					openBuyWindow ( )
				end
			elseif ( eventName == 'onClientMarkerLeave' ) then
				if ( isRendering ) then
					isRendering = false
					fuelingMarker = nil
					removeEventHandler ( "onClientRender", root, onFuelTextRender )
				end
				closeBuyWindow ( )
			end
		end
	end
end

local tick = getTickCount ( )
function onFuelTextRender ( )
	if ( isRendering and isPedInVehicle ( localPlayer ) and getVehicleController ( getPedOccupiedVehicle ( localPlayer ) ) == localPlayer and isElementWithinMarker ( localPlayer, fuelingMarker ) ) then
		local car = getPedOccupiedVehicle ( localPlayer )
		local fuel = tonumber ( getElementData ( car, "fuel" ) )
		local vehicleType=getElementData(car, "vehicle:type")
		local handling = getVehicleHandling(car)
		local fueltank=getVehicleHandling(car)['mass']
		if ( fuel < fueltank ) then
			text = "Mantiene \""..refuelKey:upper().."\" para tanquear ($"..tostring(fuelPrice*(fueltank/100)).."/galón)\nTotal para retanquear: $"..(fueltank-fuel)*fuelPrice.." tu vehículo tiene: "..(fueltank/60).." galones."
			color = tocolor ( 255, 140, 0, 255 )
			if ( getKeyState ( refuelKey ) ) then
				if ( getPlayerMoney ( localPlayer ) >= fuelPrice*(fueltank/100) ) then
					if ( getTickCount ( ) - tick >= fuelDelay ) then
						setElementData ( car, "fuel", fuel + (fueltank/100) )
						triggerServerEvent ( "NGFuel:takeMoney", localPlayer, fuelPrice*(fueltank/100) )
						tick = getTickCount ( )
					end
				else
					text = "No hay suficiente plata"
					color = tocolor ( 255, 0, 0, 255 )
				end
			end
		else
			text = "El tanque está llena!"
			color = tocolor ( 0, 255, 0, 255 )
		end
		dxDrawText ( text, 2, 2, sx, sy / 1.2, tocolor ( 0, 0, 0, 255 ), 2, "default-bold", "center", "bottom" )
		dxDrawText ( text, 0, 0, sx, sy / 1.2, color, 2, "default-bold", "center", "bottom" )
	else
		isRendering = false
		fuelingMarker = nil
		removeEventHandler ( 'onClientRender', root, onFuelTextRender )
	end
end

local fuelBlips = { }
for i, v in pairs ( fuelLocations ) do 
	local x, y, z, blip = unpack ( v )
	local marker = createMarker ( x, y, z - 1, "cylinder", 3, 255, 140, 0, 140 )
	addEventHandler ( "onClientMarkerHit", marker, onFuelMarkerHit )
	addEventHandler ( "onClientMarkerLeave", marker, onFuelMarkerHit )
	if ( blip and createBlips ) then
		fuelBlips[i] = createBlip ( x, y, z, 48, 2, 255, 255, 255, 255, 0, 370 )
	end
end
setTimer ( triggerServerEvent, 500, 1, "NGVehicles:Fuel:OnClientRequestFuelPrice", localPlayer )


addEvent ( "onClientUserSettingChange", true )
addEventHandler ( "onClientUserSettingChange", root, function ( g, v )
	if ( g == "usersetting_display_createfuelblips" ) then
		for i, v in pairs ( fuelBlips ) do
			destroyElement ( fuelBlips[i] )
			fuelBlips[i] = nil
		end
		
		fuleBlips = { }
		if v == true then
			for i, v in pairs ( fuelLocations ) do 
				if ( v [ 4 ] ) then
					fuelBlips[i] = createBlip ( v[1], v[2], v[3], 48, 2, 255, 255, 255, 255, 0, 370 )
				end
			end
		end
	end
end )

end, 500, 1 )


-- buy fuel cans
function openBuyWindow ( )
	closeBuyWindow ( )
	BuyCan.window = guiCreateWindow((sx/2-359/2), (sy/2-193/2), 359, 193, "Fuel Cans", false)
	guiWindowSetSizable(BuyCan.window, false)
	BuyCan.Image = guiCreateStaticImage(10, 28, 100, 142, ":NGVehicles/fuel/fuel_icon.png", false, BuyCan.window)
	BuyCan.Label = guiCreateLabel(128, 28, 215, 85, "Te gustaría comprar un galón por 20.000?\n\nCon los galones puedes recargar 10% de la gasolina de tu vehiculo.", false, BuyCan.window)
	guiLabelSetHorizontalAlign ( BuyCan.Label, "left", true )
	BuyCan.Buy = guiCreateButton(249, 134, 94, 36, "Buy Fuel Can", false, BuyCan.window)
	BuyCan.Close = guiCreateButton(149, 134, 94, 36, "Close", false, BuyCan.window)
	showCursor ( true )
	
	addEventHandler ( "onClientGUIClick", BuyCan.Close, closeBuyWindow )
	addEventHandler ( "onClientGUIClick", BuyCan.Buy, onClientBuyFuelCan )
end

function closeBuyWindow ( )
	if ( isElement ( BuyCan.Close ) ) then
		removeEventHandler ( "onClientGUIClick", BuyCan.Buy, closeBuyWindow )
		destroyElement ( BuyCan.Close )
	end if ( isElement ( BuyCan.Buy ) ) then
		removeEventHandler ( "onClientGUIClick", BuyCan.Buy, onClientBuyFuelCan )
		destroyElement ( BuyCan.Buy )
	end if ( isElement ( BuyCan.window ) ) then
		destroyElement ( BuyCan.window )
	end
	showCursor ( false )
end

function onClientBuyFuelCan ( )
	if ( getPlayerMoney ( ) < 20000 ) then
		return exports.NGMessages:sendClientMessage ( "No tienes dinero para comprar esto. ", 255, 0, 0 )
	end
	
	exports.NGMessages:sendClientMessage ( "Compraste gasolina por 20.000 pesitos. Presiona F6 para usarla en un vehículo.", 0, 255, 0 )
	triggerServerEvent ( "NGFuel:takeMoney", localPlayer, 20000 )
	
	local userItems = getElementData ( localPlayer, "NGUser:Items" )
	if ( not userItems.FuelCans ) then
		userItems.FuelCans = 0;
	end
	userItems.FuelCans = userItems.FuelCans + 1;
	setElementData ( localPlayer, "NGUser:Items", userItems )
end

