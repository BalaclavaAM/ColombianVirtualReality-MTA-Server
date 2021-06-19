startCoords = {
	{2187.06, -2268.47, 13.5},
	{1707.38, 975.28, 10.82},
	{-2146.23, -167.99, 35.32}
}

finishCoords = {
	{2174.14, -2302.74, 13.55, 1},
	{1630.62, 997.72, 10.82, 2},
	{-2124.3, -125.96, 35.32, 3},
	{ 1615.5283203125, -1614.431640625, 12.10223865509, 4},
	{ 1476.5732421875, -1735.2548828125, 11.943592071533, 5},
	{ 1360.8798828125, -1284.318359375, 11.949401855469, 6},
	{ 1192.7392578125, -1333.7568359375, 12.945232391357, 7},
	{ 1019.5927734375, -928.279296875, 42.1796875, 8 }, --gasolinería del norte
	{ 1027, -1364.4248046875, 12.138906478882, 9},
	{ 646.53, -1469.37, 16.32, 10},
	{ 786.884765625, -1612.86328125, 11.937650680542, 11},
	{ 815.9462890625, -1392.9716796875, 12.95408821106, 12},
	{ 1826.69140625, -1845.1533203125, 13.578125, 13},
	{ 2400.4296875, -1486.8359375, 23.828125,14},
	{ 2148.263671875, -1006.384765625, 61.870578765869, 15},
	{ 2857.71484375, -1536.0712890625, 10.576637268066, 16 },
	{ 2197.541015625, -2657.6513671875, 13.118523597717, 17 },
	--{ 1751.4375, -2060.2880859375, 13.166693687439 }, -- almacén cerca de unity station
	{ 1873.018676,-1739.553466,12.851915, 18}, -- alhambra
	{ 1270.972656,-962.317260,39.159618, 19}, -- torre vieja san andreas
	{ 1824.227294,-1397.457885,12.845108, 20}, -- club,420
	{ 1744.595336,-1172.549316,23.247001, 21}, -- casino,norte,ls
	{ 1597.924316,-1277.344976,16.871969, 22}, -- dsac
	{ 1780.598266,-1700.437988,12.916292, 23}, -- cerca,san
	{ 2093.006571,-1817.218505,12.803875, 24}, -- pizzeria
	{ 2141.745117,-1208.530151,23.328807,25}, -- near,apuestas
	{ 654.225097,-1791.725708,11.773159, 26}, -- playa
	{ 331.879760,-1344.750488,13.926565, 27}, -- tienda con parking
	{ 765.241882,-1033.121459,23.431682,28}, -- club de streapteace
	--{ 1087.164184,-297.483642,42.618633}, -- strip,club
	{ 1176.214355,-908.39075,42.716659,29}, -- Cluckin,bella
	{ 2746.098388,-1437.168945,29.869129,30}, -- btr
	{ 2569.461425,-1490.764619,23.438364,31}, -- almacén sf
	{ 1928.765991,-2142.000976,12.980903,32}, -- cerca aereopuerto sf
	{ 2252.524169,-2016.487792,12.965055,33}, -- tienda ls,
	{ 2417.993164,-1967.065307,12.844669,34}, -- tienda de empeños
	{ 1130.798339,-1373.452880,13.403291,35}, -- tiendas detrás del hospital
	{ 979.930480,-1258.825073,16.129234,36}, -- detrás último checkpoint
	{ 568.302246,-1300.114746,16.665719,37}, -- tienda carros sf 
	{ 830.182189,-607.883728,15.758930,38}, -- fuera ls
	{ 1206.854248,-1727.665771,13.012009,39}, -- dmv
	{ 1488.234985,-1877.046508,12.835832,40}, -- restaurante
	{ 1940.131591,-1860.084228,13.590534,41}, -- Garage de idlewood
	{ 2072.855468,-1767.890502,13.590801,42}, -- clucking bell
	{ 1134.118041,-1681.099365,13.778925,43}, -- dmv
	{ 1737.745117,-2255.908447,13.512469,44}, -- aereopuerto
	{ 285.878540,-1595.997070,32.253921,45} -- cerca,hotel
}
trailers = {}
trucks = {}
blip = {}
finishMarkers = {}

function destroyTrailer()
	for driver,trailer in pairs(trailers) do
		if trailer==source then
			outputChatBox("Se explotó tu trailer, debes ir por otro",driver,255,0,0,false)
			if isElement(trailers[driver]) then
				destroyElement(trailers[driver])
				trailers[driver] = nil
			end
			if trucks[source] then
				trucks[source] = nil
			end
			if isElement(blip[driver]) then
				destroyElement(blip[driver])
				blip[driver] = nil 
			end
			if isElement(finishMarkers[driver]) then
				removeEventHandler("onMarkerHit", finishMarkers[driver], finishTruckerJob)
				destroyElement(finishMarkers[driver])
				finishMarkers[driver] = nil
			end
		end
	end
end


function startTruckerJob(hitElement, matchingDimension)
	if getElementType(hitElement) == "vehicle" and (getElementModel(hitElement) == 514 or getElementModel(hitElement) == 515 or getElementModel(hitElement) == 403) then
		local driver = getVehicleOccupant ( hitElement )
		if getElementData(driver,"Job") == "Camionero" then
			local cuenta = getElementData ( hitElement, "NGVehicles:VehicleAccountOwner") or false
			if cuenta then
				return exports['NGMessages']:sendClientMessage ("Hermanito tienes que usar un camión del spawner para poder trabajar de camionero.",driver,255,0,0)
			end
			local x,y,z = getElementPosition(hitElement)
			local rx,ry,rz = getElementRotation(hitElement)
			if not isElement(trailers[driver]) then
				trailers[driver] =  createVehicle ( 435, x, y, z, rx, ry, rz )
				trucks[driver] = hitElement
				addEventHandler("onVehicleExplode",trailers[driver],destroyTrailer)
				addEventHandler("onTrailerDetach", trailers[driver], reattachTrailer)
				attachTrailerToVehicle ( hitElement, trailers[driver] )
				exports['NGMessages']:sendClientMessage ("Entrega el trailer en el icono de camion amarillo. Procura entregar el trailer en buen estado",driver,0,255,0)
				--Create the pos to assing the trailer deliver
	
				while(true) do
					local x1,y1,z1, id = unpack ( finishCoords [ math.random ( #finishCoords ) ] )
					local x,y,z = getElementPosition(source) 
					local locationStart = getZoneName ( x, y, z, true ) 
					local locationFinish = getZoneName( x1, y1, z1, true)
					if locationFinish ~= locationStart then
						blip[driver] = createBlip( x1,y1,z1, 11, 2, 255,0,0,255,0, 16383.0, driver)
						finishMarkers[driver] = createMarker(x1,y1,z1,"cylinder", 3, 0, 255, 0, 170, driver)
						setElementData(driver,"ZoneId", id)
						setElementData(finishMarkers[driver],"ZoneId", id)
						addEventHandler("onMarkerHit", finishMarkers[driver], finishTruckerJob)
						break
					end
				end
			else
				exports['NGMessages']:sendClientMessage ("Ya tienes un trailer asignado",driver,255,0,0)
			end
		else
			exports['NGMessages']:sendClientMessage ("Este marcador es solo para los camioneros.",driver,255,0,0)
		end
	end
end

function finishTruckerJob(hitElement, matchingDimension)
	if getElementType(hitElement) == "vehicle" and (getElementModel(hitElement) == 514 or getElementModel(hitElement) == 515 or getElementModel(hitElement) == 403) then
		local driver = getVehicleOccupant ( hitElement )
		local money = 0
		local cuenta = getElementData ( hitElement, "NGVehicles:VehicleAccountOwner") or false
		if cuenta then
			return exports['NGMessages']:sendClientMessage ("Hermanito tienes que usar un camión del spawner para poder trabajar de camionero.",driver,255,0,0)
		end
		if hitElement == trucks[driver] then
			if getElementData(driver,"Job") == "Camionero" then
				if getElementData(driver,"ZoneId") == getElementData(source, "ZoneId") then
					if  getVehicleTowedByVehicle ( hitElement ) == trailers[driver] then
						local jobRank = getElementData(driver,"Job Rank")
						mult = 0.8
						if jobRank == "Conductor Nuevo" then
							mult = 0.9
						elseif jobRank == "Acarreos" then
							mult = 0.95
						elseif jobRank == "Trasteos" then
							mult = 1
						elseif jobRank == "Transportador" then
							mult = 1.05
						elseif jobRank == "Camionero Novato" then
							mult = 1.1
						elseif jobRank == "Camionero" then
							mult = 1.15
						elseif jobRank == "Camionero Experimentado" then
							mult = 1.25
						elseif jobRank == "Lider Camionero" then
							mult = 1.30
						elseif jobRank == "Comandante Camionero" then
							mult = 1.35
						elseif jobRank == "Camionero emputado" then
							mult = 1.40
						elseif jobRank == "Toretto" then
							mult = 1.45
						end
						local money = math.floor(math.random(30000,80000)*(getElementHealth(trailers[driver])/1000)*mult)
						givePlayerMoney(driver, money)
						exports['NGMessages']:sendClientMessage ( "Te pagaron $"..money .." por llevar la carga!", driver, 0, 255, 0 )
						destroyElement(trailers[driver])
						trailers[driver] = nil
						destroyElement(blip[driver])
						blip[driver] = nil
						removeEventHandler("onMarkerHit", source, finishTruckerJob)
						destroyElement(finishMarkers[driver])
						finishMarkers[driver] = nil
						triggerClientEvent ( driver, "updateTruckerJob", driver )
					else
						exports['NGMessages']:sendClientMessage ("No traes ningun trailer.",driver,255,0,0)
					end
				else
					exports['NGMessages']:sendClientMessage ("Amigo ese no es el camión con el que comenzaste la ruta.",driver,255,0,0)
				end
			end
		end
	end
end
--destroy the Trailer if player quit
addEventHandler ( "onPlayerQuit", root, 
	function()
		if isElement(trailers[source]) then
			destroyElement(trailers[source])
			trailers[source] = nil
		end
		if trucks[source] then
			trucks[source] = nil
		end
		if isElement(blip[source]) then
			destroyElement(blip[source])
			blip[source] = nil 
		end
		if isElement(finishMarkers[source]) then
			removeEventHandler("onMarkerHit", finishMarkers[source], finishTruckerJob)
			destroyElement(finishMarkers[source])
			finishMarkers[source] = nil
		end
	end
)

function reattachTrailer(theTruck)
	attachTrailerToVehicle(theTruck, source) -- Reattach the truck and trailer
end


for k,v in ipairs(startCoords) do
	local startMarker = createMarker (v[1], v[2], v[3]-1, "cylinder", 3, 0, 255, 0, 170 )
	addEventHandler( "onMarkerHit", startMarker, startTruckerJob )
end



function clearTrash()
local vehT = getElementsByType ( "vehicle" ) 
	for k,v in ipairs(vehT) do
		if isVehicleBlown (v) then
			destroyElement(v)
		end
	end
end
addCommandHandler("clearveh",clearTrash)