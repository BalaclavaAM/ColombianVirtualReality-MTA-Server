addEvent("onClientPlayerStartDuel", true)
addEvent("onDuelEnded", true)
Duelo = {}

addEventHandler(
    "onClientPlayerStartDuel",
    root,
    function()
        g_currentDuel = true
    end
)

addEventHandler(
    "onDuelEnded",
    root,
    function()
        g_currentDuel = nil
    end
)

function updateJobRank()
    triggerServerEvent("NGJobs->SQL->UpdateColumn", localPlayer, localPlayer, "duelos", "AddOne")
end
addEvent("UpdateDuelo", true)
addEventHandler("UpdateDuelo", localPlayer, updateJobRank)

local screenX, screenY = guiGetScreenSize()
local guiX, guiY = screenX / 1280, screenY / 720

addEvent(getResourceName(getThisResource()) .. ":sendTimerToClient", true)
addEventHandler(
    getResourceName(getThisResource()) .. ":sendTimerToClient",
    root,
    function(remaining)
        local remaining = remaining / 1000
        if remaining then
            c_Remaining = remaining
            c_duelTimer =
                setTimer(
                function()
                    remaining = remaining - 1
                    c_Remaining = remaining
                    if remaining <= 0 then
                        if isTimer(c_duelTimer) then
                            killTimer(c_duelTimer)
                        end
                    end
                end,
                1000,
                0
            )
        end
    end
)

addEventHandler(
    "onClientRender",
    root,
    function()
        if c_duelTimer and isTimer(c_duelTimer) then
            local remaining = c_Remaining
            if remaining then
                local newTime = math.ceil(remaining)
                dxDrawText(
                    "Round starts in..",
                    guiX * 494,
                    guiY * 332,
                    guiX * 786,
                    guiY * 390,
                    tocolor(255, 255, 255, 255),
                    1.50,
                    "default-bold",
                    "center",
                    "center",
                    false,
                    false,
                    false,
                    false,
                    false
                )
                dxDrawText(
                    remaining,
                    guiX * 494,
                    guiY * 389,
                    guiX * 786,
                    guiY * 419,
                    tocolor(255, 255, 255, 255),
                    2.00,
                    "default-bold",
                    "center",
                    "center",
                    false,
                    false,
                    false,
                    false,
                    false
                )
            end
        end
        if g_currentDuel == true then
            local wepID = getPedWeapon(localPlayer)
            if wepID and wepID ~= 0 then
                if not getDuelWeapons()[wepID] then
                    triggerServerEvent(getResourceName(getThisResource()) .. ":takeMyWepInDuel", localPlayer, wepID)
                end
            end
        end
    end
)

function cerrar()
    destroyElement(Duelo[0])
    showCursor(false)
    guiSetInputMode("allow_binds")
end

function abrirgui()
    --Creacion del GUI
    local screenW, screenH = guiGetScreenSize()
    guiSetInputMode("no_binds_when_editing")
    showCursor(true)
    Duelo[0] = guiCreateWindow((screenW - 524) / 2, (screenH - 504) / 2, 524, 504, "CVR DUELOS", false)
    guiWindowSetSizable(Duelo[0], false)
    Duelo[1] = guiCreateLabel(11, 30, 503, 26, "Seleccione a quien va a retar", false, Duelo[0])
    Duelo[3] = guiCreateGridList(11, 98, 503, 140, false, Duelo[0])
    Jugadorescolumna = guiGridListAddColumn(Duelo[3], "Jugadores", 0.9)
    Duelo[2] = guiCreateEdit(11, 62, 503, 26, "", false, Duelo[0])
    Duelo[4] = guiCreateLabel(0.02, 0.48, 0.96, 0.06, "En que mapa:", true, Duelo[0])
    Duelo[5] = guiCreateGridList(10, 271, 503, 140, false, Duelo[0])
    mapa = guiGridListAddColumn(Duelo[5], "Mapa", 0.9)
    Duelo[6] = guiCreateLabel(10, 421, 501, 20, "Apuesta", false, Duelo[0])
    Duelo[7] = guiCreateEdit(11, 451, 233, 26, "", false, Duelo[0])
    guiSetProperty(Duelo[7], "ValidationString", "[0-9]*")
    Duelo[8] = guiCreateButton(256, 451, 258, 28, "¡ RETAR !", false, Duelo[0])
    Duelo[9] = guiCreateButton(475, 22, 39, 18, "X", false, Duelo[0])
    Duelo[10] = guiCreateLabel(256, 430, 258, 28, "", false, Duelo[0])
    guiLabelSetColor(Duelo[10], 255, 0, 0)

    --Evento Cerrar GUI
    addEventHandler("onClientGUIClick", Duelo[9], cerrar)

    --LLenar la tabla de jugadores
    LLenarJugadores()

    --Evento Buscar Jugadores
    addEventHandler(
        "onClientGUIChanged",
        Duelo[2],
        function(element)
            guiGridListClear(Duelo[3])
            if guiGetText(element) ~= "" then
                for i, v in ipairs(getElementsByType "player") do
                    if
                        string.find(
                            string.lower(string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", "")),
                            string.lower(guiGetText(element))
                        )
                     then
                        if v~=localPlayer then
                            if getPlayerTeam(v)~=getTeamFromName("Services") and getPlayerTeam(v)~=getTeamFromName("Emergency") and not(getElementData(v,"isPassive")) then

                                guiGridListAddRow(Duelo[3], getPlayerName(v))
                            end
                            
                        end
                    end
                end
            else
                LLenarJugadores()
            end
        end
    )

    --Obtener Mapas

    for k, v in pairs(getmapas()) do
        guiGridListAddRow(Duelo[5], k)
    end

    addEventHandler(
        "onClientGUIClick",
        Duelo[8],
        function()
            if guiGridListGetSelectedItem(Duelo[3]) == -1 then
                guiSetText(Duelo[10], "Seleccione un jugador")
                return
            end
            if guiGridListGetSelectedItem(Duelo[5]) == -1 then
                guiSetText(Duelo[10], "Seleccione un mapa")
                return
            end

            triggerServerEvent(
                "Duelos::Retar",
                resourceRoot,
                localPlayer,
                "",
                guiGridListGetItemText(Duelo[3], guiGridListGetSelectedItem(Duelo[3]), Jugadorescolumna),
                guiGetText(Duelo[7]),
                guiGridListGetItemText(Duelo[5], guiGridListGetSelectedItem(Duelo[5]), mapa)
            )
            cerrar()
        end
    )
end
addEvent( "duelos.gui", true )
addEventHandler( "duelos.gui", localPlayer, abrirgui )

function LLenarJugadores()
    for k, player in ipairs(getElementsByType("player")) do
        if player ~= localPlayer then
        if getPlayerTeam(player)~=getTeamFromName("Services") and getPlayerTeam(player)~=getTeamFromName("Emergency") and not(getElementData(player,"isPassive")) then
         guiGridListAddRow(Duelo[3], getPlayerName(player))
        end
        end
    end
end
