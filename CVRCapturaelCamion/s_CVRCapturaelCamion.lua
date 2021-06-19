local greenTeam={}
local redTeam={}
local cars={}
local weapons={}
local lastposition={}
local puja=0
local isrunning=false
local roundgreenwins=0
local roundredwins=0
local vehiclesronda={}
local premio=0


addEvent('onPlayerStartMinigame',true)
addEvent('onPlayerMinigameReady',true)
addEvent('onroundWin',true)
addEvent('onMiniGameExit',true)


cars["red"] = createVehicle(499,-1011.27, -686.74, 32.01)
cars["green"] = createVehicle(499,-472.88, -513.07, 25.52)
cars["blipg"]=createBlipAttachedTo(cars["red"],51,2,255,0,0,255,0,99999.0,getRootElement())
cars["blipr"]=createBlipAttachedTo(cars["green"],51,2,0,255,0,255,0,99999.0,getRootElement())
cars["markerr"]=createMarker( -1011.27, -686.74, 32.01, "cylinder", 3, 255, 0, 0, 255 ) 
cars["markerg"]=createMarker( -472.88, -513.07, 25.52, "cylinder", 3, 255, 0, 255, 255)




function createVehicles()
    vehiclesronda[1]=createVehicle(554,-490.56, -487.27, 25.52)
    vehiclesronda[2]=createVehicle(554,-500.22, -487.27, 25.52)
    vehiclesronda[3]=createVehicle(554,-510.24, -487.27, 25.52)
    vehiclesronda[4]=createVehicle(554,-519.98, -487.27, 25.52)
    vehiclesronda[5]=createVehicle(554,-530.05, -487.26, 25.52)
    vehiclesronda[6]=createVehicle(554,-539.32, -487.27, 25.52)
    vehiclesronda[7]=createVehicle(554,-549.97, -487.27, 25.52)
    vehiclesronda[8]=createVehicle(554,-560.31, -487.27, 25.52)
    vehiclesronda[9]=createVehicle(554,-570.31, -487.27, 25.52)
    vehiclesronda[10]=createVehicle(554,-580.31, -487.27, 25.52)
    vehiclesronda[11]=createVehicle(554,-1030, -661.14, 32.01)
    vehiclesronda[12]=createVehicle(554,-1020, -661.14, 32.01)
    vehiclesronda[13]=createVehicle(554,-1010, -661.14, 32.01)
    vehiclesronda[14]=createVehicle(554,-1000, -661.14, 32.01)
    vehiclesronda[15]=createVehicle(554,-990, -661.14, 32.01)
    vehiclesronda[16]=createVehicle(554,-980, -661.14, 32.01)
    vehiclesronda[17]=createVehicle(554,-1030, -651.14, 32.01)
    vehiclesronda[18]=createVehicle(554,-1020, -651.14, 32.01)
    vehiclesronda[19]=createVehicle(554,-1010, -651.14, 32.01)
    vehiclesronda[20]=createVehicle(554,-1000, -651.14, 32.01)
    vehiclesronda[21]=createVehicle(554,-990, -651.14, 32.01)
    vehiclesronda[22]=createVehicle(554,-980, -651.14, 32.01)
    for k,v in pairs(vehiclesronda) do
        setElementDimension (v, 50) 
        if (10<k) then
            setVehicleColor(v,0,255,0,0,255,0,0,255,0)
        else
            setVehicleColor(v,255,0,0,255,0,0,255,0,0)
        end
    end
end
function destroyVehicles()
    for k,v in pairs(vehiclesronda) do
        vehiclesronda[k]=nil
        destroyElement(v)
    end
end
local recurso = getResourceFromName ("MapRobaCamion")
startResource(recurso)
createVehicles()

setElementDimension (cars["markerr"], 50)
setElementDimension (cars["markerg"], 50) 
setElementDimension (cars["red"], 50)
setElementDimension (cars["green"], 50) 



function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function isPlayerInMinigame(plr)
    if plr and isElement(plr) and getElementType(plr) == 'player' then
        if redTeam[plr] or greenTeam[plr] then
            return true
        end
    end
end

function getWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
        for i=1,12 do
            local wep = getPedWeapon(ped,i)
            local ammo = getPedTotalAmmo (ped,i) 
            if wep and wep ~= 0 and ammo then
                playerWeapons[wep] = ammo
            end
        end
        return playerWeapons
    end
end

function entrarMinigame(plr)
    if plr then
        if isElement(greenTeam[plr]) or isElement(redTeam[plr]) then
            outputChatBox("#FF0000[CVR]#FFFFFF Ya estás en el minijuego!",plr,255,255,255,true)
            return
        end
        if getTeamName(getPlayerTeam(plr))~="Unemployed" then
            outputChatBox("#FF0000[CVR]#FFFFFF Tienes que estar sin trabajo para entrar a Captura el Camión. Usa /resign",plr,255,255,255,true)
            return
        end
        if getPlayerMoney(plr)<tonumber(get("precio")) then
            outputChatBox("#FF0000[CVR]#FFFFFF Tienes que tener al menos 25.000 para entrar a Captura el Camión",plr,255,255,255,true)
            return
        end
        if getElementDimension(plr)~=0 then
            outputChatBox("#FF0000[CVR]#FFFFFF Tienes que estar en la dimensión 0 para entrar a Captura el Camión",plr,255,255,255,true)
            return
        end
        if getElementInterior(plr)~=0 then
            outputChatBox("#FF0000[CVR]#FFFFFF Tienes que estar en el interior 0 para entrar a Captura el Camión",plr,255,255,255,true)
            return
        end
        if getPedOccupiedVehicle(plr) then
            outputChatBox("#FF0000[CVR]#FFFFFF Tienes que estar a pie para entrar a Captura el Camión",plr,255,255,255,true)
            return
        end
        if exports['NGPolice']:isPlayerJailed(plr) then
            outputChatBox("#FF0000[CVR]#FFFFFF Estás en la cana. No puedes entrar a Captura el Camión",plr,255,255,255,true)
            return
        end
        exports['NGMessages']:sendClientMessage ("#ffffffEl jugador #ff0080"..getPlayerName(plr).." #ffffffentró a #ff8080Captura el Camión #ffffff(#079300Milicos #ffffffcontra #ff0000Petroñeros #ffffffedition)!",root,255,0,0)

        triggerClientEvent(plr,"CVRCapturaCamion:enableProtection",plr)

        removeElementData(plr,"isPassive")

        if table.size(redTeam)>table.size(greenTeam) then
            if table.size(greenTeam)>0 then
                for player,bool in pairs(greenTeam) do
                    if isPlayerInMinigame(player) and player~=plr then
                        triggerClientEvent(player,"CVRCapturaCamion:addPlayerTable",player,plr)
                        triggerClientEvent(plr,"CVRCapturaCamion:addPlayerTable",plr,player)
                    end
                end
            end
            greenTeam[plr]=plr
        else
            if table.size(redTeam)>0 then
                for player,bool in pairs(redTeam) do
                    if isPlayerInMinigame(player) and player~=plr then
                        triggerClientEvent(player,"CVRCapturaCamion:addPlayerTable",player,plr)
                        triggerClientEvent(plr,"CVRCapturaCamion:addPlayerTable",plr,player)
                    end
                end
            end
            redTeam[plr]=plr
        end
        triggerEvent('onPlayerStartMinigame',plr)
        return true
    end
end
addEvent("CVRCapturaCamion:EnterPlayer",true)
addEventHandler("CVRCapturaCamion:EnterPlayer",root,entrarMinigame)

function askEnter(plr)
    triggerClientEvent(plr,"CVRCapturaCamion:askPlayer",plr)
end

addCommandHandler("capturacamion",askEnter)

addEventHandler('onPlayerStartMinigame',root,
    function()
        puja=puja+30000
        exports['NGMessages']:sendClientMessage ("#ff8080Captura el Camión #ffffffestá comenzando, espera que se unan suficientes jugadores para empezar, o salte con /salircamion!",source,255,0,0)
        exports['NGMessages']:sendClientMessage ("#ffffffLa puja de #ff8080Captura el Camión#ffffff va en "..tostring(puja),root,255,0,0)
        local x,y,z = getElementPosition(source)
        local int,dim = getElementInterior(source), getElementDimension(source)
        local rx,ry,rz = getElementRotation(source)
        local skin = getElementModel(source) or 0
        local armas = getWeapons(source) or {}
        local wp = getElementData ( source, "WantedPoints" ) 
        lastposition[source] = {x=x,y=y,z=z,int=int,dim=dim,rot=rz,skin=skin,wp=wp}
        weapons[source] = armas
        takeAllWeapons(source)
        takePlayerMoney(source,tonumber(get("precio")))
        if isElement(greenTeam[source]) then
            spawnPlayer(source,-527.98, -480.09, 25.52,269,skin,0,50)
            setElementData ( source, 'Job', 'Militar' )
            exports['NGPlayerFunctions']:setTeam ( source, "Fuerzas Armadas" )
            setElementModel ( source, 287 )
            job = "militar"
        elseif isElement(redTeam[source]) then
            spawnPlayer(source,-1015.43, -660.52, 32.01,269,skin,0,50)
            local skin2 = getElementData ( source, 'NGUser.UnemployedSkin' )
            if ( not tonumber ( skin2 ) ) then skin2 = 109
            else skin2 = tonumber ( skin2 ) end
        
            setElementData ( source, 'Job', 'Criminal' )
            exports['NGPlayerFunctions']:setTeam ( source, "Criminals" )
            setElementModel ( source, skin2 )
            job = "Criminal"
        end
        triggerEvent("NGHospitals:disableRespawn",source)
        if not(isrunning) then
            setElementFrozen(source,true)
            triggerEvent('onPlayerMinigameReady',source)
        else
            for wep,ammo in pairs(armas) do
                local newWep = tonumber(wep) or 0
                local newAmmo = tonumber(ammo) or 0
                giveWeapon(source,newWep,newAmmo)
            end
        end
    end
)

addEventHandler('onPlayerMinigameReady',root,
    function()
        if table.size(greenTeam)>=1 and table.size(redTeam)>=1 then
            isrunning=true
            setElementDimension(cars["red"],50)
            setElementDimension(cars["green"],50)
            setVehicleColor(cars["red"],255,0,0)
            setVehicleColor(cars["green"],0,255,0)
            for v,k in pairs(greenTeam) do
                setElementFrozen(v,false)
                setPedArmor(v,100)
                setElementHealth(v,100)
                local armas = weapons[v]
                for wep,ammo in pairs(armas) do
                    local newWep = tonumber(wep) or 0
                    local newAmmo = tonumber(ammo) or 0
                    giveWeapon(v,newWep,newAmmo)
                end
            end
            for v,k in pairs(redTeam) do
                setElementFrozen(v,false)
                setPedArmor(v,100)
                setElementHealth(v,100)
                local armas = weapons[v]
                for wep,ammo in pairs(armas) do
                    local newWep = tonumber(wep) or 0
                    local newAmmo = tonumber(ammo) or 0
                    giveWeapon(v,newWep,newAmmo)
                end
            end
        else
            outputChatBox("#FF0000[CVR]#FFFFFF Esperando que se unan los necesarios..",source,255,255,255,true)
        end
    end
)

addEventHandler('onPlayerWasted',root,
    function()
        outputChatBox("#FF0000[CVR]#FFFFFF En 15 segundos revivirás..",source,255,255,255,true)
        setTimer(function(source)
            local e=lastposition[source]
            if isPlayerInMinigame(source) then
                if isElement(greenTeam[source]) then
                    spawnPlayer(source,-527.98, -480.09, 25.52,269,287,0,50)
                elseif isElement(redTeam[source]) then
                    spawnPlayer(source,-1015.43, -660.52, 32.01,269,e.skin,0,50)
                end
                setPedArmor(source,100)
                local balas=weapons[source]
                for wep,ammo in pairs(balas) do
                    local newWep = tonumber(wep) or 0
                    local newAmmo = tonumber(ammo) or 0
                    giveWeapon(source,newWep,newAmmo)
                end
            end
        end, 15000, 1,source)
    end
)

redmarker = createMarker( -1079.74, -711.7, 32.01, "cylinder", 3, 255, 0, 0, 255 ) 
greenmarker = createMarker( -604.05, -481.33, 25.52, "cylinder", 3, 255, 0, 0, 255 ) 

setElementDimension (redmarker, 50)
setElementDimension (greenmarker, 50) 
      
function roundwin(hitElement,matchingDimension) 
    if (source == redmarker and hitElement == cars["green"]) then 
        if isElementWithinMarker (cars["red"], cars["markerr"]) then
            roundredwins=roundredwins+1
            exports['NGMessages']:sendClientMessage ("#ffffffEl equipo #ff1111rojo #ffffffganó la ronda de #ff8080Captura el Camión #ffffff(#079300Milicos #ffffffcontra #ff0000Petroñeros #ffffffedition)!",root,255,0,0)
            for v,k in pairs(redTeam) do
                triggerEvent('onroundWin',v)
            end
            for v,k in pairs(greenTeam) do
                triggerEvent('onroundWin',v)
            end
        else
            exports['NGMessages']:sendClientMessage ("#ffffffEl equipo #ff1111rojo #ffffffno tiene su camión en la base, por lo tanto no puede puntuar hasta recuperarlo o destruirlo!",root,255,0,0)
            return
        end
    elseif ( source == greenmarker and hitElement == cars["red"] ) then 
        if isElementWithinMarker ( cars["green"], cars["markerg"]) then
            roundgreenwins=roundgreenwins+1
            exports['NGMessages']:sendClientMessage ("#ffffffEl equipo #0afe28verde #ffffffganó la ronda de #ff8080Captura el Camión #ffffff(#079300Milicos #ffffffcontra #ff0000Petroñeros #ffffffedition)!",root,255,0,0)
            for v,k in pairs(greenTeam) do
                triggerEvent('onroundWin',v)
            end
            for v,k in pairs(redTeam) do
                triggerEvent('onroundWin',v)
            end
        else
            exports['NGMessages']:sendClientMessage ("#ffffffEl equipo #0afe28verde #ffffffno tiene su camión en la base, por lo tanto no puede puntuar hasta recuperarlo o destruirlo!",root,255,0,0)
            return
        end
    end 
end 
addEventHandler("onMarkerHit", getRootElement(),roundwin) 


addEventHandler('onroundWin',root,
    function()
        destroyVehicles()
        createVehicles()
        destroyElement(cars["green"])
        destroyElement(cars["blipg"])
        cars["blipg"]=nil
        cars["green"]=nil
        cars["green"] = createVehicle(499,-472.88, -513.07, 25.52)
        setElementDimension(cars["green"],50)
        setVehicleColor(cars["green"],0,255,0)
        destroyElement(cars["red"])
        destroyElement(cars["blipr"])
        cars["blipr"]=nil
        cars["red"]=nil
        cars["red"] = createVehicle(499,-1011.27, -686.74, 32.01)
        cars["blipg"]=createBlipAttachedTo(cars["red"],51,2,255,0,0,255,0,99999.0,getRootElement())
        cars["blipr"]=createBlipAttachedTo(cars["green"],51,2,0,255,0,255,0,99999.0,getRootElement())
        setElementDimension(cars["red"],50)
        setVehicleColor(cars["red"],255,0,0)
        if roundredwins==3 and roundgreenwins<3 then
            if get("tipopremio")=="auto" then
                premio=puja*1.2/table.size(redTeam)
            else
                premio=tonumber(get("tipopremio"))
            end
            exports['NGMessages']:sendClientMessage ("#ffffffEl equipo #ff1111rojo #ffffffganó el juego #ff8080Captura el Camión #ffffff(#079300Milicos #ffffffcontra #ff0000Petroñeros #ffffffedition)! llevándose así #00ff00 "..tostring(puja),root,255,0,0)
            for v,k in pairs(redTeam) do
                givePlayerMoney(v,premio)
                triggerEvent('onMiniGameExit',v)
            end
            for v,k in pairs(greenTeam) do
                triggerEvent('onMiniGameExit',v)
            end
            puja=0
            roundredwins=0
            roundgreenwins=0
            isrunning=false
        elseif roundgreenwins==3 and roundredwins<3 then
            if get("tipopremio")=="auto" then
                premio=puja*1.2/table.size(greenTeam)
            else
                premio=tonumber(get("tipopremio"))
            end
            for v,k in pairs(greenTeam) do
                givePlayerMoney(v,premio)
                triggerEvent('onMiniGameExit',v)
            end
            for v,k in pairs(redTeam) do
                triggerEvent('onMiniGameExit',v)
            end
            puja=0
            roundredwins=0
            roundgreenwins=0
            isrunning=false
            exports['NGMessages']:sendClientMessage ("#ffffffEl equipo #0afe28verde #ffffffganó el juego #ff8080Captura el Camión #ffffff(#079300Milicos #ffffffcontra #ff0000Petroñeros #ffffffedition)! llevándose así #00ff00 "..tostring(puja),root,255,0,0)
        elseif roundredwins==3 and roundgreenwins==3 then
            local premio=puja/2/(table.size(greenTeam)+table.size(redTeam))
            for v,k in pairs(redTeam) do
                givePlayerMoney(v,premio)
                triggerEvent('onMiniGameExit',v)
            end
            for v,k in pairs(greenTeam) do
                givePlayerMoney(v,premio)
                triggerEvent('onMiniGameExit',v)
            end
            puja=0
            roundredwins=0
            roundgreenwins=0
            isrunning=false
            exports['NGMessages']:sendClientMessage ("#ffffffEl juego #ff8080Captura el Camión #ffffff(#079300Milicos #ffffffcontra #ff0000Petroñeros #ffffffedition) terminó empatado, se devuelve la mitad del dinero",root,255,0,0)
        elseif roundredwins<3 and roundgreenwins<3 then
            for v,k in pairs(redTeam) do
                local f=lastposition[v]
                spawnPlayer(v,-1015.43, -660.52, 32.01,269,f.skin,0,50)
                local redbalas=weapons[v]
                for wep,ammo in pairs(redbalas) do
                    local newWep = tonumber(wep) or 0
                    local newAmmo = tonumber(ammo) or 0
                    giveWeapon(v,newWep,newAmmo)
                end
            end
            for v,k in pairs(greenTeam) do
                local xd=lastposition[v]
                spawnPlayer(v,-527.98, -480.09, 25.52,269,287,0,50)
                local greenbalas=weapons[v]
                for wep,ammo in pairs(greenbalas) do
                    local newWep = tonumber(wep) or 0
                    local newAmmo = tonumber(ammo) or 0
                    giveWeapon(v,newWep,newAmmo)
                end
            end
        end
    end
)

addEventHandler('onMiniGameExit',root,
    function()
        if isPlayerInMinigame(source) then
            local userposition=lastposition[source]
            spawnPlayer(source,userposition.x,userposition.y,userposition.z,userposition.rot,userposition.skin,userposition.int,userposition.dim)
            setElementData ( source, "WantedPoints", userposition.wp ) 
            local playerweapons=weapons[source]
            setTimer(function(playerweapons,source)
                for wep,ammo in pairs(playerweapons) do
                    local newWep = tonumber(wep) or 0
                    local newAmmo = tonumber(ammo) or 0
                    giveWeapon(source,newWep,newAmmo)
                end
            end,3000,1,playerweapons,source)
            weapons[source]=nil
            lastposition[source]=nil
            if isElement(greenTeam[source]) then
                greenTeam[source]=nil
                for player,bool in pairs(greenTeam) do
                    if isPlayerInMinigame(source) and player~=source then
                        triggerClientEvent(player,"CVRCapturaCamion:removePlayerTable",player,source)
                    end
                end
            end
            if isElement(redTeam[source])then
                redTeam[source]=nil
                for player,bool in pairs(redTeam) do
                    if isPlayerInMinigame(source) and player~=source then
                        triggerClientEvent(player,"CVRCapturaCamion:removePlayerTable",player,source)
                    end
                end
            end
            triggerEvent("NGJobs:resign",source,source,true)
            triggerEvent("NGHospitals:enableRespawn",source)
            triggerClientEvent(source,"CVRCapturaCamion:disableProtection",source)
        end
    end
)

function exit(p)
    triggerEvent('onMiniGameExit',p)
end
addCommandHandler("salircamion",exit)

addEventHandler('onVehicleExplode',root,
    function()
        if source==cars["green"] then
            destroyElement(cars["green"])
            cars["green"]=nil
            destroyElement(cars["blipr"])
            cars["blipr"]=nil
            cars["green"] = createVehicle(499,-472.88, -513.07, 25.52)
            cars["blipr"]=createBlipAttachedTo(cars["green"],51,2,255,0,0,255,0,99999.0,getRootElement())
            setElementDimension(cars["green"],50)
            setVehicleColor(cars["green"],0,255,0)
        elseif source==cars["red"] then
            destroyElement(cars["red"])
            destroyElement(cars["blipg"])
            cars["blipg"]=nil
            cars["red"]=nil
            cars["red"] = createVehicle(499,-1011.27, -686.74, 32.01)
            cars["blipg"]=createBlipAttachedTo(cars["red"],51,2,255,0,0,255,0,99999.0,getRootElement())
            setElementDimension(cars["red"],50)
            setVehicleColor(cars["red"],255,0,0)
        elseif source==vehiclesronda[1] then
            destroyElement(vehiclesronda[1])
            vehiclesronda[1]=nil
            vehiclesronda[1]=createVehicle(554,-490.56, -487.27, 25.52)
            setVehicleColor(vehiclesronda[1],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[1],50)   
        elseif source==vehiclesronda[2] then
            destroyElement(vehiclesronda[2])
            vehiclesronda[2]=nil
            vehiclesronda[2]=createVehicle(554,-500.22, -487.27, 25.52)
            setVehicleColor(vehiclesronda[2],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[2],50)   
        elseif source==vehiclesronda[3] then
            destroyElement(vehiclesronda[3])
            vehiclesronda[3]=nil
            vehiclesronda[3]=createVehicle(554,-510.24, -487.27, 25.52)
            setVehicleColor(vehiclesronda[3],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[3],50)   
        elseif source==vehiclesronda[4] then
            destroyElement(vehiclesronda[4])
            vehiclesronda[4]=nil
            vehiclesronda[4]=createVehicle(554,-519.98, -487.27, 25.52)
            setVehicleColor(vehiclesronda[4],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[4],50)   
        elseif source==vehiclesronda[5] then
            destroyElement(vehiclesronda[5])
            vehiclesronda[5]=nil
            vehiclesronda[5]=createVehicle(554,-530.05, -487.26, 25.52)
            setVehicleColor(vehiclesronda[5],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[5],50)   
        elseif source==vehiclesronda[6] then
            destroyElement(vehiclesronda[6])
            vehiclesronda[6]=nil
            vehiclesronda[6]=createVehicle(554,-539.32, -487.27, 25.52)
            setVehicleColor(vehiclesronda[6],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[6],50)   
        elseif source==vehiclesronda[7] then
            destroyElement(vehiclesronda[7])
            vehiclesronda[7]=nil
            vehiclesronda[7]=createVehicle(554,-549.97, -487.27, 25.52)
            setVehicleColor(vehiclesronda[7],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[7],50)   
        elseif source==vehiclesronda[8] then
            destroyElement(vehiclesronda[8])
            vehiclesronda[8]=nil
            vehiclesronda[8]=createVehicle(554,-560.31, -487.27, 25.52)
            setVehicleColor(vehiclesronda[8],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[8],50)   
        elseif source==vehiclesronda[9] then
            destroyElement(vehiclesronda[9])
            vehiclesronda[9]=nil
            vehiclesronda[9]=createVehicle(554,-570.31, -487.27, 25.52)
            setVehicleColor(vehiclesronda[9],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[9],50)   
        elseif source==vehiclesronda[10] then
            destroyElement(vehiclesronda[10])
            vehiclesronda[10]=nil
            vehiclesronda[10]=createVehicle(554,-580.31, -487.27, 25.52)
            setVehicleColor(vehiclesronda[10],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[10],50)   
        elseif source==vehiclesronda[11] then
            destroyElement(vehiclesronda[11])
            vehiclesronda[11]=nil
            vehiclesronda[11]=createVehicle(554,-1030, -661.14, 32.01)
            setVehicleColor(vehiclesronda[11],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[11],50)   
        elseif source==vehiclesronda[12] then
            destroyElement(vehiclesronda[12])
            vehiclesronda[12]=nil
            vehiclesronda[12]=createVehicle(554,-1020, -661.14, 32.01)
            setVehicleColor(vehiclesronda[12],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[12],50)   
        elseif source==vehiclesronda[13] then
            destroyElement(vehiclesronda[13])
            vehiclesronda[13]=nil
            vehiclesronda[13]=createVehicle(554,-1010, -661.14, 32.01)
            setVehicleColor(vehiclesronda[13],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[13],50)   
        elseif source==vehiclesronda[14] then
            destroyElement(vehiclesronda[14])
            vehiclesronda[14]=nil
            vehiclesronda[14]=createVehicle(554,-1000, -661.14, 32.01)
            setVehicleColor(vehiclesronda[14],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[14],50)   
        elseif source==vehiclesronda[15] then
            destroyElement(vehiclesronda[15])
            vehiclesronda[15]=nil
            vehiclesronda[15]=createVehicle(554,-990, -661.14, 32.01)
            setVehicleColor(vehiclesronda[15],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[15],50)   
        elseif source==vehiclesronda[16] then
            destroyElement(vehiclesronda[16])
            vehiclesronda[16]=nil
            vehiclesronda[16]=createVehicle(554,-980, -661.14, 32.01)
            setVehicleColor(vehiclesronda[16],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[16],50)   
        elseif source==vehiclesronda[17] then
            destroyElement(vehiclesronda[17])
            vehiclesronda[17]=nil
            vehiclesronda[17]=createVehicle(554,-1030, -651.14, 32.01)
            setVehicleColor(vehiclesronda[17],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[17],50)   
        elseif source==vehiclesronda[18] then
            destroyElement(vehiclesronda[18])
            vehiclesronda[18]=nil
            vehiclesronda[18]=createVehicle(554,-1020, -651.14, 32.01)
            setVehicleColor(vehiclesronda[18],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[18],50)   
        elseif source==vehiclesronda[19] then
            destroyElement(vehiclesronda[19])
            vehiclesronda[19]=nil
            vehiclesronda[19]=createVehicle(554,-1010, -651.14, 32.01)
            setVehicleColor(vehiclesronda[19],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[19],50)   
        elseif source==vehiclesronda[20] then
            destroyElement(vehiclesronda[20])
            vehiclesronda[20]=nil
            vehiclesronda[20]=createVehicle(554,-1000, -651.14, 32.01)
            setVehicleColor(vehiclesronda[20],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[20],50)   
        elseif source==vehiclesronda[21] then
            destroyElement(vehiclesronda[21])
            vehiclesronda[21]=nil
            vehiclesronda[21]=createVehicle(554,-990, -651.14, 32.01)
            setVehicleColor(vehiclesronda[21],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[21],50)   
        elseif source==vehiclesronda[22] then
            destroyElement(vehiclesronda[22])
            vehiclesronda[22]=nil
            vehiclesronda[22]=createVehicle(554,-980, -651.14, 32.01)
            setVehicleColor(vehiclesronda[22],0,255,0,0,255,0,0,255,0)
            setElementDimension(vehiclesronda[22],50)   
        end
    end
)
addEventHandler('onPlayerQuit',root,
    function()
        if isPlayerInMinigame(source) then
            local userposition=lastposition[source]
            spawnPlayer(source,userposition.x,userposition.y,userposition.z,userposition.rot,userposition.skin,userposition.int,userposition.dim)
            setElementData ( source, "WantedPoints", userposition.wp ) 
            local playerweapons=weapons[source]
            for wep,ammo in pairs(playerweapons) do
              local newWep = tonumber(wep) or 0
              local newAmmo = tonumber(ammo) or 0
              giveWeapon(source,newWep,newAmmo)
           end
         weapons[source]=nil
          lastposition[source]=nil
            if isElement(greenTeam[source]) then
                greenTeam[source]=nil
            end
            if isElement(redTeam[source])then
             redTeam[source]=nil
         end
     end
    end
)


addEventHandler('onVehicleEnter',getResourceRootElement(),
    function(thePlayer)
        if source==cars["green"] then
            triggerClientEvent(thePlayer,'godTruck',thePlayer)
            setTimer(function()
                triggerClientEvent(thePlayer,'disableGodTruck',thePlayer)
            end, 30000,1)
        elseif source==cars["red"] then
            triggerClientEvent(thePlayer,'godTruck',thePlayer)
            setTimer(function()
                triggerClientEvent(thePlayer,'disableGodTruck',thePlayer)
            end, 30000,1)
        end
    end
)

addEventHandler ( "onPlayerVehicleExit", getResourceRootElement(), function(seat,thePlayer)
    if seat == 0 then
        triggerClientEvent(thePlayer,'disableGodTruck',thePlayer)
    end
end)

local marcadorcamion = createMarker(1282.6,-1359.7,12.5, "cylinder", 2, 255,255,255, visibleTo)
function markerCamion (hitElement,matchingDimension)
    if isElement(hitElement) and getElementType(hitElement)=="player" and matchingDimension then
        askEnter(hitElement)
    end
end
addEventHandler("onMarkerHit",marcadorcamion,markerCamion)