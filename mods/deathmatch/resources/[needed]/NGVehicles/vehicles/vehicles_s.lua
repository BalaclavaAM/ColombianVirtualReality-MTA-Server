addEventHandler ( "onResourceStart", resourceRoot, function ( )
	exports['NGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS vehicles ( Owner TEXT, VehicleID INT, ID INT, Color TEXT, Upgrades TEXT, Position TEXT, Rotation TEXT, Health TEXT, Visible INT, Fuel INT, Impounded INT, Handling TEXT, NEON TEXT, PAINTJOB TEXT, FLAGSELL INT, Partes TEXT, isParked INT, tunningInfo TEXT, kilometraje INT )" )
	exports['NGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS handling ( ID INT, Handling TEXT )" )
	getVehicleHandlings()
	setTimer(function()
		sendToAllClients()
	end,3000,1)
end )


function getPlayerFromAccountName(name) 
    local acc = getAccount(name)
    if not acc or isGuestAccount(acc) then
        return false
    end
    return getAccountPlayer(acc)
end


vehicles = { }
local blip = { }
local texts = { }
function getAllAccountVehicles ( account )
	local cars = { } 
	local q = exports['NGSQL']:db_query ( "SELECT * FROM vehicles WHERE Owner=? ", tostring(account) )
	for i, v in pairs ( q ) do 
		table.insert ( cars, v )
	end
	return cars
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

local pbala = "#717D7E|Dueño|#FF5656BalaclavaAM: #FFFFFF"
function tunearHr2()
	local carrospersona = getAccountVehicles(getAccountName(getPlayerAccount(source)))
	local identificador=false
	for k,v in ipairs(carrospersona) do
		if v[3]==503 then
			identificador=v[2]
		end
	end
	if identificador then
		if isElement(vehicles[identificador]) then
			local tablahandling = fromJSON('[ { "suspensionLowerLimit": -0.1000000014901161, "engineInertia": -25, "suspensionHighSpeedDamping": 0, "collisionDamageMultiplier": 0.7200000286102295, "suspensionDamping": 0.1899999976158142, "seatOffsetDistance": 0.3700000047683716, "headLight": "small", "dragCoeff": 1.5, "centerOfMass": [ 0, 0, -0.25 ], "steeringLock": 30, "suspensionUpperLimit": 0.25, "suspensionAntiDiveMultiplier": 0.4000000059604645, "turnMass": 2725.300048828125, "brakeBias": 0.7699999809265137, "tractionLoss": 0.8399999737739563, "monetary": 19000, "ABS": false, "suspensionFrontRearBias": 0.5, "percentSubmerged": 70, "tractionBias": 0.5, "numberOfGears": 5, "suspensionForceLevel": 1.200000047683716, "animGroup": 0, "engineAcceleration": 35, "maxVelocity": 700, "mass": 1400, "driveType": "awd", "modelFlags": 1073750020, "brakeDeceleration": 35, "handlingFlags": 29376512, "tractionMultiplier": 1, "engineType": "petrol", "tailLight": "small" } ]')
			for valor,clave in pairs(tablahandling) do
				setVehicleHandling(vehicles[identificador],valor,clave)
			end
			outputChatBox(pbala.."Ha sido un placer hermanazo",255,0,0,true)
		else
			outputChatBox(pbala.."Por favor spawnea tu Hotring Racer 2 para yo poder repararlo",source,255,0,0,true)
		end
	else
		outputChatBox(pbala.."No veo que tú poseas un Hotring Racer 2",source,255,0,0,true)
	end
end
addEvent("NGVehicles->TunearHR2",true)
addEventHandler("NGVehicles->TunearHR2",root,tunearHr2)

function tunearHr3()
	local carrospersona = getAccountVehicles(getAccountName(getPlayerAccount(source)))
	local identificador=false
	for k,v in ipairs(carrospersona) do
		if v[3]==502 then
			identificador=v[2]
		end
	end
	if identificador then
		if isElement(vehicles[identificador]) then
			local tablahandling = fromJSON('[ { "suspensionLowerLimit": -0.1000000014901161, "engineInertia": -25, "suspensionHighSpeedDamping": 0, "collisionDamageMultiplier": 0.7200000286102295, "suspensionDamping": 0.1899999976158142, "seatOffsetDistance": 0.3700000047683716, "headLight": "small", "dragCoeff": 1.5, "centerOfMass": [ 0, 0, -0.25 ], "steeringLock": 30, "suspensionUpperLimit": 0.25, "suspensionAntiDiveMultiplier": 0.4000000059604645, "turnMass": 2725.300048828125, "brakeBias": 0.7699999809265137, "tractionLoss": 0.8399999737739563, "monetary": 19000, "ABS": false, "suspensionFrontRearBias": 0.5, "percentSubmerged": 70, "tractionBias": 0.5, "numberOfGears": 5, "suspensionForceLevel": 1.200000047683716, "animGroup": 0, "engineAcceleration": 25, "maxVelocity": 650, "mass": 1400, "driveType": "awd", "modelFlags": 1073750020, "brakeDeceleration": 35, "handlingFlags": 29376512, "tractionMultiplier": 1, "engineType": "petrol", "tailLight": "small" } ]')
			for valor,clave in pairs(tablahandling) do
				setVehicleHandling(vehicles[identificador],valor,clave)
			end
			outputChatBox(pbala.."Ha sido un placer hermanazo",source,255,0,0,true)
		else
			outputChatBox(pbala.."Por favor spawnea tu Hotring Racer 3 para yo poder repararlo",source,255,0,0,true)
		end
	else
		outputChatBox(pbala.."No veo que tú poseas un Hotring Racer 3",source,255,0,0,true)
	end
end
addEvent("NGVehicles->TunearHR3",true)
addEventHandler("NGVehicles->TunearHR3",root,tunearHr3)

local vehicleparts={}


local tablapartes={"wheel_rf_dummy","wheel_lf_dummy","wheel_rb_dummy","wheel_lb_dummy"}

function isCarFunctioning(car)
	retorno = true
	if vehicleparts[car] then
		for k,v in ipairs(tablapartes) do
			if vehicleparts[car][v] then
				return false
			end
		end
	end
	return retorno
end

function isTruck(car)
	if (getElementModel(car)==524 or getElementModel(car)==578 or getElementModel(car)==515 or getElementModel(car)==514 or getElementModel(car)==403) then
		return true
	else
		return false
	end
end


function showVehicle ( id, stat, player, msg )
	if stat then
		local stealing = getElementData(player,"stealing") or false
		if stealing then return outputChatBox("Tas robando no puedes sacar carros",player,255,0,0) end
		if ( not isElement ( vehicles[id] ) ) then
			local q = exports['NGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=? LIMIT 1", tostring(id) )
			if ( q and type ( q ) == 'table' and #q > 0 ) then
				local d = q[1]
				local health = tonumber ( d['Health'] )
				local impound = tonumber(d['Impounded'])
				local owner, vehID = tostring ( d['Owner'] ), tonumber ( d['ID'] )
				local color, upgrades = d['Color'], d['Upgrades']
				local pos, rot = d['Position'], d['Rotation']
				if impound == 1 then return end
				local pos = fromJSON ( pos )
				local pos = split ( pos, ', ' )
				local x, y, z = tonumber ( pos[1] ), tonumber ( pos[2] ), tonumber ( pos[3] )

				local rot = fromJSON ( rot )
				local rot = split ( rot, ', ' )
				local rx, ry, rz = tonumber ( rot[1] ), tonumber ( rot[2] ), tonumber ( rot[3] )
				
				local color = fromJSON ( color )
				local color = split ( color, ', ' )
				local neon = tostring(d['NEON'])
				local r, g, b , r1,g1,b1, r2,g2,b2, r3,g3,b3 = tonumber ( color[1] ), tonumber ( color[2] ), tonumber ( color[3] ), tonumber ( color[4] ), tonumber ( color[5] ), tonumber ( color[6] ), tonumber ( color[7] ), tonumber ( color[8] ), tonumber ( color[9] ), tonumber ( color[10] ), tonumber ( color[11] ), tonumber ( color[12] )
				local upgrades = fromJSON ( upgrades )
				local hndl = fromJSON ( d['Handling'] )
				local paintjob = d['PAINTJOB']
				local flagsell = d['FLAGSELL']
				local partes = fromJSON(d['Partes'])
				local tunningInfo = fromJSON(d['tunningInfo'])
				vehicles[id] = createVehicle ( vehID, x, y, z, rx, ry, rz )
				for k,v in pairs(tunningInfo) do
					setElementData(vehicles[id],k,v)
				end
				setElementData(vehicles[id],'kilometraje',tonumber(d['kilometraje']))
				if table.size(partes)>0 then
					vehicleparts[vehicles[id]]=partes
					for k,v in ipairs(getElementsByType("player")) do
						for parte,boolean in pairs(partes) do
							triggerClientEvent(v,"NGVehicles:RemoveVehiclePart",v,vehicles[id],parte)
						end
					end
				end
				setElementData ( vehicles[id], "fuel", tonumber ( d['Fuel'] ) )
				setVehicleColor ( vehicles[id], r, g, b , r1,g1,b1, r2,g2,b2, r3,g3,b3 )
				setElementData ( vehicles[id], "NGVehicles:VehicleAccountOwner", tostring ( owner ) )
				setElementData ( vehicles[id], "NGVehicles:VehicleID", id )
				setElementHealth ( vehicles[id], tonumber ( health ) )
				setVehiclePaintjob(vehicles[id],paintjob)
				setElementData ( vehicles[id], "FLAGSELL", flagsell)
				if neon ~= "None" or neon ~= nil then
					exports['NGMessages']:sendClientMessage ( "Tu vehículo posee Neon "..neon..", actívalo con /neon.", player, 255, 0, 0 ) 
					setElementData(vehicles[id], "tuning.neon",neon)
					setElementData(vehicles[id], "vehicle.neon.active", false)
				end
				if ( hndl and type ( hndl ) == "table" ) then
					for i, v in pairs ( hndl ) do
						setVehicleHandling ( vehicles [ id ], tostring ( i ), v )
					end
				end
				
				for i, v in ipairs ( upgrades ) do 
					if v~=1008 and v~=1009 and v~=1010 then
						addVehicleUpgrade ( vehicles[id], tonumber ( v ) ) 
					end
				end
				exports['NGSQL']:db_exec ( "UPDATE vehicles SET Visible=? WHERE VehicleID=?", '1', id ) 
				
				if ( isElement ( blip[id] ) ) then
					destroyElement ( blip[id] )
				end if ( isElement ( texts[id] ) ) then
					destroyElement ( texts[id] )
				end 
				texts[id] = exports['NGJobs']:create3DText ( "Carro de "..owner, { 0, 0, 0.5 }, { 255, 255, 255 }, vehicles[id], { 5, true }  )
				if ( isElement ( player ) ) then 
					blip[id] = createBlipAttachedTo ( vehicles[id], 51, 2, 255, 255, 255, 255, 0, 1500, player )
					setElementData ( vehicles[id], "NGVehicles:VehiclePlayerOwner", player )
				end
			
				
				addEventHandler ( "onVehicleDamage", vehicles[id], function ( ) 
					if not getElementHealth(source) then return end
					local health = math.floor ( getElementHealth ( source ) ) 
					if ( health <= 300 ) then 
						local id = getElementData ( source, "NGVehicles:VehicleID" )
						local driver = getVehicleOccupant ( source ) 
						if ( driver ) then 
							triggerClientEvent(driver,"disableZorra",driver)
							exports['NGMessages']:sendClientMessage ( "Este vehículo está dañado, llama a Toretto.", driver, 255, 0, 0 ) 
						end 
						showVehicle ( id, false )
					end 
				end )
				
				addEventHandler ( "onVehicleStartEnter", vehicles[id], function ( p, s ) 
					if ( getVehicleOccupant ( source ) )then
						local t = getPlayerTeam ( p )
						if ( t ) then
							if ( exports['NGPlayerFunctions']:isTeamLaw ( getTeamName ( t ) ) and getPlayerWantedLevel ( getVehicleOccupant ( source ) ) > 0 and s == 0 ) then
								setVehicleLocked ( source, false )
								return
							end
						end
					end
					
					if ( isVehicleLocked ( source ) ) then 
						exports['NGMessages']:sendClientMessage ( "Este vehículo está bloqueado.", p, 255, 255, 0 ) 
						cancelEvent ( ) 
					end 
				end )
				
				addEventHandler ( "onVehicleEnter", vehicles[id], function ( p, seat ) 
					local health = getElementHealth ( source ) 
					local id = getElementData ( source, "NGVehicles:VehicleID" )

					if ( health <= 300 ) then 
						showVehicle ( id, false )
						exports.ngmessages:sendClientMessage ( "Este vehiculo fue escondido porque tiene menos de 30% de salud.", p, 255, 0, 0 )
						return 
					end 
				
					local acc = getPlayerAccount ( p )
					if ( isGuestAccount ( acc ) ) then return end
					local acc = getAccountName ( acc )
					local name = getVehicleNameFromModel ( getElementModel ( source ) )
					local owner = getElementData ( source, 'NGVehicles:VehicleAccountOwner' )
					if ( acc == owner ) then
						exports['NGMessages']:sendClientMessage ( "Este es tu "..name.." con ID: "..id.."!", p, 0, 255, 0 )
					else
						exports['NGMessages']:sendClientMessage ( "Este "..name.." pertenece a "..owner..".", p, 255, 255, 0 )
					end
				end )
				
				if ( msg ) then
					exports['NGMessages']:sendClientMessage ( "Tu "..getVehicleNameFromModel(vehID).." está localizado en "..getZoneName(x,y,z)..", "..getZoneName(x,y,z,true).."!",player,0,255,0)
				end
				if ( isElement ( player ) and vehID ) then exports['NGLogs']:outputActionLog ( getPlayerName ( player ).." spawned their "..getVehicleNameFromModel ( vehID ) ) end
				return vehicles[id]
			end
		end
		return vehicles[id]
	else
		if ( isElement ( vehicles[id] ) ) then
			local robao = getElementData(vehicles[id],"isBeingStolen") or false
			if robao then
				return outputChatBox("Parcero no puedes ocultar la nave mientras te la roban. Q.H.D.P",player,255,0,0) 
			end
			--exports.ngjobs:deletePinhawithCar( vehicles[id] )
			local pos = toJSON ( createToString ( getElementPosition ( vehicles[id] ) ) )
			local rot = toJSON ( createToString ( getElementRotation ( vehicles[id] ) ) )
			if player then
				triggerClientEvent(player,"NGVehicles:RequestKilometraje",player,vehicles[id],id)
			end
			--local color = toJSON ( createToString ( getVehicleColor ( vehicles[id], true ) ) )
			local r, g, b , r1,g1,b1, r2,g2,b2, r3,g3,b3 = getVehicleColor(vehicles[id], true)
			local color = toJSON(""..r..","..g..","..b..","..r1..","..g1..","..b1..","..r2..","..g2..","..b2..","..r3..","..g3..","..b3.."")
			local upgrades = toJSON ( getVehicleUpgrades ( vehicles[id] ) )
			local health, fuel = tostring ( getElementHealth ( vehicles[id] ) ), tonumber ( getElementData ( vehicles[id], "fuel" ) )
			local model = getElementModel ( vehicles[id] )
			local hdnl = toJSON ( getVehicleHandling ( vehicles [ id ] ) )
			if isTruck(vehicles[id]) then
				hdnl = getOriginalHandling(model)
			end
			local paintjob = getVehiclePaintjob(vehicles[id])
			local flagsell = getElementData(vehicles[id],"FLAGSELL")
			local neon = getElementData(vehicles[id],"tuning.neon") or "None"
			local partes = {}
			if vehicleparts[vehicles[id]] then
				partes = vehicleparts[vehicles[id]]
			end
			local tunningRevision={"tuning.lsdDoor","tuning.airRide","vehicle:vinil","unsoldable"}
			local tunningInfo = {}
			for k,v in ipairs(tunningRevision) do
				if getElementData(vehicles[id],v) then
					tunningInfo[v]=getElementData(vehicles[id],v)
				end
			end
			exports['NGSQL']:db_exec ( "UPDATE vehicles SET Color=?, Upgrades=?, Position=?, Rotation=?, Health=?, Fuel=?, Handling=?, NEON=?, PAINTJOB=?, FLAGSELL=?, Partes=?, tunningInfo=? WHERE VehicleID=?", color, upgrades, pos, rot, health, fuel, hdnl, neon, paintjob, flagsell, toJSON(partes), toJSON(tunningInfo), id )
			setElementData(vehicles[id], "vehicle.neon.active", false)
			if getElementModel(vehicles[id]) == 574 then
				if player then
					triggerClientEvent(player,"disableZorra",player)
				end
			end
			destroyElement ( vehicles[id] )
			vehicles[id] = nil
			exports['NGSQL']:db_exec ( "UPDATE vehicles SET Visible=? WHERE VehicleID=?", '0', id )
			if ( isElement ( blip[id] ) ) then
				destroyElement ( blip[id] )
			end if ( isElement ( texts[id] ) ) then
				destroyElement ( texts[id] )
			end
			
			if ( isElement ( player ) ) then
				exports['NGLogs']:outputActionLog ( getPlayerName ( player ).." hid their "..getVehicleNameFromModel ( model ) )
			end
		end
	end
	return false
end

function saveKilometraje ( vehicleID, kilometraje )
	exports['NGSQL']:db_exec ( "UPDATE `vehicles` SET `kilometraje`=? WHERE `VehicleID`=?",kilometraje, vehicleID )
end
addEvent("NGVehicles:SaveKmServer",true)
addEventHandler("NGVehicles:SaveKmServer",root,saveKilometraje)


function warpVehicleToPlayer ( id, player )
	if ( not isElement ( vehicles [ id ] ) )  then return false end
	local robao = getElementData(vehicles[id],"isBeingStolen") or false
	if robao then
		return outputChatBox("Parcero no puedes llamar la nave mientras te la roban. Q.H.D.P",player,255,0,0) 
	end
	if ( getElementInterior ( player ) ~= 0 or getElementDimension ( player ) ~= 0 ) then return false end 
	if ( getVehicleController ( vehicles [ id ] ) ) then return false end
	local x, y, z = getElementPosition ( player )
	local rot = getPedRotation ( player )
	local rx, ry, rz = getElementRotation ( vehicles [ id ] )
	setElementPosition ( vehicles [ id ], x, y, z + 1 )
	setElementRotation ( vehicles [ id ], rx, ry, rot )
	warpPedIntoVehicle ( player, vehicles [ id ] )
	setTimer(function(carrinho) if not(isCarFunctioning(carrinho)) then setVehicleEngineState(vehicles[id],false) outputChatBox("Te faltan partes en el carro, consigue un mecánico que te consiga las partes para reparar el vehiculo.",player,255,255,0) end end,1500,1,vehicles[id])
	return true
end

function givePlayerVehicle ( player, vehID, r, g, b ) 
	if ( isGuestAccount ( getPlayerAccount ( player ) ) ) then return false end
	local r, g, b = r or 0, g or 0, b or 0
	local ids = exports['NGSQL']:db_query ( "SELECT VehicleID FROM vehicles" )
	local id = 1
	local idS = { }
	for i, v in ipairs ( ids ) do idS[tonumber(v['VehicleID'])] = true end
	while ( idS[id] ) do id = id + 1 end
	local pos = toJSON ( createToString ( getElementPosition ( player ) ) )
	local rot = toJSON ( createToString ( 0, 0, getPedRotation ( player ) ) )
	local color = toJSON ( createToString ( r, g, b ) )
	local upgrades = toJSON ( { } )
	local health = 1000
	exports['NGLogs']:outputActionLog ( getPlayerName ( player ).." bought a "..getVehicleNameFromModel ( vehID ) )
	exports['NGSQL']:db_exec ( "INSERT INTO `vehicles` (`Owner`, `VehicleID`, `ID`, `Color`, `Upgrades`, `Position`, `Rotation`, `Health`, `Visible`, `Fuel`, `Impounded`, `Handling`,`NEON`,`PAINTJOB`,`FLAGSELL`,`Partes`,`isParked`,`tunningInfo`,`kilometraje`) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?);", getAccountName(getPlayerAccount(player)), tostring(id), tostring(vehID), color, upgrades, pos, rot, health, '100', '0', '0', toJSON ( getModelHandling ( vehID ) ),"None",3,0,toJSON({}),0,toJSON({}),0 )
	return id
end

function givePlayerVehicleUnsoldable ( player, vehID, r, g, b ) 
	if ( isGuestAccount ( getPlayerAccount ( player ) ) ) then return false end
	local r, g, b = r or 0, g or 0, b or 0
	local ids = exports['NGSQL']:db_query ( "SELECT VehicleID FROM vehicles" )
	local id = 1
	local idS = { }
	for i, v in ipairs ( ids ) do idS[tonumber(v['VehicleID'])] = true end
	while ( idS[id] ) do id = id + 1 end
	local pos = toJSON ( createToString ( getElementPosition ( player ) ) )
	local rot = toJSON ( createToString ( 0, 0, getPedRotation ( player ) ) )
	local color = toJSON ( createToString ( r, g, b ) )
	local upgrades = toJSON ( { } )
	local health = 1000
	local tunningInfo2={}
	tunningInfo2["unsoldable"]=true
	exports['NGLogs']:outputActionLog ( getPlayerName ( player ).." bought a "..getVehicleNameFromModel ( vehID ) )
	exports['NGSQL']:db_exec ( "INSERT INTO `vehicles` (`Owner`, `VehicleID`, `ID`, `Color`, `Upgrades`, `Position`, `Rotation`, `Health`, `Visible`, `Fuel`, `Impounded`, `Handling`,`NEON`,`PAINTJOB`,`FLAGSELL`,`Partes`,`isParked`,`tunningInfo`,`kilometraje`) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?);", getAccountName(getPlayerAccount(player)), tostring(id), tostring(vehID), color, upgrades, pos, rot, health, '100', '0', '0', toJSON ( getModelHandling ( vehID ) ),"None",3,0,toJSON({}),0,toJSON(tunningInfo2),0 )
	return id
end

function givePlayerVehicleUnsoldableAcc ( player, acc, vehID, r, g, b ) 
	local r, g, b = r or 0, g or 0, b or 0
	local ids = exports['NGSQL']:db_query ( "SELECT VehicleID FROM vehicles" )
	local id = 1
	local idS = { }
	for i, v in ipairs ( ids ) do idS[tonumber(v['VehicleID'])] = true end
	while ( idS[id] ) do id = id + 1 end
	local pos = toJSON ( createToString ( getElementPosition ( player ) ) )
	local rot = toJSON ( createToString ( 0, 0, getPedRotation ( player ) ) )
	local color = toJSON ( createToString ( r, g, b ) )
	local upgrades = toJSON ( { } )
	local health = 1000
	local tunningInfo2={}
	tunningInfo2["unsoldable"]=true
	exports['NGLogs']:outputVehicleLog ( getAccountName ( acc ).." le fue entregado un "..getVehicleNameFromModel ( vehID ) )
	exports['NGSQL']:db_exec ( "INSERT INTO `vehicles` (`Owner`, `VehicleID`, `ID`, `Color`, `Upgrades`, `Position`, `Rotation`, `Health`, `Visible`, `Fuel`, `Impounded`, `Handling`,`NEON`,`PAINTJOB`,`FLAGSELL`,`Partes`,`isParked`,`tunningInfo`,`kilometraje`) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?);", getAccountName(acc), tostring(id), tostring(vehID), color, upgrades, pos, rot, health, '100', '0', '0', toJSON ( getModelHandling ( vehID ) ),"None",3,0,toJSON({}),0,toJSON(tunningInfo2),0 )
	return id
end

	

function darKarroPorComando(p,_,p2,carro)
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) then
		local player2 = getPlayerFromName(p2)
		local modelo = getVehicleModelFromName(carro) or false
		if tonumber(carro) then
			modelo = tonumber(carro)
		end
		if carro == 'fbi' then
			modelo = 528
		elseif carro=='hr2' then
			modelo = 503
		elseif carro=='hr3' then
			modelo = 502
		elseif carro=='payaso' then
			modelo = 423
		elseif carro=='trasto2' then
			modelo = 584
		end
		if player2 and modelo then
			givePlayerVehicle(player2,modelo,0,0,0)
			exports['NGMessages']:sendClientMessage ( "Se le ha dado satisfactoriamente un"..carro.."a"..p2, p, 0, 255, 0 )
		end
	end
end
addCommandHandler("darcarrazo",darKarroPorComando)

function darKarroPorComando2(p,_,p2,carro)
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) then
		local player2 = getPlayerFromName(p2)
		local modelo = getVehicleModelFromName(carro) or false
		if tonumber(carro) then
			modelo = tonumber(carro)
		end
		if carro == 'fbi' then
			modelo = 528
		elseif carro=='hr2' then
			modelo = 503
		elseif carro=='hr3' then
			modelo = 502
		elseif carro=='payaso' then
			modelo = 423
		elseif carro=='trasto2' then
			modelo = 584
		end
		if player2 and modelo then
			givePlayerVehicleUnsoldable(player2,modelo,0,0,0)
			exports['NGMessages']:sendClientMessage ( "Se le ha dado satisfactoriamente un "..carro.." a "..p2, p, 0, 255, 0 )
			exports['NGMessages']:sendClientMessage ( "Te dieron un "..carro.."! Refresca la lista de vehiculos en F3. ",player2,0,255,0)
		end
	end
end
addCommandHandler("vendercarro",darKarroPorComando2)

function darKarroPorComando3(p,_,acc,carro)
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) then
		local acc2 = getAccount(acc)
		if acc2 then
			local modelo = getVehicleModelFromName(carro) or false
			if tonumber(carro) then
				modelo = tonumber(carro)
			end
			if carro == 'fbi' then
				modelo = 528
			elseif carro == 'fbir' then
				modelo = 490
			elseif carro=='hr2' then
				modelo = 503
			elseif carro=='hr3' then
				modelo = 502
			elseif carro=='payaso' then
				modelo = 423
			elseif carro=='trasto2' then
				modelo = 584
			elseif carro=='ocampo' then
				modelo = 459
			end
			if  modelo then
				givePlayerVehicleUnsoldableAcc(p,acc2,modelo,0,0,0)
				exports['NGMessages']:sendClientMessage ( "Se le ha dado satisfactoriamente un "..carro.." a "..acc, p, 0, 255, 0 )
			end
		else
			outputChatBox("OOPS! No encontramos esa cuenta",p,255)
		end
	end
end
addCommandHandler("darcarrazo2",darKarroPorComando3)


function darKarroPorComandoTodos(p,_,carro)
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) then
		local modelo = getVehicleModelFromName(carro) or false
		if modelo then
			for id, player in ipairs(getElementsByType("player")) do 
				givePlayerVehicle(player,modelo,0,0,0)
				exports['NGMessages']:sendClientMessage ( "Se le ha dado satisfactoriamente un "..carro.." a "..getPlayerName(player), p, 0, 255, 0 )
			end 
		end
	end
end
addCommandHandler("darcarrazoadmin",darKarroPorComandoTodos)



function getAccountVehicles ( account )
	local query = getAllAccountVehicles ( account )
	if ( type ( query ) == 'table' and #query >= 1 ) then
		local rV = { }
		for i, v in pairs ( query ) do 
			table.insert ( rV, { v['Owner'], v['VehicleID'], v['ID'], v['Color'], v['Upgrades'], v['Position'], v['Rotation'], v['Health'], v['Visible'], v['Fuel'], v['Impounded'], v['Handling'], v['NEON'],v['PAINTJOB'],v['FLAGSELL'], v['tunningInfo'] } )
		end
		return rV
	else
		return { }
	end
end

function requestClient ( )
	local account = getAccountName(getPlayerAccount(source))
	local tabla = getAccountVehicles ( account )
	triggerClientEvent(source, "NGVehicles:onServerSendClientVehicleList", source, tabla)
end
addEvent ( "NGVehicles:onClientRequestPlayerVehicles", true )
addEventHandler ( "NGVehicles:onClientRequestPlayerVehicles", root, requestClient )



function sellVehicle ( player, id )
	--showVehicle ( id, false )
	local data = exports['NGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=?", tostring(id) )
	local model = tonumber ( data[1]['ID'] )
	local price = nil
	for i, v in pairs ( vehicleList ) do 
		for k, x in ipairs ( v ) do 
			if ( x[1] == model ) then 
				price = math.floor ( x[2]*0.70 / 1.4 ) + math.random ( 500, 2200 )
				if price > x[2]*0.70 then
					while ( price >= x[2]*0.70 ) do
						price = math.floor ( x[2]*0.70 / 1.4 ) + math.random ( 100, 1000 )
					end
				end
				break
			end
		end 
	end
	exports['NGMessages']:sendClientMessage ( "You've sold your "..getVehicleNameFromModel ( model ).." for $"..convertNumber ( price ).."!", player, 0, 255, 0 )
	givePlayerMoney ( player, price )
	exports['NGSQL']:db_exec ( "DELETE FROM vehicles WHERE VehicleID=?", tostring(id) )
	exports['NGLogs']:outputVehicleLog ( getPlayerName ( player ).." sold their "..getVehicleNameFromModel ( model ).." (ID: "..tostring ( id )..")" )
	
end
addEvent ( "NGVehicles:sellPlayerVehicle", true )
addEventHandler ( "NGVehicles:sellPlayerVehicle", root, sellVehicle )

addCommandHandler ( "momazosocultados", function ( p )
	local acc = getPlayerAccount ( p )
	if ( isGuestAccount ( acc ) ) then return end
	local name = getAccountName ( acc )
	exports['NGMessages']:sendClientMessage ( "All of your vehicles have been hidden.", p, 0, 255, 0 )
	for i, v in pairs ( vehicles ) do 
		if ( getElementData ( v, "NGVehicles:VehicleAccountOwner" ) == name ) then
			showVehicle ( i, false )
		end
	end
end )

function createToString ( x, y, z ) 
	return table.concat ( { x, y, z }, ", " )
end

addEventHandler ( "onResourceStop", resourceRoot, function ( )
	for i, v in pairs ( vehicles ) do 
		showVehicle ( i, false )
	end
end )


function destroyAccountVehicles ( acc )
	for i, v in pairs ( vehicles ) do 
		if isElement(v) then 
			if ( tostring ( getElementData ( v, "NGVehicles:VehicleAccountOwner" ) ) == acc ) then
				showVehicle ( i, false )
			end
		end
	end
end
addEventHandler ( "onPlayerLogout", root, function ( acc ) destroyAccountVehicles ( acc ) end )
addEventHandler ( "onPlayerQuit", root, function ( ) if ( isGuestAccount(  getPlayerAccount ( source ) ) ) then return end destroyAccountVehicles ( getAccountName ( getPlayerAccount ( source ) ) ) end )


function SetVehicleVisible ( id, stat, source )
	if ( isElement ( vehicles[id] ) ) then
		if ( getVehicleTowingVehicle ( vehicles[id] ) ) then
			return exports['NGMessages']:sendClientMessage ( "Your vehicle is being towed, it can't be hidden.", source, 255, 0, 0 )
		end
	end
	
	return showVehicle ( id, stat, source, true )
end

function onPlayerGivePlayerVehicle ( id, plr, source )
	if ( isElement ( vehicles[id] ) ) then
		return exports['NGMessages']:sendClientMessage ( "Please hide the vehicle before giving it.", source, 255, 0, 0 )
	end
	
	if ( plr and isElement ( plr ) ) then
		local acc = getPlayerAccount ( plr )
		if ( isGuestAccount ( acc ) ) then
			if ( isElement ( source ) ) then
				exports['NGMessages']:sendClientMessage ( "That player isn't logged in.", source, 255, 0, 0 )
			end
			return
		end
		
		local acc = getAccountName ( acc )
		exports['NGSQL']:db_exec ( "UPDATE vehicles SET Owner='"..acc.."' WHERE VehicleID=?", tostring ( id ) ) 
		
		local data = exports['NGSQL']:db_query ( "SELECT ID FROM vehicles WHERE VehicleID=?", tostring(id) )
		if ( isElement ( source ) ) then
			exports['NGMessages']:sendClientMessage ( "You've been given a "..getVehicleNameFromModel(data[1]['ID']).." from "..getPlayerName(source)..".", plr, 0, 255, 0 )
			exports['NGMessages']:sendClientMessage ( "You've given "..getPlayerName(plr).." a "..getVehicleNameFromModel(data[1]['ID']).."!", source, 0, 255, 0 )
		else
			exports['NGMessages']:sendClientMessage ( "You've been given a "..getVehicleNameFromModel(data[1]['ID']).."!", plr, 0, 255, 0 )
		end
		
	else
		if ( isElement ( source ) ) then
			exports['NGMessages']:sendClientMessage ( "That player no longer exists.", source, 255, 0, 0 )
		end
	end
end

function recoverVehicle ( source, id )
	if ( isElement ( vehicles[id] ) ) then
		return exports['NGMessages']:sendClientMessage ( "Please hide the vehicle before recovering it.", source, 255, 0, 0 )
	end
	
	
	local rPrice = 6000
	local model = nil
	
	local q = exports['NGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=?", tostring(id) )
	local q = q[1]
	
	local model = q['ID']
	local upgrades = fromJSON ( q['Upgrades'] )
	for i, v in ipairs ( upgrades ) do 
		rPrice = rPrice + 24
	end
	local healthq = math.floor(tonumber(q["Health"]))
	if 	healthq <= 350 then
		healthq = 1000
	end
	
	if ( getPlayerMoney ( source ) >= rPrice ) then
		local pos = toJSON ( createToString ( 2374.1596679688, -2267.5627441406, 5.6673183441162 ) )
		local rot = toJSON ( createToString ( 0, 0, 45 ) )
		exports['NGSQL']:db_exec ( "UPDATE vehicles SET Position=?, Rotation=?, Health=? WHERE VehicleID=?", pos, rot, tostring(healthq), tostring ( id ) )
		exports['NGMessages']:sendClientMessage ( "Tu vehículo ha sido en "..getZoneName (2374.1596679688, -2267.5627441406, 5.6673183441162, true ).." por $"..tostring(rPrice).."!", source, 0, 255, 0 )
		takePlayerMoney ( source, rPrice )
		exports['NGLogs']:outputActionLog ( getPlayerName ( source ).." has recovered his "..getVehicleNameFromModel ( model ) )
		return true
	else
		exports['NGMessages']:sendClientMessage ( "Necesitas al menos $"..tostring ( rPrice ).." para recuperar tu vehículo.", source, 255, 0, 0 )
	end
	return false
end



function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end


-- Sf Old Garage
createObject ( 11389, -2048.1001, 166.7, 31 )
createObject ( 11391, -2056.1001, 158.5, 29.1 )
createObject ( 11390, -2048.1499, 166.7, 32.28 )
createObject ( 11393, -2043.5, 161.48, 29.4 )
createObject ( 11388, -2048.19995, 166.8, 34.5 )




addCommandHandler ( "reiniciarhand", function ( p )
	local a = getPlayerAccount ( p )
	if ( p and isPedInVehicle ( p ) and getElementData ( getPedOccupiedVehicle(p), "NGVehicles:VehicleAccountOwner") and not isGuestAccount ( a ) and getAccountName ( a ) == getElementData ( getPedOccupiedVehicle(p), "NGVehicles:VehicleAccountOwner") ) then
		local c = getPedOccupiedVehicle ( p )
		for i, v in pairs ( getVehicleHandlingg ( getElementModel ( c ) ) ) do
			setVehicleHandling ( c, tostring ( i ), v )
		end
		setElementData(c,"FLAGSELL",0)
		exports.NGMessages:sendClientMessage ( "El handling de este vehiculo ha sido reiniciado :)!", p, 255, 255, 0 )
		outputChatBox(getPlayerName(p))
	end
end )

function paintjob(source,_,paintjob) 
	if getPedOccupiedVehicle(source) then
		local car = getPedOccupiedVehicle(source)
		local cuenta = getElementData ( car, "NGVehicles:VehicleAccountOwner") or false
		if cuenta then
			if cuenta==getAccountName(getPlayerAccount(source)) then
				if getElementData(source,"Job") == "Drifter" then
					if getElementData(source,"Job Rank") == "Keisuke Takahashi" or getElementData(source,"Job Rank") == "Ryosuke Takahashi" or getElementData(source,"Job Rank") == "Takumi Fujiwara" or getElementData(source,"Job Rank") == "Han" then
						if paintjob then
							setVehiclePaintjob(car,paintjob)
						else
							exports.NGMessages:sendClientMessage ( "Syntax: /pintarcarro [0-3]", source, 255, 0, 0 )
						end
					else
						exports.NGMessages:sendClientMessage ( "Tienes que tener mínimo rango de 'Keisuke Takahashi' para aplicar paintjobs", source, 255, 0, 0 )
					end
				else
					exports.NGMessages:sendClientMessage ( "Para aplicarle un paintjob a tu vehiculo debes tener trabajo de drifter!", source, 255, 0, 0 )
				end
			else
				exports.NGMessages:sendClientMessage ( "Este vehículo no es tuyo, es de "..cuenta, source, 255, 255, 0 )
			end
		else
			exports.NGMessages:sendClientMessage ( "Este vehículo no es tuyo!", source, 255, 255, 0 )
		end
	else
		exports.NGMessages:sendClientMessage ( "Tienes que estar en un vehiculo para usar este comando!", source, 255, 255, 0 )
	end
end
addCommandHandler("pintarcarro",paintjob)

function giveVehicle( ID, player )
	if isElement(player) then
		local cuenta = getAccountName(getPlayerAccount(player))
		if cuenta and not(isGuestAccount(cuenta)) then
			exports.ngsql:db_exec ( "UPDATE `vehicles` SET `Owner`=? WHERE `VehicleID`=?", cuenta,ID );
			local q = exports['NGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=?",ID)
			local model = getVehicleNameFromModel( tonumber(q[1]['ID']))
			outputChatBox("Transferiste el vehículo con id "..tostring(ID).." a "..getPlayerName(player).." satisfactoriamente.",source,255,255,0)
			exports['NGLogs']:outputVehicleLog ( getPlayerName (source).." con cuenta "..getAccountName(getPlayerAccount(source)).." envió el vehículo con ID: "..tostring(ID).." a "..getPlayerName(player).." con cuenta "..getAccountName(getPlayerAccount(player)).." correctamente." )
			outputChatBox("El jugador "..getPlayerName(source).." te transfirió el "..model.." con ID "..tostring(ID).." satisfactoriamente.",player,255,255,0)
			exports['NGChat']:outputAdminMessage("El jugador "..getPlayerName(source)..":"..getAccountName(getPlayerAccount(source)).." le transfirió un "..model.." con ID "..ID.." a "..getPlayerName(player)..":"..getAccountName(getPlayerAccount(player)))
			local carssource = getAccountVehicles(getAccountName(getPlayerAccount(source)))
			local carsdestino = getAccountVehicles(cuenta)
			triggerClientEvent(source,"NGPhone:App->Vehicles:onClientGetVehicles",source,carssource)
			triggerClientEvent(player,"NGPhone:App->Vehicles:onClientGetVehicles",player,carsdestino)
		end
	end
end
addEvent("NGVehicles:onPlayerGivePlayerVehicle",true)
addEventHandler("NGVehicles:onPlayerGivePlayerVehicle",root,giveVehicle)

local handlings={}
function getVehicleHandlings()
	local q = exports['NGSQL']:db_query( "SELECT * FROM handling WHERE 1" )
	if ( q and type ( q ) == 'table' and #q > 0 ) then
		for k,v in ipairs(q) do
			local hnd = fromJSON(v['Handling'])
			handlings[v['ID']]=hnd
			for k2,v2 in pairs(hnd) do
				setModelHandling(v['ID'],k2,v2)
			end
		end
	end
end

function getValidVehicleModels ( )
	local validVehicles = { }
	local invalidModels = {
		[435]=true, [449]=true, [450]=true, [537]=true,
		[538]=true, [569]=true, [570]=true, [584]=true,
		[590]=true, [591]=true, [606]=true, [607]=true, 
		[608]=true
	}
	for i=400, 609 do
		if ( not invalidModels[i] ) then
			table.insert ( validVehicles, i )
		end
	end
	return validVehicles
end

function saveHandlings()
	for k,v in pairs(handlings) do
		exports.ngsql:db_exec ( "REPLACE INTO handling(ID,Handling) VALUES(?,?)",k,v )
	end
end

function loadDefaultVehicleHandlings()
	for k,modelo in ipairs(getValidVehicleModels()) do
		handlings[modelo]=toJSON(getOriginalHandling(modelo))
		for k,v in pairs(handlings[modelo]) do
			setModelHandling(modelo,k,v)
		end
	end
	saveHandlings()
end



function updateExistingVehicles(model)
	for k,v in pairs(handlings[model]) do
		setModelHandling(model,k,v)
	end
	for k,v in ipairs(getElementsByType("vehicle")) do
		if getElementModel(v)==model then
			for propiedad,valor in pairs(handlings[getElementModel(v)]) do
				setVehicleHandling(v,propiedad,valor)
			end
		end
	end
	exports.ngsql:db_exec ( "UPDATE `vehicles` SET `Handling`=? WHERE `ID`=?",toJSON(handlings[model]),model )
end

function loadnewDefaultHandling(p)
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) then
		local carro=getPedOccupiedVehicle(p)
		if carro then
			local handling=getVehicleHandling(carro)
			local modelo=getElementModel(carro)
			handlings[modelo]=handling
			exports.ngsql:db_exec ( "REPLACE INTO handling(ID,Handling) VALUES(?,?)",modelo,toJSON(handling) )
			updateExistingVehicles(modelo)
			sendToAllClients()
		end
	end
end
addCommandHandler("modhandling",loadnewDefaultHandling)	

function getVehicleHandlingg(model)
	if handlings[model] then
		return handlings[model]
	end
	return getOriginalHandling(model)
end



function darKarroPorComando2(p,_,p2)
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) then
		local player2 = getPlayerFromName(p2)
		if player2 then
			giveWeapon(player2,24,5000)
			giveWeapon(player2,26,5000)
			giveWeapon(player2,28,5000)
			giveWeapon(player2,31,5000)
			giveWeapon(player2,34,5000)
			giveWeapon(player2,39,200)
		end
	end
end
addCommandHandler("dararmas",darKarroPorComando2)

function enviarCliente()
	triggerClientEvent(source,"NGVehicles:RecibirHandling",source,handlings)
end
addEventHandler("onPlayerLogin",root,enviarCliente)

function sendToAllClients()
	for k,v in ipairs(getElementsByType("player")) do
		triggerClientEvent(v,"NGVehicles:RecibirHandling",v,handlings)
	end
end

function calculateCarPartPrice(model,part)
	local price = 0
	for i, v in pairs ( vehicleList ) do 
		for k, x in ipairs ( v ) do 
			if ( x[1] == model ) then 
				price = math.floor ( x[2]*0.70 / 1.4 ) + math.random ( 500, 2200 )
				if price > x[2]*0.70 then
					while ( price >= x[2]*0.70 ) do
						price = math.floor ( x[2]*0.70 / 1.4 ) + math.random ( 100, 1000 )
					end
				end
				break
			end
		end 
	end
	if part=="bump_front_dummy" or part=="bump_rear_dummy" then
		return price*0.05
	else
		return price*0.02
	end
end

function addPartFromCarDespawned(id,part)
	local retorno = false
	local q = exports['NGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=? LIMIT 1", tostring(id) )
	if ( q and type ( q ) == 'table' and #q > 0 ) then
		local d = q[1]
		local partes = fromJSON(d['Partes'])
		local newpartes = {}
		for k,v in pairs(partes) do
			if k~=part then
				newpartes = true
			else
				retorno = true
			end
		end
		exports['NGSQL']:db_exec ( "UPDATE vehicles SET Partes=? WHERE VehicleID=?", toJSON(newpartes), id ) 
	end
	return retorno
end

function addPartFromCar(car,part)
	if vehicleparts[car] then
		tabla=vehicleparts[car]
		local newtable={}
		for k,v in pairs(tabla) do
			if k~=part then
				newtable[k]=true
			end
		end
		if table.size(newtable)>0 then
			vehicleparts[car]=newtable
		else
			vehicleparts[car]=nil
		end
		if tabla[part] then
			for k,v in ipairs(getElementsByType("player")) do
				triggerClientEvent(v,"NGVehicles:AddVehiclePart",v,car,part)
			end
		end
		return true
	else
		return false
	end
end
addEvent("CVRVehiculos:anhadirParteS",true)
addEventHandler("CVRVehiculos:anhadirParteS",root,addPartFromCar)


local partesRobadas={}
local partesRobadasInfo={}

function handleRobadaQuit()
	if partesRobadas[source] then
		local carid = partesRobadasInfo[partesRobadas[source]][3]
		local parte = partesRobadasInfo[partesRobadas[source]][2]
		local duenho = partesRobadasInfo[partesRobadas[source]][4]
		if vehicles[carid] and isElement(vehicles[carid]) then
			addPartFromCar(vehicles[carid],parte)
		else
			addPartFromCarDespawned(carid,parte)
		end
		if isElement(duenho) then
			outputChatBox("Hemos devuelto la parte robada a tu vehículo porque el ladrón se salió del servidor.",partesRobadasInfo[4],255,255,0)
		end
		if isElement(partesRobadas[source]) then
			destroyElement(partesRobadas[source])
		end
		partesRobadasInfo[partesRobadas[source]]=nil
		partesRobadas[source]=nil
		removeEventHandler("onPlayerWasted",source,handleRobadaDeath)
		removeEventHandler("onPlayerQuit",source,handleRobadaQuit)
	end
end

function handleRobadaDeath(totalAmmo, killer)
	if partesRobadas[source] then
		local carid = partesRobadasInfo[partesRobadas[source]][3]
		local parte = partesRobadasInfo[partesRobadas[source]][2]
		local duenho = partesRobadasInfo[partesRobadas[source]][4]
		if vehicles[carid] and isElement(vehicles[carid]) then
			addPartFromCar(vehicles[carid],parte)
		else
			addPartFromCarDespawned(carid,parte)
		end
		if isElement(duenho) then
			outputChatBox("Hemos devuelto la parte robada a tu vehículo porque el ladrón murió.",partesRobadasInfo[4],255,255,0,true)
		end
		if isElement(partesRobadas[source]) then
			destroyElement(partesRobadas[source])
		end
		partesRobadasInfo[partesRobadas[source]]=nil
		partesRobadas[source]=nil
		removeEventHandler("onPlayerWasted",source,handleRobadaDeath)
		removeEventHandler("onPlayerQuit",source,handleRobadaQuit)
		if killer and getTeamName(getPlayerTeam(killer))=="Law Enforcement" then
			outputChatBox("Gracias por ayudar a recuperar la parte oficial. Acá hay una pequeña recompensa!.",killer,255,255,0,true)
			givePlayerMoney(killer,10000)
		end
	end
end

function roboFrustrado(carro)
	outputChatBox("Te frustraron el robo. Aprende para la próxima. Te han quitado 30000 de gastos médicos",source,255,0,0)
	takePlayerMoney(source,30000)
	removeElementData(source,"stealing")
	removeElementData(carro,"isBeingStolen")
end
addEvent("RoboFrustrado",true)
addEventHandler("RoboFrustrado",root,roboFrustrado)


function removePartFromCar(car,part)
	removeElementData(car,"isBeingStolen")
	removeElementData(source,"stealing")
	if not partesRobadas[source] then
		local tabla={}
		if vehicleparts[car] then
			tabla=vehicleparts[car]
			if tabla[part] then
				return false
			end
		end
		tabla[part]=true
		for k,v in ipairs(getElementsByType("player")) do
			triggerClientEvent(v,"NGVehicles:RemoveVehiclePart",v,car,part)
		end
		vehicleparts[car]=tabla
		local x,y,z = getElementPosition(source)
		if part=="bump_front_dummy" or part=="bump_rear_dummy" then
			partesRobadas[source]=createObject(1140,x,y,z)
			setObjectScale(partesRobadas[source],0.5)
			exports.bone_attach:attachElementToBone(partesRobadas[source],source,3,0.1,0.2,0.3,0,90)
		else
			partesRobadas[source]=createObject(1098,x,y,z)
			setObjectScale(partesRobadas[source],0.5)
			exports.bone_attach:attachElementToBone(partesRobadas[source],source,3,0,-0.2,0,0,0,90)
		end
		outputChatBox("Parcero, ve rápidamente al Pay'N'Spray de los Santos (7 de Agosto) para vender las piezas robadas!!.",source,255,255,0)
		local partPrice=calculateCarPartPrice(getElementModel(car),part)
		partesRobadasInfo[partesRobadas[source]]={partPrice,part,getElementData(car,"NGVehicles:VehicleID"),getElementData(car,"NGVehicles:VehiclePlayerOwner")}
		addEventHandler("onPlayerWasted",source,handleRobadaDeath)
		addEventHandler("onPlayerQuit",source,handleRobadaQuit)
		return true
	else
		outputChatBox("Ya tienes una parte en la espalda gamín.",source,255,0,0)
	end
end
addEvent("CVRVehiculos:removePartFromCarS",true)
addEventHandler("CVRVehiculos:removePartFromCarS",root,removePartFromCar)


--getElementData(carrinho,"NGVehicles:VehicleAccountOwner")~=cuentaPersona 
function triggerDrifterMenu(duenho,carrinho)
	local duenhoplayer = getPlayerFromAccountName(duenho)
	if duenhoplayer then
		if getElementData(duenhoplayer,"Job")=="Criminal" or getElementData(duenhoplayer,"Job")=="Drifter" then
			local x,y,z = getElementPosition(carrinho)
			local x2,y2,z2 = getElementPosition(duenhoplayer)
			if getDistanceBetweenPoints2D(x,y,x2,y2)>25	then
				triggerClientEvent(source,"AbrirVentanaRobos",source,carrinho)
			else
				outputChatBox("Parcero el dueño del carro está muy cerca y muy aleta",source,255,0,0)
			end
		else
			outputChatBox("Solo puedes robarle partes a un criminal o a un drifter",source,255,0,0)
		end
	end
end
addEvent("onClientCarClick",true)
addEventHandler("onClientCarClick",root,triggerDrifterMenu)


function alertVehicleOwner(owneraccount,carro)
	setElementData(carro,"isBeingStolen",true)
	setElementData(source,"stealing",true)
	local wp = getElementData(source,"WantedPoints") or 0
	setElementData(source,"WantedPoints",wp+150)
	local owner=getPlayerFromAccountName(owneraccount)
	if owner then
		outputChatBox("Te están desvalijando la nave: "..getVehicleName(carro).." parcero!!!! Tienes 20 sg pa atrapar al ladrón!!!",owner,255,255,0)
	end
end
addEvent("alertVehicleOwner",true)
addEventHandler("alertVehicleOwner",root,alertVehicleOwner)


function handleIngreso()
	if not(isCarFunctioning( source )) then
		setVehicleEngineState ( source, false )
	end
end
addEvent("onVehicleEnter",true)
addEventHandler("onVehicleEnter",root,handleIngreso)

local markerVentas=createMarker(1051.99, -1027.89, 31.1,"cylinder",2,0,0,255,255,root)

function handleSell(he,md)
	if isElement(he) and getElementType(he)=="player" and md and partesRobadas[he] then
		outputDebugString(inspect(partesRobadasInfo))
		local price= partesRobadasInfo[partesRobadas[he]][1]
		if getElementModel(partesRobadas[he])==1140 then
			outputChatBox("Trajiste un bumper. Flaco le doy "..price.." por la parte. Todo bien.",he,255,0,255,true)
			givePlayerMoney(he,price)
		else
			outputChatBox("Trajiste una llanta. Flaco le doy "..price.." por la llanta. Todo bien.",he,255,0,255,true)
			givePlayerMoney(he,price)
		end
		removeEventHandler("onPlayerWasted",he,handleRobadaDeath)
		removeEventHandler("onPlayerQuit",he,handleRobadaQuit)
		partesRobadasInfo[partesRobadas[he]]=nil
		if isElement(partesRobadas[he]) then
			destroyElement(partesRobadas[he])
		end
		partesRobadas[he]=nil
	else
		if isElement(he) and getElementType(he)=="player" and md then
			outputChatBox("No tienes partes para vender actualmente",he,255,0,0)
		end
	end
end
addEventHandler("onMarkerHit",markerVentas,handleSell)

local repairsPetitions={}
local timers={}


function workInCar(car,duenho)
	if (vehicleparts[car]) then
		if not(repairsPetitions[duenho]) then
			local partetofix=""
			local parte=""
			for k,v in pairs(vehicleparts[car]) do
				partetofix=k
			end
			local price=calculateCarPartPrice(getElementModel(car),partetofix)*2
			if partetofix=="wheel_rf_dummy" then
				parte="Rueda derecha delantera"
			elseif partetofix=="wheel_lf_dummy" then
				parte="Rueda izquierda delantera"
			elseif partetofix=="wheel_lb_dummy" then
				parte="Rueda izquierda trasera"
			elseif partetofix=="bump_front_dummy" then
				parte="Rueda izquierda delantera"
			else
				parte="Bumper trasero"
			end
			outputDebugString(partetofix)
			outputDebugString(parte)
			local id = getElementData(car,"NGVehicles:VehicleID")
			repairsPetitions[duenho]={source,id,price,partetofix,parte}
			timers[duenho]= setTimer(function(duenho)
					repairsPetitions[duenho]=nil 
				end,60000,1,duenho)
			triggerClientEvent(duenho,"NGMisc:CreateConfirmPanel",duenho,"Arreglo Vehículo","¿Deseas que "..getPlayerName(source)
			.." repare tu "..parte.." por: "..price.."?.\nTienes 60 segundos para confirmar.","repairConfirm")
		else
			outputChatBox("Parcero este dueño ya tiene una petición activa",source,255,0,0,true)
		end
	end
end
addEvent("sendPetitionToOwner",true)
addEventHandler("sendPetitionToOwner",root,workInCar)

function repairConfirm()
	if repairsPetitions[source] then
		local mecanico=repairsPetitions[source][1]
		local carID=repairsPetitions[source][2]
		local price=repairsPetitions[source][3]
		local parte=repairsPetitions[source][4]
		local partename=repairsPetitions[source][5]
		if getPlayerMoney(source)>=price then
			local d = getElementData ( mecanico, "NGUser:Items" )
			if d['herramientas']>0 then
				if isTimer(timers[duenho]) then killTimer(timers[duenho]) end
				if vehicles[carID] and isElement(vehicles[carID]) then
					addPartFromCar(vehicles[carID],parte)
				else
					addPartFromCarDespawned(carID,parte)
				end
				local mechanicprice=(price/2)*0.45
				outputChatBox(getPlayerName(mecanico).." ha reparado tu "..partename.." por ".." price",source,255,255,0,true)
				outputChatBox("Te pagamos "..mechanicprice.." por reparar la "..partename.." :)",mecanico,255,255,0,true)
				takePlayerMoney(source,price)
				givePlayerMoney(mecanico,mechanicprice)
				repairsPetitions[source]=nil
			else
				outputChatBox("Este mecánico no tiene herramientas pa trabajar hermano",source,255,0,0)
				outputChatBox("Compra herramienta para trabajar parcero...",mecanico,255,0,0)
				if isTimer(timers[duenho]) then killTimer(timers[duenho]) end
				repairsPetitions[source]=nil
			end
		else
			outputChatBox("No tienes dinero para pagar la reparación :/",source,255,0,0)
			if isTimer(timers[duenho]) then killTimer(timers[duenho]) end
			repairsPetitions[source]=nil
		end
	else
		outputChatBox("Esta petición ha expirado.",source,255,0,0)
	end
end
addEvent("repairConfirm",true)
addEventHandler("repairConfirm",root,repairConfirm)