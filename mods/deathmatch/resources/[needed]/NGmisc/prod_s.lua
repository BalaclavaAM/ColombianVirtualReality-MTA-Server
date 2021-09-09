local carrazos={}

function chgWeather(p,_,w)
    local accName = getAccountName(getPlayerAccount(p))
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Productores" ) ) or exports['NGAdministration']:isPlayerStaff(p) then
        if w then
            if tonumber(w) then
                triggerClientEvent(p,"NGMisc:CambiarKlima",p,w)
            end
        else
            outputChatBox("Pon un número del 0 al 255",p,255,0,0)
        end
    end
end
addCommandHandler("cambiarclima",chgWeather)

function chgTime(p,_,h,m)
    local accName = getAccountName(getPlayerAccount(p))
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Productores" ) ) or exports['NGAdministration']:isPlayerStaff(p) then
        if h and m then
            if tonumber(h) and tonumber(m) then
                triggerClientEvent(p,"NGMisc:CambiarHora",p,h,m)
            end
        else
            outputChatBox("Uso: /cambiartiempo hora(0-23) minuto(0,59)",p,255,0,0)
        end
    end
end
addCommandHandler("cambiartiempo",chgTime)

function borrarcarro()
    if isElement(source) then
        destroyElement(source)
        local yabe=":v"
        local yabe2="Bv"
        for k,v in pairs(carrazos) do 
            for k2,v2 in ipairs(v) do
                if v2==source then
                    yabe=k
                    yabe2=k2
                    break
                end
            end
        end
        if yabe~=":v" and yabe2~="Bv" then
            carrazos[yabe][yabe2]=nil
        end
    end
end

function alsalirprod()
    local accName = getAccountName(getPlayerAccount(source))
    for k,v in ipairs(carrazos[accName]) do
        if isElement(v) then
            destroyElement(v)
        end
    end
    carrazos[accName]=nil
end

function sayprodcar(thePed)
    if isElement(thePed) then
        local creador = ""
        for k,v in pairs(carrazos) do
            for k2,v2 in ipairs(v) do
                if v2==source then
                    creador=k
                    break
                end
            end
        end
        outputChatBox("Este vehículo es de producción",thePed,255,255,0)
        outputChatBox("Por lo tanto no puede usarse para chimbiar",thePed,255,255,0)
        outputChatBox("Vehículo creado por: "..creador,thePed,255,255,0)
    end
end

function crearcarro(p,_,v)
    local accName = getAccountName(getPlayerAccount(p))
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Productores" ) ) or exports['NGAdministration']:isPlayerStaff(p) then
        if v then
            if tonumber(v) then
                local x,y,z = getElementPosition(p)
                if not carrazos[accName] then
                    carrazos[accName]={}
                    addEventHandler("onPlayerQuit",p,alsalirprod)
                end
                local momos = createVehicle(v,x,y,z+2,0,0,3,"Produc")
                table.insert(carrazos[accName],momos)
                addEventHandler("onVehicleExplode",momos,borrarcarro)
                addEventHandler("onVehicleEnter",momos,sayprodcar)
            end
        end
    end
end
addCommandHandler("carprod",crearcarro)

function destruircarros(p)
    local accName = getAccountName(getPlayerAccount(p))
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Productores" ) ) or exports['NGAdministration']:isPlayerStaff(p) then
        for k,v in ipairs(carrazos[accName]) do
            if isElement(v) then
                destroyElement(v)
            end
        end
        carrazos[accName]=nil
    end
end
addCommandHandler("destroycarsprod",destruircarros)

function onEnterVehicle ( theVehicle, seat, jacked )
    if getElementModel ( theVehicle ) == 522 or 510 or 581 or 509 or 468 or 521 then --ID xe
        addPedClothes ( source, "moto", "moto", 16 )
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), onEnterVehicle )
 
function onExitVehicle ( theVehicle, seat, jacked )
    if getElementModel ( theVehicle ) == 522 or 510 or 581 or 509 or 468 or 521 then --ID xe
        removePedClothes ( source, 16 )
    end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), onExitVehicle )

local peds = {}
function crearPedRandom ( p )
    local x,y,z = getElementPosition(p)
    local rx,ry,rz = getElementRotation(p)
    table.insert(peds,createPed(math.random(0,312),x,y,z,rz))
end
addCommandHandler("createp",crearPedRandom)

function destroyPedRandom ( )
    destroyElement(peds[#peds])
    peds[#peds]=nil
end
addCommandHandler("destroyp",destroyPedRandom)

local a = 0
function setAnimationPeds()
    if a == 0 then
        for k,v in ipairs(peds) do
            setPedAnimation(v,"riot","riot_angry_b",-1,true,false,false,false)
        end
        a=1
    elseif a==1 then
        for k,v in ipairs(peds) do
            setPedAnimation(v,"riot","riot_chant",-1,true,false,false,false )
        end
        a=2
    elseif a==2 then
        for k,v in ipairs(peds) do
            setPedAnimation(v,"dancing", "dance_loop", 10000000)
        end
        a=3
    elseif a==3 then
        for k,v in ipairs(peds) do
            setPedAnimation(v,"dancing", "dan_up_a", -1)
        end
        a=4
    elseif a==4 then
        for k,v in ipairs(peds) do
            setPedAnimation(v,"dancing", "bd_clap",-1)
        end
        a=5
    elseif a==5 then
        for k,v in ipairs(peds) do
            triggerEvent("BaiR1",v,v)
        end
        a=6
    elseif a==6 then
        for k,v in ipairs(peds) do
            triggerEvent("BaiR2",v,v)
        end
        a=7
    elseif a==7 then
        for k,v in ipairs(peds) do
            triggerEvent("BaiR3",v,v)
        end
        a=8
    elseif a==8 then
        for k,v in ipairs(peds) do
            triggerEvent("BaiR4",v,v)
        end
        a=9
    elseif a==9 then
        for k,v in ipairs(peds) do
            triggerEvent("BaiR5",v,v)
        end
        a=0
    end
end
addCommandHandler("anima",setAnimationPeds)


--[[
    temporal for balaclava
]]
local positions={}
local indexes={}

function isBalaclava(p)
    local retorno=false
    if getAccountName(getPlayerAccount(p))=="BalaclavaAM" or getAccountName(getPlayerAccount(p))=="Balaclava" then
        retorno=true
    end
    return retorno
end

function savePosition(p)
    if not(isBalaclava(p)) then return end
    local x,y,z,lx,ly,lz,r,fov = getCameraMatrix(p)
    if not(positions[p]) then positions[p] = {} end
    table.insert(positions[p],{x,y,z,lx,ly,lz,r,fov})
    outputChatBox("Guardada",p)
end
addCommandHandler("savepos",savePosition)

function fowardPosition(p)
    if not(isBalaclava(p)) then return end
    local index=1
    if indexes[p] then
        index=indexes[p]+1
    end
    if index>#positions[p] or index<1 then 
        index=1
    end
    if not (positions[p][index]) then return end
    indexes[p]=index
    local pt = positions[p][index]
    outputChatBox("Pos"..index,p)
    setCameraMatrix(getPlayerFromName("Balaclava"),pt[1],pt[2],pt[3],pt[4],pt[5],pt[6],pt[7],pt[8])
end
addCommandHandler("fpos",fowardPosition)

function rewindPosition(p)
    if not(isBalaclava(p)) then return end
    local index=1
    if indexes[p] then
        index=indexes[p]-1
    end
    if index>#positions[p] or index<1 then 
        index=1
    end
    if not positions[p][index] then return end
    indexes[p]=index
    local pt = positions[p][index]
    outputChatBox("Pos"..index,p)
    setCameraMatrix(getPlayerFromName("Balaclava"),pt[1],pt[2],pt[3],pt[4],pt[5],pt[6],pt[7],pt[8])
end
addCommandHandler("rpos",rewindPosition)

function delPos(p)
    if not(isBalaclava(p)) then return end
    if #positions[p]>0 then
        positions[p][#positions[p]]=nil
        outputChatBox("Borrada",p)
    end
end
addCommandHandler("delpos",delPos)