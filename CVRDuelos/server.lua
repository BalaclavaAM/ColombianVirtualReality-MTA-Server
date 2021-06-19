local g_currentDuel = {}
local g_duelChallenger = {}
local g_duelChallengePrice = {}

local g_duelReady = {}
local g_duelSpawn = {}
local g_duelRound = {}
local g_duelTimer = {}
local g_duelPoint = {}
local customm={}
local g_lastPosition = {}
local g_savedWeapons = {}
local localbackup={}


addEvent("onPlayerStartDuel", true)
addEvent("onPlayerDuelReady", true)

addEvent("onDuelStarting", true)
addEvent("onDuelRoundStarting", true)
addEvent("onDuelRoundStarted", true)
addEvent("onDuelRoundEnd", true)
addEvent("onDuelEnd", true)
addEvent("onDuelEnded", true)

function table.removeValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            table.remove(tab, index)
            return index
        end
    end
    return false
end
function darArmas(player, armas)
    setTimer(
        function(player, armas)
            for wep, ammo in pairs(armas) do
                local newWep = tonumber(wep) or 0
                local newAmmo = tonumber(ammo) or 0
                if (isElement(player) and getElementType(player) == "player") then
                    giveWeapon(player, newWep, newAmmo, false)
                end
            end
        end,
        3000,
        1,
        player,
        armas
    )
end

function challengePlayer(plr, cmd, challenger, price, custom)
    if getTeamName(getPlayerTeam(plr))=="Services" or getTeamName(getPlayerTeam(plr))=="Emergency" or getElementData(plr,"isPassive") then
        return
    end
    if challenger==nul then
        triggerClientEvent(plr, "duelos.gui", plr)
    end
    if plr and challenger then
        if isElement(g_currentDuel[plr]) then
            outputChatBox("#FF0000[CVR]#FFFFFF Ya estás en un duelo!", plr, 255, 255, 255, true)
            return
        end
        local opp = tostring(challenger)
        if opp then
            local players = getPlayersWithName(opp)
            if #players == 0 then
                outputChatBox("#FF0000[CVR]#FFFFFF No existe un jugador con ese nombre", plr, 255, 255, 255, true)
                return
            end
            if #players == 1 and players[1] == plr then
                outputChatBox("#FF0000[CVR]#FFFFFF No te puedes retar a ti mismo, bobotron", plr, 255, 255, 255, true)
                return
            end
            if #players > 1 then
                outputChatBox("#FF0000[CVR]#FFFFFF Jugadores con ese nick:", plr, 255, 255, 255, true)
                for i, v in pairs(players) do
                    outputChatBox(getPlayerName(v), plr, 255, 255, 255, true)
                end
                return
            end
            if #players == 1 and players[1] ~= plr then
                local price = tonumber(price) or 0
                if price < 0 then
                    price = 0
                end
                price = math.ceil(price)

                if not g_duelChallenger[players[1]] then
                    g_duelChallenger[players[1]] = nil
                end
                if isElement(g_currentDuel[players[1]]) then
                    outputChatBox("#FF0000[CVR]#FFFFFF Este jugador ya está en un duelo!", plr, 255, 255, 255, true)
                    return
                end
                if isElement(g_duelChallenger[players[1]]) then
                    outputChatBox(
                        "#FF0000[CVR]#FFFFFF Este jugador ya fue retado, intenta luego!",
                        plr,
                        255,
                        255,
                        255,
                        true
                    )
                    return
                end
                local money = getPlayerMoney(plr)
                local money2 = getPlayerMoney(players[1])
                local interior = getElementInterior(plr)
                local interior2 = getElementInterior(players[1])
                local dimension = getElementDimension(plr)
                local dimension2 = getElementDimension(players[1])
                if (interior == 0 and interior2 == 0) and (dimension == 0 and dimension2 == 0) then
                    if money >= price then
                        if money2 >= price then
                            exports["NGMessages"]:sendClientMessage(
                                "#81F7F3El jugador #5882FA" ..
                                    getPlayerName(plr) ..
                                        " #81F7F3retó a#5882FA " .. getPlayerName(players[1]) .. "#81F7F3 a un duelo!",
                                root,
                                255,
                                0,
                                0
                            )
                            outputChatBox(
                                "#FF0000[CVR]#FFFFFF Has retado a " ..
                                    getPlayerName(players[1]) .. "#FFFFFF a un duelo por #00FF00$" .. price,
                                plr,
                                255,
                                255,
                                255,
                                true
                            )
                            outputChatBox(
                                "#FF0000[CVR]#FFFFFF " ..
                                    getPlayerName(plr) .. "#FFFFFF te ha retado a un duelo por #00FF00$" .. price,
                                players[1],
                                255,
                                255,
                                255,
                                true
                            )
                            outputChatBox(
                                "#FF0000[CVR]#FFFFFF Para aceptar el duelo usa #00ff00/aceptarduelo",
                                players[1],
                                255,
                                255,
                                255,
                                true
                            )
                            g_duelChallenger[players[1]] = plr
                            g_duelChallengePrice[players[1]] = price
                            if custom~=nil then
                                customm[plr]=custom
                                else
                                customm[plr]="Oficina"
                            end
                            setTimer(
                                function(plr)
                                    if isElement(plr) and g_duelChallenger[plr] then
                                        g_duelChallenger[plr] = nil
                                    end
                                end,
                                15000,
                                1,
                                players[1]
                            )

                            return true
                        else
                            outputChatBox(
                                "#FF0000[CVR]#FFFFFF El jugador no tiene suficiente dinero para retarlo",
                                plr,
                                255,
                                255,
                                255,
                                true
                            )
                        end
                    else
                        outputChatBox(
                            "#FF0000[CVR]#FFFFFF Tú no tienes suficiente dinero para el duelo",
                            plr,
                            255,
                            255,
                            255,
                            true
                        )
                    end
                else
                    outputChatBox("#FF0000[CVR]#FFFFFF Estás en un interior bobotron", plr, 255, 255, 255, true)
                end
            end
        end
    end
end
addEvent("Duelos::Retar", true)
addEventHandler("Duelos::Retar", resourceRoot, challengePlayer)
addCommandHandler("duelo", challengePlayer)

function acceptPlayer(plr, cmd)
    if plr then
        if isElement(g_currentDuel[plr]) then
            outputChatBox("#FF0000[CVR]#FFFFFF Ya estás en un duelo!", plr, 255, 255, 255, true)
            return
        end
        if isElement(g_currentDuel[g_duelChallenger[plr]]) then
            outputChatBox("#FF0000[CVR]#FFFFFF Este jugador ya está en un duelo!", plr, 255, 255, 255, true)
            return
        end
        if
            g_duelChallenger[plr] and isElement(g_duelChallenger[plr]) and
                getElementType(g_duelChallenger[plr]) == "player"
         then
            local money = getPlayerMoney(plr)
            local money2 = getPlayerMoney(g_duelChallenger[plr])
            if money >= g_duelChallengePrice[plr] then
                if money2 >= g_duelChallengePrice[plr] then
                    exports["NGMessages"]:sendClientMessage(
                        "#81F7F3El jugador #5882FA" ..
                            getPlayerName(plr) ..
                                " #81F7F3aceptó el duelo de #5882FA" ..
                                    getPlayerName(g_duelChallenger[plr]) .. "#81F7F3!",
                        root,
                        255,
                        0,
                        0
                    )
                    outputChatBox(
                        "#FF0000[CVR]#FFFFFF Aceptaste el duelo de " .. getPlayerName(g_duelChallenger[plr]) .. "._.XD",
                        plr,
                        255,
                        255,
                        255,
                        true
                    )
                    outputChatBox(
                        "#FF0000[CVR]#FFFFFF " .. getPlayerName(plr) .. "#FFFFFF ha aceptado tu duelo!",
                        g_duelChallenger[plr],
                        255,
                        255,
                        255,
                        true
                    )

                    g_currentDuel[plr] = g_duelChallenger[plr]
                    g_currentDuel[g_duelChallenger[plr]] = plr

                    g_duelReady[plr] = nil
                    g_duelReady[g_duelChallenger[plr]] = nil

                    g_duelChallengePrice[g_duelChallenger[plr]] = g_duelChallengePrice[plr]

                    triggerEvent("onPlayerStartDuel", plr)
                    triggerEvent("onPlayerStartDuel", g_duelChallenger[plr])

                    g_duelChallenger[plr] = nil

                    return true
                else
                    outputChatBox(
                        "#FF0000[CVR]#FFFFFF Este jugador no tiene suficiente dinero para el duelo",
                        plr,
                        255,
                        255,
                        255,
                        true
                    )
                end
            else
                outputChatBox(
                    "#FF0000[CVR]#FFFFFF Tú no tienes suficiente dinero para el duelo",
                    plr,
                    255,
                    255,
                    255,
                    true
                )
            end
        else
            outputChatBox("#FF0000[CVR]#FFFFFF No tienes duelos pendientes!", plr, 255, 255, 255, true)
        end
    end
end
addCommandHandler("duelaccept", acceptPlayer)
addCommandHandler("aceptarduelo", acceptPlayer)

function endDuel(plr)
    if plr and isElement(plr) and getElementType(plr) == "player" then
        local s1 = g_lastPosition[plr]
        if isPedDead(plr) then
            local spawn1 = spawnPlayer(plr, s1.x, s1.y, s1.z, s1.rot, s1.skin, 0, 0)
        else
            setElementPosition(plr, s1.x, s1.y, s1.z)
            setElementRotation(plr, 0, 0, s1.rot)
            setElementDimension(plr, 0)
            setElementInterior(plr, 0)
        end
        takeAllWeapons(plr)
        local w1 = g_savedWeapons[getPlayerAccount(plr)]
        
        setTimer(
            function(plr, spawn1, w1)
                darArmas(plr, w1)
            end,
            3000,
            1,
            plr,
            spawn1,
            w1
        )
        setTimer(
            function()
                
                g_currentDuel[plr] = nil

                g_duelChallenger[plr] = nil

                g_duelReady[plr] = nil

                g_duelRound[plr] = 0

                g_duelPoint[plr] = 0

                g_duelTimer[plr] = nil

                g_lastPosition[plr] = nil

                g_savedWeapons[getPlayerAccount(plr)] = nil

                localbackup[plr]=nil
                
                

                g_duelChallengePrice[plr] = nil

                fadeCamera(plr, true)

                triggerEvent("NGHospitals:enableRespawn", plr)
                triggerEvent("NGSQL:PonerHandlerQuit",plr)
                removeEventHandler("onPlayerWasted", plr, handlermuerte)

                triggerEvent("onDuelEnded", plr)
                triggerClientEvent(plr, "onDuelEnded", plr)
            end,
            5000,
            1
        )
        return true
    end
end

addEventHandler(
    "onPlayerStartDuel",
    root,
    function()

        local x, y, z = getElementPosition(source)
        local int, dim = getElementInterior(source), getElementDimension(source)
        local rx, ry, rz = getElementRotation(source)
        local skin = getElementModel(source) or 0
        local weapons = getWeapons(source) or {}
        g_lastPosition[source] = {x = x, y = y, z = z, int = int, dim = dim, rot = rz, skin = skin}
        g_savedWeapons[getPlayerAccount(source)] = weapons
        local weapons2={}
        for i=1,12 do
            weapons2[i] = { getPedWeapon ( source, i ), getPedTotalAmmo ( source, i ) }
        end
        local weapons2 = toJSON ( weapons2 )
        localbackup[source]=weapons2
        takeAllWeapons(source)

        setPlayerMoney(source, getPlayerMoney(source) - g_duelChallengePrice[source])

        fadeCamera(source, false)
        g_duelReady[source] = true

        triggerClientEvent(source, "onClientPlayerStartDuel", source)
        triggerEvent("onPlayerDuelReady", source)
    end
)

addEventHandler(
    "onPlayerDuelReady",
    root,
    function()
        local opp = g_currentDuel[source]
        if opp and isElement(opp) then
            if g_duelReady[opp] == true then
                outputChatBox("#FF0000[CVR]#FFFFFF El duelo está a punto de empezar..", source, 255, 255, 255, true)
                outputChatBox("#FF0000[CVR]#FFFFFF El duelo está a punto de empezar..", opp, 255, 255, 255, true)
                
                triggerEvent("onDuelStarting", resourceRoot, source, opp)
            else
                outputChatBox("#FF0000[CVR]#FFFFFF Esperando a tu oponente..", source, 255, 255, 255, true)
            end
        end
    end
)

addEventHandler(
    "onDuelStarting",
    root,
    function(plr1, plr2)
        outputChatBox(inspect())
        
        local position = getDuelSpawns(customm[plr1])
        local dimension = getFreeDuelDimension()
        

        if position and dimension then
            local skin1 = getElementModel(plr1) or 0
            local skin2 = getElementModel(plr2) or 0

            local pos1 = {
                x = tonumber(position[1][1]),
                y = tonumber(position[1][2]),
                z = tonumber(position[1][3]),
                rot = tonumber(position[1][4]),
                int = tonumber(position[1][5]),
                dim = tonumber(dimension),
                skin = skin1
            }
            local pos2 = {
                x = tonumber(position[2][1]),
                y = tonumber(position[2][2]),
                z = tonumber(position[2][3]),
                rot = tonumber(position[2][4]),
                int = tonumber(position[2][5]),
                dim = tonumber(dimension),
                skin = skin2
            }

            if pos1 and pos2 then
                g_duelSpawn[plr1] = pos1
                g_duelSpawn[plr2] = pos2

                g_duelRound[plr1] = 0
                g_duelRound[plr2] = g_duelRound[plr1]

                g_duelPoint[plr1] = 0
                g_duelPoint[plr2] = 0
                --ASH
                triggerEvent("NGHospitals:disableRespawn", plr1)
                triggerEvent("NGSQL:QuitarHandlerQuit",plr1)
                addEventHandler("onPlayerWasted", plr1, handlermuerte)
                triggerEvent("NGHospitals:disableRespawn", plr2)
                triggerEvent("NGSQL:QuitarHandlerQuit",plr2)
                addEventHandler("onPlayerWasted", plr2, handlermuerte)
                --ASH
                triggerEvent("onDuelRoundStarting", resourceRoot, plr1, plr2)
                fadeCamera(plr1, true)
                fadeCamera(plr2, true)
            end
        end
    end
)

addEventHandler(
    "onDuelRoundStarting",
    root,
    function(plr1, plr2)
        g_duelRound[plr1] = g_duelRound[plr1] + 1
        g_duelRound[plr2] = g_duelRound[plr1]

        outputChatBox("#FF0000[CVR]#FFFFFF Ronda " .. g_duelRound[plr1] .. " comenzando", plr1, 255, 255, 255, true)
        outputChatBox("#FF0000[CVR]#FFFFFF Ronda " .. g_duelRound[plr1] .. " comenzando", plr2, 255, 255, 255, true)

        if g_duelSpawn[plr1] and g_duelSpawn[plr2] then
            local s1 = g_duelSpawn[plr1]
            local s2 = g_duelSpawn[plr2]
            local spawn1 = spawnPlayer(plr1, s1.x, s1.y, s1.z, s1.rot, s1.skin, s1.int, s1.dim)
            local spawn2 = spawnPlayer(plr2, s2.x, s2.y, s2.z, s2.rot, s2.skin, s2.int, s2.dim)
            setPedArmor(plr1, 100)
            setPedArmor(plr2, 100)
            --ASH

            local duelWeps = getDuelWeapons() or {}
            for wep,ammo in pairs(duelWeps) do
                local newWep = tonumber(wep) or 0
                local newAmmo = tonumber(ammo) or 0
                giveWeapon(plr1,newWep,newAmmo)
                giveWeapon(plr2,newWep,newAmmo)
            end

            setElementFrozen(plr1, true)
            setElementFrozen(plr2, true)

            fadeCamera(plr1, true)
            fadeCamera(plr2, true)

            if isTimer(g_duelTimer[plr1]) then
                killTimer(g_duelTimer[plr1])
            end

            g_duelTimer[plr1] =
                setTimer(
                function(plr1, plr2)
                    if not isElement(plr1) then
                        endDuel(plr2)
                    elseif not isElement(plr2) then
                        endDuel(plr1)
                    end
                    if isElement(plr1) and isElement(plr2) then
                        triggerEvent("onDuelRoundStarted", resourceRoot, plr1, plr2)
                    end
                end,
                5000,
                1,
                plr1,
                plr2
            )
            g_duelTimer[plr2] = g_duelTimer[plr1]
            local remaining = getTimerDetails(g_duelTimer[plr2])
            triggerClientEvent(plr1, getResourceName(getThisResource()) .. ":sendTimerToClient", plr1, remaining)
            triggerClientEvent(plr2, getResourceName(getThisResource()) .. ":sendTimerToClient", plr2, remaining)
        end
    end
)

addEventHandler(
    "onDuelRoundStarted",
    root,
    function(plr1, plr2)
        setElementData(plr1, "isGodmodeEnabled", false)
        setElementData(plr1, "isSpawnProtectionEnabled", false)
        setElementAlpha(plr1, 255)

        toggleControl(plr1, "fire", true)
        toggleControl(plr1, "next_weapon", true)
        toggleControl(plr1, "previous_weapon", true)
        setElementData(plr2, "isGodmodeEnabled", false)
        setElementData(plr2, "isSpawnProtectionEnabled", false)
        setElementAlpha(plr2, 255)

        toggleControl(plr2, "fire", true)
        toggleControl(plr2, "next_weapon", true)
        toggleControl(plr2, "previous_weapon", true)
        outputChatBox(
            "#FF0000[CVR]#FFFFFF La ronda ha comenzado, mata a #FF0000" .. getPlayerName(plr2),
            plr1,
            255,
            255,
            255,
            true
        )
        outputChatBox(
            "#FF0000[CVR]#FFFFFF La ronda ha comenzado, mata a #FF0000" .. getPlayerName(plr1),
            plr2,
            255,
            255,
            255,
            true
        )
        exports["NGMessages"]:sendClientMessage(
            "#81F7F3Comenzó el duelo de #5882FA" ..
                getPlayerName(plr1) .. " #81F7F3contra #5882FA" .. getPlayerName(plr2) .. "#81F7F3!",
            root,
            255,
            0,
            0
        )
        setElementFrozen(plr1, false)
        setElementFrozen(plr2, false)
    end
)

addEventHandler(
    "onDuelRoundEnd",
    root,
    function(plr1, plr2)
        fadeCamera(plr1, false)
        fadeCamera(plr2, false)

        --if g_duelRound[plr1] == getMaxDuelRounds() then
        if g_duelRound[plr1] == getMaxDuelRounds() then
            triggerEvent("onDuelEnd", resourceRoot, plr1, plr2)
            return
        end
        triggerEvent("onDuelRoundStarting", resourceRoot, plr1, plr2)
    end
)

addEventHandler(
    "onDuelEnd",
    root,
    function(plr1, plr2)
        outputChatBox("#FF0000[CVR]#FFFFFF El duelo ha #FF0000terminado", plr1, 255, 255, 255, true)
        outputChatBox("#FF0000[CVR]#FFFFFF El duelo ha #FF0000terminado", plr2, 255, 255, 255, true)
        if g_duelPoint[plr1] > g_duelPoint[plr2] then
            exports["NGMessages"]:sendClientMessage(
                "#81F7F3El jugador #5882FA" ..
                    getPlayerName(plr1) .. " #81F7F3ganó el duelo contra #5882FA " .. getPlayerName(plr2) .. "#81F7F3!",
                root,
                255,
                0,
                0
            )
            outputChatBox(
                "#FF0000[CVR]#FFFFFF " .. getPlayerName(plr1) .. "#FFFFFF ha #00ff00ganado#FFFFFF el duelo",
                plr1,
                255,
                255,
                255,
                true
            )
            if (tonumber(g_duelChallengePrice[plr1]) > 50000) then
                triggerClientEvent(plr1, "UpdateDuelo", plr1)
                outputChatBox("#FF0000[CVR]#FFFFFF Duelo válido", plr1, 255, 255, 255, true)
            else
                outputChatBox(
                    "#FF0000[CVR]#FFFFFF Como apostaste menos de 51.000 no se suma a tus duelos",
                    plr1,
                    255,
                    255,
                    255,
                    true
                )
            end
            outputChatBox(
                "#FF0000[CVR]#FFFFFF " .. getPlayerName(plr1) .. "#FFFFFF ha #FF0000ganado#FFFFFF el duelo",
                plr2,
                255,
                255,
                255,
                true
            )
            setPlayerMoney(plr1, getPlayerMoney(plr1) + tonumber(g_duelChallengePrice[plr1] * 2))
        elseif g_duelPoint[plr2] > g_duelPoint[plr1] then
            exports["NGMessages"]:sendClientMessage(
                "#81F7F3El jugador #5882FA" ..
                    getPlayerName(plr2) .. " #81F7F3ganó el duelo contra #5882FA " .. getPlayerName(plr1) .. "#81F7F3!",
                root,
                255,
                0,
                0
            )
            outputChatBox(
                "#FF0000[CVR]#FFFFFF " .. getPlayerName(plr2) .. "#FFFFFF ha #00ff00ganado#FFFFFF el duelo",
                plr2,
                255,
                255,
                255,
                true
            )
            if (tonumber(g_duelChallengePrice[plr2]) > 50000) then
                triggerClientEvent(plr2, "UpdateDuelo", plr2)
                outputChatBox("#FF0000[CVR]#FFFFFF Duelo válido", plr2, 255, 255, 255, true)
            else
                outputChatBox(
                    "#FF0000[CVR]#FFFFFF Como apostaste menos de 51.000 no se suma a tus duelos",
                    plr2,
                    255,
                    255,
                    255,
                    true
                )
            end
            outputChatBox(
                "#FF0000[CVR]#FFFFFF " .. getPlayerName(plr2) .. "#FFFFFF ha #FF0000ganado#FFFFFF el duelo",
                plr1,
                255,
                255,
                255,
                true
            )
            setPlayerMoney(plr2, getPlayerMoney(plr2) + tonumber(g_duelChallengePrice[plr2] * 2))
        elseif g_duelPoint[plr2] == g_duelPoint[plr1] then
            exports["NGMessages"]:sendClientMessage(
                "#81F7F3El duelo entre #5882FA" ..
                    getPlayerName(plr2) .. " #81F7F3y #5882FA " .. getPlayerName(plr1) .. "#81F7F3terminó empatado!",
                root,
                255,
                0,
                0
            )
            outputChatBox("#FF0000[CVR]#FFFFFF El duelo terminó #FFFF00empatado", plr1, 255, 255, 255, true)
            outputChatBox("#FF0000[CVR]#FFFFFF El duelo terminó #FFFF00empatado", plr2, 255, 255, 255, true)
        else
            outputChatBox("#FF0000[CVR]#FFFFFF No se pudo determinar el ganador del duelo", plr1, 255, 255, 255, true)
            outputChatBox("#FF0000[CVR]#FFFFFF No se pudo determinar el ganador del duelo", plr1, 255, 255, 255, true)
        end

        endDuel(plr1)
        endDuel(plr2)
    end
)
--ASH
function handlermuerte()
    local roundWinner = g_currentDuel[source]
    if roundWinner then
        fadeCamera(source, false)
        fadeCamera(roundWinner, false)
        if getElementHealth(roundWinner) > 0 then
            g_duelPoint[roundWinner] = g_duelPoint[roundWinner] + 1
            outputChatBox(
                "#FF0000[DUEL]#FFFFFF Tú has #00FF00ganado#FFFFFF la ronda. (#00FF00" ..
                    g_duelPoint[roundWinner] .. "#FFFFFF-#FF0000" .. g_duelPoint[source] .. "#FFFFFF)",
                roundWinner,
                255,
                255,
                255,
                true
            )
            outputChatBox(
                "#FF0000[DUEL]#FFFFFF Tú has #FF0000perdido#FFFFFF la ronda. (#00FF00" ..
                    g_duelPoint[source] .. "#FFFFFF-#FF0000" .. g_duelPoint[roundWinner] .. "#FFFFFF)",
                source,
                255,
                255,
                255,
                true
            )
            triggerEvent("onDuelRoundEnd", resourceRoot, roundWinner, source)
            cancelEvent()
        else
            outputChatBox(
                "#FF0000[DUEL]#FFFFFF Ambos jugadores murieron, reiniciando la ronda",
                roundWinner,
                255,
                255,
                255,
                true
            )
            outputChatBox(
                "#FF0000[DUEL]#FFFFFF Ambos jugadores murieron, reiniciando la ronda",
                source,
                255,
                255,
                255,
                true
            )
            g_duelRound[roundWinner] = g_duelRound[roundWinner] - 1
            g_duelRound[source] = g_duelRound[roundWinner]
            triggerEvent("onDuelRoundEnd", resourceRoot, roundWinner, source)
            cancelEvent()
        end
    end
end
--ASH
addEventHandler(
    "onVehicleEnter",
    root,
    function(plr)
        if g_currentDuel[plr] and isElement(g_currentDuel[plr]) then
            destroyElement(source)
        end
    end
)

addEvent(getResourceName(getThisResource()) .. ":takeMyWepInDuel", true)
addEventHandler(
    getResourceName(getThisResource()) .. ":takeMyWepInDuel",
    root,
    function(id)
        if id then
            if id ~= 0 and not getDuelWeapons()[id] then
                takeWeapon(source, id)
            --giveWeapon(source,31,1000)
            --giveWeapon(source,28,1000)
            end
        end
    end
)

addEvent(getResourceName(getThisResource()) .. ":destroyVehicleInDuel", true)
addEventHandler(
    getResourceName(getThisResource()) .. ":destroyVehicleInDuel",
    root,
    function(veh)
        if veh and isElement(veh) then
            destroyElement(veh)
        end
    end
)

addEventHandler(
    "onPlayerQuit",
    root,
    function()
        
        local opp = g_currentDuel[source]
        if opp then
            local money = tonumber(g_duelChallengePrice[opp])
            if money then
                setPlayerMoney(opp, getPlayerMoney(opp) + tonumber(money * 2))
            end
            endDuel(opp)
            local cuentadelveneco=getAccountName(getPlayerAccount(source)  ) 
            local s1 = g_lastPosition[source]

            exports['NGSQL']:db_exec ( "UPDATE `accountdata` SET `x`=?,`y`=?,`z`=?,`Interior`=?,`Dimension`=?,`Weapons`=? WHERE `Username`=?",s1.x, s1.y, s1.z,0,0,localbackup[source],cuentadelveneco)
            localbackup[source]=nil
        end
        if isTimer(Spawneo) then
            killTimer( Spawneo )
        end
    end
)

function isPlayerInDuel(plr)
    if plr and isElement(plr) and getElementType(plr) == "player" then
        if g_currentDuel[plr] then
            return true
        end
    end
end

