addEventHandler("onClientResourceStart", resourceRoot,
function()
	VipMain = guiCreateWindow(38, 384, 294, 497, "Menú VIP (by Balaclava)", false)
	guiWindowSetSizable(VipMain, false)
	guiSetAlpha(VipMain, 0.70)

	vidaButton = guiCreateButton(0.06, 0.10, 0.29, 0.05, "Vida", true, VipMain)
	guiSetProperty(vidaButton, "NormalTextColour", "FFFF0000")
	chalecoButton = guiCreateButton(0.37, 0.10, 0.29, 0.05, "Chaleco", true, VipMain)
	guiSetProperty(chalecoButton, "NormalTextColour", "FF7ED1F7")
	labelSalud = guiCreateLabel(0.07, 0.05, 0.56, 0.03, "Restaurar salud", true, VipMain)
	labelArmas = guiCreateLabel(0.07, 0.18, 0.58, 0.03, "Obtención de Armas", true, VipMain)
	c4Button = guiCreateButton(0.07, 0.23, 0.29, 0.05, "C4 9999", true, VipMain)
	guiSetProperty(c4Button, "NormalTextColour", "FF098402")
	aereosolButton = guiCreateButton(0.40, 0.23, 0.29, 0.05, "Aereosol", true, VipMain)
	guiSetProperty(aereosolButton, "NormalTextColour", "FFE6F721")
	quantityAereosol = guiCreateEdit(0.73, 0.23, 0.18, 0.05, "", true, VipMain)
	labelAereosol = guiCreateLabel(0.73, 0.18, 0.21, 0.03, "# Aereosol", true, VipMain)
	labelVehiculos = guiCreateLabel(0.06, 0.30, 0.60, 0.03, "Obtención de Vehiculos", true, VipMain)
	vortexButton = guiCreateButton(0.07, 0.35, 0.29, 0.05, "Vortex", true, VipMain)
	guiSetProperty(vortexButton, "NormalTextColour", "FFFFFFFF")
	infernusButton = guiCreateButton(0.40, 0.35, 0.29, 0.05, "Infernus", true, VipMain)
	guiSetProperty(infernusButton, "NormalTextColour", "FFFFFFFF")
	pmaverickButton = guiCreateButton(0.07, 0.43, 0.29, 0.05, "P. Maverick", true, VipMain)
	guiSetProperty(pmaverickButton, "NormalTextColour", "FFFFFFFF")
	labelVehicles = guiCreateLabel(0.06, 0.51, 0.56, 0.03, "Modificación de Vehículos", true, VipMain)
	buttonModLlantas = guiCreateButton(0.07, 0.56, 0.29, 0.05, "Llantas Altas", true, VipMain)
	guiSetProperty(buttonModLlantas, "NormalTextColour", "FFFFFFFF")
	buttonModHighSpeed = guiCreateButton(0.40, 0.56, 0.29, 0.05, "Alta Velocidad", true, VipMain)
	guiSetProperty(buttonModHighSpeed, "NormalTextColour", "FFFFFFFF")
	buttonMiniHedit = guiCreateButton(0.07, 0.61, 0.29, 0.05, "Mini Handling Editor", true, VipMain)
	guiSetProperty(buttonMiniHedit, "NormalTextColour", "FFFFFFFF")
	buttonModReset = guiCreateButton(0.42, 0.61, 0.20, 0.05, "Reset", true, VipMain)
	guiSetProperty(buttonModReset, "NormalTextColour", "FFFFFFFF")
	labelInfoMisc = guiCreateLabel(0.06, 0.70, 0.52, 0.03, "Info VIP y Misc", true, VipMain)
	buttonInfoVip = guiCreateButton(0.07, 0.74, 0.29, 0.05, "Info VIP", true, VipMain)
	guiSetProperty(buttonInfoVip, "NormalTextColour", "FFFFFFFF")
	buttonCJ = guiCreateButton(0.40, 0.74, 0.29, 0.05, "Personaliza CJ", true, VipMain)
	guiSetProperty(buttonCJ, "NormalTextColour", "FFFFFFFF")
	labelNameVIP = guiCreateLabel(14, 446, 139, 16, "Tienes VIP: ", false, VipMain)
	labelUntilVIP = guiCreateLabel(15, 467, 128, 15, "Hasta el día:", false, VipMain)
	buttonBattleStyle = guiCreateButton(0.07, 0.81, 0.29, 0.05, "Estilo de Pelea", true, VipMain)
	guiSetProperty(buttonBattleStyle, "NormalTextColour", "FFFFFFFF")
	rainbowButton = guiCreateButton(0.40, 0.43, 0.29, 0.05, "Rainbow", true, VipMain)
	guiSetProperty(rainbowButton, "NormalTextColour", "FFFFFFFF")
	labelInfoFix = guiCreateLabel(20, 197, 184, 15, "Presiona \"2\" para reparar tu carro", false, VipMain)
	guiLabelSetColor(labelInfoFix, 255, 222, 0)
	buttonStats = guiCreateButton(0.40, 0.81, 0.32, 0.05, "Habilidad Armas", true, VipMain)
	guiSetProperty(buttonStats, "NormalTextColour", "FFFFFFFF")
	btnExtraHealth = guiCreateButton(0.69, 0.10, 0.27, 0.05, "Salud Extra", true, VipMain)
	guiSetProperty(btnExtraHealth, "NormalTextColour", "FF5DF94D")
	btnRemoveStars = guiCreateButton(0.62, 0.92, 0.32, 0.05, "Quitar Estrellas", true, VipMain)
	guiSetProperty(btnRemoveStars, "NormalTextColour", "FF7D95FC")    

	guiSetVisible(VipMain,false)


    --Gui Fight
    fightGui = guiCreateWindow(936, 308, 193, 221, "Estilos de pelea", false)
    guiWindowSetSizable(fightGui, false)
    guiSetProperty(fightGui, "CaptionColour", "FFF00202")

    defaultRadio = guiCreateRadioButton(13, 24, 169, 15, "Default", false, fightGui)
    guiRadioButtonSetSelected(defaultRadio, true)
    boxingRadio = guiCreateRadioButton(13, 49, 169, 15, "Boxing", false, fightGui)
    kungfuRadio = guiCreateRadioButton(13, 74, 169, 15, "Kung-Fu", false, fightGui)
    kneeRadio = guiCreateRadioButton(13, 99, 169, 15, "Rodillazos", false, fightGui)
    grabRadio = guiCreateRadioButton(13, 124, 169, 15, "Grab-Kick", false, fightGui)
    elbowsRadio = guiCreateRadioButton(13, 149, 169, 15, "Codazos", false, fightGui)
    updateFightBtn = guiCreateButton(20, 174, 152, 33, "Actualizar", false, fightGui)    
    guiSetVisible(fightGui,false)
    --Customize Cj
    mainWindow = guiCreateWindow ( 0.01, 0.17, 0.3, 0.6, "CJ Customization - Ingrese solo numeros", true )
    guiCreateLabel(0.03, 0.045, 0.94, 0.5, "                             Shirt:", true, mainWindow)
    guiCreateLabel(0.03, 0.09, 0.94, 0.5, "                            Hair:", true, mainWindow)
    guiCreateLabel(0.03, 0.135, 0.94, 0.5, "                           Pants:", true, mainWindow)
    guiCreateLabel(0.03, 0.18, 0.94, 0.5, "                          Shoes:", true, mainWindow)
    guiCreateLabel(0.03, 0.225, 0.94, 0.5, "                              Hat:", true, mainWindow)
    guiCreateLabel(0.03, 0.27, 0.94, 0.5, "                         Glasses:", true, mainWindow)
    guiCreateLabel(0.03, 0.315, 0.94, 0.5, "                       Necklace:", true, mainWindow)
    guiCreateLabel(0.03, 0.36, 0.94, 0.5, "                          Watch:", true, mainWindow)
    guiCreateLabel(0.03, 0.405, 0.94, 0.5, "         Tattoos Left Chest:", true, mainWindow)
    guiCreateLabel(0.03, 0.45, 0.94, 0.5, "       Tattoos Right Chest:", true, mainWindow)
    guiCreateLabel(0.03, 0.495, 0.94, 0.5, "           Tattoos Stomach:", true, mainWindow)
    guiCreateLabel(0.03, 0.54, 0.94, 0.5, "                 Tattoos Back:", true, mainWindow)
    guiCreateLabel(0.03, 0.585, 0.94, 0.5, "        Tattoos Lower Back:", true, mainWindow)
    guiCreateLabel(0.03, 0.63, 0.94, 0.5, "  Tattoos Left Upper Arm:", true, mainWindow)
    guiCreateLabel(0.03, 0.675, 0.94, 0.5, "  Tattoos Left Lower Arm:", true, mainWindow)
    guiCreateLabel(0.03, 0.72, 0.94, 0.5, "Tattoos Right Upper Arm:", true, mainWindow)
    guiCreateLabel(0.03, 0.765, 0.94, 0.5, "Tattoos Right Lower Arm:", true, mainWindow)
    guiCreateLabel(0.03, 0.81, 0.94, 0.5, "              \"Extra\" CJ Skins:", true, mainWindow)
    guiCreateLabel(0.03, 0.855, 0.94, 0.5, "                        Fat Stat:", true, mainWindow)
    guiCreateLabel(0.03, 0.9, 0.94, 0.5, "                   Muscle Stat:", true, mainWindow)
    editA = guiCreateEdit( 0.5, 0.045, 0.2, 0.045, "", true, mainWindow )
    editB = guiCreateEdit( 0.5, 0.09, 0.2, 0.045, "", true, mainWindow )
    editC = guiCreateEdit( 0.5, 0.135, 0.2, 0.045, "", true, mainWindow )
    editD = guiCreateEdit( 0.5, 0.18, 0.2, 0.045, "", true, mainWindow )
    editQ = guiCreateEdit( 0.5, 0.225, 0.2, 0.045, "", true, mainWindow )
    editP = guiCreateEdit( 0.5, 0.27, 0.2, 0.045, "", true, mainWindow )
    editN = guiCreateEdit( 0.5, 0.315, 0.2, 0.045, "", true, mainWindow )
    editO = guiCreateEdit( 0.5, 0.36, 0.2, 0.045, "", true, mainWindow )
    editJ = guiCreateEdit( 0.5, 0.405, 0.2, 0.045, "", true, mainWindow )
    editK = guiCreateEdit( 0.5, 0.45, 0.2, 0.045, "", true, mainWindow )
    editL = guiCreateEdit( 0.5, 0.495, 0.2, 0.045, "", true, mainWindow )
    editI = guiCreateEdit( 0.5, 0.54, 0.2, 0.045, "", true, mainWindow )
    editM = guiCreateEdit( 0.5, 0.585, 0.2, 0.045, "", true, mainWindow )
    editE = guiCreateEdit( 0.5, 0.63, 0.2, 0.045, "", true, mainWindow )
    editF = guiCreateEdit( 0.5, 0.675, 0.2, 0.045, "", true, mainWindow )
    editG = guiCreateEdit( 0.5, 0.72, 0.2, 0.045, "", true, mainWindow )
    editH = guiCreateEdit( 0.5, 0.765, 0.2, 0.045, "", true, mainWindow )
    editR = guiCreateEdit( 0.5, 0.81, 0.2, 0.045, "", true, mainWindow )
    editS = guiCreateEdit( 0.5, 0.855, 0.2, 0.045, "", true, mainWindow )
    editT = guiCreateEdit( 0.5, 0.9, 0.2, 0.045, "", true, mainWindow )
    applyButton = guiCreateButton( 0.8, 0.1, 0.2, 0.3, "Apply", true, mainWindow )
    exitButton = guiCreateButton( 0.8, 0.5, 0.2, 0.3, "Exit", true, mainWindow )
    guiSetVisible(mainWindow,false)


	--minihedit
	miniHandEd = guiCreateWindow(259, 369, 260, 375, "Mini Hedit", false)
	guiWindowSetSizable(miniHandEd, false)

	aplicarBoton = guiCreateButton(0.36, 0.92, 0.28, 0.05, "Aplicar", true, miniHandEd)
	titleMultiplierTraction = guiCreateLabel(8, 30, 165, 15, "Multiplicador de Tracción 5:0", false, miniHandEd)
	editTraction = guiCreateEdit(9, 49, 46, 25, "", false, miniHandEd)
	lblTractionActual = guiCreateLabel(68, 59, 172, 19, "Actualmente tienes: ", false, miniHandEd)
	titleLowerSuspension = guiCreateLabel(8, 84, 154, 16, "Límite Bajo Suspensión 0:-4", false, miniHandEd)
	editLowerSusp = guiCreateEdit(9, 110, 46, 25, "", false, miniHandEd)
	lblLowerActual = guiCreateLabel(68, 116, 172, 19, "Actualmente tienes: ", false, miniHandEd)
	titleHigherSuspension = guiCreateLabel(8, 145, 143, 16, "Límite Alto Suspensión 2:0", false, miniHandEd)
	editHighSusp = guiCreateEdit(9, 171, 46, 25, "", false, miniHandEd)
	lblHigherActual = guiCreateLabel(68, 177, 172, 19, "Actualmente tienes: ", false, miniHandEd)
	titleAcceleration = guiCreateLabel(8, 206, 143, 16, "Aceleración 0:40", false, miniHandEd)
	editAccel = guiCreateEdit(9, 228, 46, 25, "", false, miniHandEd)
	lblAccelActual = guiCreateLabel(68, 238, 172, 19, "Actualmente tienes: ", false, miniHandEd)
	titleTractionLoss = guiCreateLabel(8, 263, 143, 16, "Pérdida de Tracción 2:0", false, miniHandEd)
	editTractionLoss = guiCreateEdit(9, 283, 46, 25, "", false, miniHandEd)
	lbltractionLoss = guiCreateLabel(68, 293, 172, 19, "Actualmente tienes: ", false, miniHandEd)
	closeButton = guiCreateButton(230, 32, 20, 17, "x", false, miniHandEd)    
	guiSetVisible(miniHandEd,false)
end
)

local screenW, screenH = guiGetScreenSize()

local remaningH = 0
local remaningA = 0

addEventHandler("onClientRender", root,
function()
	if isTimer(healthTimer) then
		local remain,times,interval = getTimerDetails(healthTimer)
		dxDrawText((remain/1000).." sg", screenW * 0.9036, screenH * 0.7200, (screenW * 0.9036) + 175, ( screenH * 0.7200) + 55, tocolor(255, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
    end
	if isTimer(armourTimer) then
		local remain,times,interval = getTimerDetails(armourTimer)
        dxDrawText((remain/1000).." sg", screenW * 0.9036, screenH * 0.7942, (screenW * 0.9036) + 175, ( screenH * 0.7942) + 55, tocolor(0, 255, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
	end
	if isTimer(fixTimer) then
		local remain,times,interval = getTimerDetails(fixTimer)
        dxDrawText((remain/1000).." sg", screenW * 0.9036, screenH * 0.6458, (screenW * 0.9036) + 175, ( screenH * 0.6458) + 55, tocolor(0, 0, 160, 255), 3.00, "default", "left", "top", false, false, false, false, false)
	end
end
)

function clickedButtonCheck ( element )
	local VIP = getElementData(localPlayer,"VIP")
	if source == applyButton then  
		incredibleTable = {	--the order is mixed because i sorted GUI menu better than type listings in code
			[0] = { storedValue = guiGetText ( editA )
			},
			[1] = { storedValue = guiGetText ( editB )
			},
			[2] = { storedValue = guiGetText ( editC )
			},
			[3] = { storedValue = guiGetText ( editD )
			},
			[4] = { storedValue = guiGetText ( editE )
			},
			[5] = { storedValue = guiGetText ( editF )
			},
			[6] = { storedValue = guiGetText ( editG )
			},
			[7] = { storedValue = guiGetText ( editH )
			},
			[8] = { storedValue = guiGetText ( editI )
			},
			[9] = { storedValue = guiGetText ( editJ )
			},
			[10] = { storedValue = guiGetText ( editK )
			},
			[11] = { storedValue = guiGetText ( editL )
			},
			[12] = { storedValue = guiGetText ( editM )
			},
			[13] = { storedValue = guiGetText ( editN )
			},
			[14] = { storedValue = guiGetText ( editO )
			},
			[15] = { storedValue = guiGetText ( editP )
			},
			[16] = { storedValue = guiGetText ( editQ )
			},
			[17] = { storedValue = guiGetText ( editR )
			},
			[18] = { storedValue = guiGetText ( editS ) --Fat Stat
	  		},
			[19] = { storedValue = guiGetText ( editT ) --Muscle Stat
			}
		}
		triggerServerEvent ( "applyClothes", getLocalPlayer (), incredibleTable )
	elseif source == exitButton then
		guiSetVisible ( mainWindow, false )
		showCursor ( false ) 
	elseif source == aereosolButton then
		if VIP=="Gold" or VIP=="Diamond" or VIP=="Esmeralda" then
			if isTimer ( sprayTimer ) then 
				outputChatBox("Espera un poco...", 255,0,0)
			else
				local quantity=9999
				if not (guiGetText(quantityAereosol) == "") then
					quantity=tonumber(guiGetText(quantityAereosol))
				end
				triggerServerEvent("setSpray",getLocalPlayer(),quantity)
				sprayTimer = setTimer(function() end, 3000,1)
			end	elseif source == aereosolButton then
			if isTimer ( sprayTimer ) then 
				outputChatBox("Espera un poco...", 255,0,0)
			else
				local quantity=9999
				if not (guiGetText(quantityAereosol) == "") then
					quantity=tonumber(guiGetText(quantityAereosol))
				end
				triggerServerEvent("setSpray",getLocalPlayer(),quantity)
				sprayTimer = setTimer(function() end, 3000,1)
			end
		else
			outputChatBox("Tienes que ser VIP Oro o más para usar este botón",255,0,0,true)
		end
	elseif source == c4Button then
		if VIP == "Diamond" or VIP == "Esmeralda" then
			if isTimer ( c4Timer ) then 
				outputChatBox("Espera un poco...", 255,0,0)
			else
				triggerServerEvent("setC4",getLocalPlayer())
				c4Timer = setTimer(function() end, 60000,1)
			end
		else
			outputChatBox("Debes tener VIP Diamond o Esmeralda para usar esta función.",255,0,0)
		end
	elseif source == vidaButton then
		if not(isTimer(healthTimer)) then
			if VIP=="Esmeralda" then
				remaningH=180000
			elseif VIP=="Gold" or VIP=="Diamond" then
				remaningH=250000
			elseif not(VIP=="None") then
				remaningH=300000
			end
			triggerServerEvent("setHealth",getLocalPlayer())
			healthTimer = setTimer( function() end, remaningH, 1)
		else 
			local remaining, executesRemaining, timeInterval = getTimerDetails(healthTimer) -- Get the timers details
			outputChatBox("Vuelve a ponerte vida en: "..(remaining/1000).."segundos",255,0,0,false)
		end
	elseif source == chalecoButton then
	
		if not(isTimer(armourTimer)) then
			if VIP=="Esmeralda" then
				remaningA=180000
			elseif not(VIP=="None") then
				remaningA=300000
			end
			triggerServerEvent("setArmour",getLocalPlayer())
			armourTimer = setTimer ( function() end, remaningA, 1 )
		else 
			local remaining, executesRemaining, timeInterval = getTimerDetails(armourTimer) -- Get the timers details
			outputChatBox("Vuelve a ponerte chaleco en: "..(remaining/1000).." segundos",255,0,0,false)
		end
	elseif source == infernusButton then
		triggerServerEvent("giveVehicle", getLocalPlayer(), 411,"spawn")
	elseif source == pmaverickButton then
		triggerServerEvent("giveVehicle", getLocalPlayer(), 497,"spawn")
	elseif source == vortexButton then
		triggerServerEvent("giveVehicle", getLocalPlayer(), 539,"spawn")
	elseif source == rainbowButton then
		if isTimer(rainbowTimer) then
			killTimer(rainbowTimer)
		else
		rainbowTimer = setTimer( function () 
			triggerServerEvent("giveVehicle", getLocalPlayer(),0,"rainbow")
			end, 3000, 3000)
		end
	elseif source == buttonBattleStyle then
		if guiGetVisible(fightGui) then
			guiSetVisible(fightGui,false)
		else
			guiSetVisible(fightGui, true)
		end
	elseif source == updateFightBtn then
		if isTimer( fighTimer) then
			outputChatBox("Espera un poco...",255,0,0)
		else
			if guiRadioButtonGetSelected( defaultRadio) then
				triggerServerEvent("updateFight",getLocalPlayer(), 4)
			elseif guiRadioButtonGetSelected( boxingRadio) then
				triggerServerEvent("updateFight",getLocalPlayer(), 5)
			elseif guiRadioButtonGetSelected( kungfuRadio) then
				triggerServerEvent("updateFight",getLocalPlayer(), 6)
			elseif guiRadioButtonGetSelected( kneeRadio) then
				triggerServerEvent("updateFight",getLocalPlayer(), 7)
			elseif guiRadioButtonGetSelected( grabRadio) then
				triggerServerEvent("updateFight",getLocalPlayer(), 15)
			elseif guiRadioButtonGetSelected( elbowsRadio) then
				triggerServerEvent("updateFight",getLocalPlayer(), 16)
			end
			fighTimer = setTimer(function() end, 3000,1)
		end
	elseif source == buttonCJ then
		if guiGetVisible(mainWindow) then
			guiSetVisible(mainWindow, false)
		else
			guiSetVisible(mainWindow, true)
		end
	elseif source == buttonStats then
		if isTimer( wepTimer ) then
			outputChatBox("Espera un momento...",255,0,0)
		else
			triggerServerEvent("giveStats", getLocalPlayer())
			wepTimer = setTimer(function() end, 3000,1)
		end
	-- Handling options
	elseif source == buttonModLlantas then
		if VIP == "Esmeralda" then
            if getPedOccupiedVehicle(localPlayer) then
			    triggerServerEvent("modHigh",localPlayer,getPedOccupiedVehicle(localPlayer))
            else
                outputChatBox("Tienes que estar en un vehiculo para hacer esto",255,0,0)
            end
        else
            outputChatBox("Tienes que ser VIP Esmeralda para usar esto",255,0,0)
        end
	elseif source == buttonModReset then
        if VIP == "Esmeralda" then
			if getPedOccupiedVehicle(localPlayer) then
        	    triggerServerEvent("modReset",localPlayer,getPedOccupiedVehicle(localPlayer))
			else 
				outputChatBox("Tienes que estar montado en un vehiculo para usar esta opción",255,0,0)
			end
        else
            outputChatBox("Tienes que ser VIP Esmeralda para usar esto",255,0,0)
        end
    elseif source == buttonModHighSpeed then
        if VIP == "Esmeralda" then
			if getPedOccupiedVehicle(localPlayer) then
        	    triggerServerEvent("modSpeed",localPlayer,getPedOccupiedVehicle(localPlayer))
			else 
				outputChatBox("Tienes que estar montado en un vehiculo para usar esta opción",255,0,0)
			end
        else
            outputChatBox("Tienes que ser VIP Esmeralda para usar esto",255,0,0)
        end
	elseif source == buttonMiniHedit then
        if VIP == "Esmeralda" then
			if getPedOccupiedVehicle(localPlayer) then
				if guiGetVisible(miniHandEd) then
					guiSetVisible(miniHandEd, false)
				else
					guiSetVisible(miniHandEd, true)
					loadPanelInfo(getPedOccupiedVehicle(localPlayer))
				end
			else 
				outputChatBox("Tienes que estar montado en un vehiculo para usar esta opción",255,0,0)
			end
        else
            outputChatBox("Tienes que ser VIP Esmeralda para usar esto",255,0,0)
        end
	elseif source == closeButton then
        if VIP == "Esmeralda" then
			guiSetVisible(miniHandEd, false)
        else
            outputChatBox("Tienes que ser VIP Esmeralda para usar esto",255,0,0)
        end
	elseif source == aplicarBoton then
        if VIP == "Esmeralda" then
			if getPedOccupiedVehicle(localPlayer) then
				checkIfApplicable(getPedOccupiedVehicle(localPlayer))
			end
        else
            outputChatBox("Tienes que ser VIP Esmeralda para usar esto",255,0,0)
        end
	elseif source == btnExtraHealth then
		if VIP == "Esmeralda" then
			outputChatBox("Tendrás vida extra por 5 minutos",255,0,0)
			triggerServerEvent("NGVIP:ExtraHealth",localPlayer)
		else
			outputChatBox("Tienes que ser VIP Esmeralda para usar este botón.",150,0,0)
		end
	elseif source == btnRemoveStars then
		if VIP == "Esmeralda" then
			triggerServerEvent("NGVIP:RemoveStars",localPlayer)
		else
			outputChatBox("Tienes que ser VIP Esmeralda para usar este botón",150,0,0)
		end
	end
end
addEventHandler ( "onClientGUIClick", root, clickedButtonCheck )

function loadPanelInfo(veh)
	local hand=getVehicleHandling(veh)
	guiSetText(editTraction,"")
	guiSetText(editLowerSusp,"")
	guiSetText(editHighSusp,"")
	guiSetText(editAccel,"")
	guiSetText(editTractionLoss,"")

	guiSetText(lblTractionActual,"Actualmente tienes: "..hand['tractionMultiplier'])
	guiSetText(lblLowerActual,"Actualmente tienes: "..hand['suspensionLowerLimit'])
	guiSetText(lblHigherActual,"Actualmente tienes: "..hand['suspensionUpperLimit'])
	guiSetText(lblAccelActual,"Actualmente tienes: "..hand['engineAcceleration'])
	guiSetText(lbltractionLoss,"Actualmente tienes: "..hand['tractionLoss'])
end

function checkIfApplicable(veh,plr)
	local hand=getVehicleHandling(veh)
	local traction = 0
	local lowsusp = 0
	local highsusp = 0
	local accel = 0
	local tractionloss = 0
	if guiGetText(editTraction) ~= "" then
		if 0<=tonumber(guiGetText(editTraction)) and tonumber(guiGetText(editTraction))<=5 then
			traction=tonumber(guiGetText(editTraction))
		else
			return outputChatBox("El multiplicador de tracción solo puede estar entre 0 y 5")
		end
	else
		traction=hand['tractionMultiplier']
	end
	if guiGetText(editLowerSusp) ~= "" then
		if -4<=tonumber(guiGetText(editLowerSusp)) and tonumber(guiGetText(editLowerSusp))<=0 then
			lowsusp=tonumber(guiGetText(editLowerSusp))
		else
			return outputChatBox("El límite bajo de suspensión solo puede estar entre -4 y 0")
		end
	else
		lowsusp=hand['suspensionLowerLimit']
	end
	if guiGetText(editHighSusp) ~= "" then
		if 0<=tonumber(guiGetText(editHighSusp)) and tonumber(guiGetText(editHighSusp))<=2 then
			highsusp=tonumber(guiGetText(editHighSusp))
		else
			return outputChatBox("El límite alto de suspensión solo puede estar entre 0 y 2")
		end
	else
		highsusp=hand['suspensionUpperLimit']
	end
	if guiGetText(editAccel) ~= "" then
		if 0<=tonumber(guiGetText(editAccel)) and tonumber(guiGetText(editAccel))<=40 then
			accel=tonumber(guiGetText(editAccel))
		else
			return outputChatBox("La aceleración solo puede estar entre 0 y 40")
		end
	else
		accel=hand['engineAcceleration']
	end
	if guiGetText(editTractionLoss) ~= "" then
		if 0<=tonumber(guiGetText(editTractionLoss)) and tonumber(guiGetText(editTractionLoss))<=2 then
			tractionloss=tonumber(guiGetText(editTractionLoss))
		else
			return outputChatBox("La pérdida de tracción solo puede estar entre 0 y 2")
		end
	else
		tractionloss=hand['tractionLoss']
	end
	triggerServerEvent("handleMiniH",localPlayer,veh,traction,lowsusp,highsusp,accel,tractionloss)
end



function showPanel()
	if getElementData(getLocalPlayer(), "VIP") ~= "None" then
		if guiGetVisible( VipMain) then
			guiSetVisible(VipMain,false) 
			guiSetVisible(fightGui, false)
			guiSetVisible(mainWindow, false)
			guiSetVisible(miniHandEd, false)
			showCursor(false)
		else
			guiSetText(labelNameVIP,"Tienes VIP: "..getElementData(localPlayer,"VIP"))
			guiSetText(labelUntilVIP,"Hasta: "..tostring ( getElementData ( localPlayer, "NGVIP.expDate" ) ))
			guiSetVisible(VipMain, true)
			showCursor(true)
		end
	end
end
bindKey("z", "down", showPanel)

function repairCar()
	if getElementData(getLocalPlayer(), "VIP") ~= "None" then
		if isTimer(fixTimer) then
			outputChatBox("Debes esperar 2 minutos para arreglar tu auto de nuevo.",255,0,0)
		else
			local car = getPedOccupiedVehicle ( getLocalPlayer() )
			if car then
				fixVehicle(car)
				fixTimer = setTimer( function() end, 120000,1)
			end
		end
	end
end
addCommandHandler("repararvip",repairCar)
bindKey("2","down",repairCar)
