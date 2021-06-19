

moneyX = 5 -- в сколько раз будет умнажатся проеханая дистанция для выдачи бабла

ped = {}
vehTaxi = {}

function playerLogin (thePreviousAccount, theCurrentAccount, autoLogin)
  if not (isGuestAccount (getPlayerAccount (source))) then
	if getAccountData ( theCurrentAccount, "passagir_Taxi_value" ) then
		local passagir = getAccountData(theCurrentAccount,"passagir_Taxi_value")
		setElementData(source,"passagir_Taxi_value",tonumber(passagir))
	else
		setElementData(source,"passagir_Taxi_value", 0)
	end
  end
end
addEventHandler ("onPlayerLogin", getRootElement(), playerLogin)

function onQuit (quitType, reason, responsibleElement)
  if not (isGuestAccount (getPlayerAccount (source))) then
    account = getPlayerAccount (source)
    if (account) then
		if getElementData ( source, "passagir_Taxi_value" ) then
			local passagir = getElementData(source,"passagir_Taxi_value")
		    setAccountData (account, "passagir_Taxi_value", tonumber(passagir))
	    end
    end
  end
end
addEventHandler ("onPlayerQuit", getRootElement(), onQuit)


local markerStartWin = createMarker( 2007.88, -1267.64, 23.98-1, "cylinder", 1.5, 0, 255, 0, 50 )
local blip = createBlipAttachedTo ( markerStartWin, 42, 2.5, 0, 0, 0, 255, 0, 200)

function markerTaxi(marker, player)
if marker == markerStartWin then
	if not isPedInVehicle(source) then
		if not getElementData(source, "JobTaxi") then
			triggerClientEvent (source, "StartWinTaxi", getRootElement(), source )
		else
			triggerClientEvent (source, "StartWinTaxi2", getRootElement(), source )
		end
	end
end
end
addEventHandler("onPlayerMarkerHit",getRootElement(),markerTaxi)

function WorkTaxi(player, state)
	if state then
		if getElementData(player,"Job") == "Taxista" then
			setElementData(player, "JobTaxi", true)
			local passagir = getElementData(player,"passagir_Taxi_value")
			if tonumber(passagir) <= 99 then
			outputChatBox("#9ACD32[Trabajo]: #FFFFFFEmpezaste a trabajar como taxista!", player, 200, 200, 200, true)
			outputChatBox("#DAA520[Informacion]: #FFFFFFHas llevado "..tonumber(passagir).." pasajeros, son 100 para llegar a nivel 2.", player, 200, 200, 200, true)
			elseif tonumber(passagir) == 100 then
				outputChatBox("#9ACD32[Trabajo]: #FFFFFF¡Comenzaste el trabajo de un taxista!", player, 200, 200, 200, true)
				outputChatBox("#DAA520[Informacion]: #FFFFFFУtu nivel 2.", player, 200, 200, 200, true)
			end
			setElementData(player,"distance_Taxi_Ped",0)
			SpawnVehicleStartJob(player)
			MarkerZakazPickups(player)
		else
			outputChatBox("#9ACD32[Trabajo]: #FFFFFFTienes que ser taxista para empezar a laburar como uno!", player, 200, 200, 200, true)
		end
	else
		setElementData(player, "JobTaxi", false)
		outputChatBox("#9ACD32[Trabajo]: #FFFFFFHas terminado el trabajo de un taxista!", player, 200, 200, 200, true)
		setElementData(player,"distance_Taxi_Ped",0)
		destroyVehicle(player)
		destroyMarkerBlips(player)
		local ped = getElementData(player,"ped_Taxi")
		if (isElement(ped)) then destroyElement(ped)end
		setElementData(player,"ped_Taxi",false)
	end
end
addEvent("StartJobTaxi", true)
addEventHandler("StartJobTaxi", getRootElement(), WorkTaxi)

function enterVehicle ( thePlayer, seat, jacked )
	if (getElementModel(source) == 420) then
		if getElementData(source, "vehicleTaxiIDs") then
			if getElementData(thePlayer, "JobTaxi") then
				local veh = getElementData(thePlayer,"vehicleTaxi")
				local vehH = getPedOccupiedVehicle ( thePlayer )
				if not (veh) == (vehH) then
					setControlState ( thePlayer, "enter_exit", true )
					outputChatBox ( "Este auto de la compañía no es tuyo!", thePlayer,255,0,0,true )
				end
			else
				setControlState ( thePlayer, "enter_exit", true )
				outputChatBox ( "Este es un auto de la compañía!", thePlayer,255,0,0,true )
			end
		end
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle ) 

function enterVehicle ( thePlayer, seat, jacked )
	if (getElementModel(source) == 420) then
		if getElementData(source, "vehicleTaxiIDs") then
			if getElementData(thePlayer, "JobTaxi") then
				local veh = getElementData(thePlayer,"vehicleTaxi")
				local vehH = getPedOccupiedVehicle ( thePlayer )
				if not (veh) == (vehH) then
					setControlState ( thePlayer, "enter_exit", true )
					outputChatBox ( "Este auto de la compañía no es tuyo!", thePlayer,255,0,0,true )
				end
			else
				setControlState ( thePlayer, "enter_exit", true )
				outputChatBox ( "Este es un auto de la compañía!", thePlayer,255,0,0,true )
			end
		end
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle ) 

local vehPOS = {
[1]={1993.64, -1276.81, 23.82},
[2]={1987.24, -1276.49, 23.82},
[3]={1982, -1276.9, 23.82},
[4]={1974.43, -1276.45, 23.82}
}

timers = {}
function SpawnVehicleStartJob(player)
if getElementDimension(player)~=0 then return end
local passagir = getElementData(player,"passagir_Taxi_value")
	local x, y, z = unpack ( vehPOS [ math.random ( #vehPOS ) ] )
	if tonumber(passagir) <= 99 then
		vehTaxi[player] = createVehicle (420,x, y, z,0,0,-90)
	elseif tonumber(passagir) == 100 then
		vehTaxi[player] = createVehicle (420,x, y, z,0,0,-90)
	end
	setElementData(vehTaxi[player],"vehicleTaxiIDs", true)
	setElementData(player,"vehicleTaxi", vehTaxi[player])
	warpPedIntoVehicle(player,vehTaxi[player])
end

function destroyVehicle(player)
local veh = getElementData(player,"vehicleTaxi")
if isElement(veh) then destroyElement(veh) end
setElementData(player,"vehicleTaxi", false)
end

-- маркеры где будут пассажири или точки куда вести пассажира
local pickups = {
[1]={2231.32, -1726.63, 13.55},
[2]={2104.53, -1607.68, 13.55},
[3]={1827.37, -1842.86, 13.58},
[4]={1841.2, -1314.08, 13.55},
[5]={2229.67, -1142.25, 25.8},
[6]={2579.24, -1042.51, 69.58},
[7]={2826.86, -1483.03, 13.48},
[8]={2818.13, -1861.68, 11.2},
[9]={2483.37, -2660.84, 13.65},
[10]={1471.35, -2246.66, 13.24},
[11]={779.5, -1789.19, 13.15},
[12]={815.5, -1390.16, 13.62},
[13]={522.7, -1450.88, 15.34},
[14]={291.5, -1230.24, 75.4},
[15]={266.9, -1009.75, 54.15},
[16]={835.15, -865.54, 69},
[17]={1190.37, -1154.9, 23.9},
[18]={1324.61, -1275.44, 13.55},
[19]={1218.29, -1577.71, 13.53},
[20]={1486.26, -1586.94, 13.55},
[21]={1242.28, -2056.89, 60.08},
[22]={1352.16, -2330.36, 13.55},
[23]={1744.73, -2118.51, 13.55},
[24]={1945.79, -2172.22, 13.55},
[25]={2498.98, -1653.83, 13.44},
[26]={2425.25, -1466.03, 24},
[27]={2464.65, -752.72, 106.04},
[28]={2266.52, -1433.42, 24},
[29]={1522.66, -800.52, 73.29},
[30]={1249.51, -736.25, 94.76},
[31]={1317.93, -503.1, 67.79},
[32]={338.41, -123.56, 1.48},
[33]={636.02, -569.54, 16.34},
[34]={1048.81, -442.87, 51.18}
}
local skinID = { 1,2,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51 }

-- []={}
markers = {}
blips = {}
function MarkerZakazPickups(player)
    local x, y, z = unpack ( pickups [ math.random ( #pickups ) ] )
	local meX, meY = getElementPosition(player)
	local distance = math.ceil(getDistanceBetweenPoints2D(x, y, meX, meY))
	if distance <= 550 and distance >= 100 then
		local skin = skinID[math.random(#skinID)]
		ped[player] = createPed(skin,x, y, z)
		setElementFrozen(ped[player],true)
		setElementData(player,"ped_Taxi",ped[player])
		markers [ player ] = createMarker ( x, y, z, "cylinder", 4, 255, 255, 0, 120, player )
		blips [ player ] = createBlipAttachedTo ( markers [ player ], 19, 2.5, 255, 0, 0, 255, 0, 99999, player)
		addEventHandler ( "onMarkerHit", markers [ player ], onTaxiMarker1 )
		outputChatBox("#0011ff[Taxi]: #FFFFFFTienes una nueva carrera, ve icono de la banderita roja en el mapa.",player,0,255,0,true)
		setElementData(player,"distance_Taxi_Ped", distance)
	else
		MarkerZakazPickups(player)
	end
end

function onTaxiMarker1(player)
if isElement(markers[player]) then
	local veh = getElementData(player,"vehicleTaxi")
	if getElementData(player, "JobTaxi") then
	if isPedInVehicle(player) then
		local vehH = getPedOccupiedVehicle ( player )
		if (getElementModel(vehH) == 420) then
			if (isElement(markers[player])) then destroyElement(markers[player])end
			if (isElement(blips[player])) then destroyElement(blips[player])end
			MarkerZakazPickups2PedOtprav(player)
		end
	end
	end
end
end

function MarkerZakazPickups2PedOtprav(player)
    local x, y, z = unpack ( pickups [ math.random ( #pickups ) ] )
	local meX, meY = getElementPosition(player)
	local distance = math.ceil(getDistanceBetweenPoints2D(x, y, meX, meY))
	if distance >= 300 then
		local veh = getElementData(player,"vehicleTaxi")
		local ped = getElementData(player,"ped_Taxi")
		warpPedIntoVehicle(ped,veh,2)
		markers [ player ] = createMarker ( x, y, z, "cylinder", 2, 255, 255, 0, 120, player )
		blips [ player ] = createBlipAttachedTo ( markers [ player ], 19, 2.5, 255, 0, 0, 255, 0, 99999, player)
		addEventHandler ( "onMarkerHit", markers [ player ], onTaxiMarker2 )
		local location = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		outputChatBox("#8700ff[Pasajero]: #FFFFFFLlevame a#19ff00 "..location.." #FFFFFF( #19ff00"..city.." #FFFFFF).",player,0,255,0,true)
		local destMoneyPed = getElementData(player,"distance_Taxi_Ped")
		setElementData(player,"distance_Taxi_Ped",destMoneyPed+distance)
	else
		MarkerZakazPickups2PedOtprav(player)
	end
end

function onTaxiMarker2(player)
if isElement(markers[player]) then
	local veh = getElementData(player,"vehicleTaxi")
	if getElementData(player, "JobTaxi") and getElementData(player,"Job") == "Taxista" then
	if isPedInVehicle(player) then
	local vehH = getPedOccupiedVehicle ( player )
		if (getElementModel(vehH) == 420) then
			local ped = getElementData(player,"ped_Taxi")
			if (isElement(ped)) then destroyElement(ped)end
			setElementData(player,"ped_Taxi",false)
			local money = getElementData(player,"distance_Taxi_Ped")
			local money = money*moneyX*1.9
			givePlayerMoney(player,money)
			local x,y,z = getElementPosition(player)
			local location = getZoneName ( x,y,z-1 )
			local city = getZoneName ( x,y,z, true )
			outputChatBox("#DAA520[Informacion]: #FFFFFFTrajiste al pasajero a#19ff00 "..location.." #FFFFFF(#19ff00"..city.."#FFFFFF),él te pagó #19ff00"..money.."$#FFFFFF.",player,0,255,0,true)
			local passagir = getElementData(player,"passagir_Taxi_value")
			if tonumber(passagir) <= 99 then
				setElementData(player,"passagir_Taxi_value",tonumber(passagir)+1)
				local passagirr = getElementData(player,"passagir_Taxi_value")
				outputChatBox("#DAA520[Informacion]: #FFFFFFTotal de pasajeros llevados:#DAA520 "..tonumber(passagirr),player,255,255,0,true)
			end
			setElementData(player,"distance_Taxi_Ped",0)
			if (isElement(markers[player])) then destroyElement(markers[player])end
			if (isElement(blips[player])) then destroyElement(blips[player])end
			--MarkerZakazPickups(player)
			outputChatBox("#0011ff[Taxi]: #FFFFFFEspera una nueva carrera.",player,0,255,0,true)
			local randTime = math.random(5000,20000)
		    setTimer(function ()
				MarkerZakazPickups(player)
			end, randTime, 1)
		end
	end
	end
end
end

function destroyMarkerBlips(player)
if (isElement(markers[player])) then destroyElement(markers[player])end
if (isElement(blips[player])) then destroyElement(blips[player])end
end

addEventHandler ( "onPlayerQuit", getRootElement(), function()
if getElementData(source, "JobTaxi") then
	if (isElement(markers[source])) then destroyElement(markers[source])end
	if (isElement(blips[source])) then destroyElement(blips[source])end
		local ped = getElementData(source,"ped_Taxi")
			if (isElement(ped)) then 
			destroyElement(ped)
			setElementData(source,"ped_Taxi",false)
		end
		setElementData(source, "JobTaxi", false)
		setElementData(source,"distance_Taxi_Ped",0)
		local veh = getElementData(source,"vehicleTaxi")
		if isElement(veh) then 
			destroyElement(veh)
			setElementData(source,"vehicleTaxi", false)
		end
	end
end)

addEventHandler ( "onPlayerWasted", getRootElement(), function()
if getElementData(source, "JobTaxi") then
if (isElement(markers[source])) then destroyElement(markers[source])end
if (isElement(blips[source])) then destroyElement(blips[source])end
	local ped = getElementData(source,"ped_Taxi")
		if (isElement(ped)) then 
		destroyElement(ped)
		setElementData(source,"ped_Taxi",false)
	end
	setElementData(source, "JobTaxi", false)
	setElementData(source,"distance_Taxi_Ped",0)
	local veh = getElementData(source,"vehicleTaxi")
	if isElement(veh) then 
		destroyElement(veh)
		setElementData(source,"vehicleTaxi", false)
	end
	outputChatBox("Fuiste despedido de taxista!",source,255,0,0)
end
end)




