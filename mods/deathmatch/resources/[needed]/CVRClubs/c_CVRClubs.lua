local prefix = "#646464[#FFF700C#0042FFV#8A0202R#646464]#FFFFFF"
local sisasnt = ""

local tag2=""
local nameclub2=""

function createMainPanel()
    --exports.ngmessages:sendClientMessage ( "Cargando el panel, espere...", 255, 255, 0 );

    mainWindow = guiCreateWindow(0.40, 0.17, 0.23, 0.63, "Club Drift CVR", true)
    guiWindowSetSizable(mainWindow, false)

    imagePanel = guiCreateStaticImage(0.03, 0.06, 0.94, 0.34, "cvrdrift.png", true, mainWindow)
    crearClub = guiCreateButton(0.03, 0.41, 0.27, 0.05, "Crear Club", true, mainWindow)
    borrarClub = guiCreateButton(0.37, 0.41, 0.27, 0.05, "Borrar Club", true, mainWindow)
    listaMiembros = guiCreateGridList(0.03, 0.49, 0.37, 0.41, true, mainWindow)
    guiGridListAddColumn ( listaMiembros, "Miembro", 1.2 )
    guiGridListAddColumn ( listaMiembros, "Rango", 1.2 )

    scrollBar = guiCreateScrollBar(0.86, 0.02, 0.14, 0.95, false, true, listaMiembros)

    searchText = guiCreateEdit(0.05, 0.91, 0.36, 0.04, "", true, mainWindow)
    guiSetProperty(searchText, "NormalTextColour", "FF464646")
    chgTag = guiCreateButton(0.69, 0.41, 0.27, 0.05, "Cambiar Tag", true, mainWindow)
    sacarMiembro = guiCreateButton(0.42, 0.91, 0.19, 0.04, "Sacar", true, mainWindow)
    darLider = guiCreateButton(0.42, 0.85, 0.19, 0.04, "Dar Líder", true, mainWindow)
    labelInfo = guiCreateLabel(0.47, 0.50, 0.47, 0.08, "Tu Club:", true, mainWindow)
    labelMiembros = guiCreateLabel(0.47, 0.55, 0.47, 0.04, "Miembros:", true, mainWindow)
    labelPoints = guiCreateLabel(0.47, 0.575, 0.47, 0.04, "Puntos CR:", true, mainWindow)
    informativeLabel = guiCreateLabel(0.05, 0.95, 0.92, 0.03, "Usa /darclub para añadir a alguien a tu club. ", true, mainWindow)
    informationLabel2 = guiCreateLabel(0.46, 0.75, 0.50, 0.07, "Usa /chatclub para hablar\n por tu club.", true, mainWindow)
    closePanel = guiCreateButton(0.89, 0.93, 0.08, 0.05, "x", true, mainWindow)
    exitClub = guiCreateButton(0.64, 0.85, 0.19, 0.04, "Salir Club", true, mainWindow)    
    showCursor(true)
    addEventHandler ( "onClientGUIClick", root, clickMainPanel )
    addEventHandler ( "onClientGUIChanged", searchText, filtrador)
    if getElementData(localPlayer,"Club Rank")=="Miembro" then
        guiSetEnabled(crearClub,false)
        guiSetEnabled(borrarClub,false)
        guiSetEnabled(chgTag,false)
        guiSetEnabled(darLider,false)
        guiSetEnabled(closePanel,false)
    end
    if getElementData(localPlayer,"Club Rank")=="Lider" then
        guiSetEnabled(crearClub,false)
        guiSetEnabled(borrarClub,false)
    end
    if getElementData(localPlayer,"Club Rank")=="Creador" then
        guiSetEnabled(crearClub,false)
        guiSetEnabled(exitClub,false)
    end
    if getElementData(localPlayer,"Club") then
        guiSetText(labelInfo,guiGetText(labelInfo).." \n"..getElementData(localPlayer,"Club"))
    end
    rr,gg,bb = 255,255,255
end

function rankGive(bool)
    if bool then
        local row, column = guiGridListGetSelectedItem  ( listaMiembros )
        local member = guiGridListGetItemText(listaMiembros, row, 1)
        triggerServerEvent("CVRClubs->updateLeader",localPlayer,member)
    end
end



function createGang()
    triggerServerEvent("CVRClub->CreateClub",localPlayer,nameclub2,tag2,rr,gg,bb)
    tag2=""
    nameclub2=""
end

function updateTag()
    triggerServerEvent("CVRClubs->updateTag",localPlayer,tag2,rr,gg,bb)
    tag2=""
end

function exitgang()
    triggerServerEvent("CVRClubs->exitGang",localPlayer)
end

function forceKick()
    local row, column = guiGridListGetSelectedItem  ( listaMiembros )
    local member = guiGridListGetItemText(listaMiembros, row, 1)
    triggerServerEvent("CVRClubs->kickGang",localPlayer,member)
end


function clickConfirmButton()
    if source == botonSisas then
        if sisasnt=="RankConfirm" then
            rankGive(true)
            onOpenConfirmar()
        elseif sisasnt=="createclub" then
            onOpenConfirmar()
            createGang()
        elseif sisasnt=="erasegang" then
            onOpenConfirmar()
            triggerServerEvent("CVRClub->DeleteClub",localPlayer)
        elseif sisasnt=="editag" then
            onOpenConfirmar()
            updateTag()
        elseif sisasnt=="exitgang" then
            exitgang()
            onOpenConfirmar()
        elseif sisasnt=="kick" then
            forceKick()
            onOpenConfirmar()
        end
    elseif source == botonNocas then
        if sisasnt=="RankConfirm" then
            onOpenConfirmar()
        end
        if sisasnt=="createclub" then
            onOpenConfirmar()
        end
        if sisasnt=="erasegang" then
            onOpenConfirmar()
        end
        if sisasnt=="editag" then
            onOpenConfirmar()
        elseif sisasnt=="exitgang" then
            onOpenConfirmar()
        elseif sisasnt=="kick" then
            onOpenConfirmar()
        end
    end
    sisasnt=""
end


function createConfirmar()
    confirmarWindow = guiCreateWindow(0.43, 0.39, 0.14, 0.11, "Confirmar", true)
    guiWindowSetSizable(confirmarWindow, false)

    botonSisas = guiCreateButton(0.05, 0.45, 0.42, 0.34, "Sisas", true, confirmarWindow)
    guiSetProperty(botonSisas, "NormalTextColour", "FF079D00")
    botonNocas = guiCreateButton(0.53, 0.45, 0.42, 0.34, "Nonas", true, confirmarWindow)
    guiSetProperty(botonNocas, "NormalTextColour", "FF9C0003")  
    addEventHandler ( "onClientGUIClick", root, clickConfirmButton )  
    showCursor(true)
end

function onOpenConfirmar()
    if ( confirmarWindow and isElement ( confirmarWindow ) ) then
        
		removeEventHandler ( "onClientGUIClick", root, clickConfirmButton )
		--removeEventHandler ( "onClientGUIChanged", root, onClientGuiChanged )

		destroyElement ( confirmarWindow ) 
		if ( isElement ( botonSisas ) ) then
			destroyElement ( botonSisas )
		end 
        if ( isElement ( botonNocas ) ) then
			destroyElement ( botonNocas )
		end
	else
		createConfirmar ( )
	end

end


function clickMainPanel()
    if source == crearClub then
        onOpenCreatePanel()
    elseif source == borrarClub then
        if getElementData(localPlayer,"Club Rank")=="Creador" then
            sisasnt="erasegang"
            onOpenConfirmar()
        end
    elseif source == chgTag then
        onOpenChangeTag()
    elseif source == sacarMiembro then
        sisasnt="kick"
        onOpenConfirmar()
    elseif source == darLider then
        if getElementData(localPlayer,"Club Rank") == "Lider" or getElementData(localPlayer,"Club Rank") == "Creador" then
            if guiGridListGetSelectedItem  (listaMiembros)>0 then
                onOpenConfirmar()
                sisasnt="RankConfirm"
            else
                outputChatBox(prefix.."Selecciona primero un miembro.",255,0,0,true)
            end
        else
            outputChatBox(prefix.."Tienes que ser líder de la gang para acceder a esto.",0,0,0,true)
        end
    elseif source == exitClub then
        sisasnt="exitgang"
        onOpenConfirmar()
    elseif source == closePanel then
        onOpenClubPanel()
    end
end

function onOpenClubPanel()
    if ( mainWindow and isElement ( mainWindow ) ) then
        
		removeEventHandler ( "onClientGUIClick", root, clickMainPanel )
        removeEventHandler ( "onClientGUIChanged", searchText, filtrador)
		--removeEventHandler ( "onClientGUIChanged", root, onClientGuiChanged )

		destroyElement ( mainWindow ) 
		if ( isElement ( imagePanel ) ) then
			destroyElement ( imagePanel )
		end 
        if ( isElement ( crearClub ) ) then
			destroyElement ( crearClub )
		end 
        if ( isElement ( borrarClub ))  then
			destroyElement ( borrarClub )
		end 
        if ( isElement ( listaMiembros ) ) then
			destroyElement ( listaMiembros )
		end 
        if ( isElement ( scrollBar ) ) then
			destroyElement ( scrollBar )
		end 
        if ( isElement ( searchText ) ) then
			destroyElement ( searchText )
		end 
        if ( isElement ( chgTag ) ) then
			destroyElement ( chgTag )
		end 
        if ( isElement ( sacarMiembro ) ) then
			destroyElement ( sacarMiembro )
		end 
        if ( isElement ( darLider ) ) then
			destroyElement ( darLider )
		end 
        if ( isElement ( labelInfo ) ) then
			destroyElement ( labelInfo )
		end 
        if ( isElement ( labelMiembros ) ) then
			destroyElement( labelMiembros )
		end 
        if ( isElement ( labelPoints )) then
            destroyElement( labelPoints )
        end
        if ( isElement ( informativeLabel ) ) then
			destroyElement ( informativeLabel )
		end 
        if ( isElement ( informationLabel2 ) ) then
			destroyElement ( informationLabel2 )
		end 
        if ( isElement ( closePanel ) ) then 
			destroyElement ( closePanel )
		end 
        if ( isElement ( exitClub ) ) then 
			destroyElement ( exitClub )
		end

		showCursor ( false )

        if ( createClubWindow and isElement ( createClubWindow ) ) then
            onOpenCreatePanel()
        end
        if ( confirmarWindow and isElement ( confirmarWindow )) then
            onOpenConfirmar()
        end
        if ( windowChangeTag and isElement(windowChangeTag)) then
            onOpenChangeTag()
        end
	else
        
		group = getElementData ( localPlayer, "Club" ) or nil
		rank = getElementData ( localPlayer, "isClubLeader" ) or nil

		if ( tostring ( group ):lower ( ) == "none" ) then
			group = nil
			rank = nil
		end

		createMainPanel ( )

        if getElementData(localPlayer,"Club") then
            triggerServerEvent("CVRClubs->requestFeed",localPlayer,getElementData(localPlayer,"Club"))
        end

	end

end

addCommandHandler("club", onOpenClubPanel )
local listownmembers=false


function feedPanel(query,puntaje)
    local ownrank = getElementData(localPlayer,"Club Rank")
    listownmembers=query
    if guiGetText(searchText) == "" then
        guiGridListClear(listaMiembros)
        for k,v in ipairs(query) do
            guiGridListAddRow(listaMiembros,v['Member'],v['Rank'])
        end
        guiSetText(labelMiembros,"Miembros:"..guiGridListGetRowCount ( listaMiembros ))
        guiSetText(labelPoints,"Puntos CR:"..puntaje)
    end
end
addEvent("CVRClubs->feedTheClient",true)
addEventHandler("CVRClubs->feedTheClient",root,feedPanel)


function onOpenCreatePanel()
    if ( createClubWindow and isElement ( createClubWindow ) ) then
        
		removeEventHandler ( "onClientGUIClick", root, clickCreatePanel )

		destroyElement ( createClubWindow ) 
		if ( isElement ( buttonCreateClub ) ) then
			destroyElement ( buttonCreateClub )
		end 
        if ( isElement ( labelTag ) ) then
			destroyElement ( labelTag )
		end
        if ( isElement ( lblnombreClub ) ) then
			destroyElement ( lblnombreClub )
		end
        if ( isElement ( nombreClubEdit ) ) then
			destroyElement ( nombreClubEdit )
		end
        if ( isElement ( tagClubEdit ) ) then
			destroyElement ( tagClubEdit )
		end
	else
		createClub()
	end

end

function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end

addEvent ( "onColorPickerOK", true )
addEventHandler ( "onColorPickerOK", root, function ( id, _, r, g, b )
	if ( id == "ClubColorPicker" ) then
		rr=r
		gg=g
		bb=b
        outputChatBox(prefix.."Color de club cambiado a: "..RGBToHex(r,g,b).."Club",255,0,0,true)
    end
end )


function clickCreatePanel()
    if source == buttonCreateClub then
        local nameclub = guiGetText(nombreClubEdit)
        local tag = guiGetText(tagClubEdit)
        if tag~="" and nameclub~="" then
            sisasnt="createclub"
            tag2=tag
            nameclub2=nameclub
            onOpenConfirmar()
            onOpenCreatePanel()
        else
            outputChatBox(prefix.."Llena todos los campos antes de continuar.",255,0,0,true)
        end
    elseif source==chgcolor then
        exports.cpicker:openPicker ( "ClubColorPicker", { 
			r=rr,
			g=gg,
			b=bb,
			a=255
		}, "Seleccionar Color Club" )
    end
end

function filtrador()
    local text = guiGetText ( source )
    if getElementData(localPlayer,"Club") then
        triggerServerEvent("CVRClubs->requestFeed",localPlayer,getElementData(localPlayer,"Club"))
    end
    if ( text ~= "" ) then
        guiGridListClear ( listaMiembros )
        for i, v in ipairs ( listownmembers ) do
            local name = tostring ( v['Member'] )
            if ( string.find ( string.lower ( name ), string.lower ( text ) ) and v ~= localPlayer ) then
                local row = guiGridListAddRow ( listaMiembros,v['Member'],v['Rank'] )
                guiGridListSetItemText ( listaMiembros, row, 1, name, false, false )
            end
        end
    end
end
function createClub()
    createClubWindow = guiCreateWindow(0.43, 0.34, 0.15, 0.31, "Crear Club", true)
    guiWindowSetSizable(createClubWindow, false)

    buttonCreateClub = guiCreateButton(0.25, 0.61, 0.47, 0.11, "Crear Club", true, createClubWindow)
    labelTag = guiCreateLabel(0.09, 0.13, 0.94, 0.11, "TAG (Máximo 4 carácteres)", true, createClubWindow)
    lblnombreClub = guiCreateLabel(0.09, 0.40, 0.90, 0.11, "Nombre de Club", true, createClubWindow)
    nombreClubEdit = guiCreateEdit(0.08, 0.47, 0.83, 0.10, "", true, createClubWindow)
    guiEditSetMaxLength(nombreClubEdit, 20)
    tagClubEdit = guiCreateEdit(0.08, 0.22, 0.83, 0.10, "", true, createClubWindow)
    guiEditSetMaxLength(tagClubEdit, 4)
    chgcolor = guiCreateButton(0.25, 0.76, 0.47, 0.11, "Colores", true, createClubWindow)   
    addEventHandler ( "onClientGUIClick", root, clickCreatePanel ) 
end

function onOpenChangeTag()
    if ( windowChangeTag and isElement ( windowChangeTag ) ) then
        
		removeEventHandler ( "onClientGUIClick", root, clickChangeTAG )

		destroyElement ( windowChangeTag ) 
		if ( isElement ( editTextTAG ) ) then
			destroyElement ( editTextTAG )
		end 
        if ( isElement ( buttonChangeTag ) ) then
			destroyElement ( buttonChangeTag )
		end
        if ( isElement ( colorbutton ) ) then
			destroyElement ( colorbutton )
		end
	else
		createChangeTAG()
	end

end

function clickChangeTAG()
    if source == buttonChangeTag then
        local tag = guiGetText(editTextTAG)
        if tag~="" then
            sisasnt="editag"
            tag2=tag
            onOpenConfirmar()
            onOpenChangeTag()
        else
            outputChatBox(prefix.."Llena todos los campos antes de continuar.",255,0,0,true)
        end
    elseif source==colorbutton then
        exports.cpicker:openPicker ( "ClubColorPicker", { 
			r=rr,
			g=gg,
			b=bb,
			a=255
		}, "Seleccionar Color Club" )
    end
end


function createChangeTAG()
    windowChangeTag = guiCreateWindow(0.44, 0.39, 0.12, 0.18, "Cambiar Club Tag", true)
    guiWindowSetSizable(windowChangeTag, false)

    editTextTAG = guiCreateEdit(0.12, 0.19, 0.78, 0.17, "", true, windowChangeTag)
    guiEditSetMaxLength(editTextTAG, 4)
    buttonChangeTag = guiCreateButton(0.28, 0.53, 0.42, 0.18, "Cambiar", true, windowChangeTag)
    colorbutton = guiCreateButton(0.28, 0.75, 0.42, 0.18, "Colores", true, windowChangeTag)    
    addEventHandler ( "onClientGUIClick", root, clickChangeTAG ) 
end
