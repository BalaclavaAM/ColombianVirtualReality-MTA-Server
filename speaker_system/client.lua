--[[
NOTE: the official (and latest) version of this resource is available at https://community.multitheftauto.com/index.php?p=resources&s=details&id=18330
--]]

local subTrackOnSoundDown = 0.1
local subTrackOnSoundUp = 0.1

local resX, resY = guiGetScreenSize()
local tbl = {}

local radioTable = {
	{"Radio CVR", "http://node-25.zeno.fm/yeghg6y9x4zuv?rj-ttl=5&rj-tok=AAABdQOecu0AwBWy-6iKZn1LeQ"},
	{"La Kalle", "https://18533.live.streamtheworld.com/LA_KALLE_SC"},
	{"Radio 1", "http://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_1_BOGAAC.aac"},
	{"Olimpica Stereo", "http://i50.letio.com/9114.aac"},
	{"Vibra Bogotá", "http://provisioning.streamtheworld.com/asx/VIBRAAAC.asx"},
}

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then
        return math[method](number * factor) / factor
    else
        return tonumber(("%." .. decimals .. "f"):format(number))
    end
end

function speakersysGUI()

	if (speakersys) then
		return true
	end

	speakersys = guiCreateWindow((resX - 325) / 1.1, (resY - 380) / 1.4, 325, 380, "Sistema de Bafles", false)
	guiSetAlpha(speakersys, 1)
	guiWindowSetSizable(speakersys, false)
	urlGrid = guiCreateGridList(10, 54, 304, 139, false, speakersys)
	urlEdit = guiCreateEdit(10, 25, 304, 26, "http://node-25.zeno.fm/yeghg6y9x4zuv?rj-ttl=5&rj-tok=AAABdQOecu0AwBWy-6iKZn1LeQ", false, speakersys)
	setBtn = guiCreateButton(10, 200, 150, 30, "Crear Bafle", false, speakersys)
	destroyBox = guiCreateButton(162, 200, 150, 30, "Destruir Bafle", false, speakersys)
	pauseBtn = guiCreateButton(10, 235, 150, 30, "Play - Pause", false, speakersys)
	close = guiCreateButton(162, 235, 150, 30, "Cerrar", false, speakersys)
	volplus = guiCreateButton(13, 271, 23, 22, "+", false, speakersys)
	volminus = guiCreateButton(41, 271, 23, 22, "-", false, speakersys)    
	volume = guiCreateLabel(70, 275, 150, 17, "", false, speakersys)
	xmlSetting = guiCreateCheckBox(15, 345, 160, 17, "Activar bafles ajenos", false, false, speakersys)
	enableLabel = guiCreateLabel(167, 345, 150, 17, "", false, speakersys)
	urlColumn = guiGridListAddColumn(urlGrid, "Estaciones", 0.8)
	guiSetVisible(speakersys, false)

	if (not getSetting("box") or getSetting("box") == "ENABLED") then
		enable = true
		guiCheckBoxSetSelected(xmlSetting, true)
		setSetting("box", "ENABLED")
		guiSetText(enableLabel, "Escuchas todos los bafles")
		guiLabelSetColor(enableLabel, 0, 255, 0)
	elseif getSetting("box") == "DISABLED" then
		enable = nil
		guiCheckBoxSetSelected(xmlSetting, false)
		guiSetText(enableLabel, "Sólo puedes escuchar tu bafle")
		guiLabelSetColor(enableLabel, 255, 0, 0)
	end

	addEventHandler("onClientGUIClick", urlGrid, updateUrlEdit, false)

	for key, ent in pairs(radioTable) do
		local row = guiGridListAddRow(urlGrid)
		guiGridListSetItemText(urlGrid, row, urlColumn, ent[1], false, false)
	end

	setTimer(getRadioInfo, 10000, 0)
end
addEventHandler("onClientResourceStart", resourceRoot, speakersysGUI)

function updateUrlEdit()
	if (guiGridListGetItemText(urlGrid, guiGridListGetSelectedItem(urlGrid), 1) ~= "") then
		for key, ent in pairs(radioTable) do
			if (guiGridListGetItemText(urlGrid, guiGridListGetSelectedItem(urlGrid), 1) == ent[1]) then
				guiSetText(urlEdit, ent[2])
			end
		end
	end
end

function openGUI()
	if (guiGetVisible(speakersys)) then
		guiSetVisible(speakersys, false)
		showCursor(false)
	else
		guiSetVisible(speakersys, true)
		showCursor(true)
	end
end
addEvent("Speaker.openInterface", true)
addEventHandler("Speaker.openInterface", root, openGUI)

local isSound = false

function clickEvent()
	if (source == setBtn) then
		local vol = 1.0
		local dist = 85
		local url = guiGetText(urlEdit)
		if (url == "") then
			return
		end
		
		-- If you need to add any checks for whether or not a player is allowed to create speakers (e.g location, element data, etc).. then do it on this line.

		if string.len(url) > 320 then
			return outputChatBox("ERROR: URL Muy larga!", 255, 0, 0)
		end

		triggerServerEvent("speaker.startStream", localPlayer, url, vol, dist)
		isSound = true
		guiSetText(volume, "Volumen actual: 100%")
	elseif (source == close) then
		openGUI()
	elseif (source == pauseBtn) then
		triggerServerEvent("speaker.pause", localPlayer)
	elseif (source == destroyBox) then
		triggerServerEvent("speaker.destroy", localPlayer)
		isSound = false
		guiSetText(volume, "Volumen actual: 100%")
	elseif (source == xmlSetting) then
		enable = not enable
		if (enable) then
			outputChatBox("Vuelva a conectarse para volver a escuchar los bafles desactivadas", 0, 255, 0)
			setSetting("box", "ENABLED")
			guiCheckBoxSetSelected(xmlSetting, true)
			guiSetText(enableLabel, "Escuchas todos los bafles")
			guiLabelSetColor(enableLabel, 0, 255, 0)
		else
			setSetting("box", "DISABLED")
			guiCheckBoxSetSelected(xmlSetting, false)
			guiSetText(enableLabel, "Sólo puedes escuchar tu bafle")
			guiLabelSetColor(enableLabel, 255, 0, 0)
		end
	elseif (source == volminus) then
		if (isElement(tbl[getPlayerSerial(localPlayer)][1])) then
			local toVol = math.round(getSoundVolume(tbl[getPlayerSerial(localPlayer)][1]) - subTrackOnSoundDown, 2)
			if (toVol > 0.0) then
				triggerServerEvent("onPlayerChangeSpeakerBoxVolume", localPlayer, toVol)
				guiSetText(volume, "Volumen actual: " .. math.floor(toVol * 100) .. "%")
			else
				outputChatBox("El volumen no puede ser mas bajo.", 255, 0, 0)
			end
		end
	elseif (source == volplus) then
		if (isElement(tbl[getPlayerSerial(localPlayer)][1])) then
			local toVol = math.round(getSoundVolume(tbl[getPlayerSerial(localPlayer)][1]) + subTrackOnSoundUp, 2)
			if (toVol < 1.1) then
				triggerServerEvent("onPlayerChangeSpeakerBoxVolume", localPlayer, toVol)
				guiSetText(volume, "Volumen actual: " .. math.floor(toVol * 100) .. "%")
			else
				outputChatBox("El volumen no puede ser mas alto.", 255, 0, 0)
			end
		end
	end
end
addEventHandler("onClientGUIClick", resourceRoot, clickEvent)

function setData(value, theType, serial)
	if (not tbl[serial]) then
		return
	end
	if (not isElement(tbl[serial][1])) then
		return
	end
	if (theType == "vol") then
		setSoundVolume(tbl[serial][1], value)
	elseif (theType == "dist") then
		setSoundMaxDistance(tbl[serial][1], value)
	elseif (theType == "destroy") then
		stopSound(tbl[serial][1])
		destroyElement(tbl[serial][2])
		tbl[serial] = nil
	end
end
addEvent("speaker.setData", true)
addEventHandler("speaker.setData", root, setData)

function ps(serial)
	if (not tbl[serial]) then
		return
	end
	if (not isElement(tbl[serial][1])) then
		return
	end
	setSoundPaused(tbl[serial][1], not isSoundPaused(tbl[serial][1]))
end
addEvent("speaker.ps", true)
addEventHandler("speaker.ps", root, ps)

function setBox(str)
	if (not str) then
		return
	end
	for serial, ent in pairs(str) do
		if (tbl[serial] and isElement(tbl[serial][1])) then
			destroyElement(tbl[serial][1])
			destroyElement(tbl[serial][2])
		end
		if (isElement(ent[1])) then
			if (ent[11] == getPlayerName(localPlayer) or enable) then
				local radio = playSound3D(ent[2], ent[3], ent[4], ent[5], false, false)
				setElementData(radio, "ob", ent[11])
				local dumm = createObject(1337, ent[3], ent[4], ent[5])
				setElementAlpha(dumm, 0)
				setElementCollisionsEnabled(dumm, false)
				attachElements(dumm, ent[1], -0.32, -0.22, 0.8)
				tbl[serial] = {radio, dumm}
				if (ent[6] and isElement(ent[6])) then
					attachElements(radio, ent[6])
				end
				setElementInterior(radio, ent[7])
				setElementDimension(radio, ent[8])
				setSoundVolume(radio, ent[9])
				setSoundMaxDistance(radio, ent[10])
				setInteriorSoundsEnabled(false)
			end
		end
	end
end
addEvent("speaker.setBox", true)
addEventHandler("speaker.setBox", root, setBox)

function getRadioInfo()
	for key, radio in pairs(tbl) do
		if (radio[1] and isElement(radio[1])) then
			tbl[key][3] = nil
			table.insert(tbl[key], getSoundMetaTags(radio[1]).stream_title or getSoundMetaTags(radio[1]).title)
		end
	end
end

function drawData()
	for key, radio in pairs(tbl) do
		if (radio[2] and isElement(radio[2] and radio[1])) then
			local eX, eY, eZ = getElementPosition(radio[2])
			local eZ = eZ + 1
			local sx, sy = getScreenFromWorldPosition(eX, eY, eZ)
			local cameraX, cameraY, cameraZ = getCameraMatrix()
			if (sx and sy) then
				if (not enable and getElementData(radio[1], "ob") ~= getPlayerName(localPlayer)) then
					stopSound(radio[1])
					destroyElement(radio[2])
					tbl[key] = nil
					return false
				end
				local distance = getDistanceBetweenPoints3D(cameraX, cameraY, cameraZ, eX, eY, eZ)
				if (distance <= 50 and isLineOfSightClear(cameraX, cameraY, cameraZ, eX, eY, eZ, true, false, false, false, false, false) and radio[3]) then
					local height = dxGetFontHeight(1, "default-bold")
					local owner = getElementData(radio[1], "ob")
					text = radio[3]
					if toggle then
						text = "Owner: " .. owner .. " - " .. text .. ""
					end
					local width = dxGetTextWidth(text, 1, "default-bold")
					dxDrawRectangle(sx - width / 2 - 5, sy, width + 8, height, tocolor(0, 0, 0, 255), false)
					dxDrawText(text, sx - width / 2, sy, sx - width / 2, sy, tocolor(150, 50, 150, 255), 1, "default-bold")
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, drawData)

function toggleCursor(key, state)
	toggle = not toggle
end
bindKey("lalt", "both", toggleCursor)

settingsXMLFile = nil

function init()
	settingsXMLFile = xmlLoadFile("settings.xml")
	if not settingsXMLFile then
		settingsXMLFile = xmlCreateFile("settings.xml", "settings")
	end
end

init()

function setSetting(setting, value)
	if value then
		value = tostring(value)
		xmlNodeSetAttribute(settingsXMLFile, setting, value)
	end
	xmlSaveFile(settingsXMLFile)
end

function getSetting(setting)
	if setting then
		local val = xmlNodeGetAttribute(settingsXMLFile, setting)
		if val then
			return val
		else
			return false
		end
	else
		return false
	end
end
triggerServerEvent("getSpeakers", localPlayer)

addEvent("onPlayerChangeSpeakerBoxVolumeC", true)
addEventHandler("onPlayerChangeSpeakerBoxVolumeC", root,
    function(who, vol)
        if (isElement(tbl[who][1])) then
            setSoundVolume(tbl[who][1], tonumber(vol))
        end
    end
)


