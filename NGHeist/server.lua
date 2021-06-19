criminals = {}
polices = {}
vans = {}
moneyBags = {}
moneyBagsDrop = {}
timeStart = 30000
bankDim = 233
items = {}
drill = {}
peds = {}
moneyBagsMarkers = {}
local minPlayers = 2
local minPolices = 2
local team = getTeamFromName("Criminals")
local policeTeam = getTeamFromName("Law Enforcement")

pedsData = {
		{141,356.3, 178.68, 1008.38,270},
		{186,359.71, 173.64, 1008.39,270},
		{240,356.3, 168.69, 1008.38,270},
}
drillData = {
	{2985,346.10001,156.10001,1013.2,0,0,92},
	{919,346.29999,156.2,1013.6,0,0,0},
	{2902,346.29999,155.89999,1014.2,0,0,0},
	{918,346.89999,156.8,1013.6,0,0,0},
	{354,345.79999,159.7,1013.4,0,0,0},
	{2780,346.70001,160,1013.2,0,0,0},
}
finishPos = {
	{2787.83, -2418.11, 13.63},
	{844.05, -600.94, 18.42},
	{1610.67, -1819.49, 13.48},
	{-68.39, -1586.53, 2.62},
}
escapePos ={
	{961.9, -1126.57, 23.67},
	{1156.31, -1039.41, 31.74},
	{878.02, -992.03, 35.44},
	{1138.37, -949.96, 42.61},
	
	
}
policeSpawns = {
	{376.42, 187.64, 1008.39},
	{354.34, 206.82, 1008.38},
	{366.72, 192.97, 1008.38},
	{361.62, 173.39, 1025.79},
	{355.03, 150.77, 1025.79},
	{347.36, 160.49, 1025.79},
}

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function stopBankHeist()
	timeStart = 30000
	for k,v in pairs(criminals) do
		triggerClientEvent(v,"clearHeist",v)
		criminals[v] = nil
	end
	for k,v in pairs(polices) do
		triggerClientEvent(v,"clearHeist",v)
		polices[k] = nil
	end
	for k,v in pairs(vans) do
		if isElement(v) then
			destroyElement(v)
		end
		vans[k] = nil
	end
	
	for k,v in pairs(items) do
		if isElement(v) then
			destroyElement(v)
		end
		items[k] = nil
	end
	
	for k,v in pairs(moneyBags) do
		if isElement(v) then
			destroyElement(v)
		end
		moneyBags[k] = nil
	end
	
	for k,v in pairs(moneyBagsDrop) do
		if isElement(moneyBagsDrop) then
			destroyElement(moneyBagsDrop)
		end
		moneyBagsDrop[k] = nil
	end
	
	for k,v in pairs(drill) do
		if isElement(v) then
			destroyElement(v)
		end
		drill[k] = nil
	end
	
	for k,v in pairs(peds) do
		if isElement(v) then
			destroyElement(v)
		end
		peds[k] = nil
	end
	
	for k,v in pairs(moneyBagsMarkers) do
		if isElement(v) then
			destroyElement(v)
		end
		moneyBagsMarkers[k] = nil
	end
	
	if isElement(moneyDropMarker) then
		destroyElement(moneyDropMarker)
		moneyDropMarker = nil
	end
	
	if isElement(exitMarker) then
		destroyElement(exitMarker)
		exitMarker = nil
	end
	
	if isElement(escapeMarker) then
		destroyElement(escapeMarker) 
		escapeMarker = nil
	end
	
	if isElement(escapeBlip) then
		destroyElement(escapeBlip)
		escapeBlip = nil
	end
	
	if isElement(finishMarker) then
		destroyElement(finishMarker) 
		finishMarker = nil
	end
	
	if isElement(finishBlip) then
		destroyElement(finishBlip)
		finishBlip = nil
	end
	
	if isElement(c4Marker) then
		destroyElement(c4Marker) 
		c4Marker = nil
	end
	
	if isElement(drillMarker) then
		destroyElement(drillMarker)
		drillMarker = nil
	end
	
	if isElement(moneyMarker) then
		destroyElement(moneyMarker) 
		moneyMarker = nil
	end
	
	
	if isElement(securiCar) then
		destroyElement(securiCar)
		securiCar = nil
	end
	if isTimer(failTimer) then
		killTimer(failTimer)
	end
	setTeamFriendlyFire ( team , true )
	setTeamFriendlyFire(getTeamFromName("Law Enforcement"), true)
	setTimer(function() loadBankHeist() end,30*60*1000,1)
end

function takeBagOfMoneyFromGround(hitElement,matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) ~= "player" then return end
	if getPlayerTeam(hitElement) ~= team then return end
	if getElementData(hitElement,"hasBag") then exports.NGMessages:sendClientMessage("Ya llevas un maletin de dinero en tu mano!",hitElement,255,0,0) return end
	local id = getElementData(source,"bagId")
	destroyElement(moneyBags[id])
	moneyBags[id] = nil
	
	local x,y,z = getElementPosition(hitElement)
	moneyBags[id] = createObject(1210,x,y,z)
	setElementCollisionsEnabled(moneyBags[id],false)
	setElementData(hitElement,"hasBag", true)
	setElementData(hitElement,"bagId",id)
	setElementInterior(moneyBags[id],3)
	setElementDimension(moneyBags[id],bankDim)
	exports.bone_attach:attachElementToBone(moneyBags[id],hitElement,12,0,0.05,0.27,0,180,0)
	destroyElement(source)
	moneyBagsDrop[id] = nil
end

addEventHandler("onPlayerQuit", root,
	function()
		if criminals[source] == source then
			if getElementData(source,"hasBag") then
					local x,y,z = getElementPosition(source)
					local id = getElementData(source,"bagId")
					destroyElement(moneyBags[id])
					moneyBags[id]= nil
					moneyBags[id] = createObject(1210,x,y,z)
					setElementCollisionsEnabled(moneyBags[id],false)
					moneyBagsMarkers[id] = createMarker(x,y,z,"corona",0.5,255,0,0,120)
					setElementData(moneyBagsMarkers[id],"bagId",id)
					addEventHandler("onMarkerHit", moneyBagsMarkers[id], takeBagOfMoneyFromGround)
					setElementData(source,"hasBag", false)
					setElementData(source,"bagId", false)
					setElementInterior(moneyBags[id],3)
					setElementDimension(moneyBags[id],bankDim)
					setElementInterior(moneyBagsMarkers[id],3)
					setElementDimension(moneyBagsMarkers[id],bankDim)
				end
				criminals[source] = nil
				local totalCrims = tablelength(criminals)
				for k,v in pairs(criminals) do
					triggerClientEvent(v,"updateCounterCrim",v,totalCrims )
				end
				for k,v in pairs(polices) do
					triggerClientEvent(v,"updateCounterCrim",v,totalCrims)
				end
			if tablelength(criminals) == 0 then
				exports.NGMessages:sendClientMessage("Los criminales han fallado el robo del banco!",root,255,0,0)
				for k,v in pairs(polices) do
					local copMoney = 10000
					exports.NGMessages:sendClientMessage("Has detenido el robo y has ganado"..copMoney.." sal del banco normalmente!",v,0,0,255)
					givePlayerMoney(v,copMoney)
					setElementDimension(v,1)
				end
				stopBankHeist()
			end
		elseif polices[source] == source then
			polices[source] = nil
			local totalPolice = tablelength(polices)
			for k,v in pairs(criminals) do
				triggerClientEvent(v,"updateCounterPolice",totalPolice)
			end
			for k,v in pairs(polices) do
				triggerClientEvent(v,"updateCounterPolice",totalPolice)
			end
		end
	end
)

addEventHandler("onPlayerWasted", root, 
	function( ammo, attacker, weapon, bodypart)
		if criminals[source] == source then
			givePlayerMoney(attacker,5000)
			if getElementData(source,"hasBag") then
				local x,y,z = getElementPosition(source)
				local id = getElementData(source,"bagId")
				destroyElement(moneyBags[id])
				moneyBags[id]= nil
				moneyBags[id] = createObject(1210,x,y,z)
				setElementCollisionsEnabled(moneyBags[id],false)
				moneyBagsMarkers[id] = createMarker(x,y,z,"corona",0.5,255,0,0,120)
				setElementData(moneyBagsMarkers[id],"bagId",id)
				addEventHandler("onMarkerHit", moneyBagsMarkers[id], takeBagOfMoneyFromGround)
				setElementData(source,"hasBag", false)
				setElementData(source,"bagId", false)
				setElementInterior(moneyBags[id],3)
				setElementDimension(moneyBags[id],bankDim)
				setElementInterior(moneyBagsMarkers[id],3)
				setElementDimension(moneyBagsMarkers[id],bankDim)
			end
			
			criminals[source] = nil
			local totalCrims = tablelength(criminals)
			for k,v in pairs(criminals) do
				triggerClientEvent(v,"updateCounterCrim",v,totalCrims )
			end
			for k,v in pairs(polices) do
				triggerClientEvent(v,"updateCounterCrim",v,totalCrims)
			end
			
			if tablelength(criminals) == 0 then
				exports.NGMessages:sendClientMessage("Los criminales han fallado el robo del banco!",root,255,0,0)
				for k,v in pairs(polices) do
					local copMoney = 15000
					exports.NGMessages:sendClientMessage("Has detenido el robo y has ganado"..copMoney.." sal del banco normalmente!",v,0,0,255)
					givePlayerMoney(v,copMoney)
					setElementDimension(v,1)
					triggerClientEvent(v,"clearHeist",v)
				end
				stopBankHeist()
			end
			
		elseif polices[source] == source then
			polices[source] = nil

			local totalPolice = tablelength(polices)
			for k,v in pairs(criminals) do
				triggerClientEvent(v,"updateCounterPolice",v,totalPolice)
			end
			for k,v in pairs(polices) do
				triggerClientEvent(v,"updateCounterPolice",v,totalPolice)
			end
		end
		triggerClientEvent(source,"clearHeist",source )
		
	end
)

function plantC4(hitElement, matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) ~= "player" then return end
	if getPlayerTeam(hitElement) ~= team then return end
	destroyElement(source)
	setPedAnimation(hitElement, "colt45", "colt45_reload",-1,true,false,true)
	for k,v in pairs(criminals) do
		exports.NGMessages:sendClientMessage("El usuario "..getPlayerName(hitElement).." ha plantado el C4, alejate!",v,255,0,0)
	end
	setTimer(function()
		setPedAnimation(hitElement)
		items["c4"] = createObject(1654,371.79998779297,166.60000610352,1008.9000244141,0,0,180)
		setElementDimension(items["c4"],bankDim)
		setElementInterior(items["c4"],3)
		setTimer( function()
			createExplosion(371.79998779297,166.60000610352,1008.9000244141,10)
			if isElement(items["c4"]) then destroyElement(items["c4"]) end
			if isElement(items["door"]) then destroyElement(items["door"]) end
		end,30000,1)
	end,3000,1)
	
end

function dropMoney(hitElement, matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) ~= "player" then return end
	if not getElementData(hitElement,"hasBag") then return end
	if getPlayerTeam(hitElement) ~= team then return end
	local bagId = getElementData(hitElement,"bagId")
	moneyBagsDrop[bagId] = bagId
	destroyElement(moneyBags[bagId])
	setElementData(hitElement, "hasBag", false)
	setElementData(hitElement, "bagId", false)
end

function exitTo(hitElement, matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) ~= "player" then return end
	if getPlayerTeam(hitElement) ~= team then return end
	if tablelength(polices) ~= 0 then exports.NGMessages:sendClientMessage("Debes asesinar a todos los policias del lugar!",hitElement,255,0,0)return end
	setElementInterior(hitElement,0)
	setElementPosition(hitElement, 943.44+math.random(0,1), -1018.79, 48.73)
	exports.NGMessages:sendClientMessage("Prepara la huida, cuando esten listos pasen por el marcador rojo, el carro de seguridad debe ir con ustedes!",hitElement,255,0,0)
end

addEventHandler("onVehicleExplode",resourceRoot,
	function()
		if source == securiCar then
			exports.NGMessages:sendClientMessage("Los Criminales han fallado el robo del banco!",root,255,0,0)
			stopBankHeist()
		end
	end
)

function escape(hitElement, matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) == "vehicle" then
		local ocupants = getVehicleOccupants(hitElement)
		setElementDimension(hitElement,0)
		for k,v in pairs( ocupants ) do 
			setElementDimension(v, 0)
			exports.NGMessages:sendClientMessage("Escolta el vehiculo de seguridad hasta el marcador de sirena rojo!",v,255,0,0)
		end
	elseif getElementType(hitElement) =="player" then
		setElementDimension(hitElement,0)
		exports.NGMessages:sendClientMessage("Escolta el vehiculo de seguridad hasta el marcador de sirena rojo!",hitElement,255,0,0)
	end

end
function finishHeist(hitElement,matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) == "vehicle" then
		if hitElement == securiCar then
			local totalMoney = math.floor((tablelength(moneyBagsDrop)*math.random(10000,18000))/tablelength(criminals))
			for k,v in pairs(criminals) do
				givePlayerMoney(v, totalMoney)
				triggerClientEvent(v,"clearHeist",v)
				triggerClientEvent(v,"onShowMoney",v)
			end
			exports.NGMessages:sendClientMessage("Los criminales han robado el banco!",root,255,0,0)
			stopBankHeist()
		end
	end
end

function placeDrillHit(hitElement, matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) ~= "player" then return end
	destroyElement(source)
	setPedAnimation(hitElement, "rob_bank", "cat_safe_open",-1,true,false,true)
	setTimer( function()
		for k,v in ipairs(drillData) do 
			drill[k] = createObject(v[1], v[2], v[3], v[4], v[5], v[6],v[7])
			setElementDimension(drill[k], bankDim)
			setElementInterior(drill[k], 3)
		end
		for k,v in pairs(criminals) do
			exports.NGMessages:sendClientMessage("El usuario "..getPlayerName(hitElement).." ha colocado el taladro termico, aguanta 3 minutos!",v,255,0,0)
		end
		setPedAnimation(hitElement)
		setTimer( function()
			for k,v in ipairs(drill) do
				if isElement(v) then
					destroyElement(v)
					drill[k] = nil
				end
			end
			if isElement(items["lock"]) then
				destroyElement(items["lock"])
				items["lock"] = nil
			end
			for k,v in pairs(criminals) do
				exports.NGMessages:sendClientMessage("La lanza termica ha terminado, recoge el botin y llevalo a la ventana del segundo piso, tienes 1 minuto!",v,255,0,0)
			end
			moneyDropMarker = createMarker(364.67, 157.33, 1013.19, "cylinder", 1.5, 255, 255, 0, 170 )
			setElementDimension(moneyDropMarker,bankDim)
			setElementInterior(moneyDropMarker, 3)
			addEventHandler("onMarkerHit", moneyDropMarker, dropMoney)
			setTimer(function () 
				exitMarker = createMarker(364.7, 157.33, 1018.98,"cylinder", 1.5, 255, 255, 0, 170 )
				setElementDimension(exitMarker,bankDim)
				setElementInterior(exitMarker,3)
				if isElement(moneyDropMarker) then
					destroyElement(moneyDropMarker)
				end
				if isElement(moneyMarker) then 
					destroyElement(moneyMarker)
				end
				addEventHandler("onMarkerHit", exitMarker, exitTo)
				
				for k,v in pairs(criminals) do
					if getElementData(v,"hasBag") then
						destroyElement(moneyBags[getElementData(v,"bagId")])
					end
					exports.NGMessages:sendClientMessage("Las bolsas han sido cargadas en el carro de seguridad, salta por la ventana del tercer piso!",v,255,0,0)
				end
				
				for k,v in pairs(moneyBagsMarkers) do
					if isElement(v) then
						destroyElement(v)
					end
					moneyBagsMarkers[k] = nil
				end
				
				local x,y,z = unpack(escapePos[math.random(#escapePos)])
				escapeMarker = createMarker( x, y, z, "checkpoint", 2, 255, 255, 0, 170 )
				setElementDimension(escapeMarker, bankDim)
				escapeBlip = createBlipAttachedTo(escapeMarker, 53)
				setElementDimension(escapeBlip, bankDim)
				addEventHandler("onMarkerHit", escapeMarker, escape)
				
				local x1,y1,z1 = unpack(finishPos[math.random(#finishPos)])
				finishMarker = createMarker(x1,y1,z1, "checkpoint",2,255, 255, 0, 170 )
				finishBlip = createBlipAttachedTo(finishMarker, 20)
				setElementVisibleTo(finishMarker,root, false)
				setElementVisibleTo(finishBlip,root, false)
				for k,v in pairs(criminals) do
					setElementVisibleTo(finishMarker,v,true)
					setElementVisibleTo(finishBlip,v,true)
				end
				addEventHandler("onMarkerHit", finishMarker, finishHeist)
			end,60000,1)
		end, 180000,1)
	end,3000,1)
end

local bagCounter = 0
function takeBagOfMoney(hitElement,matchingDim)
	if not matchingDim then return end
	if getElementType(hitElement) ~= "player" then return end
	if getPlayerTeam(hitElement) ~= team then return end
	if getElementData(hitElement,"hasBag") then exports.NGMessages:sendClientMessage("Ya tienes una maletin de dinero en tu mano!",hitElement,255,0,0) return end
	if bagCounter == 10 then destroyElement(source) return end
	
	bagCounter = bagCounter + 1
	setElementData(hitElement,"hasBag",true)
	local x,y,z = getElementPosition(hitElement)
	moneyBags[bagCounter] = createObject(1210,x,y,z)
	setElementDimension(moneyBags[bagCounter], bankDim)
	setElementInterior(moneyBags[bagCounter], 3)
	setElementData(hitElement,"bagId",bagCounter)
	exports.bone_attach:attachElementToBone(moneyBags[bagCounter],hitElement,12,0,0.05,0.27,0,180,0)
end

function starBankHeist()
	c4Marker = createMarker(372.04, 167.53, 1007.38, "cylinder", 1.5, 255, 255, 0, 170 )
	setElementDimension(c4Marker,bankDim)
	setElementInterior(c4Marker,3)
	addEventHandler("onMarkerHit", c4Marker, plantC4)
	items["door"] = createObject( 2957,372.5, 166.5, 1009)
	setElementDimension(items["door"],bankDim)
	setElementInterior(items["door"],3)
	
	for k,v in ipairs(pedsData) do
		peds[k] = createPed(v[1],v[2],v[3],v[4],v[5])
		setElementInterior(peds[k], 3)
		setElementDimension(peds[k],233)
		setPedAnimation(peds[k], "rob_bank", "shp_handsup_scr",-1,false,false,true)
	end
	
	for k, v in pairs(criminals) do
		setElementPosition(v,378.67, 174.47, 1008.38)
		setElementDimension(v,bankDim)
		setElementInterior(v,3)
		triggerClientEvent ( v, "loadClientHeist", v, tablelength(criminals), tablelength(polices) )
	end
	
	drillMarker = createMarker(345.68, 156.51, 1013.19, "cylinder", 1.5, 255, 255, 0, 170 )
	addEventHandler("onMarkerHit", drillMarker, placeDrillHit)
	setElementDimension(drillMarker,bankDim)
	setElementInterior(drillMarker,3)
	
	items["lock"] = createObject(2949,344.89999, 156.89999 ,1013.2 ,0 ,0 ,90)
	setElementDimension(items["lock"],bankDim)
	setElementInterior(items["lock"],3)
	
	moneyMarker = createMarker(348.12, 161.01, 1013.19, "cylinder", 1.5, 255, 255, 0, 170 )
	setElementDimension(moneyMarker, 233)
	setElementInterior(moneyMarker,3)
	addEventHandler("onMarkerHit", moneyMarker, takeBagOfMoney)
	

	securiCar = createVehicle ( 428, 977.07, -1042.19, 31.26 , 0, 0, 180, "BANK6969")
	setElementDimension(securiCar,bankDim)
	for i= 1,math.ceil(tablelength(criminals)/2) do
		vans[i] = createVehicle ( 468, 976.96 + i*1, -1034.98, 30.24, 0, 0,180, "BALAGAY")
		setElementDimension( vans[i], bankDim )
	end
	timeStartPolice = 30000
	setTimer(function()
		
		if timeStartPolice/1000 <= 4 and timeStartPolice/1000 > 1 then
			for k,v in pairs(polices) do
				exports.NGMessages:sendClientMessage("La defensa del banco comienza en "..tostring((timeStartPolice-1000)/1000).."",v,255,0,0)
			end
		elseif timeStartPolice/1000 == 1 then
			for k,v in pairs(polices) do
				local x,y,z = unpack(policeSpawns[math.random(#policeSpawns)])
				setElementDimension(v,bankDim)
				setElementInterior(v,3)
				setElementPosition(v,x,y,z)
				triggerClientEvent(v,"updateCounterCrim",v, tablelength(criminals))
				triggerClientEvent(v,"updateCounterPolice",v, tablelength(polices))
			end
		end
		timeStartPolice = timeStartPolice -1000
	end,1000,30)
	for k,v in pairs(criminals) do
		triggerClientEvent(v,"updateCounterPolice",v,tablelength(polices))
	end
	failTimer = setTimer(function() 
		exports.NGMessages:sendClientMessage("Los criminales han fallado el robo del banco!",root,255,0,0) 
		for k,v in pairs(criminals) do
			if getElementInterior(v) == 3 and getElementDimension(v) == 233 then
				setElementDimension(v,1)
			elseif getElementInterior(v) ~= 3 and getElementDimension(v) == 233 then
				setElementDimension(v,0)
			end
		end
		for k,v in pairs(polices) do
			if getElementDimension(v) == bankDim then
				setElementDimension(v,1)
			end
		end
		stopBankHeist()
	end,30*60*1000,1)
end

function loadPlayerToHeist(player, matchingDim)
    if not matchingDim then return end
    if getElementType(player) ~= "player" then return end
    if isPedInVehicle ( player ) then return end
    local pTeam = getPlayerTeam( player )
    local teamName = getTeamName( pTeam )
    if teamName == "Criminals" and source == marker then
        criminals[player] = player
        setElementDimension(player,1)
	elseif teamName == "Law Enforcement" and source == markerCops then
		polices[player] = player
		setElementDimension(player,1)
    else
        exports.NGMessages:sendClientMessage("No eres policia o criminal!",player,255,0,0)
    end
end

function startPlayerBankHeist()
	if timeStart/1000 <= 4 and timeStart/1000 > 1 then
		for k,v in pairs(criminals) do
			exports.NGMessages:sendClientMessage("El robo al banco comienza en "..tostring((timeStart-1000)/1000).."",v,255,0,0)
		end
	elseif timeStart/1000 == 1 then
		if tablelength(criminals) >= minPlayers and tablelength(polices) >= minPolices then
			for k,v in pairs(criminals) do
				exports.NGMessages:sendClientMessage("El robo del banco ha comenzado!",v,255,0,0)
				setElementData(v,"WantedPoints",getElementData(v,"WantedPoints")+300)
			end
			starBankHeist()
		else
			for k,v in pairs(criminals) do
				exports.NGMessages:sendClientMessage("No hay jugadores suficientes!",v,255,0,0)
				criminals[v] = nil
				setElementDimension(v,0)
			end
			for k,v in pairs(polices) do
				exports.NGMessages:sendClientMessage("No hay jugadores suficientes!",v,255,0,0)
				polices[v] = nil
				setElementDimension(v,0)
			end
			stopBankHeist()
		end
	end
	timeStart = timeStart-1000
end


function loadBankHeist()
	exports.NGMessages:sendClientMessage("Ha comenzado un robo de banco en Los Santos!",root,255,0,0)
	setTeamFriendlyFire ( team , false )
	setTeamFriendlyFire(getTeamFromName("Law Enforcement"), false)
	marker = createMarker(915.01, -1037.3, 30.9,"cylinder", 1.5, 255, 0, 0, 170 )
	addEventHandler("onMarkerHit",marker,loadPlayerToHeist)
	
	markerCops = createMarker(1553.13, -1696.47, 5.22,"cylinder", 1.5, 0, 0, 255, 170 )
	addEventHandler("onMarkerHit",markerCops,loadPlayerToHeist)
	
	joinTimer = setTimer(
	function()
		if isElement(marker) then
			destroyElement(marker)
			marker = nil
		end
		if isElement(markerCops) then
			destroyElement(markerCops)
			markerCops = nil
		end
		setTimer(startPlayerBankHeist,1000,30)
	end
	,120000,1)
end

loadBankHeist()