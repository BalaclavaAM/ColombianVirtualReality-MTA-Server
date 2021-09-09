local rewards = {}
local blips = {}
local carteleros = {}
local prefijo = "#929292[#FF0000CVRHitman#929292]#FF8484"

--Helpers!

function isPossible(player)
    if getElementData(player,"isPassive") or getTeamName(getPlayerTeam(player))=="Services" or not (getElementDimension(player)==0) or not(getElementInterior(player)==0) then
        return false
    else
        return true
    end
end

function hasReward(player)
    if rewards[player] then
        return true
    else
        return false
    end
end

function removeEvents(player)
    outputChatBox("papu")
    removeEventHandler("onPlayerWasted",player,payReward)
    removeEventHandler("onPlayerQuit",player,playerQuit)
end


function payReward(ammo, attacker, weapon)
    if attacker then
        if getElementType(attacker)=="player" then
            if not(attacker==source) then
                givePlayerMoney(attacker,rewards[source])
                outputChatBox(prefijo.."El jugador #FFFFFF"..getPlayerName(attacker).." #FF8484ha asesinado a #FFFFFF"..getPlayerName(source).." y ha ganado "..tostring(rewards[source]),root,255,0,0,true)
                destroyElement(blips[source])
                rewards[source]=nil
                blips[source]=nil
                carteleros[source]=nil
                removeEvents(source)
            end
        end
    end
end

function playerQuit()
    if isElement(carteleros[source]) then
        givePlayerMoney(carteleros[source],rewards[source])
    end
    destroyElement(blips[source])
    carteleros[source]=nil
    rewards[source]=nil
    blips[source]=nil
    removeEvents(source)
    outputChatBox(prefijo.."El jugador #FFFFFF"..getPlayerName(source).." #FF8484se ha desconectado y su recompensa se ha eliminado",root,255,0,0,true)
end


function putReward(p,_,p2,reward)
    local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
    if toJ then
        if reward then
            if tonumber(reward)>30000 then
                if getPlayerMoney(p)>=tonumber(reward) then
                    if isPossible(toJ) then
                        if not (hasReward(toJ)) then
                            takePlayerMoney(p,tonumber(reward))
                            rewards[toJ]=tonumber(reward)
                            blips[toJ] = createBlipAttachedTo(toJ,23)
                            carteleros[toJ]=p
                            addEventHandler ( "onPlayerWasted", toJ, payReward )
                            addEventHandler ( "onPlayerQuit", toJ, playerQuit )
                            outputChatBox(prefijo.."El jugador #FFFFFF"..getPlayerName(p).." #FF8484ha asignado una recompensa de #FFFFFF"..reward.." #FF8484para asesinar a #FFFFFF"..getPlayerName(toJ),root,255,0,0,true)
                        else
                            takePlayerMoney(p,tonumber(reward))
                            rewards[toJ]=rewards[toJ]+tonumber(reward)
                            outputChatBox(prefijo.."El jugador #FFFFFF"..getPlayerName(p).." #FF8484ha aumentado la recompensa para asesinar a #FFFFFF"..getPlayerName(toJ).." #FF8484la nueva recompensa es#FFFFFF "..tostring(rewards[toJ]),root,255,0,0,true)
                        end
                    else
                        exports['NGMessages']:sendClientMessage ( "No es posible asignar la recompensa. Este jugador es un trabajador, está en modo pasivo o está en otra dimensión.", p, 255, 255, 0 )
                    end
                else
                    exports['NGMessages']:sendClientMessage ( "No tienes la cantidad que darás de recompensa", p, 255, 255, 0 )
                end
            else
                exports['NGMessages']:sendClientMessage ( "La recompensa debe ser superior a 30000", p, 255, 255, 0 )
            end
        else
            exports['NGMessages']:sendClientMessage ( "Tienes que especificar una recompensa. Sintax: /hitman player recompensa", p, 255, 255, 0 )
        end
    else
        exports['NGMessages']:sendClientMessage ( "El jugador "..p2.." no existe!", p, 255, 255, 0 )
    end
end
addCommandHandler("hitman",putReward)