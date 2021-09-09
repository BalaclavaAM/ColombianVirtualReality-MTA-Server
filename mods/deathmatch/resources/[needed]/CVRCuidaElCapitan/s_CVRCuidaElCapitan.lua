local playersinMinigame = {}
local redspawn = {2706.24, 904.81, 10.53}
local playerposition = {}
local stars = {}
local bluespawn = {2588.87, 789.69, 10.95}
local redteam = 0
local blueteam = 0
local started = false
local capitanes = {}
local weapons={}
local lastexecuted=false
local blips={}

function table.empty( a )
    if type( a ) ~= "table" then
        return false
    end
    
    return next(a) == nil
end
------------------------------
function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=2,9 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end



function getWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
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

function giveWeapons(player)
    if isElement(player) and getElementType(player) == "player" then
        local armas = weapons[player]
        for wep,ammo in pairs(armas) do
            local newWep = tonumber(wep) or 0
            local newAmmo = tonumber(ammo) or 0
            giveWeapon(source,newWep,newAmmo,false)
        end
    end 
    local newarmas=getWeapons(player) or {}
    while table.empty(newarmas) do
        giveWeapons(player)
    end
end


function isInMinigame(player) 
    if playersinMinigame[player] then
        return true
    else
        return false
    end
end

function exitPlayer(player)
    if isElement(player) and getElementType(player) == "player" then
        if isInMinigame(player) then
            local skin2 = getElementData ( player, 'NGUser.UnemployedSkin' )
            spawnPlayer(player,playerposition[player][1],playerposition[player][2],playerposition[player][3],0,skin2,0,0)
            local armas = weapons[player]
            darArmasCapitan(player,armas)
            removeElementData(player,"isinCapitan")
            if playersinMinigame[player]=="Red" then
                redteam =redteam-1
            else
                blueteam=blueteam-1
            end
            playersinMinigame[player]=nil
            playerposition[player]=nil
            setPlayerTeam(player,getTeamFromName("Unemployed"))
            setElementFrozen(player,false)
            setElementData(player,"WantedPoints",stars[player])
            stars[player]=nil
            weapons[player]=nil
            removeEventHandler("onPlayerWasted",player,muertepersona)
            triggerEvent("NGHospitals:enableRespawn",player)
            if blueteam == 0 and redteam == 0 then
                playersinMinigame = {}
                redspawn = {2706.24, 904.81, 10.53}
                playerposition = {}
                stars = {}
                bluespawn = {2588.87, 789.69, 10.95}
                redteam = 0
                blueteam = 0
                started = false
                capitanes = {}
                outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El minijuego CuidaElCapitán ha terminado",player,255,255,0,true)
            end
        end
    else
        if playersinMinigame[player]=="Red" then
            redteam =redteam-1
        else
            blueteam=blueteam-1
        end
        playersinMinigame[player]=nil
        weapons[player]=nil
        stars[player]=nil
    end
end
addCommandHandler("salircapitan",exitPlayer)
function exitPlayerEvent()
    exitPlayer(source)
end
addEventHandler("onPlayerQuit",root,exitPlayerEvent)

function darArmasCapitan(player,armas)
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

function muertepersona()
    if isElement(source) and getElementType(source) == "player" then
        if capitanes[source] then
            local skin2 = getElementData ( source, 'NGUser.UnemployedSkin' )
            spawnPlayer(source,playerposition[source][1],playerposition[source][2],playerposition[source][3],0,skin2,0,0)
            setPedArmor(source,100)
            local armas = weapons[source]
            darArmasCapitan(source,armas)
            setPlayerTeam(source,getTeamFromName("Unemployed"))
            playersinMinigame[source]=nil
            removeEventHandler("onPlayerWasted",source,muertepersona)
            triggerEvent("NGHospitals:enableRespawn",source)
            for player,blip in pairs(blips) do
               destroyElement(blip) 
            end
            blips={}
            if capitanes[source]=="Red" then
                redteam=redteam-1
                outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El equipo azul ha ganado!",root,255,255,0,true)
                for k,v in pairs(playersinMinigame) do 
                    if v=="Blue" then
                        setPlayerMoney(k,getPlayerMoney(k)+40000)
                    end
                    if k~=source then
                        exitPlayer(k)
                    end
                end
            elseif capitanes[source]=="Blue" then
                outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El equipo rojo ha ganado!",root,255,255,0,true)
                blueteam=blueteam-1
                for k,v in pairs(playersinMinigame) do 
                    if v=="Red" then
                        setPlayerMoney(k,getPlayerMoney(k)+40000)
                    end
                    if k~=source then
                        exitPlayer(k)
                    end
                end
            end
            capitanes={}
        elseif playersinMinigame[source] then
            local skin2 = getElementData ( source, 'NGUser.UnemployedSkin' )
            if isInMinigame(source) then
                if playersinMinigame[source]=="Red" then
                    spawnPlayer(source,2706.24, 904.81, 10.53,0,skin2,0,0)
                elseif playersinMinigame[source]=="Blue" then
                    spawnPlayer(source,2588.87, 789.69, 10.95,0,skin2,0,0)
                end
                setElementDimension(source,40)
                setPedArmor(source,100)
                local armas = weapons[source]
                darArmasCapitan(source,armas)
            end
        end
    end
end


function startMinigame(forced) 
    forced=forced or false
    local total=getPlayerCount()
    --if (redteam+blueteam)>total*0.20 then
    if (redteam+blueteam)==10 or forced then
        started=true
        for k,v in pairs(playersinMinigame) do
            setElementFrozen(k,false)
        end
        outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0CuidaElCapitan ha empezado!",root,255,255,0,true)
        local players = {}
        local index = 1
        for k,v in pairs(playerposition) do
            players[index]=k
            index = index+1
            setPedArmor(k,100)
            setElementHealth(k,100)
        end
        local lider1 = players[math.random(1,#players)]
        while (not (playersinMinigame[lider1] == "Red")) or not (isElement(lider1) and getElementType(lider1) == "player" ) do
            lider1 = players[math.random(1,#players)]
        end
        local lider2 = players[math.random(1,#players)]
        while (not (playersinMinigame[lider2] == "Blue")) or not (isElement(lider2) and getElementType(lider2) == "player" ) do
            lider2 = players[math.random(1,#players)]
        end
        capitanes[lider1]="Red"
        capitanes[lider2]="Blue"
        blips[lider2]=createBlipAttachedTo(lider2,30,2,255,0,0,255,0,999999,root)
        blips[lider1]=createBlipAttachedTo(lider1,43,2,255,0,0,255,0,999999,root)
        outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El líder del equipo #0178FFazul #C0C0C0 es #0178FF"..getPlayerName(lider2).." #C0C0C0asesinalo para ganar!",root,255,255,0,true)
        outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El líder del equipo #FF0101rojo #C0C0C0 es #FF0101"..getPlayerName(lider1).." #C0C0C0asesinalo para ganar!",root,255,255,0,true)
    end
end

function forcestartMinigame(p)
    if exports['NGAdministration']:isPlayerStaff(p) or getElementData(p,"VIP")~="None" then
        if not started and #players>=2 then
            startMinigame(true)
        end
    end
end

addCommandHandler("comenzarcapitan",forcestartMinigame)

function enterMinigame()
    local player = source
    if (getElementData(player,"Job")=="UnEmployed") and not (getElementData(player,"isPassive")) then
        if not started then
            local armas = getWeapons(player) or {}
            if not (table.empty(armas)) then
                if getPlayerMoney(player)>=20000 then
                    weapons[player] = armas
                    if not isInMinigame(player) then
                        if getElementDimension(player)==40 or(getElementDimension(player) == 0 and getElementInterior(player)== 0) then
                            triggerEvent("NGHospitals:disableRespawn",player)
                            addEventHandler("onPlayerWasted",player,muertepersona)
                            if redteam == 0 and blueteam == 0 then
                                --if not lastexecuted or getTickCount()-lastexecuted>300000 then
                                    local x1,y1,z1 = getElementPosition(player)
                                    playerposition[player]={x1,y1,z1}
        
                                    outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El jugador #0178FF"..getPlayerName(player).." #C0C0C0ha empezado un CuidaElCapitan, entra con /capitan",root,255,255,0,true)
                                    setElementPosition(player,redspawn[1],redspawn[2],redspawn[3])
                                    setElementDimension(player,40)
                                    setElementFrozen(player,true)
                                    darArmasCapitan(player,armas)
                                    playersinMinigame[player]="Red"
                                    setPlayerTeam(player,getTeamFromName("Criminals"))
                                    redteam= redteam+1
                                    stars[player] = getElementData(player,"WantedPoints")
                                    setElementData(player,"isinCapitan",true)
                                    lastexecuted=getTickCount()
                                    takePlayerMoney(player,20000)
                                --else
                                    --outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0Este minijuego solo se puede jugar cada 5 minutos",player,255,255,0,true)
                                --end
                            else
                                if redteam<=10 and blueteam<= 10 then
                                    takePlayerMoney(player,20000)
                                    if redteam>=blueteam then
                                        local x1,y1,z1 = getElementPosition(player)
                                        playerposition[player]={x1,y1,z1}
                                        outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El jugador #0178FF"..getPlayerName(player).."#C0C0C0 ha entrado al equipo azul en el minijuego CuidaElCapitan, entra con /capitan",root,255,255,0,true)
                                        setElementPosition(player,bluespawn[1],bluespawn[2],bluespawn[3])
                                        setElementDimension(player,40)
                                        setElementFrozen(player,true)
                                        blueteam=blueteam+1
                                        darArmasCapitan(player,armas)
                                        playersinMinigame[player]="Blue"
                                        setPlayerTeam(player,getTeamFromName("Law Enforcement"))
                                        startMinigame()
                                        stars[player] = getElementData(player,"WantedPoints")
                                        setElementData(player,"isinCapitan",true)
                                    else
                                        local x1,y1,z1 = getElementPosition(player)
                                        playerposition[player]={x1,y1,z1}
                                        outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El jugador #0178FF"..getPlayerName(player).." #C0C0C0ha entrado al equipo rojo en el minijuego CuidaElCapitan, entra con /capitan",root,255,255,0,true)
                                        setElementPosition(player,redspawn[1],redspawn[2],redspawn[3])
                                        setElementDimension(player,40)
                                        setElementFrozen(player,true)
                                        redteam=redteam+1
                                        playersinMinigame[player]="Red"
                                        setPlayerTeam(player,getTeamFromName("Criminals"))
                                        startMinigame()
                                        darArmasCapitan(player,armas)
                                        stars[player] = getElementData(player,"WantedPoints")
                                        setElementData(player,"isinCapitan",true)
                                    end
                                else
                                    outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El minijuego está lleno",player,255,255,0,true)
                                end
                            end
                        else
                            outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0Tienes que estar en la dimensión 0 y en el interior 0 para entrar al minijuego",player,255,255,0,true)
                        end
                    else
                        outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0Ya estás en el minijuego",player,255,255,0,true)
                    end
                else
                    outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0Tienes que tener 20.000 o más para participar :).",player,255,255,0,true)
                end
            else
                outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0Parceiro no tienes armas o no pudimos guardarlas, intenta nuevamente",player,255,255,0,true)
            end
        else
            outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0El minijuego no ha empezado",player,255,255,0,true)
        end
    else
        outputChatBox("#FFFFFF[#FCDE00C#004AAFV#C20101R#FFFFFF] #C0C0C0Necesitas estar sin modo pasivo y sin trabajo para entrar al minijuego",player,255,255,0,true)
    end
end
addEvent("CVRCuidaElCapitan:EntrarMinijuego",true)
addEventHandler("CVRCuidaElCapitan:EntrarMinijuego",root,enterMinigame)


function ventanaCapitan(p)
    local titulo= "CVR Presenta: Cuida el Capitán"
    local desc="En este minijuego debes asesinar al capitán del otro equipo.\nEl capitán del equipo rojo tendrá un ícono de dragon.\nEl capitán del equipo azul tendrá un ícono de policía.\n\nAl ganar, todos las personas del equipo ganador obtendrán 40.000. Entrar cuesta 20.000 :).\n\nComandos:\n/capitan: Usa este comando para entrar al juego.\n/salircapitan: Si quieres salir del juego, usa este comando.\n/comenzarcapitan: Si eres admin o VIP puedes usar este comando para empezar el minijuego."
    triggerClientEvent(p,"NGMisc:CreateConfirmPanel",p,titulo,desc,"CVRCuidaElCapitan:EntrarMinijuego")
end
addCommandHandler("capitan",ventanaCapitan)

local ped = createPed(160,1269.41, -1351.69, 13.5)
setElementRotation(ped,0,0,97)
setElementFrozen(ped,true)

local marcadorcapitan = createMarker(1319.19, -1356.43, 12.63,"cylinder", 2, 255,255,255, visibleTo)

function markerCapitan (hitElement,matchingDimension)
    if isElement(hitElement) and getElementType(hitElement)=="player" and matchingDimension then
        ventanaCapitan(hitElement)
    end
end

addEventHandler("onMarkerHit",marcadorcapitan,markerCapitan)
