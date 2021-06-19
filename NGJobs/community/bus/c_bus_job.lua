local line, route, m_number, curCpType = nil
local busMarker, busNextMarker = nil
local busBlip, busNextBlip = nil
local busStopColShape = nil

local bus = { [431]=true, [437]=true, [479]=true, [405]=true }

local blip

function resetBusJob()
	player = getLocalPlayer()
	setElementData(player,"enRuta",true)
	if (isElement(blip)) then
		destroyElement(blip)
		removeEventHandler("onClientVehicleEnter", getRootElement(), startBusJob)
		blip = nil
	end
	
	if isElement(busMarker) then
		destroyElement(busMarker)
		busMarker = nil
	end
	
	if isElement(busBlip) then
		destroyElement(busBlip)
		busBlip = nil
	end
	
	if isElement(busNextMarker) then
		destroyElement(busNextMarker)
		busNextMarker = nil
	end
	
	if isElement(busNextBlip) then
		destroyElement(busNextBlip)
		busNextBlip = nil
	end
	
	m_number = 0
end

function displayBusJob()
	blip = createBlip(1711.29296875, -1881.2841796875, 13.110404968262, 0, 4, 255, 127, 255)
	outputChatBox("#FF9933Ve al #FF66CCpunto#FF9933 en tu radar y entra al bus/coach.", 255, 194, 15, true)
end

function startBusJob()
	player = getLocalPlayer()
	setElementData(player,"enRuta",true)
	local job = getElementData(getLocalPlayer(), "Job")
	if (job == "Busetero") then
		if blip then
			destroyElement(blip)
			blip = nil
		end
		if busMarker then
			outputChatBox("#FF9933Ya habías empezado una ruta de bus.", 255, 194, 14, true)
		else
			local vehicle = getPedOccupiedVehicle(getLocalPlayer())
			if vehicle and getVehicleController(vehicle) == getLocalPlayer() and bus[getElementModel(vehicle)] then
				line = math.random( 1, #g_bus_routes )
				route = g_bus_routes[line]
				curCpType = 0
				
				local x, y, z = 1811, -1890, 13 -- Depot start point
				busBlip = createBlip(x, y, z, 0, 3, 255, 200, 0, 255)
				busMarker = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150) -- start marker.
				busStopColShape = createColSphere(0, 0, 0, 5)
				
				addEventHandler("onClientMarkerHit", busMarker, updateBusCheckpointCheck)
				addEventHandler("onClientMarkerLeave", busMarker, checkWaitAtStop)
				addEventHandler("onClientColShapeHit", busStopColShape,
					function(element)
						if getElementType(element) == "vehicle" and bus[getElementModel(element)] then
							setVehicleLocked(vehicle, false)
						end
					end
				)
				addEventHandler("onClientColShapeLeave", busStopColShape,
					function(element)
						if getElementType(element) == "vehicle" and bus[getElementModel(element)] then
							setVehicleLocked(vehicle, true)
						end
					end
				)
				
				local nx, ny, nz = route.points[1][1], route.points[1][2], route.points[1][3]
				if (route.points[1][4]==true) then
					busNextMarker = createMarker( nx, ny, nz, "checkpoint", 2.5, 255, 0, 0, 150) -- small red marker
					busNextBlip = createBlip( nx, ny, nz, 0, 2, 255, 0, 0, 255) -- small red blip
				else
					busNextMarker = createMarker( nx, ny, nz, "checkpoint", 2.5, 255, 200, 0, 150) -- small yellow marker
					busNextBlip = createBlip( nx, ny, nz, 0, 2, 255, 200, 0, 255) --small  yellow blip
				end
				
				m_number = 0
				triggerServerEvent("payBusDriver", getLocalPlayer(), line, 0)
				
				setVehicleLocked(vehicle, true)
				
				outputChatBox("#FF9933Conduce por la #FFCC00ruta #FF9933haciendo caso a las #A00101paradas #FF9933en el camino.", 255, 194, 14, true)
				outputChatBox("#FF9933Serás pagado por cada parada.", 255, 194, 14, true)
			else
				outputChatBox("#FF9933Debes estar en un bus para comenzar la ruta.", 255, 194, 14, true)
			end
		end
	else
		outputChatBox("No eres busetero.", 255, 194, 14)
	end
end
addCommandHandler("comenzarruta", startBusJob, false, false)

function updateBusCheckpointCheck(thePlayer)
	if thePlayer == getLocalPlayer() then
		local vehicle = getPedOccupiedVehicle(thePlayer)
		local handling = exports['NGVehicles']:getClientVehicleHandlingg(getElementModel(vehicle))
		local handbus = getVehicleHandling(vehicle)
		if math.abs(handbus['engineAcceleration']-handling['engineAcceleration'])>1 then
			return outputChatBox("Hermanito ese bus está tuneado, sólo se puede trabajar con buses de fábrica",255,0,0)
		end
		if vehicle and bus[getElementModel(vehicle)] then
			if curCpType == 3 then
				busStopTimer = setTimer(updateBusCheckpointAfterStop, 5000, 1, true)
				outputChatBox("#FF9933Espera un momento en la parada del autobús hasta que desaparezca el marcador..", 255, 0, 0, true )
				triggerServerEvent("busAdNextStop", getLocalPlayer(), line, route.points[m_number][5])
			elseif curCpType == 2 then
				endOfTheLine()
			elseif curCpType == 1 then
				busStopTimer = setTimer(updateBusCheckpointAfterStop, 5000, 1, false)
				outputChatBox("#FF9933Espera un momento en la parada del autobús hasta que desaparezca el marcador..", 255, 0, 0, true )
				triggerServerEvent("busAdNextStop", getLocalPlayer(), line, route.points[m_number][5])
			else
				updateBusCheckpoint()
			end
		else
			outputChatBox("#FF9933Debes estar en un bus para comenzar una ruta.", 255, 0, 0, true ) -- Wrong car type.
		end
	end
end

function updateBusCheckpoint()
	-- Find out which marker is next.
	local max_number = #route.points
	local newnumber = m_number+1
	local nextnumber = m_number+2
	local x, y, z = nil
	local nx, ny, nz = nil
	
	x = route.points[newnumber][1]
	y = route.points[newnumber][2]
	z = route.points[newnumber][3]
	
	if (tonumber(max_number-1) == tonumber(m_number)) then -- if the next checkpoint is the final checkpoint.
		setElementPosition(busMarker, x, y, z)
		setElementPosition(busBlip, x, y, z)
		
		if (route.points[newnumber][4]==true) then -- If it is a stop.
			curCpType = 3
			setMarkerColor(busMarker, 255, 0, 0, 150)
			setBlipColor(busBlip, 255, 0, 0, 255)
			setElementPosition(busStopColShape, x, y, z)
		else -- it is just a route.
			curCpType = 2
			setMarkerColor(busMarker, 255, 200, 0, 150)
			setBlipColor(busBlip, 255, 200, 0, 255)
		end
		
		nx, ny, nz = 1811, -1890, 13 -- Depot start point
		setElementPosition(busNextMarker, nx, ny, nz)
		setElementPosition(busNextBlip, nx, ny, nz)
		setMarkerColor(busNextMarker, 255, 0, 0, 150)
		setBlipColor(busNextBlip, 255, 0, 0, 255)
		setMarkerIcon(busNextMarker, "finish")
	else
		nx = route.points[nextnumber][1]
		ny = route.points[nextnumber][2]
		nz = route.points[nextnumber][3]
		
		setElementPosition(busMarker, x, y, z)
		setElementPosition(busBlip, x, y, z)
		
		setElementPosition(busNextMarker, nx, ny, nz)
		setElementPosition(busNextBlip, nx, ny, nz)
		
		if (route.points[newnumber][4]==true) then -- If it is a stop.
			curCpType = 1
			setMarkerColor(busMarker, 255, 0, 0, 150)
			setBlipColor(busBlip, 255, 0, 0, 255)
			setElementPosition(busStopColShape, x, y, z)
		else -- it is just a route.
			curCpType = 0
			setMarkerColor(busMarker, 255, 200, 0, 150)
			setBlipColor(busBlip, 255, 200, 0, 255)
		end
		
		if (route.points[nextnumber][4] == true) then
			setMarkerColor(busNextMarker, 255, 0, 0, 150)
			setBlipColor(busNextBlip, 255, 0, 0, 255)
		else
			setMarkerColor(busNextMarker, 255, 200, 0, 150)
			setBlipColor(busNextBlip, 255, 200, 0, 255)
		end
	end
	m_number = m_number + 1
end

function checkWaitAtStop(thePlayer)
	if thePlayer == getLocalPlayer() then
		if busStopTimer then
			outputChatBox("Espera en la parada del bus.", 255, 0, 0)
			if isTimer(busStopTimer) then
				killTimer(busStopTimer)
				busStopTimer = nil
			end
		end
	end
end

function updateBusCheckpointAfterStop(endOfLine)
	if isTimer(busStopTimer) then
		killTimer(busStopTimer)
		busStopTimer = nil
	end
	local stopNumber = route.points[m_number][5]
	triggerServerEvent("payBusDriver", getLocalPlayer(), line, stopNumber)
	if endOfLine then
		endOfTheLine(getLocalPlayer())
	else
		updateBusCheckpoint(getLocalPlayer())
	end
end

function endOfTheLine(thePlayer)
	local money = 0
	if busNextBlip then
		destroyElement(busNextBlip)
		destroyElement(busNextMarker)
		busNextBlip = nil
		busNextMarker = nil
		
		if busStopColShape then
			destroyElement(busStopColShape)
			busStopColShape = nil
		end
		
		local x, y, z = 1811, -1890, 13 -- Depot start point
		setElementPosition(busMarker, x, y, z)
		setElementPosition(busBlip, x, y, z)
		setMarkerColor(busMarker, 255, 0, 0, 150)
		setBlipColor(busBlip, 255, 0, 0, 255)
		setMarkerIcon(busMarker, "finish")
		curCpType = 2
	else
		if busBlip then
			-- Remove the old marker.
			destroyElement(busBlip)
			destroyElement(busMarker)
			busBlip = nil
			busMarker = nil
		end
		local money = math.floor(math.random(70000,110000))
		triggerServerEvent ( "NGJobs->GivePlayerMoney", localPlayer, localPlayer, money, "Te pagaron $"..tostring(money).." por completar toda la ruta!" )
		outputChatBox("#FF9933Final del camino. Usa /startbus para comenzar la ruta otra vez.", 0, 255, 0, true )
		setVehicleLocked(vehicle, false)
		updateJobRank()
	end
end

function updateJobRank()
	triggerServerEvent ( "NGJobs->SQL->UpdateColumn", localPlayer, localPlayer, "completeroutes", "AddOne" )
end

function enterBus ( thePlayer, seat )
	local driver = getVehicleOccupant ( source, 0 )    
	if(thePlayer == getLocalPlayer()) then
		local vehID = getElementModel (source)
		if(bus[vehID])then
			if(seat~=0)then 
					if (getPlayerMoney(thePlayer) < 1800) then
						triggerServerEvent("removePlayerFromBus", getLocalPlayer())
						outputChatBox("No tienes 1800 para pagar el bus.", 255, 0, 0)
					else
						triggerServerEvent("payPasaje", driver, thePlayer, driver)
					end
			elseif not busMarker and getElementData(getLocalPlayer(), "Job") == "Busetero" then
				startBusJob()
			end
		end
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), enterBus)


function startEnterBus(thePlayer, seat)
	if getElementData(thePlayer, "Job") == "Busetero" then
		if seat == 0 and bus[getElementModel(source)] then
			if getVehicleController(source) then -- if someone try to jack the driver stop him
				cancelEvent()
				if thePlayer == getLocalPlayer() then
					outputChatBox("Las puertas del conductor están bloqueadas.", 255, 0, 0)
				end
			else
				setVehicleLocked(source, false)
			end
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), startEnterBus)


function onPlayerQuit()
	if getElementData(source, "job") == 3 then
		vehicle = getPedOccupiedVehicle(source)
		if vehicle and bus[getElementModel(vehicle)] and getVehicleOccupant(vehicle) == source then
			setVehicleLocked(vehicle, false)
		end
	end
end
addEventHandler("onClientPlayerQuit", getRootElement(), onPlayerQuit)