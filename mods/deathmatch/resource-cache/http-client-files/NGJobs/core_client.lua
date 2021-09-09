localPlayer = getLocalPlayer()

local _guiSetVisible = guiSetVisible
function guiSetVisible ( window, visible )
	--outputChatBox ( tostring ( window )..": "..tostring( visible ) )
	_guiSetVisible ( window, visible );
end



local do3dtextrender = false
setTimer ( function ( )
	do3dtextrender = exports.NGLogin:isClientLoggedin ( )
end, 1000, 1 )

addEvent ( "onClientPlayerLogin", true )
addEventHandler ( "onClientPlayerLogin", root, function ( )
	do3dtextrender = true
end )


jobDescriptions = { 
	['Busetero'] = [[Con el trabajo de busetero tendrás que recoger jugadores y viajar a través de paradas por todo el servidor!]],
    ['Camionero'] = [[Con el trabajo de camionero tendrás que repartir cargas por las ciudades! ]],
	['fisherman'] = [[Con el trabajo de Fisher, podrás engendrar un bote y conducir alrededor del agua para recolectar los artículos capturados. Para atrapar artículos, debes estar en un bote que está en el agua, y DEBES estar moviéndote, o de lo contrario estarás perdiendo el tiempo. Una vez que su área de almacenamiento esté llena, deberá regresar al puerto para vender su pescado. \N\nPara ver su red, use el comando /net]],
	['medic'] = [[Cuando eres médico, puedes curar a otros jugadores y pagar por ello. El dinero que reciba para curar al jugador, depende de la cantidad de salud que tenía antes.]], 
	['police'] = [[Cuando eres un policía, podrás arrestar a jugadores buscados, por lo que tienen que pagar el tiempo por su crimen. Para saber si se desea un jugador, puedes verificar su nombre en F5, o mirar su etiqueta de nombre, y será (suNombre) [NiveldeBúsqueda]. También tendrán una estrella de la policía flotando sobre su cabeza. Si un jugador decide huir de ti, puedes usar la pistola silenciada como un taser, y cuando los dispares, se pondrán en una animación de tasadas, para que puedas arrestarlos.]],
	['mechanic'] = [[Cuando trabajas como mecánico, puedes ir a cualquier lugar en Los Santos arreglando autos de jugadores. Para arreglar un auto, solo tiene que hacer clic en él y luego le preguntará al cliente si le gustaría arreglarlo. Si aceptan, se iniciará una barra de progreso y luego, cuando termine, su automóvil se arreglará y se le pagará.]],
	['criminal'] = [[Como delincuente, puede ir robando autos en Los Santos, recogiendo armas gratis en San Fierro y dando tumbos en Las Ventures, pero tenga cuidado, la policía siempre está detrás de usted.]],	
	['detective'] = [[Cuando eres un detective en el servidor, todavía tendrás todas las funciones disponibles como oficial de policía normal (panel de policía, chat de radio, arrestos), excepto cuando seas un detective al que se te llamará a los casos de delitos cuando un compañero de policía es asesinado. Cuando llegas a la escena del crimen, solo tienes que buscar pistas del asesino. También tendrás la capacidad de generar vehículos más rápidos.]],
	['pilot'] = [[Cuando seas piloto, volarás un avión alrededor de San Andreas, recogiendo y entregando pasajeros de un punto a otro. También podrá recoger a otros jugadores, ellos podrán establecer un punto de ruta cuando los entregue a su punto de ruta, se le pagará]],
	['stunter'] = [[Si eres un stunter, puedes recorrer San Andreas haciendo trucos en bicicletas o motocicletas. Por cada truco que hagas, serás pagado. También puedes hacer entregas bajo el sistema de Rappi.]],
	['Taxista'] = [[Si eres un taxista, podrás recoger pasajeros por la ciudad y según la cantidad de metros recorridos se te será recompensado. En modo single player podrás hacer deliveries por la ciudad. ]],
	['Drifter'] = [[Los drifters patinarán por el mapa obteniendo dinero ]],
	['militar'] = [[Los militares deben joder al pueblo]],
	['Granjero'] = [[Ser granjero consiste en trabajar con el tractor pasando por encima de las plantas. Además de ello tienes que evitar a los militares que intentan hacer falsos positivos contigo.]],
	['Basurero'] = [[Debes entregar la basura junto con un compañero por toda la ciudad!.]]
}


sx, sy = guiGetScreenSize ( )
rSX, rSY = sx / 1280, sx / 1024
local JobWindow = guiCreateWindow( ( sx / 2 - (rSX*500) / 2 ), (sy-(rSY*230))-rSY*15, rSX*500, rSY*230, "Sistema de Trabajos", false)
local JobDescription = guiCreateMemo((rSX*10), (rSY*23), (rSX*480), (rSY*150), "Job Description", false, JobWindow)
local JobAccept = guiCreateButton((rSX*10), ((rSY*230)-(rSY*25))-rSY*10, (rSX*150), (rSY*25), "Aceptar Trabajo", false, JobWindow)
local JobDeny = guiCreateButton((rSX*170), ((rSY*230)-(rSY*25))-rSY*10, (rSX*150), (rSY*25), "Rechazar Trabajo", false, JobWindow)
guiSetVisible ( JobWindow, false )
guiWindowSetSizable(JobWindow, false)
guiWindowSetMovable ( JobWindow, false )
guiSetFont(JobDeny, "default-bold-small")
guiSetFont(JobAccept, "default-bold-small")
guiMemoSetReadOnly ( JobDescription, true )
--guiSetFont(JobDescription, "default-bold-small")
-- settings: { maxDist = 17, showBoarder & Hide rectangle = false }


addEventHandler ( 'onClientPreRender', root, function ( )
	if ( do3dtextrender ) then
		for ind, v in ipairs ( getElementsByType ( '3DText' ) ) do
			local continueRender = true
			local text = getElementData ( v, 'text' )
			local pos = getElementData ( v, 'position' )
			local color = getElementData ( v, 'color' )
			local parent = getElementData ( v, 'parentElement' )
			
			if ( parent ) then
				if ( isElement ( parent ) ) then
					if ( isPedInVehicle ( localPlayer ) and getElementType ( parent ) == 'vehicle' and getPedOccupiedVehicle ( localPlayer ) == parent ) then return end
					local offset = pos
					local px, py, pz = getElementPosition ( parent )
					pos = { px+offset[1], py+offset[2], pz+offset[3] }
					if ( parent == localPlayer ) then
						continueRender = false
					end
				else
					destroyElement ( v )
				end
			end
				
			
			if continueRender and text and pos and color then
				local x, y, z = unpack ( pos )
				local z = z + 1.15
				local settings = getElementData ( v, 'Settings' ) or { }
				local maxDist = settings[1] or 17
				
				if ( settings[2] ) then
					showBoarder = true
				else
					showBoarder = false
				end
				
				local px, py, pz = getElementPosition ( localPlayer )
				local _3DDist = getDistanceBetweenPoints3D ( x, y, z, px, py, pz )
				if ( _3DDist <= maxDist and isLineOfSightClear ( x, y, z, px, py, pz, true, false, false, true, false, false ) ) then
					local x, y = getScreenFromWorldPosition ( x, y, z )
					local r, g, b = unpack ( color )
					if x then
						local textSize = rSY*2
						local textSize = textSize * ( ( maxDist - _3DDist ) / maxDist )
						--local textSize = 2
						local textWidth = dxGetTextWidth(text,textSize,'default')
						local height = dxGetFontHeight ( textSize, 'default' )
						local x = x-(textWidth/2)
						if x and y and r and g and b then
							if ( showBoarder ) then 
								dxDrawRectangle ( x-6, y+1, textWidth+12, height+2, tocolor ( 0, 0, 0, 120 ) )
								dxDrawText ( tostring ( text ), x, y, 0, 0, tocolor ( r, g, b, 255 ), textSize )
							else
								dxDrawBoarderedText ( tostring ( text ), x, y, 0, 0, tocolor ( r, g, b, 255 ), textSize )
							end
						end
					end
				end
			end
		end
	end
end )

function dxDrawBoarderedText ( text, x, y, endX, endY, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	local text = tostring ( text )
	local x = tonumber(x) or 0
	local y = tonumber(y) or 0
	local endX = tonumber(endX) or x
	local endY = tonumber(endY) or y
	local color = color or tocolor ( 255, 255, 255, 255 )
	local size = tonumber(size) or 1
	local font = font or "default"
	local alignX = alignX or "left"
	local alignY = alignY or "top"
	local clip = clip or false
	local wordBreak = wordBreak or false
	local postGUI = postGUI or false
	local colorCode = colorCode or false
	local subPixelPos = subPixelPos or false
	local fRot = tonumber(fRot) or 0
	local fRotCX = tonumber(fRotCX) or 0
	local fRotCY = tonumber(fRotCy) or 0
	local offSet = tonumber(offSet) or 1
	local t_g = text:gsub ( "#%x%x%x%x%x%x", "" )
	dxDrawText ( t_g, x-offSet, y-offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x-offSet, y, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x, y-offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x+offSet, y+offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x+offSet, y, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x, y+offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	return dxDrawText ( text, x, y, endX, endY, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
end


function create3DText ( str, pos, color, parent, settings ) 
	if str and pos and color then
		local text = createElement ( '3DText' )
		local settings = settings or  { }
		setElementData ( text, "text", str )
		setElementData ( text, "position", pos )
		setElementData ( text, "color", color )
		if ( not parent ) then
			parent = nil
		else
			if ( isElement ( parent ) ) then
				parent = parent
			else
				parent = nil
			end
		end
		setElementData ( text, "Settings", settings )
		setElementData ( text, "parentElement", parent )
		return text
	end
	return false
end

local peds = { }
function refreshGodmodePeds ( )
	for i, v in ipairs ( peds ) do
		destroyElement ( v )
	end
	
	for i, v in ipairs ( getElementsByType ( 'GodmodePed' ) ) do 
		local id = getElementData ( v, "Model" )
		local x, y, z, rz = unpack ( getElementData ( v, "Position" ) )
		peds[i] = createPed ( id, x, y, z, rz )
		setElementFrozen ( peds[i], true )
		addEventHandler ( 'onClientPedDamage', peds[i], function ( ) cancelEvent ( ) end )
	end
	
end
refreshGodmodePeds ( )
setTimer ( refreshGodmodePeds, 30000, 0 )


openedJob = nil
addEvent ( 'NGJobs:OpenJobMenu', true )
addEventHandler ( 'NGJobs:OpenJobMenu', root, function ( job )
	openedJob = job
	guiSetVisible ( JobWindow, true )
	showCursor ( true )
	local desc = jobDescriptions [ job ] 
	guiSetText ( JobDescription, tostring ( desc ) )
	addEventHandler ( "onClientGUIClick", root, clickingevents_jobmenu )
	
end )

function clickingevents_jobmenu ( )
	if ( source == JobDeny ) then
		desc = nil
		openedJob = nil
		guiSetVisible ( JobWindow, false )
		showCursor ( false )
		removeEventHandler ( "onClientGUIClick", root, clickingevents_jobmenu )
	elseif ( source == JobAccept ) then
		
		triggerServerEvent ( "NGJobs:SetPlayerJob", localPlayer, openedJob )
	
		desc = nil
		openedJob = nil
		guiSetVisible ( JobWindow, false )
		showCursor ( false )
		removeEventHandler ( "onClientGUIClick", root, clickingevents_jobmenu )
	end
end

addEventHandler ( 'onClientPlayerWasted', root, function ( )
	if ( source == localPlayer ) then
		showCursor ( false )
		guiSetVisible ( JobWindow, false )
	end
end )


addEvent ( "onPlayerResign", true )

msnLbl = guiCreateLabel(0.33, 0.39, 0.32, 0.10, "Mision cumplida!", true)
guiSetFont(msnLbl, "sa-gothic")
guiLabelSetColor(msnLbl, 247, 210, 7)
guiLabelSetHorizontalAlign(msnLbl, "center", false)
guiLabelSetVerticalAlign(msnLbl, "center")

lvlLabel = guiCreateLabel(0.42, 0.48, 0.15, 0.07, "Nivel: ++", true)
guiSetFont(lvlLabel, "sa-header")
guiLabelSetHorizontalAlign(lvlLabel, "center", false)  
guiSetVisible(msnLbl, false)
guiSetVisible(lvlLabel, false)

function checkLvlFn(q3)
	level = 10
	if math.ceil(level-((q3[1]["total"]/level)-math.floor(q3[1]["total"]/level))*level) == level then
		playSound("missionpassed.mp3")
		local x,y = guiGetScreenSize()
		guiSetVisible(msnLbl, true)
		guiSetVisible(lvlLabel, true)

		setTimer(
		function()
			guiSetVisible(msnLbl, false)
			guiSetVisible(lvlLabel, false)
		end,5000,1)
	end
end

addEvent ( "checkLvl", true )
addEventHandler ( "checkLvl", localPlayer, checkLvlFn )