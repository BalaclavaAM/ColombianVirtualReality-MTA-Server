local fps = 0
local nextTick = 0
local peak = 0
local song = playSound("http://stream.zeno.fm/yeghg6y9x4zuv.pls")
local tick_2 = 0
local sx, sy = guiGetScreenSize()
local maxPing = 10000
local cancionActual = ""
local label = guiCreateLabel(0.01, 0.95, 0.98, 0.1, "", true)
setSoundVolume(song, 0)

function getPlayerFPS() -- Setup the useful function
    return fps
end

local function updateFPS(msSinceLastFrame)
    -- FPS are the frames per second, so count the frames rendered per milisecond using frame delta time and then convert that to frames per second.
    local now = getTickCount()
    if (now >= nextTick) then
        fps = (1 / msSinceLastFrame) * 1000
        nextTick = now + 1000
    end
end

function cambiarTexto()

    fps = getPlayerFPS()
    ping = getPlayerPing(localPlayer)
    if (ping < maxPing) then maxPing = ping end
    if (fps < 10 and exports.NGPhone:getSetting("usersettings_display_lowfpswarning") and tick_2 - getTickCount() >= 5000) then
        exports["NGMessages"]:sendClientMessage("Pocos fps?. usa F3->Opciones->Performance->save para subir tus fps", 255, 0, 0)
        tick_2 = getTickCount()
    end
    if (fps > peak) then peak = fps end

    if cancionActual ~= "" then
        guiSetText(label, "FPS Actuales: " .. tostring(math.floor(fps)) .. " | Pico de FPS: " .. tostring(math.floor(peak)) .. " | Ping Actual: " .. tostring(ping) .. " | Ping más bajo: " .. tostring(maxPing) .. " | Canción en RADIO CVR: " .. tostring(cancionActual))
    else
        guiSetText(label, "FPS Actuales: " .. tostring(math.floor(fps)) .. " | Pico de FPS: " .. tostring(math.floor(peak)) .. " | Ping Actual: " .. tostring(ping) .. " | Ping más bajo: " .. tostring(maxPing))

    end
end

addEventHandler("onClientSoundChangedMeta", song, function()
    cancion = getSoundMetaTags(song)
    cancionActual = cancion["stream_title"]
end)


addEventHandler("onClientPlayerLogin", root, function()
    if exports.NGPhone:getSetting("usersettings_display_clienttoserverstats") then

        addEventHandler("onClientPreRender", root, updateFPS)
        addEventHandler("onClientRender", root, cambiarTexto)
    end
end)

addEventHandler("onClientUserSettingChange", root, function(cad, val)
    if (cad == "usersettings_display_clienttoserverstats") then
        if val then
            addEventHandler("onClientPreRender", root, updateFPS)
            addEventHandler("onClientRender", root, cambiarTexto)
        else
            if isElement(label) then
                guiSetText(label, "")
                removeEventHandler("onClientPreRender", root, updateFPS)
                removeEventHandler("onClientRender", root, cambiarTexto)
            end
        end
    end
end)
