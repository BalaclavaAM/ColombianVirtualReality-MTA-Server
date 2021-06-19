local players = {}
local lastposition={}
local infoPlayer={}
local weapons = {}
local startCords = {
    {607.57, 2405.73, 323.55},
    {624.39, 2406.06, 323.55},
    {633.96, 2423.27, 327.55},
    {625, 2424.06, 318.56},
    {601.79, 2424.15, 311.31},
    {584.09, 2448.16, 316.06},
    {585.34, 2416.24, 319.05},
    {582.95, 2424.64, 323.8},
    {592.89, 2418.77, 327.3},
    {601.84, 2449.21, 324.05}
}
local started = false

function enterHalo()
    EncerronaEntrada(source,true)
end 
addEvent("CVREncerrona:entrarHalo",true)
addEventHandler("CVREncerrona:entrarHalo",root,enterHalo)

function ventanaHalo(pl)
    local titulo= "CVR Presenta: Halo Encerrona"
    local desc="En este minijuego te llevaremos a esos viejos tiempos donde jugaras Halo y haras la encerrona.\nEn este minijuego te daremos las legendarias armas de changon y espada para que mates a todos.\nComandos del minijuego:\n/forzarchangon: este comando forza el inicio del minijuego y solo lo puede activar un vip diamante o superior\n/salirchangon: Este comando sirve para salirte del minijuego."
    triggerClientEvent(pl,"NGMisc:CreateConfirmPanel",pl,titulo,desc,"CVREncerrona:entrarHalo")
end
addCommandHandler("halo",ventanaHalo)
local timers={}
function getPedWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
        for i=1,12 do
            local wep = getPedWeapon(ped,i)
            local ammo = getPedTotalAmmo (ped,i) 
            if wep and wep ~= 0 and ammo and wep ~= 40 then
                playerWeapons[wep] = ammo
            end
        end
    else
        return false
    end
    return playerWeapons
end


function getWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) then
        for i=1,12 do
            local wep = getPedWeapon(ped,i)
            local ammo = getPedTotalAmmo (ped,i) 
            if wep and wep ~= 0 and wep~=40 and ammo then
                playerWeapons[wep] = ammo
            end
        end
        return playerWeapons
    end
end



function spawner(player,frozen)
    if players[player] then
        if isElement(player) and getElementType(player) == "player" then
            local x,y,z = unpack ( startCords [ math.random ( #startCords ) ] )
            local locura = spawnPlayer(player,x,y,z,0,70,0,40,getPlayerTeam(player))
            setTimer(function(player)
                giveWeapon ( player,8,999,true )
                giveWeapon ( player,25,9999,false )
            end,
            1500,1,player
            )
            if frozen then
                setElementFrozen( player, true )
            end
            if locura then
                return true
            else
                return false
            end
        end
    end
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

local CHANGON = createMarker(1367.99, -1768.71, 12.64, "cylinder", 1.5, 255, 255, 0, 170)

function comenzarJuego(forzado)
    if table.size(players)>(getPlayerCount()*1) or forzado then
        for player,bool in pairs(players) do
            if player and isElement(player) and getElementType(player) == "player" then
                setElementFrozen(player,false)
                setElementData(player,"isPassive",false)
                started=true
                outputChatBox("#004176[#82C5FDEspada y Changón#004176]#B4DDFFHa comenzado la ronda, a dar CHANGON Y ESCOPETA",player,255,0,0,true)
            end
        end
    end
end

function forcestart(player)
    if getElementData(player,"VIP") == "Diamond" or getElementData(player,"VIP") == "Esmeralda" or exports['NGAdministration']:isPlayerStaff(player) then
        comenzarJuego(true)
    end
end
addCommandHandler("forzarchangon",forcestart)

function darArmas(player,armas)
    outputDebugString("Dandole armas a "..getPlayerName(player))
    setTimer(function(player,armas)
        for wep,ammo in pairs(armas) do
            local newWep = tonumber(wep) or 0
            local newAmmo = tonumber(ammo) or 0
            if (isElement(player) and getElementType(player) == "player" ) then
                giveWeapon(player,newWep,newAmmo,false)
            end 
        end
    end,3000,1,player,armas)
end

function exitGameQuit(source)
    if players[source] then
        local informacion = (infoPlayer[source])
        spawnPlayer(source,informacion.x, informacion.y,informacion.z,informacion.rot,informacion.skin,informacion.int,informacion.dim,getPlayerTeam(source))
        setElementData (source, "wp" , informacion.wp)
        local armas = weapons[source]
        darArmas(source, armas)
        players[source]=nil
        weapons[source]=nil
        infoPlayer[source]=nil
    end
end

function exitGame(player)
    if players[player] then
        if isElement(player) then
            local informacion = (infoPlayer[player])
            spawnPlayer(player,informacion.x, informacion.y,informacion.z,informacion.rot,informacion.skin,informacion.int,informacion.dim,getPlayerTeam(player))
            setElementData (player, "wp" , informacion.wp)
            local armas = weapons[player]
            darArmas(source, armas)
            triggerEvent("NGHospitals:enableRespawn",player)
            removeEventHandler("onPlayerWasted",player,muerte)
            players[player]=nil
            weapons[player]=nil
            infoPlayer[player]=nil
            if table.size(players)==0 then
                started=false
                outputChatBox("El minijuego #82C5FDEspada y Changón #FFFFFha terminado",root,0,0,0)
            end
        end
    end
end
addCommandHandler("salirchangon",exitGame)


function finishGame(killer)
    for player,kills in pairs(players) do
        if timers[player] and isTimer(timers[player]) then
            killTimer(timers[player])
        end
       exitGame(player) 
    end
    outputChatBox("El ganador de #82C5FDEspada y Changón#004176#FFFFFF es "..getPlayerName(killer),root,255,0,0,true)
end

function muerte(ammo, attacker, weapon, bodypart)
    if (players[source]) and isElement(source) then
        if attacker then
            if not(attacker==source) and players[attacker] then
                players[attacker]=players[attacker]+1
                outputChatBox("#004176[#82C5FDEspada y Changón#004176]#B4DDFFHas asesinado a "..getPlayerName(source).." ,llevas "..tostring(players[attacker]).." kills, son "..get("kills").." para ganar",attacker,255,0,0,true)
            end
            if players[attacker]>=tonumber(get("kills")) then
                finishGame(attacker)
            else
                triggerClientEvent(source,"playRespawn",source)
                timers[source]=setTimer(function(source)
                    spawner(source,false)
                end,4000,1,source)
            end
        else
            triggerClientEvent(source,"playRespawn",source)
            timers[source]=setTimer(function(source)
                spawner(source,false)
            end,4000,1,source)
        end
    end
end


addEventHandler("onPlayerQuit",root,exitGameQuit)

function EncerronaEntrada(hitElement,matchingDimension)
    if isElement(hitElement) and getElementType(hitElement) == "player" then
        if getElementData(hitElement,"Job") == "UnEmployed" then
            if not(exports['NGPolice']:isPlayerJailed(hitElement)) then
                if not started then
                    local x,y,z = getElementPosition(hitElement)
                    local int,dim = getElementInterior(hitElement), getElementDimension(hitElement)
                    local rx,ry,rz = getElementRotation(hitElement)
                    local skin = getElementModel(hitElement) or 0
                    local armas=getWeapons(hitElement) or {}
                    local wp = getElementData ( hitElement, "WantedPoints" ) 
                    infoPlayer[hitElement] = {x=x,y=y,z=z,int=int,dim=dim,rot=rz,skin=skin,wp=wp}
                    if armas then
                        if matchingDimension then
                            players[hitElement]=0
                            setElementData(hitElement,"isPassive",true)
                            if spawner(hitElement,true) then
                                triggerClientEvent(hitElement,"playAsesino",hitElement)
                                weapons[hitElement]=armas
                                outputChatBox("#004176[#82C5FDEspada y Changón#004176]#B4DDFFHas entrado al minijuego de ENCERRONA",hitElement,255,0,0,true)
                                outputChatBox("#004176[#82C5FDEspada y Changón#004176]#B4DDFFPara salir usa #FF5A5A/salirchangon",hitElement,255,0,0,true)
                                comenzarJuego(false)
                                addEventHandler("onPlayerWasted",hitElement,muerte)
                                triggerEvent("NGHospitals:disableRespawn",hitElement)
                            end
                        else
                            outputChatBox("No estás en la misma dimensión que el marcador",hitElement,255,0,0,false)
                        end
                    else
                        outputChatBox("No tienes armas, o no pudimos obtenerlas, relogea.",hitElement,255,0,0,false)
                    end
                else
                    outputChatBox("La partida de changon y espada ya comenzó, espera que termine",hitElement,255,0,0,false)
                end
            else
                outputChatBox("Estás encanao mamaguevo",hitElement,255,0,0,false)
            end
        else
            outputChatBox("Parcero, tienes que estar sin trabajo para entrar. Usa /resign",hitElement,255,0,0,false)
        end
    end
end
addEventHandler("onMarkerHit", CHANGON, EncerronaEntrada)