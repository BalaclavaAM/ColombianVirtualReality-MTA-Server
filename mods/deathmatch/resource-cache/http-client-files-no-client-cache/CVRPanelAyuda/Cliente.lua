-- ****************************************************************************
--
-- RECURSO: PanelDeAyuda_GTACHILE
-- ARCHIVO: Cliente.lua
-- PROPOSITO: Funcionamiento del Panel de ayuda por parte del cliente
-- CREADORES: Tomas Andres Navarro < GamerCarl >
--https://discord.gg/mtacvr
-- *****************************************************************************
local pos = 0
local infoTrabajos = { 
	["nameTrabajo"] = { "Piloto" , "Camionero", "Busetero" , "Rappi", "Taxista" , "Basurero", "Pescador" , "Mecanico", "Policia" , "Detective", "Criminal" , "Drifter", "Militar" , "Medico"},
	["icon"] = {"Avion" , "Camion" , "Puntos", "Entrega", "Bandera", "Basura", "Pescado", "Carros", "Criminal", "Criminal", "Robar", "Zonas", "Motosierra", "Extintor"},
	["descTrabajo"] = { 
        "Debes volar hacia todos los aeropuertos del mapa, debes ir al icono que te indican, abajo te mostraré cual es, recuerda entrar a menos de 10kph al marcador!" ,
        "Debes llevar cargas hacia otras ciudades del mapa, debes ir al icono que te indican, abajo te mostraré cual es, recuerda cuidar tu carga!" ,
        "Debes realizar las rutas por el mapa, sigue los marcadores amarillos y para en los marcadores rojos donde te daran algo de dinero, la paga es al final.",
        "Debes entregar pedidos desde los restaurantes a las casas en tu pizzaboy, recuerda el icono a donde debes ir. Tambien puedes ir por los santos picando para ganar unos pesos. ;)",
        "Debes recoger a los pasajeros y llevarlos a sus destinos, recuerda el icono al que debes ir.",
        "Para este trabajo son requeridas 2 personas, una vez tengas a un compañero debes coger el Camion de la basura e ir por los puntos indicados, una persona debe ir conduciendo y la otra debe ir recogiendo la basura, una vez terminen todo el recorrido deberán ir al punto rojo para que les paguen.(El punto de pago esta dentro dentro de una casa en el mismo lugar donde obtuvieron el trabajo)",
        --"Debes sacar un bote e ir moviendote por el lago para obtener pescados, una vez completes la cantidad que se te especifica debe dirigirte al puente y al lado del spawn de botes habrá un circulo de color blanco que indican el punto de pago",
		"Compra una caña y ponte a pescar al lado del lago, debes lograr que la linea verde este alineada con el pez y asi poder agarrarlo, para cobrar, ve donde el que vende la caña. (usa  -  para mirar tu inventario)",
        "Debes buscar por la ciudad carros abandonados por sus dueños e incautarlos con la grua y llevarlos a los patios. Para arreglar un auto, solo tiene que hacer clic en él y esperar a que el jugador acepte, su automóvil se arreglará y se te pagará.(Recuerda comprar herramientas)",
        "Debes arrestar a jugadores buscados, por lo que tienen que pagar el tiempo por su crimen. Para saber si se desea un jugador, puedes verificar su nombre en F5, o mirar su etiqueta de nombre, y será NOMBRE[NiveldeBúsqueda]. Si un jugador decide huir de ti, puedes usar la pistola silenciada como un taser, y cuando los dispares, se pondrán en una animación de tasadas, para que puedas arrestarlos con el bolillo.",
        "Tendrás todas las funciones disponibles como oficial de policía normal, excepto cuando seas un detective al que se te llamará a los casos de delitos cuando un compañero de policía es asesinado. Cuando llegas a la escena del crimen, solo tienes que buscar pistas del asesino.",
        "La funcionalidad del criminal es matar policias, por cada policia que mates te pagaran automaticamente 8.000, también puedes robar carros y maletín que te darán dinero extra.",
        "Como drifter se te habilitaran las zonas rojas que indican las partes donde puedes obtener puntajes por driftear y te pagaran pequeñas cantidades por ello. También hay modos contrareloj en pistas de drift.(Recuerda usar /tele para ir a las zonas rojas)",
        "Debes matar a desempleados, criminales y policias con tu motosierra para ganar dinero.",
        "Tu función será curar a la jugadores que tengan su salud baja, cadá vez que cures a alguien por completo te pagaran, para curar a una misma persona debes esperar 5 minutos por lo cual deberás buscar otros jugadores si quieres que te paguen.",
    },
	["iconoArma"] = {"Icono","Icono","Icono","Icono","Icono","Icono","Utensilio","Actividades","Arma","Arma","Actividades","Actividad","Arma","Utensilio"},
	["escalaText"] = {13,13,13,13,13,10,12,11,10,13,13,11,14,13},
	["color"] = {{255,255,0},{255,255,0},{255,255,0},{255,255,0},{255,255,0},{255,255,0},{255,255,0},{255,255,0},{0,0,255},{0,0,255},{255,0,0},{255,0,0},{0,255,0},{0,255,255}}
}
	
local  ubicaciones = {
	--["City"] = {{Piloto},{Camionero},{Busetero}, {Rappi}, {Taxista} , {Basurero}, {Pescador} , {Mecanico}, {Policia} , {Detective}, {Criminal} , {Drifter}, {Militar} , {Medico}}
	["LS"] = {
		{2002.43, -2294.47, 13.55},
		{2176.35, -2259.4, 14.77},
		{1766.98, -1905.6, 13.57},
		{1947.92, -1364.58, 18.58},
		{2004.25, -1281.2, 23.98},
		{2193.2, -1991.85, 13.55},
		{2157.8, -97.62, 2.81},
		{2276.62, -2359.15, 13.55},
		{1575.86, -1634.44, 13.56},
		{1560, -1691.11, 5.89},
		{2141.52, -1733.27, 17.29},
		{1812.81, -1900.53, 13.57},
		nil,
		{1177.77, -1328.49, 14.09}},

	["LV"] = {
		{1652.25, 1614.12, 10.82},
		{1629.73, 969.22, 10.82},
		nil,
		nil,
		nil,
		nil,
		nil,
		{1658.43, 2198.95, 10.82},
		{2296.47, 2463.58, 10.82},
		{2296.36, 2455.54, 10.82},
		{2460.4, 1325.64, 10.82},
		{1982.91, 1757.23, 11.76},
		nil,
		{1615.07, 1820.36, 10.83}},

	["SF"] = {
		{-1254.19, 16.47, 14.15},
		{-2136.83, -237.44, 35.32},
		nil,
		nil,
		nil,
		nil,
		nil,
		{-1710.65, 403.05, 7.42},
		{-1615.61, 682.19, 7.19},
		{-1574.18, 653.2, 7.19},
		{-1832.38, 584.9, 35.16},
		{-319.21, 1536.6, 75.56},
		{-1060.47, -1203.73, 129.22},
		nil},
}
function panelAyuda()
	
	local screenW, screenH = guiGetScreenSize()
	PAventanaayuda = guiCreateWindow((screenW - 627) / 2, (screenH - 495) / 2, 627, 495, "PANEL DE AYUDA", false)
	--guiWindowSetSizable(PAventanaayuda, false)
	guiSetProperty(PAventanaayuda, "CaptionColour", "FFE8F00C")
	guiSetAlpha(PAventanaayuda, 0.95)

	PALogoCVR = guiCreateStaticImage(169, 24, 291, 63, ":CVRPanelAyuda/Logos/logoColor.png", false, PAventanaayuda)
	PABotSalir = guiCreateButton(270, 461, 89, 24, "SALIR", false, PAventanaayuda)
	guiSetProperty(PABotSalir, "NormalTextColour", "C4FD0000")
	PAtabpanel = guiCreateTabPanel(9, 95, 608, 361, false, PAventanaayuda)

	PAtabInfo = guiCreateTab("Informacion", PAtabpanel)
	PAmemoInfo = guiCreateMemo(1, 1, 607, 336, "", false, PAtabInfo)
	guiMemoSetReadOnly(PAmemoInfo, true)

	PAtabReglas = guiCreateTab("Reglas", PAtabpanel)
	PAmemoReglas = guiCreateMemo(1, 1, 607, 336, "", false, PAtabReglas)
	guiMemoSetReadOnly(PAmemoReglas, true)

	PAtabAdmin = guiCreateTab("Administracion", PAtabpanel)
	PAmemoAdmin = guiCreateMemo(1, 1, 607, 336, "", false, PAtabAdmin)
	guiMemoSetReadOnly(PAmemoAdmin, true)

	PAtabComandos = guiCreateTab("Comandos", PAtabpanel)
	PAmemoComandos = guiCreateMemo(1, 1, 607, 336, "", false, PAtabComandos)
	guiMemoSetReadOnly(PAmemoComandos, true)

	PAtabVIP = guiCreateTab("Acerca del VIP", PAtabpanel)
	PAmemoVip = guiCreateMemo(1, 1, 607, 336, "", false, PAtabVIP)
	guiMemoSetReadOnly(PAmemoVip, true)

	PAtabTrabajos = guiCreateTab("Trabajos", PAtabpanel)

	PABotPiloto = guiCreateButton(24, 11, 104, 27, "Piloto", false, PAtabTrabajos)
	guiSetProperty(PABotPiloto, "NormalTextColour", "FFFFFF00")
	PABotCamionero = guiCreateButton(180, 10, 104, 27, "Camionero", false, PAtabTrabajos)
	guiSetProperty(PABotCamionero, "NormalTextColour", "FFFFFF00")
	PABotBusetero = guiCreateButton(329, 10, 104, 27, "Busetero", false, PAtabTrabajos)
	guiSetProperty(PABotBusetero, "NormalTextColour", "FFFFFF00")
	PABotRappi = guiCreateButton(478, 10, 104, 27, "Rappi", false, PAtabTrabajos)
	guiSetProperty(PABotRappi, "NormalTextColour", "FFFFFF00")
	PABotTaxista = guiCreateButton(24, 51, 104, 27, "Taxista", false, PAtabTrabajos)
	guiSetProperty(PABotTaxista, "NormalTextColour", "FFFFFF00")
	PABotBasurero = guiCreateButton(180, 51, 104, 27, "Basurero", false, PAtabTrabajos)
	guiSetProperty(PABotBasurero, "NormalTextColour", "FFFFFF00")
	PABotPescador = guiCreateButton(329, 51, 104, 27, "Pescador", false, PAtabTrabajos)
	guiSetProperty(PABotPescador, "NormalTextColour", "FFFFFF00")
	PABotMecanico = guiCreateButton(478, 51, 104, 27, "Mecanico", false, PAtabTrabajos)
	guiSetProperty(PABotMecanico, "NormalTextColour", "FFFFFF00")
	PABotPolicia = guiCreateButton(24, 136, 104, 27, "Policia", false, PAtabTrabajos)
	guiSetProperty(PABotPolicia, "NormalTextColour", "FF0000FF")
	PABotDetective = guiCreateButton(180, 136, 104, 27, "Detective", false, PAtabTrabajos)
	guiSetProperty(PABotDetective, "NormalTextColour", "FF0000FF")
	PABotCriminal = guiCreateButton(329, 136, 104, 27, "Criminal", false, PAtabTrabajos)
	guiSetProperty(PABotCriminal, "NormalTextColour", "FFFF0000")
	PABotDrifter = guiCreateButton(478, 136, 104, 27, "Drifter", false, PAtabTrabajos)
	guiSetProperty(PABotDrifter, "NormalTextColour", "FFFF0000")
	PABotMilitar = guiCreateButton(24, 180, 104, 27, "Militar", false, PAtabTrabajos)
	guiSetProperty(PABotMilitar, "NormalTextColour", "FF00FF00")
	PABotMedico = guiCreateButton(180, 180, 104, 27, "Medico", false, PAtabTrabajos)
	guiSetProperty(PABotMedico, "NormalTextColour", "FF00FEFE")
	--PABotOtro = guiCreateButton(24, 93, 104, 27, "Otro", false, PAtabTrabajos)
	--guiSetProperty(PABotOtro, "NormalTextColour", "FFFFFF00")


	PADescIconosTrabajo = guiCreateLabel(24, 235, 244, 65, "Cada trabajo tiene su color, y tienen los siguientes iconos.", false, PAtabTrabajos)
	local font0_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", 10)
	guiSetFont(PADescIconosTrabajo, font0_PoetsenOneRegular)
	guiLabelSetColor(PADescIconosTrabajo, 255, 0, 47)
	guiLabelSetHorizontalAlign(PADescIconosTrabajo, "center", true)
	guiLabelSetVerticalAlign(PADescIconosTrabajo, "center")

	PAIconosTrabajos = guiCreateStaticImage(311, 218, 287, 105, ":CVRPanelAyuda/Logos/iconJobs.png", false, PAtabTrabajos)
	PAtabRedes = guiCreateTab("Redes sociales", PAtabpanel)
	PAmemoRedes = guiCreateMemo(1, 1, 607, 336, "", false, PAtabRedes) 
	guiMemoSetReadOnly(PAmemoRedes, true)

	informacionTexto()
	reglasTexto()
	administracionTexto()
	comandosTexto()
	vipTexto()
	redesTexto()

	addEventHandler("onClientGUIClick",PABotSalir,abrirocerrar,false)

	addEventHandler("onClientGUIClick",PABotPiloto,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotCamionero,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotBusetero,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotRappi,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotTaxista,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotBasurero,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotPescador,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotMecanico,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotPolicia,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotDetective,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotCriminal,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotDrifter,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotMilitar,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotMedico,AbrirCerrarAyudaTrabajos,false)
end
---------------------------------------------------------------------------
function AyudaTrabajosCVR(pnameTrabajo,icon,descTrabajo,escalaText)
	if source == PABotPiloto then
		pos = 1
	elseif source == PABotCamionero then
		pos = 2
	elseif source == PABotBusetero then
		pos = 3
	elseif source == PABotRappi then
		pos = 4
	elseif source == PABotTaxista then
		pos = 5
	elseif source == PABotBasurero then
		pos = 6
	elseif source == PABotPescador then
		pos = 7
	elseif source == PABotMecanico then
		pos = 8
	elseif source == PABotPolicia then
		pos = 9
	elseif source == PABotDetective then
		pos = 10
	elseif source == PABotCriminal then
		pos = 11
	elseif source == PABotDrifter then
		pos = 12
	elseif source == PABotMilitar then
		pos = 13
	elseif source == PABotMedico then
		pos = 14
	end
	local R = tonumber(infoTrabajos["color"][pos][1])
	local G = tonumber(infoTrabajos["color"][pos][2])
	local B = tonumber(infoTrabajos["color"][pos][3])
	PAPVentanaTrabajosCVR = guiCreateWindow(487, 221, 627, 477, "AYUDA - "..infoTrabajos["nameTrabajo"][pos], false)
	--guiWindowSetSizable(PAPVentanaTrabajosCVR, false)
	guiSetAlpha(PAPVentanaTrabajosCVR, 0.90)

	PAImagenTrabajosCVR = guiCreateStaticImage(10, 38, 180, 401, ":CVRPanelAyuda/Logos/"..infoTrabajos["nameTrabajo"][pos]..".png", false, PAPVentanaTrabajosCVR)

	PAPregunta1 = guiCreateLabel(225, 30, 380, 39, "¿Que se hace en este trabajo?", false, PAPVentanaTrabajosCVR)
	local font1_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", 18)
	guiSetFont(PAPregunta1, font1_PoetsenOneRegular)
	guiLabelSetColor(PAPregunta1, R, G, B)
	guiLabelSetHorizontalAlign(PAPregunta1, "center", false)
	guiLabelSetVerticalAlign(PAPregunta1, "center")

	PADescTrabajosCVR = guiCreateLabel(207, 73, 410, 119, infoTrabajos["descTrabajo"][pos] , false, PAPVentanaTrabajosCVR)
	local font2_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", infoTrabajos["escalaText"][pos])
	guiSetFont(PADescTrabajosCVR, font2_PoetsenOneRegular)
	guiLabelSetHorizontalAlign(PADescTrabajosCVR, "left", true)
	guiLabelSetVerticalAlign(PADescTrabajosCVR, "center")

	PAIconoTrabajosCVR = guiCreateStaticImage(212, 257, 135, 152, ":CVRPanelAyuda/Logos/icon"..infoTrabajos["icon"][pos]..".png", false, PAPVentanaTrabajosCVR)

	PATextIcono = guiCreateLabel(212, 202, 135, 41, infoTrabajos["iconoArma"][pos], false, PAPVentanaTrabajosCVR)
	guiSetFont(PATextIcono, font1_PoetsenOneRegular)
	guiLabelSetColor(PATextIcono, R, G, B)
	guiLabelSetHorizontalAlign(PATextIcono, "center", false)
	guiLabelSetVerticalAlign(PATextIcono, "center")


	PAPregunta2 = guiCreateLabel(366, 202, 231, 42, "¿Donde coges el trabajo?", false, PAPVentanaTrabajosCVR)
	local font3_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", 14)
	guiSetFont(PAPregunta2, font3_PoetsenOneRegular)
	guiLabelSetColor(PAPregunta2, R, G, B)
	guiLabelSetHorizontalAlign(PAPregunta2, "center", false)
	guiLabelSetVerticalAlign(PAPregunta2, "center")

	PABotUbiTrabajosCVR1 = guiCreateButton(415, 262, 140, 36, "UBICACION LS", false, PAPVentanaTrabajosCVR)
	PABotUbiTrabajosCVR2 = guiCreateButton(416, 304, 140, 36, "UBICACION LV", false, PAPVentanaTrabajosCVR)
	PABotUbiTrabajosCVR3 = guiCreateButton(415, 346, 140, 36, "UBICACION SF", false, PAPVentanaTrabajosCVR)

	PAIconoUbic = guiCreateStaticImage(556, 387, 51, 42, ":NGPlayerFunctions/files/waypointV2.png", false, PAPVentanaTrabajosCVR)
	PABotCerrar = guiCreateButton(265, 441, 92, 26, "Cerrar", false, PAPVentanaTrabajosCVR)
	guiSetProperty(PABotCerrar, "NormalTextColour", "FFFF0000")

	addEventHandler("onClientGUIClick",PABotCerrar,AbrirCerrarAyudaTrabajos,false)
	addEventHandler("onClientGUIClick",PABotUbiTrabajosCVR1,blip,false)
	addEventHandler("onClientGUIClick",PABotUbiTrabajosCVR2,blip,false)
	addEventHandler("onClientGUIClick",PABotUbiTrabajosCVR3,blip,false)
end


---------------------------------------------------------------------------
-- Funciones de los textos en el panel
function informacionTexto()
    archivo = fileOpen("Espanol/General.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoInfo:setText (contenido)
    fileClose (archivo)
end
  
function reglasTexto()
    archivo = fileOpen("Espanol/Reglas.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoReglas:setText (contenido)
    fileClose (archivo)
end
  
function administracionTexto()
    archivo = fileOpen("Espanol/Administracion.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoAdmin:setText (contenido)
    fileClose (archivo)
end
  
function comandosTexto()
    archivo = fileOpen("Espanol/Comandos.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoComandos:setText (contenido)
    fileClose (archivo)
end

function vipTexto()
    archivo = fileOpen("Espanol/VIP.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoVip:setText (contenido)
    fileClose (archivo)
end
  
  
function redesTexto()
    archivo = fileOpen("Espanol/Redes.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoRedes:setText (contenido)
    fileClose (archivo)
end
  
----------------------------------------------------

function blip()
	if source == PABotUbiTrabajosCVR1 then
		if ubicaciones["LS"][pos] ~= nil then
			exports.ngplayerfunctions:createWaypointLoc ( tonumber(ubicaciones["LS"][pos][1]), tonumber(ubicaciones["LS"][pos][2]), tonumber(ubicaciones["LS"][pos][3]) )
		else
			outputChatBox("No hay ubicaciones de "..infoTrabajos["nameTrabajo"][pos].." en Los Santos",255,0,0,true)
		end
	elseif source == PABotUbiTrabajosCVR2 then 
		if ubicaciones["LV"][pos] ~= nil then
			exports.ngplayerfunctions:createWaypointLoc ( tonumber(ubicaciones["LV"][pos][1]), tonumber(ubicaciones["LV"][pos][2]), tonumber(ubicaciones["LV"][pos][3]) )
		else
			outputChatBox("No hay ubicaciones de "..infoTrabajos["nameTrabajo"][pos].." en Las Venturas",255,0,0,true)
		end
	elseif source == PABotUbiTrabajosCVR3 then 
		if ubicaciones["SF"][pos] ~= nil then
			exports.ngplayerfunctions:createWaypointLoc ( tonumber(ubicaciones["SF"][pos][1]), tonumber(ubicaciones["SF"][pos][2]), tonumber(ubicaciones["SF"][pos][3]) )
		else
			outputChatBox("No hay ubicaciones de "..infoTrabajos["nameTrabajo"][pos].." en San Fierro",255,0,0,true)
		end
	end
end

----------------------------------------------------
function AbrirCerrarAyudaTrabajos()
	if not(isElement(PAPVentanaTrabajosCVR)) then
		AyudaTrabajosCVR()
	else
		destroyElement(PAPVentanaTrabajosCVR)
	end
--[[	if source == PABotTrabajosCVR then
		if not(isElement(PAPVentanaTrabajosCVR)) then
			AyudaTrabajosCVR()
		else
			destroyElement(PAPVentanaTrabajosCVR)
		end
		elseif source == PABotCamionero then
		if not(isElement(PAPVentanaCamionero)) then
			AyudaCamionero()
		else
			destroyElement(PAPVentanaCamionero)
		end
		elseif source == PABotTrabajo1 then
		if not(isElement(PAPVentanaTrabajo1)) then
			AyudaTrabajo()
		else
			destroyElement(PAPVentanaTrabajo1)
		end
	elseif source == PABotTrabajo2 then
		if not(isElement(PAPVentanaTrabajo2)) then
			AyudaTrabajo()
		else
			destroyElement(PAPVentanaTrabajo2)
		end
		elseif source == PABotTrabajo3 then
			if not(isElement(PAPVentanaTrabajo3)) then
				AyudaTrabajo()
			else
				destroyElement(PAPVentanaTrabajo3)
			end
		elseif source == PABotRappi then
			if not(isElement(PAPVentanaRappi)) then
				AyudaTrabajo()
			else
				destroyElement(PAPVentanaRappi)
			end
	elseif source == PABotCerrar then
		if isElement(PAPVentanaTrabajosCVR) then
			destroyElement(PAPVentanaTrabajosCVR)

		elseif isElement(PAPVentanaCamionero) then
			destroyElement(PAPVentanaCamionero)

		elseif isElement(PAPVentanaTrabajo1) then
			destroyElement(PAPVentanaTrabajo1)

		elseif isElement(PAPVentanaTrabajo2) then
			destroyElement(PAPVentanaTrabajo2)

		elseif isElement(PAPVentanaTrabajo3) then
			destroyElement(PAPVentanaTrabajo3)

		elseif isElement(PAPVentanaRappi) then
			destroyElement(PAPVentanaRappi)

		end
	end]]
end



-----------------------------------------------------
function abrirocerrar()
  -- Verificamos si la ventana se muestra en tal caso de que no se muestre se abre
	if (isElement(PAventanaayuda) == false) then
		local inHouse = getElementData(localPlayer,"inHouse") or false
		if not(inHouse) then
			panelAyuda()
			-- Se muestra el cursor
			showCursor(true)
			-- Se reproduce el sonido del Panel cuando abre
			playSound("abrir.wav")
		-- en caso de que el panel se esta mostrando se oculta
		end
	else
		if isElement(PAPVentanaTrabajosCVR) then
			destroyElement(PAPVentanaTrabajosCVR)
		end
	destroyElement(PAventanaayuda)
	-- Se deja de mostrar el cursor
	showCursor(false)
	-- Se reproduce el sonido del Panel
	playSound("abrir.wav")
	end
end
addCommandHandler("ayuda",abrirocerrar)
bindKey("F4", "down", abrirocerrar)


function setInHouse(inHouse)
  if inHouse then
    setElementData(localPlayer,"inHouse",true,false)
  else
    setElementData(localPlayer,"inHouse",false,false)
  end
end
addEvent("CVRPanelAyuda:setInHouse",true)
addEventHandler("CVRPanelAyuda:setInHouse",root,setInHouse)