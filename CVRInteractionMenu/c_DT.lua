DGS = exports.dgs

local botones = {}

local botonesOcultados = {}

local buttonInfo = {}

local Ventana = false

function RefreshPos ()
    local x,y,z = getElementPosition( localPlayer )
	DGS:dgs3DInterfaceSetPosition ( Ventana, x,y,z+1.35 )
end

function createMainMenu(mainName)
    local x,y,z = getElementPosition( localPlayer )

    Ventana = DGS:dgsCreate3DInterface(x,y,z+1.35,1,1,200,200)

    addEventHandler ( "onClientRender", root, RefreshPos )

    local imagen = DGS:dgsCreateImage(0,0,200,200,"fondo5.png",false,Ventana)

    DGS:dgsCreateLabel(0,5,200,30,mainName, false,Ventana ,tocolor( 255,255,255),1,1,nil,nil,nil,"center","center")

    local labelDown = DGS:dgsCreateLabel  ( 0, 154, 200,30, "▼", false,Ventana ,tocolor(255,255,255),1,1,nil,nil,nil,"center","center")
    addEventHandler ( "onDgsMouseClick", labelDown, makeSlide)

    local labelNone = DGS:dgsCreateLabel  ( 0, 184, 200,30, "", false,Ventana ,tocolor(255,255,255),1,1,nil,nil,nil,"center","center")

    if Ventana then
        return Ventana
    else
        return false
    end
end

function destroyVentana()
    if isElement(Ventana) then
        destroyElement(Ventana)
        removeEventHandler( "onClientRender", root, RefreshPos )
        showCursor( false )
        botones = {}
        botonesOcultados = {}
    end
end

function addButtontoVentana(nameButton,functionHandler)
    if isElement( Ventana ) then
        if #botones==0 then
            table.insert(botones,DGS:dgsCreateButton(2.5,30,195,34,nameButton,false,Ventana))
            buttonInfo[botones[1]]={nameButton,functionHandler}
            addEventHandler ( "onDgsMouseClick", botones[1],functionHandler)
            return botones[1]
        elseif #botones==1 then
            table.insert(botones,DGS:dgsCreateButton(2.5,64,195,30,nameButton,false,Ventana))
            buttonInfo[botones[2]]={nameButton,functionHandler}
            addEventHandler ( "onDgsMouseClick", botones[2],functionHandler)
            return botones[2]
        elseif #botones==2 then
            table.insert(botones,DGS:dgsCreateButton(2.5,94,195,30,nameButton,false,Ventana))
            buttonInfo[botones[3]]={nameButton,functionHandler}
            addEventHandler ( "onDgsMouseClick", botones[3],functionHandler)
            return botones[3]
        elseif #botones==3 then
            table.insert(botones,DGS:dgsCreateButton(2.5,124,195,30,nameButton,false,Ventana))
            buttonInfo[botones[4]]={nameButton,functionHandler}
            addEventHandler ( "onDgsMouseClick", botones[4],functionHandler)
            return botones[4]
        else
            table.insert(botonesOcultados,{nameButton,functionHandler})
        end
    end
end

function makeSlide(b,s)
    if isElement( Ventana ) and s=="up" and #botonesOcultados>0 then
        for k,button in ipairs(botones) do
            table.insert(botonesOcultados,{buttonInfo[button][1],buttonInfo[button][2]})
            destroyElement(button)
        end
        botones={}
        local copiaOcultados = botonesOcultados
        botonesOcultados={} 
        for k,button in ipairs(copiaOcultados) do
            addButtontoVentana(button[1],button[2])
        end
    end
end

function dibujarCedula ( login,nick,vip )
    local Cedula= guiCreateStaticImage( .25, .25, .5, .45, "cedula.png",true)
    if Cedula then
        local login = guiCreateLabel( .15, .35, 1, .2, login, true,Cedula )
        guiLabelSetColor( login, 0, 0, 0 )
        local nick = guiCreateLabel( .15, .5, 1, .2, nick, true,Cedula )
        guiLabelSetColor( nick, 0, 0, 0 )
        local vip = guiCreateLabel( .15, .635, 1, .2, vip, true,Cedula )
        guiLabelSetColor( vip, 0, 0, 0 )
        local estrellas = getPlayerWantedLevel(localPlayer).." Estrellas"
        Estrellas = guiCreateLabel( .61, .875, .35, .1, estrellas, true,Cedula )
        guiLabelSetColor( Estrellas, 0, 0, 0 )
        guiLabelSetHorizontalAlign ( Estrellas,"center")
        salir = guiCreateButton( .93, .03, .055, .07, "", true, Cedula )
        addEventHandler ( "onClientGUIClick",salir,function() destroyElement( Cedula )  end, false )
        guiSetAlpha( salir, 0 )
    end
end
addEvent( "dibujarCedula", true )
addEventHandler( "dibujarCedula", localPlayer, dibujarCedula )


function MicuentaF()
    destroyVentana()
    triggerServerEvent( "HMenu::PCedula", root, localPlayer )
end

function onItemClick(b,s)
    if s == "up" then
        destroyVentana()
        createMainMenu(getPlayerName(localPlayer))
        addButtontoVentana("Volver...",handleBack)
        for k,v in pairs(getItems()) do
            local boton = addButtontoVentana(k.."    "..v,function(b,s) if s=='up' then exports["NGInventory"]:useItem ( k ) end end)
        end
    end
end

function handleBack()
    Personal()
end

function InventarioF(b,s)
    if s=="up" then
        destroyVentana()
        createMainMenu(getPlayerName(localPlayer))
        addButtontoVentana("Volver...",handleBack)
        addButtontoVentana("Vestimenta",function(_,state) if state ~="up" then return end Personal() triggerServerEvent("NGShop>OpenSkinPanel",localPlayer) end)
        addButtontoVentana("Items",onItemClick)
        addButtontoVentana("Drogas",handleBack)
    end
end

function AccionesF(b,s)
    if s == "up" then
        destroyVentana()
        createMainMenu(getPlayerName(localPlayer))
        addButtontoVentana("Volver...",handleBack)
        addButtontoVentana("Modo Pasivo",function(_,state) if state~='up' then return end Personal() exports['CVRModoPasivo']:activarmodo (localPlayer) end)
        addButtontoVentana("Suicidarme",function(_,state) if state~='up' then return end Personal() executeCommandHandler( "kill") end)
        addButtontoVentana("Renunciar",function(_,state) if state~='up' then return end Personal() triggerServerEvent( "HMenu::ComandoServer", root, "resign" ) end)
    end
end

function AyudaF(b,s)
    if s == "up" then
        destroyVentana()
        createMainMenu(getPlayerName(localPlayer))
        addButtontoVentana("Volver...",handleBack)
        addButtontoVentana("General",function(_,state) if state~='up' then return end Personal() showCursor( false ) exports["CVRBrowser"]:AbrirNavegador("https://colombianvirtualreality.com/foro") end)
        addButtontoVentana("Reglas",function(_,state) if state~='up' then return end Personal() showCursor( false ) exports["CVRBrowser"]:AbrirNavegador("https://colombianvirtualreality.com/foro/index.php?/topic/279-reglas-servidor-colombian-virtual-reality/") end)
        addButtontoVentana("Ayuda",function(_,state) if state~='up' then return end Personal() showCursor( false ) exports["CVRBrowser"]:AbrirNavegador("https://colombianvirtualreality.com/foro/index.php?/forum/4-sobre-el-servidor-📚/") end)
    end
end


function Personal ()
    destroyVentana()
    Ventana = createMainMenu(getPlayerName(localPlayer))
    addButtontoVentana("Cédula ►",MicuentaF)
    addButtontoVentana("Inventario ►",InventarioF)
    addButtontoVentana("Acciones ►",AccionesF)
    addButtontoVentana("Foro ►",AyudaF)
end

function Personal2 ()
    if isElement(Ventana) then
        destroyVentana()
    else
        Ventana = createMainMenu(getPlayerName(localPlayer))
        addButtontoVentana("Cédula ►",MicuentaF)
        addButtontoVentana("Inventario ►",InventarioF)
        addButtontoVentana("Acciones ►",AccionesF)
        addButtontoVentana("Foro ►",AyudaF)
    end
end
addEvent( "Personal::Mostrar", true )
addEventHandler( "Personal::Mostrar", localPlayer, Personal2 )



bindKey("i","down", Personal2) 

function getItems()
    local items = getElementData ( localPlayer, "NGUser:Items" )
    return items
end