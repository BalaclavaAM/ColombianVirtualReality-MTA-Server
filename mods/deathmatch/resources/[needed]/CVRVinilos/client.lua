screenW, screenH = guiGetScreenSize()

MainWindowCVRVinilos = guiCreateWindow(screenW-1300, screenH*0.5-285*0.5, 300, 285, "Menu de Vinilos", false)
guiWindowSetSizable(MainWindowCVRVinilos, false)
guiSetVisible(MainWindowCVRVinilos, false)

gridTuneo = guiCreateGridList(5, 25, 290, 150, false, MainWindowCVRVinilos)
guiGridListAddColumn(gridTuneo, "vinilo", 0.9)

seleccionarTuneo = guiCreateButton(140, 210, 140, 25, "Instalar", false, MainWindowCVRVinilos)
CerrarTuneo = guiCreateButton(140, 245, 140, 25, "Cerrar", false, MainWindowCVRVinilos)

ImagenTuneo = guiCreateStaticImage(5, 190, 100, 100, "textures/1.jpg", false, MainWindowCVRVinilos)
guiSetVisible(ImagenTuneo, false)


addEventHandler("onClientGUIClick", root, function ()
	local selected = guiGridListGetItemData(gridTuneo, guiGridListGetSelectedItem(gridTuneo), 1)
	if source == gridTuneo then
		if selected then
			guiStaticImageLoadImage(ImagenTuneo, selected)
			guiSetVisible(ImagenTuneo, true)
		else
			guiSetVisible(ImagenTuneo, false)
		end
	elseif source == CerrarTuneo then
		guiSetVisible(MainWindowCVRVinilos, false)
		showCursor(false)
	elseif source == seleccionarTuneo then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then
			if selected then
				setElementData(vehicle, "vehicle:vinil", selected)
				triggerServerEvent("setCarColorVinil", localPlayer, vehicle, selected, 255, 255, 255)
			else
				setElementData(vehicle, "vehicle:vinil", false)
			end
		end
	end
end)

for i,v in pairs(tune.list) do
	row = guiGridListAddRow(gridTuneo)
	guiGridListSetItemText(gridTuneo, row, 1, v[1], false, false)
	guiGridListSetItemData(gridTuneo, row, 1, v[2])
end

function activarPanel()
	if getElementData(localPlayer,"Job") == "Drifter" then
		if (getPedOccupiedVehicle(localPlayer) and getElementModel(getPedOccupiedVehicle(localPlayer))==562) then
			guiSetVisible(MainWindowCVRVinilos, not guiGetVisible(MainWindowCVRVinilos))
			showCursor(guiGetVisible(MainWindowCVRVinilos))
		end
	else
		outputChatBox("Tienes que ser drifter para cambiar la pintura de tu elegy.",255,0,0)
	end
end
addCommandHandler("pintarelegy",activarPanel)

vinils = {}
function imageVehicleVinil(vehicle)
	renderTarget = dxCreateRenderTarget(1024, 1024, true)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 1024, 1024, dxCreateTexture(getElementData (vehicle, "vehicle:vinil" )))
	dxSetRenderTarget()
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

function getTextureFromRenderTarget(renderTarget)
	return dxCreateTexture(dxGetTexturePixels(renderTarget))
end

function setVehicleVinil(vehicle)
	if not vinils[vehicle] then
		vinils[vehicle] = dxCreateShader("textures/texreplace.fx")
	end
	if not getElementData (vehicle, "vehicle:vinil" ) then return end
	engineApplyShaderToWorldTexture(vinils[vehicle], "elegy1body256", vehicle)
	engineApplyShaderToWorldTexture(vinils[vehicle], "elegy2body256", vehicle)
	engineApplyShaderToWorldTexture(vinils[vehicle], "elegy3body256", vehicle)
	engineApplyShaderToWorldTexture(vinils[vehicle], "elegy4body256", vehicle)
	texture = imageVehicleVinil(vehicle)
	dxSetShaderValue(vinils[vehicle], "TEXTURE_REMAP", texture )
end

addEventHandler( "onClientElementStreamIn", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		if getElementData (source, "vehicle:vinil" ) then 
			setVehicleVinil(source) 
		end
	end
end)

function aplicarViniloStreamed(vehicle)
	if isElementStreamedIn(vehicle) then
		setVehicleVinil(vehicle)
	end
end
addEvent("CVRVinilos:aplicarViniloStreamed",true)
addEventHandler("CVRVinilos:aplicarViniloStreamed",root,aplicarViniloStreamed)


function arreglarPinturas()
	for k,v in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(v) and getElementModel(v)==562 then
			setVehicleVinil(v)
		end
	end
end
addCommandHandler("fixelegys",arreglarPinturas)
