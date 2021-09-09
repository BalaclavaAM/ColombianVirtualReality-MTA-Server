--[[
NOTE: the official (and latest) version of this resource is available at https://community.multitheftauto.com/index.php?p=resources&s=details&id=18330
--]]

local subTrackOnSoundDown = 0.1
local subTrackOnSoundUp = 0.1

local resX, resY = guiGetScreenSize()
local tbl = {}
local volbool=false
local radio = false
a = {}
b={}
a[0]="CVR"
b[0]="http://node-25.zeno.fm/yeghg6y9x4zuv?rj-ttl=5&rj-tok=AAABdQOecu0AwBWy-6iKZn1LeQ"
a[1]="La Klle"
b[1]="https://18533.live.streamtheworld.com/LA_KALLE_SC"
a[2]="Radio 1"
b[2]="http://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_1_BOGAAC.aac"
a[3]="Olimpica"
b[3]="http://i50.letio.com/9114.aac"
a[4]="Vibra"
b[4]="http://provisioning.streamtheworld.com/asx/VIBRAAAC.asx"
a[5]="Custom"
a[6]="YT"
index = 0
intento = 0



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
	mp3 = guiCreateStaticImage(0.86, 0.43, 0.13, 0.42, ":CVRRadio/mp3.png", true)
	guiSetVisible(mp3, false)
	izquierda = guiCreateButton(0.21, 0.71, 0.16, 0.11, "", true, mp3)
	guiSetAlpha(izquierda, 0.00)
	centro = guiCreateButton(0.37, 0.71, 0.24, 0.11, "", true, mp3)
	guiSetAlpha(centro, 0.00)
	derecha = guiCreateButton(0.61, 0.71, 0.16, 0.11, "", true, mp3)
	guiSetAlpha(derecha, 0.00)
	Delete = guiCreateButton(0.37, 0.64, 0.24, 0.07, "", true, mp3)
	guiSetAlpha(Delete, 0.00)
	VolToggle = guiCreateButton(0.37, 0.82, 0.24, 0.07, "", true, mp3)
	guiSetAlpha(VolToggle, 0.00)
	
	label = guiCreateLabel(0.15, 0.05, 0.66, 0.07, a[index], true, mp3)
	guiLabelSetColor(label, 154, 154, 154)
	guiLabelSetHorizontalAlign(label, "center", true)
	guiLabelSetVerticalAlign(label, "center")
	close = guiCreateButton(0.71, 0.07, 0.08, 0.05, "X", true, mp3)
	guiSetAlpha(close, 0.00)
	xmlSetting = guiCreateCheckBox(0.45, 0.37, 0.16, 0.08, "", true, true, mp3)
	sololabel = guiCreateLabel(0.15, 0.31, 0.66, 0.06, " Escuchas todos los bafles", true, mp3)
	guiLabelSetHorizontalAlign(sololabel, "center", false)
	guiLabelSetVerticalAlign(sololabel, "bottom")


	if index==5 then
		custombox = guiCreateEdit(0.17, 0.12, 0.65, 0.07, "", true, mp3)
	end
	if index==6 then
		ytbox = guiCreateEdit(0.17, 0.12, 0.65, 0.07, "", true, mp3)
	end


	if (not getSetting("box") or getSetting("box") == "ENABLED") then
		enable = true
		guiCheckBoxSetSelected(xmlSetting, true)
		setSetting("box", "ENABLED")
	elseif getSetting("box") == "DISABLED" then
		enable = nil
		guiCheckBoxSetSelected(xmlSetting, false)

	end
	setTimer(getRadioInfo, 10000, 0)
end
addEventHandler("onClientResourceStart", resourceRoot, speakersysGUI)



function openGUI()
	if (guiGetVisible(mp3)) then
		guiSetVisible(mp3, false)
		showCursor(false)
	else
		guiSetVisible(mp3, true)
		showCursor(true)
	end
end
addEvent("Speaker.openInterface", true)
addEventHandler("Speaker.openInterface", root, openGUI)

local isSound = false

function GetYT ( url )
	triggerServerEvent("speaker.startStream", localPlayer, url, 1.0, 85)
	isSound = true
    
end
addEvent( "GetYT", true )
addEventHandler( "GetYT", localPlayer, GetYT )

function clickEvent()
	if (source == centro) then
		local vol = 1.0
		local dist = 85
		local url = b[index]
		--Custom
		if index==5 then
        	url= guiGetText(custombox)
		end
		if index==6 then
			url= guiGetText(ytbox)
			if (url == "") then
				return
			end		
			url = "https://cvraudio.herokuapp.com/?url="..url

	
		end

		--Custom
		if (url == "") then
			return
		end
		if (yturl == "") then
			return
		end
		-- If you need to add any checks for whether or not a player is allowed to create speakers (e.g location, element data, etc).. then do it on this line.

		

		triggerServerEvent("speaker.startStream", localPlayer, url, vol, dist)
		isSound = true
		
	elseif (source == close) then
		openGUI()
	elseif (source == izquierda)then
		index= index-1
        if index==-1 then
                index=6
        end
        if index==6 then
			ytbox = guiCreateEdit(0.17, 0.12, 0.65, 0.07, "", true, mp3)  
		elseif index==5 then
			destroyElement(ytbox)
			custombox = guiCreateEdit(0.17, 0.12, 0.65, 0.07, "", true, mp3)  
        elseif index==4 then
                destroyElement(custombox)
        end
        guiSetText(label,a[index])
	elseif (source== derecha) then
		index= index+1
        if index==6 then
				ytbox = guiCreateEdit(0.17, 0.12, 0.65, 0.07, "", true, mp3) 
                destroyElement(custombox)
		elseif index==7 then
			destroyElement(ytbox)
			index=0
		
        elseif index==5 then
			    custombox = guiCreateEdit(0.17, 0.12, 0.65, 0.07, "", true, mp3)  
        end
        guiSetText(label,a[index])
	elseif (source == pauseBtn) then
		triggerServerEvent("speaker.pause", localPlayer)
	elseif (source == Delete) then
		triggerServerEvent("speaker.destroy", localPlayer)
		isSound = false
	elseif (source==VolToggle)then
		if volbool==false then
			VOLLabel = guiCreateLabel(0.15, 0.19, 0.66, 0.07, "VOLUMEN", true, mp3)
			guiLabelSetColor(VOLLabel, 154, 154, 154)
			guiLabelSetHorizontalAlign(VOLLabel, "center", false)
			guiLabelSetVerticalAlign(VOLLabel, "center")
			ScrollVOL = guiCreateScrollBar(0.16, 0.26, 0.65, 0.05, true, true, mp3)
			guiScrollBarSetScrollPosition(ScrollVOL, 50.0)  
			addEventHandler( "onClientGUIScroll", ScrollVOL, OnScroll )
			volbool=true
	
	else 
			destroyElement (ScrollVOL); 
			destroyElement (VOLLabel); 
			volbool = false
	
			
	end
	elseif (source == xmlSetting) then
		enable = not enable
		if (enable) then
			outputChatBox("Vuelva a conectarse para volver a escuchar los bafles desactivadas", 0, 255, 0)
			setSetting("box", "ENABLED")
			guiCheckBoxSetSelected(xmlSetting, true)
			guiSetText(sololabel, "Escuchas todos los bafles")

		else
			setSetting("box", "DISABLED")
			guiCheckBoxSetSelected(xmlSetting, false)
			guiSetText(sololabel, "Escuchas solo tu bafle")

		end
	elseif (source == volminus) then
		if (isElement(tbl[getPlayerSerial(localPlayer)][1])) then
			local toVol = math.round(getSoundVolume(tbl[getPlayerSerial(localPlayer)][1]) - subTrackOnSoundDown, 2)
			if (toVol > 0.0) then
				triggerServerEvent("onPlayerChangeSpeakerBoxVolume", localPlayer, toVol)

			else
				outputChatBox("El volumen no puede ser mas bajo.", 255, 0, 0)
			end
		end
	elseif (source == volplus) then
		if (isElement(tbl[getPlayerSerial(localPlayer)][1])) then
			local toVol = math.round(getSoundVolume(tbl[getPlayerSerial(localPlayer)][1]) + subTrackOnSoundUp, 2)
			if (toVol < 1.1) then
				triggerServerEvent("onPlayerChangeSpeakerBoxVolume", localPlayer, toVol)

			else
				outputChatBox("El volumen no puede ser mas alto.", 255, 0, 0)
			end
		end
	end
end
addEventHandler("onClientGUIClick", resourceRoot, clickEvent)
function OnScroll()
	triggerServerEvent("onPlayerChangeSpeakerBoxVolume", localPlayer, guiScrollBarGetScrollPosition(ScrollVOL)/100)
	
end
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

				radio = playSound3D(ent[2], ent[3], ent[4], ent[5], false, false)
				addEventHandler("onClientSoundStream",radio,function(suc,length,streamN,error)
					if not suc then
					tbl[serial][3]="Error"
					else
						if string.find(ent[2], "https://cvraudio.herokuapp.com") then
							tbl[serial][3]="[CVR] YOUTUBE "
						  else
							print ("No info")
						  end
					end
				end)
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
		if (radio[1] and isElement(radio[1]) and tbl[key][3]~= "[CVR] YOUTUBE " and tbl[key][3]~= "Error") then
			tbl[key][3] = nil
			table.insert(tbl[key], getSoundMetaTags(radio[1]).stream_title or getSoundMetaTags(radio[1]).title or "[Radio CVR]")
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
        if (tbl[who]~=nil) then
            setSoundVolume(tbl[who][1], tonumber(vol))
        end
    end
)


