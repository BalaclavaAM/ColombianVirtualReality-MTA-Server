local option = { }
local blips = { }
local vehicleData = { }
local sx, sy = guiGetScreenSize ( )
local rSX, rSY = sx / 1280, sx / 1024
local Vehicles = guiCreateWindow( (sx-(rSX*470))-5, (sy-(rSY*260))-5, rSX*466, rSY*260, "Vehiculos", false)
local cars = guiCreateGridList((rSX*11), (rSY*28), (rSX*274), (rSY*220), false, Vehicles)
option['trade'] = guiCreateButton((rSX*295), (rSY*28)+((rSY))+(rSY*1), (rSX*162), (rSY*40), "Tradear", false, Vehicles)
option['recover'] = guiCreateButton((rSX*295), (rSY*28)+((rSY*40))+(rSY*5), (rSX*162), (rSY*40), "Recuperar", false, Vehicles)
option['sell'] = guiCreateButton((rSX*295), (rSY*28)+((rSY*40)*2)+(rSY*10), (rSX*162), (rSY*40), "Vender", false, Vehicles)
option['give'] = guiCreateButton((rSX*295), (rSY*28)+((rSY*40)*3)+(rSY*15), (rSX*162), (rSY*40), "Regalar", false, Vehicles)
option['close'] = guiCreateButton((rSX*295), (rSY*28)+((rSY*40)*4)+(rSY*20), (rSX*162), (rSY*40), "Cerrar", false, Vehicles)  
guiSetVisible ( Vehicles, false )
guiWindowSetSizable(Vehicles, false)
guiGridListAddColumn(cars, "ID", 0.15)
guiGridListAddColumn(cars, "Vehicle", 0.75)
guiGridListSetSortingEnabled ( cars, false )

local GiveWindow = guiCreateWindow( ( sx / 2 - 449 / 2 ), ( sy / 2 - 401 / 2 ), 449, 401, "Regalar Vehiculos", false)
guiWindowSetSizable(GiveWindow, false)
guiSetVisible ( GiveWindow, false )
local gridGive = guiCreateGridList(9, 27, 430, 317, false, GiveWindow)
guiGridListAddColumn(gridGive, "Nombre", 0.9)
btnGiveGive = guiCreateButton(302, 354, 137, 33, "Regalar", false, GiveWindow)
btnGiveCancel = guiCreateButton(151, 354, 137, 33, "Cancelar", false, GiveWindow)   


function crearventanaMain(carrazo)
	CArrInho=carrazo
	local screenW, screenH = guiGetScreenSize()
	ventanaPrincipalRobos = guiCreateWindow((screenW - 496) / 2, (screenH - 486) / 2, 496, 486, "Tráfico de Piezas", false)
	guiWindowSetSizable(ventanaPrincipalRobos, false)

	imagenLadrones = guiCreateStaticImage(16, 33, 299, 161, ":NGVehicles/fx/LadronesCVR.png", false, ventanaPrincipalRobos)
	imagenCarro = guiCreateStaticImage(73, 242, 365, 201, ":NGVehicles/fx/CarroPNG.png", false, ventanaPrincipalRobos)
	buttonRuedaDelanteraIzq = guiCreateButton(315, 237, 77, 29, "Rueda Delantera L", false, ventanaPrincipalRobos)
	guiSetProperty(buttonRuedaDelanteraIzq, "NormalTextColour", "FFFFFFFF")
	buttonRuedaDelanteraDer = guiCreateButton(315, 424, 77, 29, "Rueda Delantera R", false, ventanaPrincipalRobos)
	guiSetProperty(buttonRuedaDelanteraDer, "NormalTextColour", "FFFFFFFF")
	buttonRuedaTraseraIzq = guiCreateButton(101, 424, 106, 29, "Rueda Trasera R", false, ventanaPrincipalRobos)
	guiSetProperty(buttonRuedaTraseraIzq, "NormalTextColour", "FFFFFFFF")
	labelParteARobar = guiCreateLabel(15, 204, 227, 24, "Seleccione parte a robar:", false, ventanaPrincipalRobos)
	guiLabelSetVerticalAlign(labelParteARobar, "center")
	buttonVertical = guiCreateButton(444, 269, 26, 145, "", false, ventanaPrincipalRobos)
	buttonVertical1 = guiCreateButton(38, 273, 26, 145, "", false, ventanaPrincipalRobos)

	buttonVerticalRadio1 = guiCreateRadioButton(185, 219, 114, 35, "", false, buttonVertical1)

	label2= guiCreateLabel(329, 34, 158, 165, "La misión consiste en:\n\nRobar piezas de carros para\nganarse las lukas si pilla.", false, ventanaPrincipalRobos)
	buttonCerrar = guiCreateButton(467, 454, 19, 22, "X", false, ventanaPrincipalRobos)
	imgBumper2 = guiCreateStaticImage(38, 283, 23, 124, ":NGVehicles/fx/Bumper.png", false, ventanaPrincipalRobos)
	imgBumper = guiCreateStaticImage(444, 280, 23, 124, ":NGVehicles/fx/Bumper.png", false, ventanaPrincipalRobos)
	buttonRuedaTraseraDer = guiCreateButton(108, 238, 106, 29, "Rueda Trasera L", false, ventanaPrincipalRobos)
	guiSetProperty(buttonRuedaTraseraDer, "NormalTextColour", "FFFFFFFF")    
end

local timer=false
local stealvehicle=false

function removerParteTimer(carro,parte)
	stealvehicle=false
	setElementFrozen(localPlayer,false)
	removeEventHandler("onClientPlayerWasted",root,checkifDeath)
	removeEventHandler("onClientVehicleStartEnter",root,checkifEnterVehicle)
	triggerServerEvent("CVRVehiculos:removePartFromCarS",localPlayer,carro,parte)
	timer=false
end

function checkifDeath()
	if source == localPlayer then
		removeEventHandler("onClientPlayerWasted",root,checkifDeath)
		removeEventHandler("onClientVehicleStartEnter",root,checkifEnterVehicle)
		if isTimer(timer) then
			killTimer(timer)
			timer=false
			triggerServerEvent("RoboFrustrado",localPlayer,stealvehicle)
			stealvehicle=false
		end
	end
end

function checkifEnterVehicle(p)
	if p==localPlayer then
		outputChatBox("Veneco no puedes entrar al carro mientras lo estás robando ._.",255,0,0)
		cancelEvent()
	end
end

function addtimer(carro,parte)
	if getVehicleComponentVisible(carro,parte) then
		if not (isTimer(timer)) then
			setElementFrozen(localPlayer,true)
			outputChatBox("Uy kieto empezaste a robar una parte. En 20 segundos te podrás mover.",255,0,0)
			addEventHandler("onClientPlayerWasted",root,checkifDeath)
			addEventHandler("onClientVehicleStartEnter",root,checkifEnterVehicle)
			stealvehicle=carro
			timer=setTimer(removerParteTimer,20000,1,carro,parte)
			local ownerAccount = getElementData(carro,"NGVehicles:VehicleAccountOwner")
			triggerServerEvent("alertVehicleOwner",localPlayer,ownerAccount,carro)
		else
			local restante,realizados,intervalo = getTimerDetails(timer)
			outputChatBox("Parcero ud ya está robando una parte. Faltan: "..tostring((restante/1000)).." segundos.",255,0,0)
		end
	else
		outputChatBox("Este carro no tiene esa parte que le vas a robar",255,0,0)
	end
end

function botonesPanelDesvalijar()
	if source==buttonCerrar then
		createAndDestroyVentana()
	elseif source==buttonRuedaDelanteraIzq then
		addtimer(CArrInho,"wheel_lf_dummy")
	elseif source==buttonRuedaDelanteraDer then
		addtimer(CArrInho,"wheel_rf_dummy")
	elseif source==buttonRuedaTraseraIzq then
		addtimer(CArrInho,"wheel_lb_dummy")
	elseif source==buttonRuedaTraseraDer then
		addtimer(CArrInho,"wheel_rb_dummy")
	elseif source==buttonVertical then
		addtimer(CArrInho,"bump_front_dummy")
	elseif source==buttonVertical1 then
		addtimer(CArrInho,"bump_rear_dummy")
	end
end

function createAndDestroyVentana(carrazo)
	if isElement(ventanaPrincipalRobos) then
		showCursor(false)
		destroyElement(ventanaPrincipalRobos)
		removeEventHandler("onClientGUIClick",root,botonesPanelDesvalijar)
	else
		crearventanaMain(carrazo)
		showCursor(true)
		addEventHandler("onClientGUIClick",root,botonesPanelDesvalijar)
	end
end
addEvent("AbrirVentanaRobos",true)
addEventHandler("AbrirVentanaRobos",root,createAndDestroyVentana)


addCommandHandler("vehiculos", function ( )
	if ( not exports['NGLogin']:isClientLoggedin ( ) ) then return end 
	local tos = not guiGetVisible ( Vehicles )
	guiSetVisible ( Vehicles, tos )
	showCursor ( tos )
	guiGridListClear ( cars )
	givingVehicle = nil
	if ( tos ) then
		reloadList ( )
		for i, v in pairs ( option  ) do 
			addEventHandler ( "onClientGUIClick", v, buttonClicking )
			if ( i ~= 'close' ) then
				guiSetEnabled ( v, false )
			end
		end
		addEventHandler ( "onClientGUIClick", cars, buttonClicking )
		addEventHandler ( "onClientGUIClick", btnGiveCancel, buttonClicking )
		addEventHandler ( "onClientGUIClick", btnGiveGive, buttonClicking )
	else
		closeMenu ( )
	end
end )

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

addEvent ( "NGVehicles:onServerSendClientVehicleList", true )
addEventHandler ( "NGVehicles:onServerSendClientVehicleList", root, function  ( cList ) 
	vehicleData = { }
	guiGridListClear ( cars )
	if ( #cList == 0 ) then
		guiGridListSetItemText ( cars, guiGridListAddRow ( cars ), 2, "You have no vehicles.", true, true )
	else
		local impoundedVehicles = ""
		for i, v in ipairs ( cList ) do
			if ( v[11] == 0 ) then
				local row = guiGridListAddRow ( cars )
				guiGridListSetItemText ( cars, row, 1, tostring ( i ), false, true )
				guiGridListSetItemText ( cars, row, 2, tostring ( getVehicleNameFromModel ( v[3] ) ), false, false )
				guiGridListSetItemData ( cars, row, 1, v[2] )
				table.insert ( vehicleData, v[2], v )
			else
				if (  impoundedVehicles == "" ) then
					impoundedVehicles = getVehicleNameFromModel ( v[3] )
				else
					impoundedVehicles = impoundedVehicles..", "..getVehicleNameFromModel ( v[3] )
				end
			end
		end
		if ( impoundedVehicles ~= "" ) then
			exports['NGMessages']:sendClientMessage ( "Vehicles: "..impoundedVehicles.." are impounded.", 255, 255, 0 )
		end
	end
end )

function buttonClicking ( )
	if ( source == option['close'] ) then
		closeMenu ( )
	elseif ( source == cars ) then
		local row, col = guiGridListGetSelectedItem ( cars )
		if ( row ~= -1 ) then
			for i, v in pairs ( option ) do guiSetEnabled ( v, true ) end
			local index = guiGridListGetItemData ( source, row, 1 )
			local visible = tonumber ( vehicleData[index][9] )
			if ( visible == 1 ) then visible = true else visible = false end
		else
			for i,v in pairs ( option ) do
				guiSetEnabled ( v, false )
				if ( i == 'close' ) then
					guiSetEnabled ( v, true )
				elseif ( i == 'show' ) then
					guiSetText ( v, 'Show' )
				end
			end
		end
	elseif ( source == option['sell'] ) then
		local row, col = guiGridListGetSelectedItem ( cars )
		if ( row ~= -1 ) then
			local index = guiGridListGetItemData ( cars, row, 1 )
			local visible = tonumber ( vehicleData[index][9] )
			if ( visible == 1 ) then visible = true else visible = false end
			if ( visible ) then
				return exports['NGMessages']:sendClientMessage ( "Esconde tu vehiculo antes de mostrarlo.", 255, 255, 0 )
			end
			triggerServerEvent ( "NGVehicles:sellPlayerVehicle", localPlayer, localPlayer, index )
			setTimer ( reloadList, 200, 1 )
		end
	elseif ( source == option['give'] ) then
		local row, col = guiGridListGetSelectedItem ( cars )
		if ( row ~= -1 ) then
			local index = guiGridListGetItemData ( cars, row, 1 )
			local visible = tonumber ( vehicleData[index][9] )
			local modificado = tonumber ( vehicleData[index][15] )
			if (modificado == 1) then modificado = true else modificado = false end
			if ( visible == 1 ) then visible = true else visible = false end
			if ( visible ) then
				return exports['NGMessages']:sendClientMessage ( "Esconde tu vehiculo antes de regalarlo.", 255, 0, 0 )
			end
			if modificado then
				return exports['NGMessages']:sendClientMessage ( "Ese vehiculo está modificado con VIP. Quítale los mods para venderlo.", 255, 0, 0 )
			end
			local vehID = vehicleData[index][2]
			if ( vehID ) then
			
				guiSetVisible ( GiveWindow, true )
				guiBringToFront ( GiveWindow ) 
				guiGridListClear ( gridGive )
				givingVehicle = index
				local count = 0
				for i, v in ipairs ( getElementsByType ( 'player' ) ) do
					if ( v ~= localPlayer ) then
						guiGridListSetItemText ( gridGive, guiGridListAddRow ( gridGive ), 1, getPlayerName ( v ), false, false  )
						count = count + 1
					end
				end
				if ( count == 0 ) then
					guiGridListSetItemText ( gridGive, guiGridListAddRow ( gridGive ), 1, "Lo siento, no hay jugadores en linea.", true, true  )
				end
			end
		end
	elseif ( source == btnGiveCancel ) then
		guiSetVisible ( GiveWindow, false )
	elseif ( source == btnGiveGive ) then 
		local row, col = guiGridListGetSelectedItem ( gridGive )
		if ( row ~= -1 ) then
			local pName = guiGridListGetItemText ( gridGive, row, 1 )
			if ( not isElement ( getPlayerFromName ( pName ) ) ) then return exports['NGMessages']:sendClientMessage ( "Sorry, that player  no longer exists.", 255, 0, 0 ) end
			
			if ( vehicleData[givingVehicle][9] == 1 ) then return exports['NGMessages']:sendClientMessage ( "Esconde tu vehiculo antes de regalarlo.", 255, 0, 0 ) end
			local vehicleID = vehicleData[givingVehicle][2]
			triggerServerEvent ( "NGVehicles:onPlayerGivePlayerVehicle", localPlayer, vehicleID, getPlayerFromName ( pName ) )
			guiSetVisible ( GiveWindow, false ) 
			setTimer ( reloadList, 200, 1 )
		else
			exports['NGMessages']:sendClientMessage ( "Select a player to send your vehicle to.", 255, 0, 0 )
		end
	elseif ( source == option['recover'] ) then
		local row, col = guiGridListGetSelectedItem ( cars )
		if ( row == -1 ) then return end
		local data = vehicleData[guiGridListGetItemData ( cars, row, 1 )]
		if ( data[9] == 1 ) then return exports['NGMessages']:sendClientMessage ( "Para recuperar tu vehiculo, escondelo primero.", 255, 0, 0 ) end
		triggerServerEvent ( "NGVehicles:AttemptRecoveryOnID", localPlayer, data[2] )
	end
end

function closeMenu ( )
	guiGridListClear ( cars )
	guiSetVisible ( Vehicles, false )
	showCursor ( false )
	vehicleData = nil
	for i, v in pairs ( option  ) do 
		removeEventHandler ( "onClientGUIClick", v, buttonClicking )
		guiSetEnabled ( v, false )
		if ( i == 'close' ) then
			guiSetEnabled ( v, true )
		elseif( i == 'show' ) then
			guiSetText ( v, "Show" )
		end
	end
	removeEventHandler ( "onClientGUIClick", cars, buttonClicking )
	removeEventHandler ( "onClientGUIClick", btnGiveCancel, buttonClicking )
	removeEventHandler ( "onClientGUIClick", btnGiveGive, buttonClicking )
	
	guiSetVisible ( GiveWindow, false )
end

function reloadList ( )
	guiGridListClear ( cars )
	guiGridListSetItemText ( cars, guiGridListAddRow ( cars ), 2, "Loading...", true, true )
	triggerServerEvent ( "NGVehicles:onClientRequestPlayerVehicles", localPlayer )
	for i, v in pairs ( option ) do 
		if ( i ~= 'close' ) then
			guiSetEnabled ( v, false )
		end
	end
end

function getVehicleVisiable ( id )
	local i = vehicleData[id][9]
	if ( i == 1 ) then
		return true
	else
		return false
	end
end

local handlings={}
function receptorHandling(hnds)
	handlings=hnds
end
addEvent("NGVehicles:RecibirHandling",true)
addEventHandler("NGVehicles:RecibirHandling",root,receptorHandling)

function getClientVehicleHandlingg( id )
	if handlings[id] then
		return handlings[id]
	end
	return getOriginalHandling(id)
end



local tablapartes={"wheel_rf_dummy","wheel_lf_dummy","wheel_rb_dummy","wheel_lb_dummy","bump_front_dummy","bump_rear_dummy"}

local carsandparts={}

function updateCar(vehicle)
	if isElementStreamedIn(vehicle) then
		if carsandparts[vehicle] then
			for parte,boolean in pairs(carsandparts[vehicle]) do
				setVehicleComponentVisible(vehicle,parte,false)
			end
		else
			for k,v in ipairs(tablapartes) do 
				setVehicleComponentVisible(vehicle,v,true)
			end
		end
	end
end

function handleStreamedCar()
	if isElement(source) and carsandparts[source] then
		for parte,boolean in pairs(carsandparts[source]) do
			setVehicleComponentVisible(source,parte,false)
		end
	end
end

function addPart(vehicle,part)
	if carsandparts[vehicle] then
		local newtable = {}
		for k,v in pairs(carsandparts[vehicle]) do
			if k~=part then
				newtable[k] = true
			end
		end
		if table.size(newtable)>0 then
			carsandparts[vehicle]=newtable
		else
			carsandparts[vehicle]=nil
			removeEventHandler("onClientElementStreamIn",vehicle,handleStreamedCar)
		end
		updateCar(vehicle)
	end
end
addEvent("NGVehicles:AddVehiclePart",true)
addEventHandler("NGVehicles:AddVehiclePart",root,addPart)



function removeLocalPart(vehicle,part)
	local table={}
	if carsandparts[vehicle] then
		table=carsandparts[vehicle]
	else
		addEventHandler("onClientElementStreamIn",vehicle,handleStreamedCar)
	end
	table[part]=true
	carsandparts[vehicle]=table
	updateCar(vehicle)
end
addEvent("NGVehicles:RemoveVehiclePart",true)
addEventHandler("NGVehicles:RemoveVehiclePart",root,removeLocalPart)



function Click3d ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
    if ( state == "up" and getTeamName(getPlayerTeam(localPlayer))=="Criminals" and clickedElement and getElementType(clickedElement)=="vehicle" and getElementData(clickedElement,"NGVehicles:VehicleAccountOwner") and getElementData(clickedElement,"NGVehicles:VehiclePlayerOwner")~=localPlayer) then
		local duenho = getElementData(clickedElement,"NGVehicles:VehicleAccountOwner")
		local ocupantes = getVehicleOccupants(clickedElement)
		if table.size(ocupantes)<1 then
			local x,y,z = getElementPosition(localPlayer)
			local x2,y2,z2 = getElementPosition(clickedElement)
			if getDistanceBetweenPoints2D(x,y,x2,y2)<4 then
				triggerServerEvent("onClientCarClick",localPlayer,duenho,clickedElement)
			else
				outputChatBox("Tienes que estar a menos de 4 metros del vehículo que deseas robar")
			end
		end
    end
end
addEventHandler ( "onClientClick", root, Click3d)


function Click3d2 ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
    if ( state == "up" and getElementData(localPlayer,"Job")=="Mechanic" and clickedElement and getElementType(clickedElement)=="vehicle" and getElementData(clickedElement,"NGVehicles:VehiclePlayerOwner")) then
		if getElementData(localPlayer,"workMode") then
			local x,y,z = getElementPosition(localPlayer)
			local x2,y2,z2 = getElementPosition(clickedElement)
			if getDistanceBetweenPoints2D(x,y,x2,y2)<4 then
				local duenho = getElementData(clickedElement,"NGVehicles:VehiclePlayerOwner")
				local x3,y3,z3 = getElementPosition(duenho)
				if getDistanceBetweenPoints2D(x,y,x2,y2)<10 then
					triggerServerEvent("sendPetitionToOwner",localPlayer,clickedElement,duenho)
					outputChatBox("Petición enviada",255,0,255,true)
				else
					outputChatBox("El dueño está muy lejos amigo, no puedes hacerle la petición",255,0,0)
				end
			else
				outputChatBox("Tienes que estar a menos de 4 metros del vehículo que deseas reparar",255,0,0)
			end
		else
			outputChatBox("Necesitas tener las herramientas activas para fabricar piezas de carros. Actívalas en F6!.",255,0,0)
		end
    end
end
addEventHandler ( "onClientClick", root, Click3d2)