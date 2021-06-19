local pueblos={}
pueblos['elquebrados']={dimension=50,
                        team=false,
                        win=2,
                        interior=0}
                        
pueblos['elquebrados']['spawnlocations']={{-1612.59, 2670.28, 54.55},{-1441.09, 2670.78, 55.69},{-1428.86, 2599.84, 55.69},{-1545.34, 2602, 55.69}}

local jugadores={}
local prefijo="["
function getPueblosNoTeam()
    local keys={}
    for k,v in pairs(pueblos) do
        if not (v['team']) then
            table.insert(keys,k)
        end
    end
    return keys
end

function getArmas(source)
    local weapons = { }
	for i=1,12 do 
        weapons[i] = { getPedWeapon ( source, i ), getPedTotalAmmo ( source, i ) } 
    end
    return weapons
end

function getRandomSpawn(pueblo)
    local spawnlocations=pueblos[pueblo]['spawnlocations']
    return pueblos[pueblo]['spawnlocations'][math.random(1,#spawnlocations)]
end

function respawnPlayer(player)
    local pueblo=jugadores[player]['pueblo']
    local pueblointerior = pueblos[pueblo]['interior']
    local pueblodimension = pueblos[pueblo]['dimension']
    local puebloposition = getRandomSpawn(pueblo)
    local playerskin = jugadores[player]['skin']
    if isPedDead(player) then
        spawnPlayer(player,puebloposition[1],puebloposition[2],puebloposition[3],0,playerskin,pueblointerior,pueblodimension)
        fadeCamera ( player, true)
        setCameraTarget ( player, player)
        for i, v in pairs ( jugadores[player]['armas'] ) do
            giveWeapon ( player, v[1], v[2] )
        end
    else
        setElementPosition(player,puebloposition[1],puebloposition[2],puebloposition[3],true)
        setElementHealth(player,100)
        setElementDimension(player,pueblodimension)
        setElementInterior(player,pueblointerior)
    end
end

function getPlayersinPueblo(pueblo)
    local players={}
    for k,v in pairs(jugadores) do
        if v['pueblo']==pueblo then
            table.insert(players,k)
        end
    end
    return players
end

function exitPlayer(player)
    local x = jugadores[player]['x']
    local y = jugadores[player]['y']
    local z = jugadores[player]['z']
    local dimension = jugadores[player]['dimension']
    local skin = jugadores[player]['skin']
    local armas = jugadores[player]['armas']
    local interior = jugadores[player]['interior']
    if isPedDead(player) then
        triggerEvent("NGHospitals:RespawnMk",player)
    else
        setElementPosition(player,x,y,z,true)
        setElementDimension(player,dimension)
        setElementInterior(player,interior)
        setElementHealth(player,100)
    end
    jugadores[player]=nil
    triggerEvent("NGHospitals:enableRespawn",player)
    removeEventHandler("onPlayerWasted",player,handleMuerte)
end
addCommandHandler("salirpueblo",exitPlayer)

function handleMuerte(totalAmmo,killer,killerWeapon)
    if killer and isElement(killer) and getElementType(killer)=="player" and killer~=source then
        jugadores[killer]["kills"]=jugadores[killer]["kills"]+1
        local playerspueblo = getPlayersinPueblo(jugadores[killer]['pueblo'])
        for k,v in ipairs(playerspueblo) do
            if isElement(v) then
                outputChatBox(prefijo..getPlayerName(source).." ha sido asesinado por "..getPlayerName(killer).." quien lleva "..jugadores[killer]["kills"].." kills",v,255,0,0,true)
            end
        end
        if jugadores[killer]["kills"]>=pueblos[jugadores[killer]['pueblo']]['win'] then
            outputChatBox(prefijo..getPlayerName(killer).." ha ganado la batalla en el pueblo "..jugadores[killer]['pueblo'],root,255,0,0,true)
            for k,v in ipairs(playerspueblo) do
                if isElement(v) then
                    exitPlayer(v)
                end
            end
        else
            respawnPlayer(source)
        end
    else
        respawnPlayer(source)
    end
end


function enterPueblo(player,_,pueblox)
    if not (exports['NGPolice']:isPlayerJailed(player)) then
        outputChatBox(pueblox)
        if pueblox and pueblos[pueblox] then
            local armas2=getArmas(player)
            if #armas2>0 then
                local x2,y2,z2 = getElementPosition(player)
                local interior2 = getElementInterior(player)
                local dimension2 = getElementDimension(player)
                local skin2 = getElementModel(player)
                jugadores[player]={kills=0,pueblo=pueblox,x=x2,y=y2,z=z2,interior=interior2,dimension=dimension2,skin=skin2,armas=armas2}
                triggerEvent("NGHospitals:disableRespawn",player)
                addEventHandler("onPlayerWasted",player,handleMuerte)
                respawnPlayer(player)
            else
                outputChatBox(prefijo.."No pudimos obtener tus armas :(",player,255,0,0,true)
            end
        else
            outputChatBox(prefijo.."Puedes entrar a los siguientes pueblos "..table.concat(getPueblosNoTeam(),", "),player,255,0,0,true)
        end
    else
        outputChatBox(prefijo.."No puedes usar este comando estando jaileado.",player,255,0,0,true)
    end
end
addCommandHandler("pvppueblo",enterPueblo)