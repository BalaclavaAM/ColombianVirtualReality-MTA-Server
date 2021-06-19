local drivers = {}
local blips = {}
local acCheck = {}

function updateBusBlips(line)
	local driversonline = 0
	for k, v in ipairs(drivers[line]) do
		driversonline = driversonline + #v
	end
	
	if driversonline > 0 then
		for k, v in ipairs(drivers[line]) do
			if #(drivers[line][k-1] or {}) + #v > 0 then
				setBlipColor( blips[line][k], 127, 255, 63, 127 )
			else
				setBlipColor( blips[line][k], 255, 255, 63, 127 )
			end
		end
	else
		for k, v in ipairs(blips[line]) do
			setBlipColor( v, 255, 63, 63, 127 )
		end
	end
end

function removeDriver()
	for k, v in ipairs(drivers) do
		for key, value in ipairs(v) do
			for i, player in pairs(value) do
				if player == source then
					table.remove(value, i)
				end
			end
		end
	end
end

function removeDriverOnAllLines()
	removeDriver()
	for line, v in pairs(drivers) do
		updateBusBlips(line)
	end
end
addEventHandler( "onPlayerQuit", getRootElement(), removeDriverOnAllLines )
addEventHandler("onCharacterLogin", getRootElement(), removeDriverOnAllLines )

local secretHandle = ''

function allowElementData(thePlayer, index)
	setElementData(thePlayer, secretHandle.."p:"..index, false, false)
end

function protectElementData(thePlayer, index)
	setElementData(thePlayer, secretHandle.."p:"..index, true, false)
end

function changeProtectedElementData(thePlayer, index, newvalue)
	allowElementData(thePlayer, index)
	setElementData(thePlayer, index, newvalue)
	protectElementData(thePlayer, index)
end

function changeProtectedElementDataEx(thePlayer, index, newvalue, sync, nosyncatall)
	if (thePlayer) and (index) then
		if not newvalue then
			newvalue = nil
		end
		if not nosyncatall then
			nosyncatall = false
		end
	
		allowElementData(thePlayer, index)
		if not setElementData(thePlayer, index, newvalue, sync) then
		--	if not thePlayer or not isElement(thePlayer) then
		--	outputDebugString("changeProtectedElementDataEx")
		-- --	outputDebugString(tostring(thePlayer))
		--  outputDebugString("index: "..index)
		--	outputDebugString("newvalue: "..tostring(newvalue))
		--	outputDebugString("sync: "..tostring(sync))
		--	end
		end
		if not sync then
			if not nosyncatall then
				if getElementType ( thePlayer ) == "player" then
				end
			end
		end
		protectElementData(thePlayer, index)
		return true
	end
	return false
end

function fetchH()
	return secretHandle
end

function payBusDriver(line, stop)
	local seat = getPedOccupiedVehicleSeat(client)
	if not seat or seat ~= 0 then
		return
	end
	
	if (acCheck[client] == stop) and (stop ~= -1) then
		triggerBusCheatDetection(client,stop)
	end
	acCheck[client] = stop

	if stop == -2 then
		removeDriver()
		givePlayerMoney(client, 600)
	elseif stop == -1 then
		removeDriverOnAllLines()
		return
	elseif stop == 0 then
		table.insert( drivers[line][1], client )
	else
		givePlayerMoney(client, 300)

		if drivers[line][stop+1] then
			removeDriver()
			table.insert( drivers[line][stop+1], client )
		end
	end
	updateBusBlips(line)
end
addEvent("payBusDriver",true)
addEventHandler("payBusDriver", getRootElement(), payBusDriver)

function payPasaje(thePlayer, driver)
	if (getElementData(driver,"Job") == "Busetero") then
		takePlayerMoney ( thePlayer, 1800 )
		givePlayerMoney ( driver, 1800 )
		outputChatBox ("[CVR]"..getPlayerName(thePlayer).." te pagó 1800 por entrar al bus", driver, 0, 255, 0 )
		outputChatBox("Pagaste 1800 pa montar en el bus", thePlayer, 0, 255, 0)
	else
		outputChatBox("Sé busetero para que te paguen el pasaje cuando suban a este vehículo" , driver, 0, 255, 0 )
	end
end
addEvent("payPasaje",true)
addEventHandler("payPasaje", getRootElement(), payPasaje)


function triggerBusCheatDetection(thePlayer,stop)
	exports['NGMessages']:sendClientMessage ("[payBusDriver]".. getPlayerName(thePlayer) .. " " .. getPlayerIP(thePlayer) .. " used the same stop twice ("..stop..")" , 32)
end

function busAdNextStop(line, stop)
	local seat = getPedOccupiedVehicleSeat(source)
	if not seat or seat ~= 0 then
		return
	end
	
	exports['NGMessages']:sendClientMessage (source, " -- Esta parada: [".. g_bus_routes[line].stops[stop] .. "] --", 255, 51, 102)
	if(stop<#g_bus_routes[line].stops)then
		exports['NGMessages']:sendClientMessage (source, " -- Siguiente parada: [".. g_bus_routes[line].stops[stop+1] .. "] --", 255, 51, 102)
	end
end
addEvent("busAdNextStop",true)
addEventHandler("busAdNextStop", getRootElement(), busAdNextStop)

function takeBusFare(thePlayer)
	exports.global:takeMoney(source, 5)
	givePlayerMoney(thePlayer, 5)
end
addEvent("payBusFare", true)
addEventHandler("payBusFare", getRootElement(), takeBusFare)

function ejectPlayerFromBus()
	changeProtectedElementDataEx(source, "realinvehicle", 0, false)
	removePedFromVehicle(source)
end
addEvent("removePlayerFromBus", true)
addEventHandler("removePlayerFromBus", getRootElement(), ejectPlayerFromBus)

-- BUS ROUTES BLIPS
function createBusBlips( )
	for routeID, route in ipairs( g_bus_routes ) do
		blips[routeID] = {}
		drivers[routeID] = {}
		for pointID, point in ipairs( route.points ) do
			if point[4] and #route.points ~= pointID then
				local stop = #blips[routeID]+1
				blips[routeID][stop] = createBlip( point[1], point[2], point[3], 0, 1, 255, 63, 63, 127, -5, 65 )
				drivers[routeID][stop] = {}
			end
		end
	end
end
addEventHandler( "onResourceStart", getResourceRootElement(), createBusBlips )