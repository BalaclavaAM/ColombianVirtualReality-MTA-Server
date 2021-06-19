local sx, sy = guiGetScreenSize ( )
local rsx, rsy = sx / 1280, sy / 960

--[[
	Drug Item Ids:
	drug_white -> 1575
	drug_orange -> 1576
	drug_yellow -> 1577
	drug_green -> 1578
	drug_blue -> 1579
	drug_red -> 1580
	polita -> 1509
	guaro -> 1668
	chamber -> 1520
]]


local items = {

	['Guaro'] = {
		nam = "Guaro",
		dropable=true,
		itemid=1668,
		requiresInVehicle=false,
		useableInVehicle=false,
		img = ":NGInventory/files/guaro_icon.png",
		desc = "Pa´ que tomes con todos tus parceros, para que vivas la vida al maximo con este guarito tapa roja de antioquia cual te va hacer sacar esas penas del alma"
	},

	['Chamber'] = {
		nam = "Chamber",
		dropable=true,
		itemid=1520,
		requiresInVehicle=false,
		useableInVehicle=false,
		img = ":NGInventory/files/chamber_icon.png",
		desc = "Pa´que saques lo ñero de tu interior y te tomes unos tragos de este remedio santo traido desde el bajo mundo de Bogotá pero, ¡Cuidado, este remedio suele dejarte ciego si no lo sabes tomar!"
	},

	['Polita'] = {
		nam = "Pola",
		dropable=true,
		itemid=1509,
		requiresInVehicle=false,
		useableInVehicle=true,
		img = ":NGInventory/files/polita_icon.png",
		desc = "La polita tipica para que parches relajado y te pongas entonado, pero relajate que si tomas mucho no maneje"
	},
	
	['FuelCans'] = {
		nam = "Bidones",
		dropable=true,
		itemid=1650,
		requiresInVehicle=true,
		useableInVehicle=true,
		img = ":NGVehicles/fuel/fuel_icon.png",
		desc = "Este bidón contiene 10% de gasolina. Muy útil para cuando te quedas sin gasolina a un lado del camino."
	},

	['Drug.LSD'] = {
		nam = "Drug - LSD",
		dropable=true,
		itemid=1580,
		requiresInVehicle=false,
		useableInVehicle=false,
		img = ":NGDrugs/files/lsd_icon.png",
		desc = "When you use this drug, you'll be sucked into a world where aliens are chasing you. As they get close to you, they'll fade away but if you kill them you'll get paid!"
	},

	['Drug.Marijuana'] = {
		nam = "Drug - Marijuana",
		dropable=true,
		itemid=1578,
		requiresInVehicle=false,
		useableInVehicle=true,
		img = ":NGDrugs/files/weed_icon.png",
		desc = "When you use this drug, you'll get a greenish screen and every second you'll get 2% health."
	},

	['health_packs'] = {
		nam = "Vendas",
		dropable = true,
		itemid = 1578,
		requiresInVehicle = false,
		useableInVehicle = true,
		img = ":NGHealthPack/pack.png",
		desc = "Si tu salud se está quedando corta. Puedes usar esto para regenerarla!"
	},

	['herramientas'] = {
		nam = "Herramientas",
		dropable = false,
		itemid = 2798,
		requiresInVehicle = false,
		useableInVehicle = false,
		img = ":NGInventory/files/gato_botella.png",
		desc = "Herramientas para fabricar partes de carrinho!",
	}
}

local d = getElementData(localPlayer,"NGUser:Items")
if d then
	for i, v in pairs ( items ) do
		if ( v.requiresInVehicle ) then
			items [ i ].useableInVehicle = true
		end

		if ( not d [ i ] ) then
			d [ i ] = 0
			setElementData ( localPlayer, "NGUser:Items", d )
		end 
	end
end

function createInventoryWindow ( )
	if ( not exports.NGLogin:isClientLoggedin ( ) ) then return end
	inven = {}
	selectedItem = nil
	inven.window = guiCreateWindow((sx/2-514/2), (sy/2-380/2), 514, 380, "Inventario", false)
	guiWindowSetSizable(inven.window, false)
	inven.list = guiCreateGridList(10, 33, 251, 337, false, inven.window)
	guiGridListAddColumn(inven.list, "Item", 0.65)
	guiGridListAddColumn(inven.list, "Cantidad", 0.25)
	guiGridListSetSortingEnabled ( inven.list, false )
	inven.citem = guiCreateLabel(271, 43, 188, 21, "No Hay Item Seleccionado", false, inven.window)
	inven.img = guiCreateStaticImage(400, 58, 80, 85, "none.png", false, inven.window)
	inven.camount = guiCreateLabel(271, 79, 188, 21, "Cantidad del Item: N/A", false, inven.window)
	inven.temp1 = guiCreateLabel(271, 138, 188, 21, "Descripción:", false, inven.window)
	inven.desc = guiCreateLabel(271, 159, 230, 167, "N/A", false, inven.window)
	guiLabelSetHorizontalAlign(inven.desc, "left", true)
	inven.use = guiCreateButton(414, 342, 81, 28, "Usar", false, inven.window)
	inven.drop = guiCreateButton(414, 310, 81, 28, "Tirar", false, inven.window)
	inven.exit = guiCreateButton(319, 340, 81, 30, "Salir", false, inven.window)
	showCursor ( true )
	for i, v in pairs ( getElementData ( localPlayer, "NGUser:Items" ) or { } ) do
		if ( items [ i ] ) then
			local r = guiGridListAddRow ( inven.list )
			guiGridListSetItemText ( inven.list, r, 1, tostring ( items [ i ].nam ), false, false )
			guiGridListSetItemData ( inven.list, r, 1, i )
			guiGridListSetItemText ( inven.list, r, 2, tostring ( v ), false, false )
		end
	end
	addEventHandler ( "onClientGUIClick", inven.use, onClientGUIClick )
	addEventHandler ( "onClientGUIClick", inven.drop, onClientGUIClick )
	addEventHandler ( "onClientGUIClick", inven.exit, onClientGUIClick )
	addEventHandler ( "onClientGUIClick", inven.list, onClientGUIClick )
	
	guiSetEnabled ( inven.use, false )
	guiSetEnabled ( inven.drop, false )
end

function closeInventoryWindow ( )
	if inven then
		if ( isElement ( inven.use ) ) then
			removeEventHandler ( "onClientGUIClick", inven.use, onClientGUIClick )
			destroyElement ( inven.use )
		end if ( isElement ( inven.drop ) ) then
			removeEventHandler ( "onClientGUIClick", inven.drop, onClientGUIClick )
			destroyElement ( inven.drop )
		end if ( isElement ( inven.exit ) ) then
			removeEventHandler ( "onClientGUIClick", inven.exit, onClientGUIClick )
			destroyElement ( inven.exit )
		end if ( isElement ( inven.list ) ) then
			removeEventHandler ( "onClientGUIClick", inven.list, onClientGUIClick )
			destroyElement ( inven.list )
		end if ( isElement ( inven.citem ) ) then
			destroyElement ( inven.citem )
		end if ( isElement ( inven.camount ) ) then
			destroyElement ( inven.camount )
		end if ( isElement ( inven.temp1 ) ) then
			destroyElement ( inven.temp1 )
		end if ( isElement ( inven.desc ) ) then
			destroyElement ( inven.desc )
		end if ( isElement ( inven.window ) ) then
			destroyElement ( inven.window  )
		end
		inven = nil
		selectedItem = nil
		showCursor ( false )
	end
end

function onClientGUIClick ( )
	if ( source == inven.exit ) then
		closeInventoryWindow ( )
	elseif ( source == inven.list ) then
		selectedItem = nil
		guiSetText ( inven.citem, "Item no Seleccionado" )
		guiSetText ( inven.camount, "Cantidad del Item: N/A" )
		guiSetText ( inven.desc, "N/A" )
		guiSetEnabled ( inven.use, false )
		guiSetEnabled ( inven.drop, false )
		local r, c = guiGridListGetSelectedItem ( source )
		guiStaticImageLoadImage ( inven.img, "none.png" )
		if ( r ~= -1 ) then
			local name = tostring ( guiGridListGetItemData ( source, r, 1 ) )
			local c = getElementData(localPlayer,"NGUser:Items")[name]
			guiSetText ( inven.citem, items[name].nam )
			guiSetText ( inven.camount, "Cantidad del Item: "..c )
			guiSetText ( inven.desc, items[name].desc )
			guiSetEnabled ( inven.use, c > 0 )
			guiSetEnabled ( inven.drop, items[name].dropable and not isPedInVehicle ( localPlayer ) )
			selectedItem = name
			if ( items[name].img and fileExists ( items[name].img ) ) then
				guiStaticImageLoadImage ( inven.img, items[name].img )
			end

			if ( items[name].requiresInVehicle ) then
				guiSetText ( inven.desc, guiGetText ( inven.desc ) .."\n\nEsto requiere que estés en un vehículo." )
				if ( not isPedInVehicle ( localPlayer ) ) then
					guiSetEnabled ( inven.use, false )
				end
			end

			if ( isPedInVehicle ( localPlayer ) and not items [ name ].useableInVehicle ) then
				guiSetEnabled ( inven.use, false )
			elseif ( not isPedInVehicle ( localPlayer ) and not items[name].requiresInVehicle ) then
				guiSetEnabled ( inven.use, true )
			end
		end
	elseif ( source == inven.use ) then
		if ( not selectedItem ) then
			return
		end
		useItem ( selectedItem )
	elseif ( source == inven.drop ) then
		local r, _ = guiGridListGetSelectedItem ( inven.list )
		local name = guiGridListGetItemText ( inven.list, r, 1 )
		local max = tonumber ( guiGridListGetItemText ( inven.list, r, 2 ) )
		AskDropAmount ( max, "Cuantos '"..tostring(name).."' te gustaría arrojar?", function ( amount, _name )
			local id = ""
			for i, v in pairs ( items ) do
				if ( v.nam == _name ) then
					id = i
				end
			end
			local am = getElementData(localPlayer,"NGUser:Items")
			if ( amount > am[id] ) then
				return exports.NGMessages:sendClientMessage ( 'Cantidad insignificante', 255, 0, 0 )
			end
			am[id] = am[id] - amount
			setElementData ( localPlayer, "NGUser:Items", am )
			reloadInvenPanel ( )
			triggerServerEvent ( "NGInventory:onClientDropItem", localPlayer, items[id].itemid, amount, id )
		end, name )
	end
end 


bindKey ( "F6", "down", function ( )
	if ( inven and isElement ( inven.window ) ) then
		closeInventoryWindow ( )
	else
		createInventoryWindow ( )
	end
end )

function useItem ( item )
	local rv = false
	
	local d = getElementData ( localPlayer, "NGUser:Items" )
	if not d then return false end
	if not d[item] then return false end
	local amount = d[item]

	if ( amount <= 0 ) then 
		return false 
	end
	
	if ( item == 'FuelCans' ) then
		local c = getPedOccupiedVehicle ( localPlayer )
		if not c then outputChatBox("No estás en un vehículo",255,0,0) return end
		local handling = getVehicleHandling(c)
		local fueltank=getVehicleHandling(c)['mass']
		if ( getVehicleController ( c ) == localPlayer ) then
			local f = getElementData ( c, "fuel" )
			if ( (f*100)/fueltank <= 90 ) then
				rv = true
				setElementData ( c, "fuel", f + (fueltank/10) )
				exports.NGMessages:sendClientMessage ( "Usaste un bidón... +10% gasolina", 0, 255, 0 )
			else
				exports.NGMessages:sendClientMessage ( "Tu gasolina tiene que estar por debajo de 90% para usar este item.", 255, 0, 0 )
			end
		else
			exports.NGMessages:sendClientMessage ( "No eres el conductor del vehículo.", 255, 255, 0 )
		end
	elseif ( item =="herramientas") then
		exports.NGMessages:sendClientMessage ("Has activado el modo de trabajo. Clickea un vehículo dentro de los próximos 30 segundos.",255, 255, 0 )
		setElementData(localPlayer,"workMode",true,false)
		setTimer(function() setElementData(localPlayer,"workMode",false,false) end,30000,1)
	elseif ( item =="Guaro" ) then 
		triggerServerEvent("NGInventory:LicorServer",localPlayer,"Guaro")
		exports.NGMessages:sendClientMessage ("Parcero estas tomando el autentico guaro tapa roja antioqueño",255, 255, 0 )
		reloadInvenPanel ( )
	elseif ( item =="Chamber" ) then 
		triggerServerEvent("NGInventory:LicorServer",localPlayer,"Chamber")
		exports.NGMessages:sendClientMessage ("Uy ñero metale suave al chamber que se queda ciego.",255, 255, 0 )
		reloadInvenPanel ( )
	elseif ( item =="Polita" ) then
		triggerServerEvent("NGInventory:LicorServer",localPlayer,"Polita")
		exports.NGMessages:sendClientMessage ("Tomando polita relajado para que refresque el día.",255, 255, 0 )
		reloadInvenPanel ( )
	elseif ( item == "Drug.LSD" )  then
		exports.NGDrugs:useDrug ( "LSD", 1 )
		exports.NGMessages:sendClientMessage ( "You have decided to use LSD. Get ready for some crazy shit", 255, 255, 0 )
		rv = true
	elseif ( item == "Drug.Marijuana" ) then
		exports.NGDrugs:useDrug ( "Marijuana", 1 )
		--exports.NGMessages:sendClientMessage ( "~~~~~ Stoner ~~~~~", 0, 255, 0 )
		--exports.NGMessages:sendClientMessage ( "You smoked some that grade A shit, man!", 255, 255, 0)
		exports.NGMessages:sendClientMessage ( "You'll get 2% health every second", 255, 0, 0 )
		rv = true
	elseif ( item == "health_packs" ) then
		if ( exports.nghealthpack:useHealthPack ( ) ) then
			rv = true
		else
			exports.ngmessages:sendClientMessage ( "You don't need a health pack right now!", 255, 255, 0 )
		end
	end
	
	triggerServerEvent ( "NGInventory:onClientUseItem", localPlayer, item )
	
	if rv then
		d[item] = d[item] - 1
		setElementData ( localPlayer, "NGUser:Items", d )
		reloadInvenPanel ( )
	end
	return rv
end


function reloadInvenPanel ( )
	local d = getElementData ( localPlayer, "NGUser:Items" )
	closeInventoryWindow ( )
	return true
end



timerpola=false
timerguaro=false
timerchamber=false

--Eventos
function clientEffect ( licor,nivel )
	if licor=="Polita" then
		if not (timerpola) then
			timerpola=setTimer(endfarra,60000,1)
		else
			local mresting=0
			if isTimer(timerpola) then
				msresting= getTimerDetails(timerpola)
			end
			killTimer(timerpola)
			timerpola=setTimer(endfarra,msresting+60000,1)
		end
		if nivel > 0 then
			setCameraShakeLevel( 50+nivel )
		else
			setCameraShakeLevel(50)
			setGameSpeed ( 0.5 )
		end
	elseif licor=="Guaro" then
		if not (timerguaro) then
			timerguaro=setTimer(endGuaro,120000,1)
		else
			local mresting=0
			if isTimer(timerguaro) then
				msresting= getTimerDetails(timerguaro)
			end
			killTimer(timerguaro)
			timerguaro=setTimer(endGuaro,msresting+120000,1)
		end
		setCameraShakeLevel(250)
		setGameSpeed ( 0.3 )
	elseif licor=="Chamber" then
		if not (timerchamber) then
			timerchamber=setTimer(endChamber,60000,1)
			fadeCamera(false,30,255,255,255)
		else
			local mresting=0
			if isTimer(timerchamber) then
				msresting= getTimerDetails(timerchamber)
			end
			killTimer(timerpola)
			timerchamber=setTimer(endChamber,msresting+60000,1)
		end
		setCameraShakeLevel(250)
		setGameSpeed ( 2 )
	end
end
addEvent( "NGInventory:ClientEffect", true )
addEventHandler( "NGInventory:ClientEffect", localPlayer, clientEffect )



function endGuaro()
	timerguaro=false
	local dimorig=getElementDimension(localPlayer)
	setCameraShakeLevel(0)
	setElementDimension(localPlayer,dimorig+1)
	setElementDimension(localPlayer,dimorig)
	setGameSpeed ( 1 )
	triggerServerEvent("EndEffect",localPlayer,"Guaro")
end

function endChamber()
	timerchamber=false
	local dimorig=getElementDimension(localPlayer)
	setCameraShakeLevel(0)
	setElementDimension(localPlayer,dimorig+1)
	setElementDimension(localPlayer,dimorig)
	setGameSpeed ( 1 )
	triggerServerEvent("EndEffect",localPlayer,"Chamber")
	fadeCamera(true,10,255,255,255)
end


function endfarra()
	timerpola=false
	local dimorig=getElementDimension(localPlayer)
	setCameraShakeLevel(0)
	setElementDimension(localPlayer,dimorig+1)
	setElementDimension(localPlayer,dimorig)
	setGameSpeed ( 1 )
	triggerServerEvent("EndEffect",localPlayer,"Polita")
end


function handlePunhos(a,weapon,loss)
	if a and getElementData(a,"guaro") and weapon and loss and weapon == 0 then
		setElementHealth(localPlayer,(getElementHealth(localPlayer)-loss*0.5))
	end
end
addEventHandler("OnClientPlayerDamage",localPlayer,handlePunhos)




--[[-------------------------------------------------
Notes:

> This code is using a relative image filepath. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move images into your local resource and reference them there.
--]]-------------------------------------------------


local botones={}

function crearPanel()
	local screenW, screenH = guiGetScreenSize()
	ventanaMain = guiCreateWindow((screenW - 296) / 2, (screenH - 436) / 2, 296, 436, "Licorera", false)
	guiWindowSetMovable(ventanaMain, false)
	guiWindowSetSizable(ventanaMain, false)

	imagen1 = guiCreateStaticImage(191, 33, 88, 100, ":NGInventory/files/chamber_icon.png", false, ventanaMain)
	botonchamber = guiCreateButton(0.00, 0.00, 1.00, 1.00, "", true, imagen1)
	guiSetAlpha(botonchamber, 0.00)
	addEventHandler("onClientGUIClick",botonchamber,comprar)

	imagen2 = guiCreateStaticImage(190, 143, 89, 102, ":NGInventory/files/polita_icon.png", false, ventanaMain)
	botonpola = guiCreateButton(0, 1, 89, 101, "", false, imagen2)
	guiSetAlpha(botonpola, 0.00)
	addEventHandler("onClientGUIClick",botonpola,comprar)

	imagen3 = guiCreateStaticImage(188, 255, 91, 115, ":NGInventory/files/guaro_icon.png", false, ventanaMain)
	botonguaro = guiCreateButton(0.02, 0.01, 0.98, 0.99, "", true, imagen3)
	guiSetAlpha(botonguaro, 0.00)
	addEventHandler("onClientGUIClick",botonguaro,comprar)

	botones[1] = guiCreateLabel(0.14, 0.10, 0.42, 0.05, "Chamber: 1200 pesos", true, ventanaMain)
	botones[2] = guiCreateLabel(0.15, 0.33, 0.42, 0.05, "Pola: 3500 pesos", true, ventanaMain)
	botones[3] = guiCreateLabel(0.15, 0.58, 0.42, 0.05, "Guaro: 8000 pesos", true, ventanaMain)
	botones[4] = guiCreateLabel(0.15, 0.15, 0.46, 0.11, "Cuidado. Te puede dejar ciego!. \nEl chamber te da energía\nla meta la pones tú", true, ventanaMain)
	botones[5] = guiCreateLabel(0.15, 0.39, 0.46, 0.11, "Polita clásica!.\nAhora en tu inventario!!", true, ventanaMain)
	botones[6] = guiCreateLabel(0.15, 0.63, 0.46, 0.11, "Un guarito suave.\nCuidado, este es el borra\nmemorias!!", true, ventanaMain)
	botones[7] = guiCreateLabel(0.06, 0.93, 0.79, 0.04, "Dale clic a los iconos para comprar!", true, ventanaMain)
	botones[8] = guiCreateButton(0.86, 0.94, 0.06, 0.04, "x", true, ventanaMain)   
	addEventHandler("onClientGUIClick",botones[8],comprar)
end

function comprar()
	if source==botonchamber then
		triggerServerEvent("NGInventory:ButLiquor",localPlayer,"Chamber",1200)
	elseif source==botonpola then
		triggerServerEvent("NGInventory:ButLiquor",localPlayer,"Polita",3500)
	elseif source==botonguaro then
		triggerServerEvent("NGInventory:ButLiquor",localPlayer,"Guaro",8000)
	elseif source==botones[8] then
		mostrarYOcultarPanel()
	end
end

function mostrarYOcultarPanel()
	if isElement(ventanaMain) then
		destroyElement(ventanaMain)
		showCursor(false)
	else
		crearPanel()
		showCursor(true)
	end
end
addEvent("NGInventory:OpenClientMenu",true)
addEventHandler("NGInventory:OpenClientMenu",root,mostrarYOcultarPanel)


