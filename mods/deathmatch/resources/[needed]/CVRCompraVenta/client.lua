
local tiempopantallamin = 1.5
local tiempopantalla = tiempopantallamin*60000

addEventHandler("onClientResourceStart", resourceRoot, 
	function (  )
		textos = {}
		id = {}
		textos2 = {}
		id2 = {}
		textos3 = {}
		id3 = {}
		textos4 = {}
		id4 = {}
	end
)

addEventHandler("onClientResourceStop", resourceRoot, 
	function (  )
		textos = false
		id = false
		textos2 = false
		id2 = false
		textos3 = false
		id3 = false
		textos4 = false
		id4 = false
	end
)
local sx, sy = 1280,600
local x, y = guiGetScreenSize ( )
local font2 = dxCreateFont( "img/font2.ttf", ( 15 / sy ) * y )

function joinQuit()
    for _, v in ipairs( textos ) do
		local i = v[1]
		local texto = v[2]
		local ancho = dxGetTextWidth(  texto,  0.70, font2, true )
		local cuenta = ( getTickCount(  ) - textos["tick2_"..tostring(i)] )
		local endTime = textos["tick_"..tostring(i)] + 1000
		local elapsedTime = getTickCount() - textos["tick_"..tostring(i)]
		local duration = endTime - textos["tick_"..tostring(i)]
		local progress = elapsedTime / duration
		local xe, x2, ae = interpolateBetween ( 0, 0, 0, ancho+3, ancho+3, 255, progress, "OutQuad")
		local alp = 0
		textos["rectangle_"..tostring(i)], textos["text_"..tostring(i)], alp =  xe , x2 , ae
		if cuenta >= 2500 then
            alp = 0
            local newcount = math.floor( ( cuenta / 10  ) - 250 )
            if newcount <= 100 then
                textos["texty_"..tostring(i)] = newcount
            end
            if newcount <= 100 then
                textos["rectangley_"..tostring(i)] = newcount
            end
            local newcounts = math.floor( ( ( cuenta / 10 ) - 250 ) * 2.5 )
            if newcounts <= 250 then
                textos["alpha_"..tostring(i)]  = newcounts
            end
            if newcounts >= 240 then
                textos["alpha_"..tostring(i)] = 250
                table.remove( textos, 1 )
            end    
        end
		if 200 - textos["alpha_"..tostring(i)]  - 175 > 0 then
        	dxDrawRectangle(  x - textos["rectangle_"..tostring(i)], ( ( 380 -textos["rectangley_"..tostring(i)]) / sy ) * y , ( 165+ancho / sx ) * x, ( 16 / sy ) * y, tocolor(0, 0, 0, 250 -( textos["alpha_"..tostring(i)]  - 175 ) ), false)
		end
		if 200 -textos["alpha_"..tostring(i)] > 0 then
			dxDrawText(texto, x - textos["text_"..tostring(i)]  , ( ( 380 -textos["texty_"..tostring(i)] ) / sy ) * y , ( 500 / sx ) * x, ( 315 / sy ) * y,          tocolor(255, 255, 255, 200 -textos["alpha_"..tostring(i)] ), 0.60, font2, "left", "top", false, false, false, true, false)
		end 
    end
	
end
addEventHandler("onClientRender", root, joinQuit )

function joinQuit2()
    for _, v in ipairs( textos2 ) do
		local i = v[1]
		local texto = v[2]
		local ancho = dxGetTextWidth(  texto,  0.70, font2, true )
		local cuenta = ( getTickCount(  ) - textos2["tick2_"..tostring(i)] )
		local endTime = textos2["tick_"..tostring(i)] + 1000
		local elapsedTime = getTickCount() - textos2["tick_"..tostring(i)]
		local duration = endTime - textos2["tick_"..tostring(i)]
		local progress = elapsedTime / duration
		local xe, x2, ae = interpolateBetween ( 0, 0, 0, ancho+3, ancho+3, 255, progress, "OutQuad")
		local alp = 0
		textos2["rectangle_"..tostring(i)], textos2["text_"..tostring(i)], alp =  xe , x2 , ae
		if cuenta >= 2500 then
            alp = 0
            local newcount = math.floor( ( cuenta / 10  ) - 250 )
            if newcount <= 100 then
                textos2["texty_"..tostring(i)] = newcount
            end
            if newcount <= 100 then
                textos2["rectangley_"..tostring(i)] = newcount
            end
            local newcounts = math.floor( ( ( cuenta / 10 ) - 250 ) * 2.5 )
            if newcounts <= 250 then
                textos2["alpha_"..tostring(i)]  = newcounts
            end
            if newcounts >= 240 then
                textos2["alpha_"..tostring(i)] = 250
                table.remove( textos2, 1 )
            end    
        end
        if 200 - textos2["alpha_"..tostring(i)]  - 175 > 0 then
        	dxDrawRectangle(  x - textos2["rectangle_"..tostring(i)], ( ( 405 -textos2["rectangley_"..tostring(i)]) / sy ) * y , ( 165+ancho / sx ) * x, ( 16 / sy ) * y, tocolor(0, 0, 0, 275 -( textos2["alpha_"..tostring(i)]  - 175 ) ), false)
		end
		if 200 -textos2["alpha_"..tostring(i)] > 0 then
			dxDrawText(texto, x - textos2["text_"..tostring(i)]  , ( ( 405-textos2["texty_"..tostring(i)] ) / sy ) * y , ( 500 / sx ) * x, ( 315 / sy ) * y,          tocolor(255, 255, 255, 200 -textos2["alpha_"..tostring(i)] ), 0.60, font2, "left", "top", false, false, false, true, false)
		end 

    end
	
end
addEventHandler("onClientRender", root, joinQuit2 )

function joinQuit3()
    for _, v in ipairs( textos3 ) do
		local i = v[1]
		local texto = v[2]
		local ancho = dxGetTextWidth(  texto,  0.70, font2, true )
		local cuenta = ( getTickCount(  ) - textos3["tick2_"..tostring(i)] )
		local endTime = textos3["tick_"..tostring(i)] + 1000
		local elapsedTime = getTickCount() - textos3["tick_"..tostring(i)]
		local duration = endTime - textos3["tick_"..tostring(i)]
		local progress = elapsedTime / duration
		local xe, x2, ae = interpolateBetween ( 0, 0, 0, ancho+3, ancho+3, 255, progress, "OutQuad")
		local alp = 0
		textos3["rectangle_"..tostring(i)], textos3["text_"..tostring(i)], alp =  xe , x2 , ae
		if cuenta >= 2500 then
            alp = 0
            local newcount = math.floor( ( cuenta / 10  ) - 250 )
            if newcount <= 100 then
                textos3["texty_"..tostring(i)] = newcount
            end
            if newcount <= 100 then
                textos3["rectangley_"..tostring(i)] = newcount
            end
            local newcounts = math.floor( ( ( cuenta / 10 ) - 250 ) * 2.5 )
            if newcounts <= 250 then
                textos3["alpha_"..tostring(i)]  = newcounts
            end
            if newcounts >= 240 then
                textos3["alpha_"..tostring(i)] = 250
                table.remove( textos3, 1 )
            end    
        end

		if 200 - textos3["alpha_"..tostring(i)]  - 175 > 0 then
        	dxDrawRectangle(  x - textos3["rectangle_"..tostring(i)], ( ( 430 -textos3["rectangley_"..tostring(i)]) / sy ) * y , ( 165+ancho / sx ) * x, ( 16 / sy ) * y, tocolor(0, 0, 0, 275 -( textos3["alpha_"..tostring(i)]  - 175 ) ), false)
		end
		if 200 -textos3["alpha_"..tostring(i)] > 0 then
			dxDrawText(texto, x - textos3["text_"..tostring(i)]  , ( ( 430-textos3["texty_"..tostring(i)] ) / sy ) * y , ( 500 / sx ) * x, ( 315 / sy ) * y,          tocolor(255, 255, 255, 200 -textos3["alpha_"..tostring(i)] ), 0.60, font2, "left", "top", false, false, false, true, false)
		end 

    end
	
end
addEventHandler("onClientRender", root, joinQuit3 )

function joinQuit4()
    for _, v in ipairs( textos4 ) do
		local i = v[1]
		local texto = v[2]
		local ancho = dxGetTextWidth(  texto,  0.70, font2, true )
		local cuenta = ( getTickCount(  ) - textos4["tick2_"..tostring(i)] )
		local endTime = textos4["tick_"..tostring(i)] + 1000
		local elapsedTime = getTickCount() - textos4["tick_"..tostring(i)]
		local duration = endTime - textos4["tick_"..tostring(i)]
		local progress = elapsedTime / duration
		local xe, x2, ae = interpolateBetween ( 0, 0, 0, ancho+3, ancho+3, 255, progress, "OutQuad")
		local alp = 0
		textos4["rectangle_"..tostring(i)], textos4["text_"..tostring(i)], alp =  xe , x2 , ae
		if cuenta >= 2500 then
            alp = 0
            local newcount = math.floor( ( cuenta / 10  ) - 250 )
            if newcount <= 100 then
                textos4["texty_"..tostring(i)] = newcount
            end
            if newcount <= 100 then
                textos4["rectangley_"..tostring(i)] = newcount
            end
            local newcounts = math.floor( ( ( cuenta / 10 ) - 250 ) * 2.5 )
            if newcounts <= 250 then
                textos4["alpha_"..tostring(i)]  = newcounts
            end
            if newcounts >= 240 then
                textos4["alpha_"..tostring(i)] = 250
                table.remove( textos4, 1 )
            end    
        end

		if 200 - textos4["alpha_"..tostring(i)]  - 175 > 0 then
        	dxDrawRectangle(  x - textos4["rectangle_"..tostring(i)], ( ( 455 -textos4["rectangley_"..tostring(i)]) / sy ) * y , ( 165+ancho / sx ) * x, ( 16 / sy ) * y, tocolor(0, 0, 0, 275 -( textos4["alpha_"..tostring(i)]  - 175 ) ), false)
		end
		if 200 -textos4["alpha_"..tostring(i)] > 0 then
			dxDrawText(texto, x - textos4["text_"..tostring(i)]  , ( ( 455-textos4["texty_"..tostring(i)] ) / sy ) * y , ( 500 / sx ) * x, ( 315 / sy ) * y,          tocolor(255, 255, 255, 200 -textos4["alpha_"..tostring(i)] ), 0.60, font2, "left", "top", false, false, false, true, false)
		end 

    end
	
end
addEventHandler("onClientRender", root, joinQuit4 )
     
function outputBarraMensaje( msj )
	if not textos then
		textos = {}
	end
	if not id then
		id = {}
	end
	textos["tick2_"..tostring(#id+1)] = getTickCount(  ) + tiempopantalla
	textos["tick_"..tostring(#id+1)] = getTickCount(  )
	textos["rectangle_"..tostring(#id+1)] = 0
	textos["text_"..tostring(#id+1)] = 0
	textos["rectangley_"..tostring(#id+1)] = 0
	textos["texty_"..tostring(#id+1)] = 0
	textos["alpha_"..tostring(#id+1)] = 0
	table.insert( textos, { #id+1, tostring( msj ) })
	table.insert( id, { #id+1 })

end
addEvent("msJoin", true)
addEventHandler("msJoin", getLocalPlayer(  ), outputBarraMensaje )

function outputBarraMensaje2( msj2 )
	if not textos2 then
		textos2 = {}
	end
	if not id2 then
		id2 = {}
	end
	textos2["tick2_"..tostring(#id2+1)] = getTickCount(  ) + tiempopantalla
	textos2["tick_"..tostring(#id2+1)] = getTickCount(  )
	textos2["rectangle_"..tostring(#id2+1)] = 0
	textos2["text_"..tostring(#id2+1)] = 0
	textos2["rectangley_"..tostring(#id2+1)] = 0
	textos2["texty_"..tostring(#id2+1)] = 0
	textos2["alpha_"..tostring(#id2+1)] = 0
	table.insert( textos2, { #id2+1, tostring( msj2 ) })
	table.insert( id2, { #id2+1 })
end
addEvent("msJoin2", true)
addEventHandler("msJoin2", getLocalPlayer(  ), outputBarraMensaje2 )

function outputBarraMensaje3( msj3 )
	if not textos3 then
		textos3 = {}
	end
	if not id3 then
		id3 = {}
	end
	textos3["tick2_"..tostring(#id3+1)] = getTickCount(  ) + tiempopantalla
	textos3["tick_"..tostring(#id3+1)] = getTickCount(  )
	textos3["rectangle_"..tostring(#id3+1)] = 0
	textos3["text_"..tostring(#id3+1)] = 0
	textos3["rectangley_"..tostring(#id3+1)] = 0
	textos3["texty_"..tostring(#id3+1)] = 0
	textos3["alpha_"..tostring(#id3+1)] = 0
	table.insert( textos3, { #id3+1, tostring( msj3 ) })
	table.insert( id3, { #id3+1 })

end
addEvent("msJoin3", true)
addEventHandler("msJoin3", getLocalPlayer(  ), outputBarraMensaje3)

function outputBarraMensaje4( msj4 )
	if not textos4 then
		textos4 = {}
	end
	if not id4 then
		id4 = {}
	end
	textos4["tick2_"..tostring(#id4+1)] = getTickCount(  ) + tiempopantalla
	textos4["tick_"..tostring(#id4+1)] = getTickCount(  )
	textos4["rectangle_"..tostring(#id4+1)] = 0
	textos4["text_"..tostring(#id4+1)] = 0
	textos4["rectangley_"..tostring(#id4+1)] = 0
	textos4["texty_"..tostring(#id4+1)] = 0
	textos4["alpha_"..tostring(#id4+1)] = 0
	table.insert( textos4, { #id4+1, tostring( msj4 ) })
	table.insert( id4, { #id4+1 })
end
addEvent("msJoin4", true)
addEventHandler("msJoin4", getLocalPlayer(  ), outputBarraMensaje4 )

--#################### PANEL #################################--
vehicleNames = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perennial", "Sentinel", "Dumper", "Fire Truck", "Trashmaster", "Stretch", "Manana", 
                       "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", 
                       "Mr. Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", 
                       "Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", 
                       "Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", 
                       "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", 
                       "Quadbike", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", 
                       "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring Racer", "Sandking", 
                       "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer 3", "Hotring Racer 2", "Bloodring Banger", 
                       "Rancher Lure", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker", "Roadtrain", "Nebula", 
                       "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Towtruck", "Fortune", "Cadrona", "FBI Truck", 
                       "Willard", "Forklift", "Tractor", "Combine Harvester", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", 
                       "Bullet", "Clover", "Sadler", "Fire Truck Ladder", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility Van", 
                       "Nevada", "Yosemite", "Windsor", "Monster 2", "Monster 3", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", 
                       "Tahoma", "Savanna", "Bandito", "Freight Train Flatbed", "Streak Train Trailer", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", 
                       "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer (Tanker Commando)", "Emperor", "Wayfarer", "Euros", "Hotdog", 
                       "Club", "Box Freight", "Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police LS", "Police", "Police SF", "Police LV", "Police Ranger", 
                       "Ranger", "Picador", "S.W.A.T.", "Alpha", "Phoenix", "Glendale Damaged", "Sadler", "Sadler Damaged", "Baggage Trailer (covered)", 
                       "Baggage Trailer (Uncovered)", "Trailer (Stairs)", "Boxville Mission", "Farm Trailer", "Street Clean Trailer"
}
			

--[[-------------------------------------------------
Notes:
> This code is using a relative image filepath. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move images into your local resource and reference them there.
--]]-------------------------------------------------


function PanelCompraVentaCVR()
	local screenW, screenH = guiGetScreenSize()
	CVMain = guiCreateWindow((screenW - 334) / 2, (screenH - 453) / 2, 334, 453, "Compra-Venta CVR", false)
	guiWindowSetSizable(CVMain, false)
	guiSetAlpha(CVMain, 0.70)
	CVLista = guiCreateGridList(9, 37, 146, 362, false, CVMain)
	guiGridListAddColumn(CVLista, "NOMBRE", 0.9)
	CVEntradaCarro = guiCreateEdit(10, 409, 145, 20, "", false, CVMain)
	CVLogo = guiCreateStaticImage(165, 27, 146, 142, ":CVRCompraVenta/Img/cvrlogo.png", false, CVMain)
	CVcombobox = guiCreateComboBox(163, 198, 141, 72, "", false, CVMain)
	guiSetFont(CVcombobox, "clear-normal")
	guiComboBoxAddItem(CVcombobox, "Compro")
	guiComboBoxAddItem(CVcombobox, "Vendo")
	cVTitulo = guiCreateLabel(165, 181, 129, 17, "Compra | Vende", false, CVMain)
	guiLabelSetHorizontalAlign(cVTitulo, "center", false)
	guiLabelSetVerticalAlign(cVTitulo, "center")
	CVEntradaPrecio = guiCreateEdit(166, 265, 138, 24, "", false, CVMain)
	guiEditSetMaxLength ( CVEntradaPrecio, 9)
	guiSetProperty(CVEntradaPrecio, "ValidationString", "^[0-9]*$")
	cVPrecio = guiCreateLabel(166, 243, 128, 17, "PRECIO", false, CVMain)
	guiLabelSetHorizontalAlign(cVPrecio, "center", false)
	guiLabelSetVerticalAlign(cVPrecio, "center")
	CVBotonPubli = guiCreateButton(174, 342, 120, 51, "PUBLICAR", false, CVMain)
	CVBotonSalir = guiCreateButton(302, 410, 22, 23, "X", false, CVMain)
	guiSetProperty(CVBotonSalir, "NormalTextColour", "FECF0000")
	CVTituloLista = guiCreateLabel(12, 21, 141, 16, "LISTA DE CARROS", false, CVMain)
	guiLabelSetHorizontalAlign(CVTituloLista, "center", false)
	guiLabelSetVerticalAlign(CVTituloLista, "center")
	addEventHandler("onClientGUIChanged",CVEntradaCarro,filtrador)
	for k, v in ipairs(vehicleNames) do
		guiGridListAddRow(CVLista,v)
	end
	addEventHandler("onClientGUIClick",CVBotonPubli,triggerAnunciar,false)
	addEventHandler("onClientGUIClick",CVBotonSalir,CompraVentaCVR,false)
end
function triggerAnunciar (p)
	PrecioCarro = guiGetText( CVEntradaPrecio )
	PrecioCarronumero =tonumber(PrecioCarro)    
	DeseaHacer = guiGetText( CVcombobox ) 
	p,q= guiGridListGetSelectedItem(CVLista)
	NombreCarroSelect = guiGridListGetItemText(CVLista,p,q)
	if PrecioCarronumero ~= "" and DeseaHacer ~= "" and NombreCarroSelect ~= "" then
		triggerServerEvent ( "CrearAnuncio", localPlayer,localPlayer,DeseaHacer,NombreCarroSelect,PrecioCarronumero)
		CompraVentaCVR()
		return
	elseif PrecioCarronumero == "" and DeseaHacer ~= "" and NombreCarroSelect ~= "" then
		triggerServerEvent ( "CrearAnuncio", localPlayer,localPlayer,DeseaHacer,NombreCarroSelect)
		CompraVentaCVR()
		return
	else
		outputChatBox( "#000000|#FFFF00C#0000FFV#FF0000R#000000|#FF0000Anuncios: #FFFFFFRecuerda Seleccionar y llenar todo lo requerido.",250,0,0, true) 
	end
end
function filtrador()
    local text = guiGetText (source)
    if ( text ~= "" ) then
        guiGridListClear ( CVLista )
        for k, v in ipairs ( vehicleNames ) do
            local name = k
            if ( string.find ( string.lower ( v ), string.lower ( text ) ) ) then
                local row = guiGridListAddRow (CVLista,v )
                guiGridListSetItemText ( CVLista, row, 1, v, false, false )
            end
        end
    else
        guiGridListClear (CVLista)
        for k,v in ipairs (vehicleNames) do
            guiGridListAddRow(CVLista,v)
        end
    end
end

function CompraVentaCVR()
    if isElement(CVMain) then
        destroyElement(CVMain)
        showCursor(false)
		--guiSetInputEnabled(false)
		guiSetInputMode ("allow_binds")
    else
        PanelCompraVentaCVR()
        showCursor(true)
		--guiSetInputEnabled(true)
		guiSetInputMode ("no_binds_when_editing")
    end
end
addCommandHandler("anunciar", CompraVentaCVR)