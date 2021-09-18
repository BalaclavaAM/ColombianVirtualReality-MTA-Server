car_fly = false

function enableZorra ( commandName )
	local vehicle = getPedOccupiedVehicle ( localPlayer )
			if getElementModel(vehicle) == 574 then
				if car_fly == false then
					setWorldSpecialPropertyEnabled("aircars", true )
					exports['NGMessages']:sendClientMessage ("Zorra voladora activada",localPlayer,0,255,0)
					car_fly = true
				end
			else	
				exports['NGMessages']:sendClientMessage ("Tienes que estar en una zorra para activar esto",localPlayer,0,255,0)
				exports['NGMessages']:sendClientMessage (vehicle,localPlayer,0,255,0)
			end
end

function disableZorra ( commandName )
	setWorldSpecialPropertyEnabled("aircars", false )
	exports['NGMessages']:sendClientMessage ("Zorra voladora desactivada",localPlayer,0,255,0)
	car_fly = false
end

addEvent( "disableZorra", true )
addEventHandler( "disableZorra", localPlayer, disableZorra )

addCommandHandler("volar", enableZorra )
addCommandHandler("novolar", disableZorra )

function farratime ( nivel )
	if nivel > 0 then
		setCameraShakeLevel( 50+nivel )
	else
		setCameraShakeLevel(50)
		setGameSpeed ( 0.5 )
	end
end

addEvent( "farratime", true )
addEventHandler( "farratime", localPlayer, farratime )

function endfarra()
	setCameraShakeLevel(0)
	setGameSpeed ( 1 )
end
addEvent( "finishfarra", true )
addEventHandler( "finishfarra", localPlayer, endfarra )


--[[-------------------------------------------------
Notes:

> This code is using a relative image filepath. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move images into your local resource and reference them there.
--]]-------------------------------------------------




function crearmenuBalaBot()
        windowBalaBot = guiCreateWindow(0.43, 0.24, 0.18, 0.53, "Menú BalaBot", true)
        guiWindowSetSizable(windowBalaBot, false)
        guiSetAlpha(windowBalaBot, 0.58)

        gridBalaBot = guiCreateGridList(0.08, 0.47, 0.86, 0.38, true, windowBalaBot)
        guiGridListAddColumn(gridBalaBot, "Opción", 0.9)
        for i = 1, 4 do
            guiGridListAddRow(gridBalaBot)
        end
        guiGridListSetItemText(gridBalaBot, 0, 1, "Comprar 1 mes de VIP Bronze (75 Millones)", false, false)
        guiGridListSetItemText(gridBalaBot, 1, 1, "Handlear Hotring Racer 2", false, false)
        guiGridListSetItemText(gridBalaBot, 2, 1, "Handlear Hotring Racer 3", false, false)
        guiGridListSetItemText(gridBalaBot, 3, 1, "¿Cómo puedo ser admin?", false, false)
        btnConfirmar = guiCreateButton(0.34, 0.92, 0.32, 0.06, "Seleccionar", true, windowBalaBot)
        btnSalir = guiCreateButton(0.90, 0.94, 0.07, 0.04, "x", true, windowBalaBot)
        takagiImage = guiCreateStaticImage(0.23, 0.11, 0.50, 0.27, "e.png", true, windowBalaBot)    
end

local pbala = "#717D7E|Dueño|#FF5656BalaclavaAM: #FFFFFF"

function clickBalaBot()
	if source==btnConfirmar then
		local row, column = guiGridListGetSelectedItem  ( gridBalaBot )
        local option = guiGridListGetItemText(gridBalaBot, row, 1)
		if option=="Handlear Hotring Racer 2" then
			triggerServerEvent("NGVehicles->TunearHR2",localPlayer)
		elseif option=="Handlear Hotring Racer 3" then
			triggerServerEvent("NGVehicles->TunearHR3",localPlayer)
		elseif option=="¿Cómo puedo ser admin?" then
			outputChatBox(pbala.."Hola cómo estás. Cada cierto tiempo abrimos postulaciones para ser admin.",255,0,0,true)
			outputChatBox(pbala.."En este momento estas postulaciones no están abiertas y no creo que las abramos pronto",255,0,0,true)
			outputChatBox(pbala.."Recuerda que para ser admin debes ser un usuario antiguo y responsable",255,0,0,true)
			outputChatBox(pbala.."Gracias por jugar en CVR, es un placer para nosotros brindate la mejor experiencia :D",255,0,0,true)
		elseif option=="Comprar 1 mes de VIP Bronze (75 Millones)" then
			triggerServerEvent("NGMisc->CheckIfCanBuyVIP",localPlayer)
		else
			outputChatBox("Selecciona una opción válida para continuar")
		end
	elseif source==btnSalir then
		openBalaBot()
	end
end

function openBalaBot()
    if ( windowBalaBot and isElement ( windowBalaBot ) ) then
        
		removeEventHandler ( "onClientGUIClick", root, clickBalaBot )
		--removeEventHandler ( "onClientGUIChanged", root, onClientGuiChanged )

		destroyElement ( windowBalaBot ) 
		if ( isElement ( takagiImage ) ) then
			destroyElement ( takagiImage )
		end 
        if ( isElement ( gridBalaBot ) ) then
			destroyElement ( gridBalaBot )
		end 
        if ( isElement ( btnConfirmar ))  then
			destroyElement ( btnConfirmar )
		end 
        if ( isElement ( btnSalir ) ) then
			destroyElement ( btnSalir )
		end 
		showCursor ( false )
	else
		crearmenuBalaBot ( )
		showCursor(true)
		addEventHandler ( "onClientGUIClick", root, clickBalaBot )
	end
end
addEvent("NGMisc->AbrirBalaBot",true)
addEventHandler("NGMisc->AbrirBalaBot",root,openBalaBot)

function cancelPedDamage()
	if getElementModel(source) == 91 then
		cancelEvent() -- Cancels the onClientPedDamage event
	end
end
addEventHandler("onClientPedDamage", root, cancelPedDamage)

imgW = 250
imgH = 125
function adminLogo()
    for i,player in ipairs(getElementsByType("ped",getRootElement(),true)) do
		if getElementModel(player)==91 then
			local cX, cY, cZ = getCameraMatrix()
			local hX, hY, hZ = getPedBonePosition(player, 8)
			hZ = hZ + 0.3
			local pX,pY,pZ = getPedBonePosition(localPlayer, 8)
			pZ = pZ + 0.5
			if getScreenFromWorldPosition(hX, hY, hZ) and isLineOfSightClear(cX,cY,cZ, pX,pY,pZ) then
				local sX, sY, sD = getScreenFromWorldPosition(hX, hY, hZ)
				local relative = (50 - sD) / 50
				if relative > 0 then
					local iW = (imgW * relative)/2
					local iH = (imgH * relative)/2
					local iX = sX - (iW / 2)
					local iY = sY - (iH / 2)

					dxDrawImage(iX, iY, iW, iH, "bala.png")
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, adminLogo)


function pedirArma()
	local arma=getPedWeapon(localPlayer)
	if arma~=0 then
		triggerServerEvent("NGMisc->PedirArma",localPlayer,arma)
	end
end
addCommandHandler("quitararma",pedirArma)


function clickaceptar ( )
    local evento = getElementData(source,"evento")
	local Ventana = getElementData(source,"Ventana")
    if isElement(Ventana) then
        destroyElement(Ventana)
    end
	if evento then
		showCursor( false )
    	triggerServerEvent(evento, localPlayer)
	end
end

function clickcerrar ( )
    local Ventana = getElementData(source,"Ventana")
    if isElement(Ventana) then
        destroyElement(Ventana)
		showCursor( false )
    end
end

function spawnPanel(titulo,desc,evento)
    local ventana,botona,botond = crearPanelgene(titulo,desc)
    setElementData(botona,"evento",evento,false)
	setElementData(botona,"Ventana",ventana,false)
    setElementData(botond,"Ventana",ventana,false)
    addEventHandler("onClientGUIClick",botona,clickaceptar)
    addEventHandler("onClientGUIClick",botond,clickcerrar)
    showCursor( true )
end
addEvent("NGMisc:CreateConfirmPanel",true)
addEventHandler("NGMisc:CreateConfirmPanel",root,spawnPanel)



function crearPanelgene(titulo,desc)
    local sx, sy = guiGetScreenSize ( )
    local rSX, rSY = sx / 1280, sx / 1024
    local CapturaWindow = guiCreateWindow( ( sx / 2 - (rSX*500) / 2 ), (sy-(rSY*230))-rSY*15, rSX*500, rSY*230, titulo, false)
    local CapturaDescription = guiCreateMemo((rSX*10), (rSY*23), (rSX*480), (rSY*150), desc, false, CapturaWindow)
    local CapturaAccept = guiCreateButton((rSX*10), ((rSY*230)-(rSY*25))-rSY*10, (rSX*150), (rSY*25), "Aceptar", false, CapturaWindow)
    local CapturaDeny = guiCreateButton((rSX*170), ((rSY*230)-(rSY*25))-rSY*10, (rSX*150), (rSY*25), "Rechazar", false, CapturaWindow)
    guiWindowSetSizable(CapturaWindow, false)
    guiWindowSetMovable ( CapturaWindow, false )
    guiSetFont(CapturaDeny, "default-bold-small")
    guiSetFont(CapturaAccept, "default-bold-small")
    guiMemoSetReadOnly ( CapturaDescription, true )
    return CapturaWindow,CapturaAccept,CapturaDeny
end


local advertencias = 0
function kickPing()
	local x,y,z = getElementPosition(localPlayer)
	if ((getElementData(localPlayer,"Job")=="Police Officer" or getElementData(localPlayer,"Job")=="Criminal") and getPlayerPing(localPlayer)>=300) or (getElementData(localPlayer,"Job")=="UnEmployed" and getZoneName(x,y,z,true)=="San Fierro" and getPlayerPing(localPlayer)>=300) then
		if advertencias<3 then
			advertencias=advertencias+1
			outputChatBox("|CVR|".."Amigo, tu ping es muy inestable. No puedes ser "..getElementData(localPlayer,"Job").." con este ping advertencia "..advertencias.."/3.",255,0,0)
		else
			triggerServerEvent("NGmisc:kickServer",localPlayer,"Has sido kickeado por ping alto siendo policía o criminal. O turfeando.")
		end
	end
end
setTimer(kickPing, 10000, 0)