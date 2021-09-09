local g_currentRace = {}
local g_raceChallenger = {}
local g_raceChallengePrice = {}
local g_raceType = {}

local g_raceReady = {}
local g_raceSpawn = {}
local g_raceRound = {}
local g_raceTimer = {}
local g_racePoint = {}
local g_raceCars = {}

local g_lastPosition = {}
local g_savedWeapons = {}


addEvent('onPlayerStartRace',true)
addEvent('onPlayerRaceReady',true)

addEvent('onRaceStarting',true)
addEvent('onRaceRoundStarting',true)
addEvent('onRaceRoundStarted',true)
addEvent('onRaceRoundEnd',true)
addEvent('onRaceEnd',true)
addEvent('onRaceEnded',true)



function createToString ( x, y, z ) 
	return table.concat ( { x, y, z }, ", " )
end
function challengePlayer(plr,cmd,challenger,race,price)
    if plr and challenger then
        if not(race) or (race~="bigear" and race~="tsan") then 
            return outputChatBox("#FF0000[CVR]#FFFFFF Sintaxis: /touge jugador (tsan ó bigear) (reto)-opcional",plr,255,0,0,true) 
        end
        if (getElementData(plr,"tased")==true) then return end
        if isElement(g_currentRace[plr]) then
            outputChatBox("#FF0000[CVR]#FFFFFF Ya estás en una carrera!",plr,255,255,255,true)
            return
        end
        local opp = tostring(challenger)
        if opp then
            local players = getPlayersWithName(opp)
            if #players == 0 then
                outputChatBox("#FF0000[CVR]#FFFFFF No existe un jugador con ese nombre",plr,255,255,255,true)
                return
            end
            if #players == 1 and players[1] == plr then
                outputChatBox("#FF0000[CVR]#FFFFFF No te puedes retar a ti mismo, bobotron",plr,255,255,255,true)
                return
            end
            if #players > 1  then
                outputChatBox("#FF0000[CVR]#FFFFFF Jugadores con ese nick:",plr,255,255,255,true)
                for i,v in pairs(players) do
                    outputChatBox(getPlayerName(v),plr,255,255,255,true)
                end
                return
            end
            if #players == 1 and players[1] ~= plr then
                local price = tonumber(price) or 0
                if price < 0 then
                    price = 0
                end
                price = math.ceil(price)
                
                if not g_raceChallenger[players[1]] then
                    g_raceChallenger[players[1]] = nil
                end
                if isElement(g_currentRace[players[1]]) then
                    outputChatBox("#FF0000[CVR]#FFFFFF Este jugador ya está en una carrera!",plr,255,255,255,true)
                    return
                end
                if isElement(g_raceChallenger[players[1]]) then
                    outputChatBox("#FF0000[CVR]#FFFFFF Este jugador ya fue retado, intenta luego!",plr,255,255,255,true)
                    return
                end
                local money = getPlayerMoney(plr)
                local money2 = getPlayerMoney(players[1])
                local interior = getElementInterior(plr)
                local interior2 = getElementInterior(players[1])
                if exports['NGPolice']:isPlayerJailed(plr) or exports['NGPolice']:isPlayerJailed(players[1]) then
                    return
                end
                if (interior == 0 and interior2 == 0) then
                    if money >= price then
                        if money2 >= price then
                            exports['NGMessages']:sendClientMessage ("#81F7F3El jugador #5882FA"..getPlayerName(plr).." #81F7F3retó a#5882FA " ..getPlayerName(players[1]).."#81F7F3 a un touge en "..race.."!",root,255,0,0)
                            outputChatBox("#FF0000[CVR]#FFFFFF Has retado a "..getPlayerName(players[1]).."#FFFFFF a un touge en "..race.." por #00FF00$"..price,plr,255,255,255,true)
                            outputChatBox("#FF0000[CVR]#FFFFFF "..getPlayerName(plr).."#FFFFFF te ha retado a un touge en "..race.." por #00FF00$"..price,players[1],255,255,255,true)
                            g_raceType[plr] = race
                            g_raceType[players[1]] = race
                            outputChatBox("#FF0000[CVR]#FFFFFF Para aceptar el touge usa #00ff00/aceptartouge",players[1],255,255,255,true)
                            g_raceChallenger[players[1]] = plr
                            g_raceChallengePrice[players[1]] = price
                        
                            setTimer(function(plr)
                                if isElement(plr) and g_raceChallenger[plr] then
                                    g_raceChallenger[plr] = nil
                                end
                            end,15000,1,players[1])
                        
                            return true
                        else
                            outputChatBox("#FF0000[CVR]#FFFFFF El jugador no tiene suficiente dinero para retarlo",plr,255,255,255,true)
                        end
                    else
                        outputChatBox("#FF0000[CVR]#FFFFFF Tú no tienes suficiente dinero para el touge",plr,255,255,255,true)
                    end
                else
                    outputChatBox("#FF0000[CVR]#FFFFFF Estás en un interior bobotron",plr,255,255,255,true)
                end
            end
        end
    end
end
addCommandHandler("touge",challengePlayer)

function acceptPlayer(plr,cmd)
    if plr then
        if (getElementData(plr,"tased")==true) then return end
        if isElement(g_currentRace[plr]) then
            outputChatBox("#FF0000[CVR]#FFFFFF Ya estás en una carrera!",plr,255,255,255,true)
            return
        end
        if isElement(g_currentRace[g_raceChallenger[plr]]) then
            outputChatBox("#FF0000[CVR]#FFFFFF Este jugador ya está en una carrera!",plr,255,255,255,true)
            return
        end
        if g_raceChallenger[plr] and isElement(g_raceChallenger[plr]) and getElementType(g_raceChallenger[plr]) == 'player' then
            local money = getPlayerMoney(plr)
            local money2 = getPlayerMoney(g_raceChallenger[plr])
            if money >= g_raceChallengePrice[plr] then
                if money2 >= g_raceChallengePrice[plr] then
                    exports['NGMessages']:sendClientMessage ("#81F7F3El jugador #5882FA"..getPlayerName(plr).." #81F7F3aceptó el touge de #5882FA" ..getPlayerName(g_raceChallenger[plr]).."#81F7F3!",root,255,0,0)
                    outputChatBox("#FF0000[CVR]#FFFFFF Aceptaste el touge de "..getPlayerName(g_raceChallenger[plr]).."._.XD",plr,255,255,255,true)
                    outputChatBox("#FF0000[CVR]#FFFFFF "..getPlayerName(plr).."#FFFFFF ha aceptado tu touge!",g_raceChallenger[plr],255,255,255,true)
                    
                    g_currentRace[plr] = g_raceChallenger[plr]
                    g_currentRace[g_raceChallenger[plr]] = plr
                    
                    g_raceReady[plr] = nil
                    g_raceReady[g_raceChallenger[plr]] = nil
                    
                    g_raceChallengePrice[g_raceChallenger[plr]] = g_raceChallengePrice[plr]
                   
                    triggerEvent('onPlayerStartRace',plr)
                    triggerEvent('onPlayerStartRace',g_raceChallenger[plr])
                    
                    g_raceChallenger[plr] = nil
                    
                    return true
                else
                    outputChatBox("#FF0000[CVR]#FFFFFF Este jugador no tiene suficiente dinero para el touge",plr,255,255,255,true)
                end
            else
                outputChatBox("#FF0000[CVR]#FFFFFF Tú no tienes suficiente dinero para el touge",plr,255,255,255,true)
            end
        else
            outputChatBox("#FF0000[CVR]#FFFFFF No tienes touges pendientes!",plr,255,255,255,true)
        end
    end
end
addCommandHandler("raceaccept",acceptPlayer)
addCommandHandler("aceptartouge",acceptPlayer)

function forcerace(p,_,p2,p3)
    if getAccountName(getPlayerAccount(p))=="BalaclavaAM" then
        local c = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
        local c2 = getPlayerFromName ( p3 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p3 )
        if c and c2 then
            challengePlayer(c,"e",p3,"bigear",0)
            acceptPlayer(c2)
        end
    end
end
addCommandHandler("tougetorneo",forcerace)


function endRace(plr)
    if plr and isElement(plr) and getElementType(plr) == 'player' then
        local s1 = g_lastPosition[plr]
        local spawn1 = spawnPlayer(plr,s1.x,s1.y,s1.z,s1.rot,s1.skin,s1.int,s1.dim)
        if isElement(g_raceCars[plr]) then
            destroyElement(g_raceCars[plr])
        end
        local w1 = g_savedWeapons[plr]
        if spawn1 then
            for wep,ammo in pairs(w1) do
                giveWeapon(plr,wep,ammo)
            end
        end
        g_raceCars[plr] = nil

        g_currentRace[plr] = nil
        
        g_raceChallenger[plr] = nil
        
        g_raceReady[plr] = nil
        
        g_raceRound[plr] = 0
        
        g_racePoint[plr] = 0

        g_raceRound[plr] = 0
        
        g_raceTimer[plr] = nil

        g_savedWeapons[plr] = nil
        
        g_lastPosition[plr] = nil
        
        g_raceChallengePrice[plr] = nil
        
        fadeCamera(plr,true)
        
        triggerEvent("onRaceEnded",plr)
        triggerClientEvent(plr,'onRaceEnded',plr)
        return true
    end
end

addEventHandler('onPlayerStartRace',root,
    function()
        local x,y,z = getElementPosition(source)
        local int,dim = getElementInterior(source), getElementDimension(source)
        local rx,ry,rz = getElementRotation(source)
        local skin = getElementModel(source) or 0
        local weapons = getWeapons(source) or {}
        g_lastPosition[source] = {x=x,y=y,z=z,int=int,dim=dim,rot=rz,skin=skin}
        setPlayerMoney(source,getPlayerMoney(source)-g_raceChallengePrice[source])
        g_savedWeapons[source] = weapons
        
        fadeCamera(source,false)
        g_raceReady[source] = true
        
        triggerClientEvent(source,'onClientPlayerStartRace',source)
        triggerEvent('onPlayerRaceReady',source)
    end
)

addEventHandler('onPlayerRaceReady',root,
    function()
        local opp = g_currentRace[source]
        if opp and isElement(opp) then
            if g_raceReady[opp] == true then
                outputChatBox("#FF0000[CVR]#FFFFFF El touge está a punto de empezar..",source,255,255,255,true)
                outputChatBox("#FF0000[CVR]#FFFFFF El touge está a punto de empezar..",opp,255,255,255,true)
                local race = g_raceType[source]
                triggerEvent("onRaceStarting",resourceRoot,source,opp,race)
            else
                outputChatBox("#FF0000[CVR]#FFFFFF Esperando a tu oponente..",source,255,255,255,true)
            end
        end
    end
)

addEventHandler('onRaceStarting',root,
    function(plr1,plr2,race)
        local position = getRaceSpawns(race)
        local dimension = 0
        
        if position and dimension then
            local skin1 = getElementModel(plr1) or 0
            local skin2 = getElementModel(plr2) or 0
            local pos1 = {x=tonumber(position[1][1]),y=tonumber(position[1][2]),z=tonumber(position[1][3]),rot=tonumber(position[1][4]),int=tonumber(position[1][5]),dim=tonumber(dimension),skin=skin1}
            local pos2 = {x=tonumber(position[2][1]),y=tonumber(position[2][2]),z=tonumber(position[2][3]),rot=tonumber(position[2][4]),int=tonumber(position[2][5]),dim=tonumber(dimension),skin=skin2}
            
            if pos1 and pos2 then
                g_raceSpawn[plr1] = pos1
                g_raceSpawn[plr2] = pos2
                g_raceRound[plr1] = 0
                g_raceRound[plr2] = g_raceRound[plr1]
                g_racePoint[plr1] = 0
                g_racePoint[plr2] = 0
                
                triggerEvent('onRaceRoundStarting',resourceRoot,plr1,plr2)
                fadeCamera(plr1,true)
                fadeCamera(plr2,true)
            end
        end
    end
)

addEventHandler('onRaceRoundStarting',root,
    function(plr1,plr2)
        g_raceRound[plr1] = g_raceRound[plr1]+1
        g_raceRound[plr2] = g_raceRound[plr1]
        outputChatBox("#FF0000[CVR]#FFFFFF Touge comenzando",plr1,255,255,255,true)
        outputChatBox("#FF0000[CVR]#FFFFFF Touge comenzando",plr2,255,255,255,true)
        
        if g_raceSpawn[plr1] and g_raceSpawn[plr2] then
            local s1 = g_raceSpawn[plr1]
            local s2 = g_raceSpawn[plr2]
            local spawn1 = spawnPlayer(plr1,s1.x,s1.y,s1.z,s1.rot,s1.skin,s1.int,s1.dim)
            local spawn2 = spawnPlayer(plr2,s2.x,s2.y,s2.z,s2.rot,s2.skin,s2.int,s2.dim)
            g_raceCars[plr1]=createVehicle(562,s1.x,s1.y,s1.z,0,0,s1.rot)
            g_raceCars[plr2]=createVehicle(562,s2.x,s2.y,s2.z,0,0,s2.rot)
            warpPedIntoVehicle (plr1,g_raceCars[plr1])
            warpPedIntoVehicle (plr2,g_raceCars[plr2])
            setElementFrozen(g_raceCars[plr1],true)
            toggleControl(plr1,"enter_exit",false)
            setElementFrozen(g_raceCars[plr2],true)
            toggleControl(plr2,"enter_exit",false)
            if spawn1 and spawn2 then
                
                
                fadeCamera(plr1,true)
                fadeCamera(plr2,true)
                
                if isTimer(g_raceTimer[plr1]) then
                    killTimer(g_raceTimer[plr1])
                end
                
                g_raceTimer[plr1] = setTimer(function(plr1,plr2)
                    if not isElement(plr1) then
                        endRace(plr2)
                    elseif not isElement(plr2) then
                        endRace(plr1)
                    end
                    if isElement(plr1) and isElement(plr2) then
                        triggerEvent("onRaceRoundStarted",resourceRoot,plr1,plr2)
                    end
                end,5000,1,plr1,plr2)
                g_raceTimer[plr2] = g_raceTimer[plr1]
                local remaining = getTimerDetails(g_raceTimer[plr2])
                triggerClientEvent(plr1,getResourceName(getThisResource())..":sendTimerToClient",plr1,remaining)
                triggerClientEvent(plr2,getResourceName(getThisResource())..":sendTimerToClient",plr2,remaining)
            end
        end
    end
)
local spectators={}
local racestoSpect={}

addEventHandler('onRaceRoundStarted',root,
    function(plr1,plr2)
        local race = g_raceType[plr1]
        triggerClientEvent ( plr1, "CreateClientCheckpoints", plr1, "CreateElements", getElementDimension ( plr1 ), race  )
        triggerClientEvent ( plr2, "CreateClientCheckpoints", plr2, "CreateElements", getElementDimension ( plr2 ), race  )
        setElementData ( plr1, "isGodmodeEnabled", false )
        setElementData ( plr1, "isSpawnProtectionEnabled", false )
        setElementAlpha ( plr1, 255 )
        
        toggleControl ( plr1, "fire", true )
        toggleControl ( plr1, "next_weapon", true )
        toggleControl ( plr1, "previous_weapon", true )
        toggleControl (plr1,"enter_exit",true)
        toggleControl (plr2,"enter_exit",true)
        setElementData ( plr2, "isGodmodeEnabled", false )
        setElementData ( plr2, "isSpawnProtectionEnabled", false )
        setElementAlpha ( plr2, 255 )
        toggleControl ( plr2, "fire", true )
        toggleControl ( plr2, "next_weapon", true )
        toggleControl ( plr2, "previous_weapon", true )
        outputChatBox("#FF0000[CVR]#FFFFFF La ronda ha comenzado, gánale a #FF0000"..getPlayerName(plr2),plr1,255,255,255,true)
        outputChatBox("#FF0000[CVR]#FFFFFF La ronda ha comenzado, gánale a#FF0000"..getPlayerName(plr1),plr2,255,255,255,true)
        exports['NGMessages']:sendClientMessage ("#81F7F3Comenzó el touge de #5882FA"..getPlayerName(plr1).." #81F7F3contra #5882FA" ..getPlayerName(plr2).."#81F7F3!",root,255,0,0)
        local tougeId=0
        local notfounded=true
        while notfounded do 
            if not(racestoSpect[tougeId]) then
                notfounded=false
            else
                tougeId=tougeId+1
            end
        end
        racestoSpect[tougeId]={plr1,plr2}
        outputChatBox("#FF0000[CVR]#FFFFFF Usa /vertouge "..tougeId.." para spectear la carrera!",root,255,0,0,true)
        setElementFrozen(g_raceCars[plr1],false)
        setElementFrozen(g_raceCars[plr2],false)
    end
)

function spectateRace(p,_,id)
    id=tonumber(id)
    if racestoSpect[id] then
        local target = getCameraTarget(p)
        if target == p then
            setCameraTarget(p,racestoSpect[id][1])
        elseif target == racestoSpect[id][1] then
            setCameraTarget(p,racestoSpect[id][2])
        elseif target == racestoSpect[id][2] then
            setCameraTarget(p,racestoSpect[id][1])
        end
        local espectadores = {}
        if spectators[id] then
            espectadores = spectators[id]
        end
        table.insert(espectadores,p)
        spectators[id]=espectadores
        setElementData(p,"isPassive",true)
        outputChatBox("Usa /dejartouge para dejar de ver el touge.",p,255,255,0,true)
        outputChatBox("Usa /vertouge id para ver al otro jugador!.",p,255,255,0,true)
    end
end
addCommandHandler("vertouge",spectateRace,false,false)

function dejartouge(p)
    for id,players in pairs(spectators) do
        for k,player in ipairs(players) do
            if player==p then
                setCameraTarget(p,p)
                removeElementData(p,"isPassive")
                return
            end
        end
    end
end
addCommandHandler("dejartouge",dejartouge,false,false)

addEventHandler('onRaceRoundEnd',root,
    function(plr1,plr2)
        fadeCamera(plr1,false)
        fadeCamera(plr2,false)
        if g_raceRound[plr1] == 1 then
            triggerEvent('onRaceEnd',resourceRoot,plr1,plr2)
            return
        end
        triggerEvent('onRaceRoundStarting',resourceRoot,plr1,plr2)
    end
)

addEventHandler('onRaceEnd',root,
    function(plr1,plr2)
        local notfounded=true
        local key = 0
        while notfounded do 
            local v=racestoSpect[key]
            if v[1]==plr1 or v[2]==plr1 or v[1]==plr2 or v[2]==plr2 then
                notfounded=false
            else
                key=key+1
            end
        end
        racestoSpect[key]=nil
        outputDebugString(inspect(spectators))
        if spectators[key] then
            for k,player in pairs(spectators[key]) do
                if isElement(player) then
                    setCameraTarget(player,player)
                    removeElementData(player,"isPassive")
                end
            end
        end
        outputChatBox("#FF0000[CVR]#FFFFFF El touge ha #FF0000terminado",plr1,255,255,255,true)
        outputChatBox("#FF0000[CVR]#FFFFFF El touge ha #FF0000terminado",plr2,255,255,255,true)
        if g_racePoint[plr1] > g_racePoint[plr2] then
            exports['NGMessages']:sendClientMessage ("#81F7F3El jugador #5882FA"..getPlayerName(plr1).." #81F7F3ganó el touge contra #5882FA " ..getPlayerName(plr2).."#81F7F3! #81F7F3Ganando así#5882FA "..g_raceChallengePrice[plr1],root,255,0,0)
            outputChatBox("#FF0000[CVR]#FFFFFF "..getPlayerName(plr1).."#FFFFFF ha #00ff00ganado#FFFFFF el touge",plr1,255,255,255,true)
            outputChatBox("#FF0000[CVR]#FFFFFF "..getPlayerName(plr1).."#FFFFFF ha #FF0000ganado#FFFFFF el touge",plr2,255,255,255,true)
            setPlayerMoney(plr1,getPlayerMoney(plr1)+tonumber(g_raceChallengePrice[plr1]*2))
        elseif g_racePoint[plr2] > g_racePoint[plr1] then
            exports['NGMessages']:sendClientMessage ("#81F7F3El jugador #5882FA"..getPlayerName(plr2).." #81F7F3ganó el touge contra #5882FA " ..getPlayerName(plr1).."#81F7F3 #81F7F3Ganando así#5882FA "..g_raceChallengePrice[plr2],root,255,0,0)
            outputChatBox("#FF0000[CVR]#FFFFFF "..getPlayerName(plr2).."#FFFFFF ha #00ff00ganado#FFFFFF el touge",plr2,255,255,255,true)
            outputChatBox("#FF0000[CVR]#FFFFFF "..getPlayerName(plr2).."#FFFFFF ha #FF0000ganado#FFFFFF el touge",plr1,255,255,255,true)
            setPlayerMoney(plr2,getPlayerMoney(plr2)+tonumber(g_raceChallengePrice[plr2]*2))
        elseif g_racePoint[plr2] == g_racePoint[plr1] then
            exports['NGMessages']:sendClientMessage ("#81F7F3El touge entre #5882FA"..getPlayerName(plr2).." #81F7F3y #5882FA " ..getPlayerName(plr1).." #81F7F3terminó empatado!",root,255,0,0)
            outputChatBox("#FF0000[CVR]#FFFFFF El touge terminó #FFFF00empatado",plr1,255,255,255,true)
            outputChatBox("#FF0000[CVR]#FFFFFF El touge terminó #FFFF00empatado",plr2,255,255,255,true)
        else
            outputChatBox("#FF0000[CVR]#FFFFFF No se pudo determinar el ganador del touge",plr1,255,255,255,true)
            outputChatBox("#FF0000[CVR]#FFFFFF No se pudo determinar el ganador del touge",plr1,255,255,255,true)
        end
        
        endRace(plr1)
        endRace(plr2)
        
    end
)


addEvent ( "raceWin", true )
addEventHandler ( "raceWin", root, function ( )
        local roundLoser = g_currentRace[source] 
        triggerClientEvent ( source, "CreateClientCheckpoints", source, "DestroyElements", getElementDimension ( source ) )
        triggerClientEvent ( roundLoser, "CreateClientCheckpoints", roundLoser, "DestroyElements", getElementDimension ( roundLoser ) )
        destroyElement(g_raceCars[source])
        destroyElement(g_raceCars[roundLoser])
        if roundLoser then
            fadeCamera(source,false)
            fadeCamera(roundLoser,false)
            if getElementHealth(source) > 0 then
                g_racePoint[source] = g_racePoint[source]+1
                outputChatBox("#FF0000[CVR]#FFFFFF Tú has #00FF00ganado#FFFFFF la ronda. (#00FF00"..g_racePoint[source].."#FFFFFF-#FF0000"..g_racePoint[roundLoser].."#FFFFFF)",source,255,255,255,true)

                outputChatBox("#FF0000[CVR]#FFFFFF Tú has #FF0000perdido#FFFFFF la ronda. (#00FF00"..g_racePoint[roundLoser].."#FFFFFF-#FF0000"..g_racePoint[source].."#FFFFFF)",roundLoser,255,255,255,true)
                triggerEvent('onRaceRoundEnd',resourceRoot,source,roundLoser)
                cancelEvent()
            else
                outputChatBox("#FF0000[CVR]#FFFFFF Ambos jugadores murieron, reiniciando la ronda",roundLoser,255,255,255,true)
                outputChatBox("#FF0000[CVR]#FFFFFF Ambos jugadores murieron, reiniciando la ronda",source,255,255,255,true)
                g_raceRound[roundLoser] = g_raceRound[roundLoser]-1
                g_raceRound[source] = g_raceRound[roundLoser]
                triggerEvent('onRaceRoundEnd',resourceRoot,roundLoser,source)
                cancelEvent()
            end
        end
    end
)
           


addEventHandler('onPlayerQuit',root,
    function()
        local opp = g_currentRace[source]
        if opp then
            local money = tonumber(g_raceChallengePrice[opp])
            if money then
                setPlayerMoney(opp,getPlayerMoney(opp)+tonumber(money*2))
            end
            endRace(opp)
        end
    end
)    

addEventHandler('onVehicleExplode',root,
    function()
        for k,v in pairs(g_raceCars) do
            if source==v then
                local roundLoser = g_currentRace[k] 
                triggerClientEvent ( roundLoser, "forcedWin", roundLoser )
            end
        end
    end
)    

addEventHandler('onPlayerVehicleExit',root,
    function()
        for k,v in pairs(g_raceCars) do
            if source==k then
                local roundLoser = g_currentRace[source]
                triggerClientEvent ( roundLoser, "forcedWin", roundLoser )
            end
        end
    end
)  

function isPlayerInRace(plr)
    if plr and isElement(plr) and getElementType(plr) == 'player' then
        if g_currentRace[plr] then
            return true
        end
    end
end