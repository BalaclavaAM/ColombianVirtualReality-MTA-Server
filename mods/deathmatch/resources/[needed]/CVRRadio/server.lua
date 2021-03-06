local sounds, antiSpam = {}, {}
local pagesource={}
function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
  end
function split(pString, pPattern)
    local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
      table.insert(Table,cap)
       end
       last_end = e+1
       s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
       cap = pString:sub(last_end)
       table.insert(Table, cap)
    end
    return Table
 end


function startStream(url, vol, dist)

	if (not antiSpam[client]) then
		antiSpam[client] = 0
		setTimer(function(plr)
		antiSpam[plr] = nil end, 10000, 1, client)
	end

	antiSpam[client] = ((antiSpam[client] or 0) + 1)

	if (antiSpam[client] > 5) then
		outputChatBox("You can't put more than 5 boxes in less than 10 seconds!", client, 255, 0, 0)
		return false
	end

	local serial = getPlayerSerial(client)

	if (not sounds[client]) then
		sounds[client] = {}
	end

	if (sounds[client][serial] and isElement(sounds[client][serial][1])) then
		destroyElement(sounds[client][serial][1])
	end

	local x, y, z = getElementPosition(client)
	local interior = getElementInterior(client)
	local dimension = getElementDimension(client)
	local box = createObject(2229, x - 0.5, y + 0.5, z - 1, 0, 0, rx)

	setElementDimension(box, dimension)
	setElementInterior(box, interior)

	local vehicle = getPedOccupiedVehicle(client)

	if (isPedInVehicle(client) and vehicle and isElement(vehicle)) then
		sounds[client][serial] = {box, url, x, y, z + 2, vehicle, interior, dimension, vol, dist, getPlayerName(client)}
		setElementCollisionsEnabled(box, false)
		attachElements(box, vehicle, -0.7, -1.5, -0.1, 0, 90, 0)
	else
		sounds[client][serial] = {box, url, x, y, z, false, interior, dimension, vol, dist, getPlayerName(client)}
		setElementCollisionsEnabled(box, false)
	end

	triggerClientEvent(root, "speaker.setBox", root, sounds[client])
end
addEvent("speaker.startStream", true)
addEventHandler("speaker.startStream", root, startStream)

function setting(vol, dist)
	local serial = getPlayerSerial(client)
	if (sounds[client]) then
		if (vol) then
			triggerClientEvent(root, "speaker.setData", root, vol, "vol", serial)
			return true
		end
		if (dist) then
			triggerClientEvent(root, "speaker.setData", root, dist, "dist", serial)
			return true
		end
	end
end
addEvent("speaker.change", true)
addEventHandler("speaker.change", root, setting)

function openGUI(player)
	triggerClientEvent(player, "Speaker.openInterface", player)
end
addCommandHandler("sound", openGUI)
addCommandHandler("music", openGUI)
addCommandHandler("radio", openGUI)
addCommandHandler("speaker", openGUI)
addCommandHandler("bafle", openGUI)

function delAdmin(player, cmd, ID)
	if (hasObjectPermissionTo(player, "command.mute", false)) then
		local s2 = getPlayerFromName(ID)
		if (ID and s2 and sounds[s2]) then
			local serial = getPlayerSerial(s2)
			destroyElement(sounds[s2][serial][1])
			triggerClientEvent(root, "speaker.setData", root, false, "destroy", serial)
			outputChatBox("Speaker removed!", player, 0, 255, 0)
			sounds[s2] = nil
		else
			outputChatBox("Error, el jugador no existe o no tiene un bafle.", player, 255, 0, 0)
		end
	end
end
addCommandHandler("delbox", delAdmin)

function destroy()
	local serial = getPlayerSerial(client)
	if (sounds[client]) then
		destroyElement(sounds[client][serial][1])
		triggerClientEvent(root, "speaker.setData", root, false, "destroy", serial)
		sounds[client] = nil
	end
end
addEvent("speaker.destroy", true)
addEventHandler("speaker.destroy", root, destroy)

function pause()
	if (sounds[client]) then
		local serial = getPlayerSerial(client)
		triggerClientEvent(root, "speaker.ps", root, serial)
	end
end
addEvent("speaker.pause", true)
addEventHandler("speaker.pause", root, pause)

function getSpeakers()
	local ltable = {}
	local speakers = 0
	for k, v in pairs(sounds) do
		for k2, v2 in pairs(v) do
			ltable[k2] = sounds[k][k2]
			speakers = speakers + 1
		end
	end
	if (speakers >= 1) then
		triggerClientEvent(source, "speaker.setBox", source, ltable)
	end
end
addEvent("getSpeakers", true)
addEventHandler("getSpeakers", root, getSpeakers)

function onPlayerQuit()
	if (sounds[source]) then
		local serial = getPlayerSerial(source)
		destroyElement(sounds[source][serial][1])
		triggerClientEvent(root, "speaker.setData", root, false, "destroy", serial)
		sounds[source] = nil
	end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

addEvent("onPlayerChangeSpeakerBoxVolume", true)
addEventHandler("onPlayerChangeSpeakerBoxVolume", root,
    function(to)
        triggerClientEvent(root, "onPlayerChangeSpeakerBoxVolumeC", root, getPlayerSerial(source), to)
    end
)