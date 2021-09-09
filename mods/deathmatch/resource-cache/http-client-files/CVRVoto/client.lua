function CrearVentanaEncuensta(player,Op1,Op2,tamFuente2,Pregunta2)
	local screenW, screenH = guiGetScreenSize()
	if isElement(CVRVentanaVotoPanelDePregunta) == true then
		destroyElement( CVRVentanaVotoPanelDePregunta )
	else 
		CVRVentanaVotoPanelDePregunta = guiCreateWindow(10, (screenH - 181) / 2, 260, 181, "Con >> M << sacas el cursor del mouse.", false)
        guiWindowSetSizable(CVRVentanaVotoPanelDePregunta, false)

		CVRVentanaVotoTiruloPregunta = guiCreateLabel(6, 31, 249, 98, "Pregunta.", false, CVRVentanaVotoPanelDePregunta)
        local font1_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", tamFuente2)
        guiSetFont(CVRVentanaVotoTiruloPregunta, font1_PoetsenOneRegular)
        guiLabelSetHorizontalAlign(CVRVentanaVotoTiruloPregunta, "center", true)
        guiLabelSetVerticalAlign(CVRVentanaVotoTiruloPregunta, "center")

        CVRVentanaVotoBtOp1 = guiCreateButton(10, 134, 68, 39, " ", false, CVRVentanaVotoPanelDePregunta)
        local font2_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", 10)
        guiSetFont(CVRVentanaVotoBtOp1, font2_PoetsenOneRegular)
		addEventHandler("onClientGUIClick",CVRVentanaVotoBtOp1,BotonVotar1,false)

        CVRVentanaVotoBtOp2 = guiCreateButton(96, 134, 68, 39, " ", false, CVRVentanaVotoPanelDePregunta)
        guiSetFont(CVRVentanaVotoBtOp2, font2_PoetsenOneRegular)
		addEventHandler("onClientGUIClick",CVRVentanaVotoBtOp2,BotonVotar2,false)

        CVRVentanaVotoBtNoVotar = guiCreateButton(182, 134, 68, 39, "No Votar", false, CVRVentanaVotoPanelDePregunta)
        guiSetFont(CVRVentanaVotoBtNoVotar, font2_PoetsenOneRegular)
        guiSetProperty(CVRVentanaVotoBtNoVotar, "NormalTextColour", "FFFEF000") 
		addEventHandler("onClientGUIClick",CVRVentanaVotoBtNoVotar,BotonVotar3,false)

		guiSetText(CVRVentanaVotoTiruloPregunta, Pregunta2)
		guiSetText(CVRVentanaVotoBtOp1, Op1)
		guiSetText(CVRVentanaVotoBtOp2, Op2)
	end

end
addEvent("VentanaEncuesta",true)
addEventHandler("VentanaEncuesta",root,CrearVentanaEncuensta)


function CrearPanelEncuensta()
	local screenW, screenH = guiGetScreenSize()
	if isElement(CVRVotoPanelEncuesta) == false then
		
		guiSetInputMode ("no_binds")
		
		CVRVotoPanelEncuesta = guiCreateWindow((screenW - 261) / 2, (screenH - 306) / 2, 261, 306, "Previsualizacion de pregunta", false)
        guiWindowSetSizable(CVRVotoPanelEncuesta, false)
	
		local PreguntaDef = "Mira como queda tu pregunta acá y cambia el tamaño de letra."
		CVRVotoTiruloPregunta = guiCreateLabel(6, 28, 249, 100, PreguntaDef , false, CVRVotoPanelEncuesta)
		local tamFuente = 12
		local font3_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", tamFuente)
		guiSetFont(CVRVotoTiruloPregunta, font3_PoetsenOneRegular)
        guiLabelSetHorizontalAlign(CVRVotoTiruloPregunta, "center", true)
        guiLabelSetVerticalAlign(CVRVotoTiruloPregunta, "center")

        local font0_PoetsenOneRegular = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", 10)
        CVRVotoBtOp1 = guiCreateButton(10, 134, 68, 39, "OP1", false, CVRVotoPanelEncuesta)
        guiSetFont(CVRVotoBtOp1, font0_PoetsenOneRegular)
        CVRVotoboxOP1 = guiCreateEdit(0, 0, 68, 39, "OP1", false, CVRVotoBtOp1)

        CVRVotoBtOp2 = guiCreateButton(96, 134, 68, 39, "OP2", false, CVRVotoPanelEncuesta)
        guiSetFont(CVRVotoBtOp2, font0_PoetsenOneRegular)
        CVRVotoboxOP2 = guiCreateEdit(0, 0, 68, 39, "OP2", false, CVRVotoBtOp2)
	
		CVRVotoBtNoVotar = guiCreateButton(182, 134, 68, 39, "No Votar", false, CVRVotoPanelEncuesta)
        guiSetFont(CVRVotoBtNoVotar, font0_PoetsenOneRegular)
        guiSetProperty(CVRVotoBtNoVotar, "NormalTextColour", "FFFEF000")
	
        CVRVotoBoxPregunta = guiCreateEdit(10, 204, 235, 29, "¿Que deseas preguntar?", false, CVRVotoPanelEncuesta)
		addEventHandler("onClientGUIChanged",CVRVotoBoxPregunta,PrevisualizarEncuesta)
	
        CVRVotoPregunta = guiCreateLabel(4, 179, 251, 15, "Pregunta", false, CVRVotoPanelEncuesta)
        guiSetFont(CVRVotoPregunta, font0_PoetsenOneRegular)
        guiLabelSetHorizontalAlign(CVRVotoPregunta, "center", false)
        guiLabelSetVerticalAlign(CVRVotoPregunta, "center")


        CVRVotoBtHacerEncuesta = guiCreateButton(46, 254, 92, 39, "Hacer encuesta", false, CVRVotoPanelEncuesta)
		addEventHandler("onClientGUIClick",CVRVotoBtHacerEncuesta,EmpezarEncuesta,false)

        CVRVotoBtSalir = guiCreateButton(230, 270, 21, 22, "X", false, CVRVotoPanelEncuesta)
        guiSetProperty(CVRVotoBtSalir, "NormalTextColour", "FFFF0000")
		addEventHandler("onClientGUIClick",CVRVotoBtSalir,SalirEncuesta,false)

        CVRVotoTituloTamaoPreg = guiCreateLabel(144, 233, 106, 21, "Tamaño Letra", false, CVRVotoPanelEncuesta)
        guiLabelSetHorizontalAlign(CVRVotoTituloTamaoPreg, "center", true)
        guiLabelSetVerticalAlign(CVRVotoTituloTamaoPreg, "center")

		CVRVotoboxTamaoletra = guiCreateEdit(178, 260, 40, 27, "12", false, CVRVotoPanelEncuesta)
        guiEditSetMaxLength(CVRVotoboxTamaoletra, 2)
		addEventHandler("onClientGUIChanged",CVRVotoboxTamaoletra,PrevisualizarEncuesta)

		showCursor(true)

	else 
		destroyElement( CVRVotoPanelEncuesta )
		showCursor(false)
	end
 end
addEvent("AbrirPanelEncuesta",true)
addEventHandler("AbrirPanelEncuesta",root,CrearPanelEncuensta)

  


function TerminarEncuesta()
	if isElement(CVRVentanaVotoPanelDePregunta) == true then
		destroyElement( CVRVentanaVotoPanelDePregunta )
	end
end
addEvent("Terminarencuesta",true)
addEventHandler("Terminarencuesta",root,TerminarEncuesta)

function EmpezarEncuesta(player,Op1,Op2,tamFuente2,Pregunta2)
	local player = getPlayerName(localPlayer)
	tamFuente2 = guiGetText(CVRVotoboxTamaoletra)
	Op1 = guiGetText(CVRVotoboxOP1)
	Op2 = guiGetText(CVRVotoboxOP2)
	Pregunta2 = guiGetText(CVRVotoTiruloPregunta)
	destroyElement(CVRVotoPanelEncuesta)
	showCursor(false)
	guiSetInputMode ("no_binds_when_editing")
	local tamaoNuevo2 = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", tamFuente2)
	triggerServerEvent ("EnviarOpcionesAServer",root,player,Op1,Op2,tamFuente2,Pregunta2)
	
end

function PrevisualizarEncuesta()
	tamFuente = guiGetText(CVRVotoboxTamaoletra)
	Pregunta = guiGetText(CVRVotoBoxPregunta)
	local tamaoNuevo = guiCreateFont(":CVRfuentes/PoetsenOneRegular.ttf", tamFuente)
	guiSetFont(CVRVotoTiruloPregunta, tamaoNuevo)
	guiSetText(CVRVotoTiruloPregunta, Pregunta)
end

function SalirEncuesta(estatus)
	estatus = 0
	destroyElement(CVRVotoPanelEncuesta)
	showCursor(false)
	guiSetInputMode("allow_binds")
	triggerServerEvent("Estadoen0",root,estatus)
end

function BotonVotar1(v)
	local v = getPlayerName(localPlayer)
	triggerServerEvent ("onBoton1",root,v)
	destroyElement(CVRVentanaVotoPanelDePregunta)
	outputChatBox("#31D304Has votado en la encuesta!",255 , 255, 255,true)
end

function BotonVotar2(f)
	local f = getPlayerName(localPlayer)
	triggerServerEvent ("onBoton2",root,f)
	destroyElement(CVRVentanaVotoPanelDePregunta)
	outputChatBox("#31D304Has votado en la encuesta!",255 , 255, 255,true)
end

function BotonVotar3(p)
	local p = getPlayerName(localPlayer)
	triggerServerEvent ("onBoton3",root,p)
	destroyElement(CVRVentanaVotoPanelDePregunta)
	outputChatBox("#D30426Has decidido no votar en la encuesta!",255 , 255, 255,true)
end