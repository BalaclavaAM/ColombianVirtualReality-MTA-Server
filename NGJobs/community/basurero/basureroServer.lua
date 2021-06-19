coordenadasmarcadores={
    { 2113.18, -1892.16, 13.92 }, 
    { 2084.58, -1826.85, 12.9 }, 
    { 2113.14, -1381.19, 23.35 }, 
    { 2224.78, -1223.74, 23.32 }, 
    { 2543.86, -1090.14, 62.12 }, 
    { 2545.93, -1044.21, 68.96 }, 
    { 2121.19, -989.63, 56.87 }, 
    {1925.2, -1088.88, 24.16 }, 
    { 1782.66, -1168.51, 23.18 }, 
    { 1529.43, -1038.74, 23.16 }, 
    { 1265.86, -1007.9, 33.59 }, 
    {2180.6, -1988.12, 14.14}
}

coordenadasmarcadores2={
    { 2112.54, -1888.07, 13.55 }, 
    { 2092.38, -1824.65, 13.55 }, 
    { 2112.71, -1365.91, 23.98 }, 
    { 2226.39, -1228.67, 23.97 }, 
    { 2547.94, -1102.89, 62.63 }, 
    { 2545.25, -1036.89, 69.58 }, 
    { 2121.46, -982.3, 57.31 }, 
    { 1925.59, -1081.54, 24.27 }, 
    { 1780.73, -1179.31, 23.83 }, 
    { 1522.48, -1018.21, 23.92 }, 
    { 1275.17, -1007.23, 34.26 },
    {2195.6, -1969.26, 13.78}
}
companieros={}
onduty={}
paradas={}


function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end


marcadoresbasura={}
marcadoresbasura2={}
blipbasura={}
blipbasura2={}

function parada(hitElement, matchingDimension)
    if getElementType(hitElement)=="vehicle" then
        if getElementModel(hitElement)==408 then
            local conductor = getVehicleOccupant(hitElement,0) or false
            if not onduty[conductor] then return end
            local ayudante = companieros[conductor] or false
            local basureando = onduty[conductor] or false
            local parada = paradas[conductor] or false
            local parada2 = paradas[ayudante] or false
            if source==marcadoresbasura[table.size(marcadoresbasura)] and parada and parada2 then
                if parada==table.size(marcadoresbasura) and parada2==table.size(marcadoresbasura2) then
                    setElementVisibleTo(source,conductor,false)
                    exports['NGMessages']:sendClientMessage ( "Espera a que tu ayudante reclame el pago.", conductor, 0, 255, 0 )
                    return
                end
            end
            if not basureando then return end
            if not ayudante then return end
            if not parada == paradas[companeiro] then return end
            if not (source == marcadoresbasura[parada-1]) then return end
            exports['NGMessages']:sendClientMessage ( "Espera a que tu ayudante recicle.", conductor, 0, 255, 0 )
            exports['NGMessages']:sendClientMessage ( "Bájate a reciclar!.", ayudante, 255, 255, 0 )
        end
    end
end



function parada2(hitElement, matchingDimension)
    if getElementType(hitElement)=="player" then
        if getElementData(hitElement,"Job") == "Basurero" and onduty[hitElement] then
            local companeiro = companieros[hitElement] or false
            local basureando = onduty[hitElement] or false
            local parada = paradas[hitElement] or false
            local parada2 = paradas[companeiro] or false
            if source==marcadoresbasura2[table.size(marcadoresbasura)] and parada and parada2 then
                if parada==table.size(marcadoresbasura) and parada2==table.size(marcadoresbasura2) then
                    setElementVisibleTo(source,hitElement,false)
                    finishjob(hitElement)
                    return
                end
            end
            local vehiclecompaneiro = getPedOccupiedVehicle(companeiro) or false
            if not vehiclecompaneiro then return end
            if not (isElementWithinMarker(vehiclecompaneiro,marcadoresbasura[paradas[companeiro]-1]) and getElementModel(vehiclecompaneiro) == 408) then exports['NGMessages']:sendClientMessage ( "Tu compañero tiene que estar parado en su marcador con un camión de la basura!", hitElement, 177,50,0 ) return end
            if not basureando then return end
            if not companeiro then return end
            if not (source == marcadoresbasura2[parada-1]) then return end
            if not (paradas[companeiro]==paradas[hitElement]) then return end
            setearvisible2(hitElement,parada)
        end
    end
end

function finishjob(reciclador)
    local jobRank = getElementData(driver,"Job Rank") or "MeteBoxer"
    mult = 1
    if jobRank == "Reciclador" then
        mult = 0.9
    elseif jobRank == "Recogebasura" then
        mult = 0.95
    elseif jobRank == "Recogebasura experimentado" then
        mult = 1
    elseif jobRank == "Transportador de la basura" then
        mult = 1.05
    elseif jobRank == "Maestro de la basura" then
        mult = 1.1
    elseif jobRank == "CAPO de la basura" then
        mult = 1.15
    end
 
    local jobRank2 = getElementData(companieros[reciclador],"Job Rank") or "MeteBoxer"
    mult2 = 1
    if jobRank == "Reciclador" then
        mult2 = 0.9
    elseif jobRank == "Recogebasura" then
        mult2 = 0.95
    elseif jobRank == "Recogebasura experimentado" then
        mult2 = 1
    elseif jobRank == "Transportador de la basura" then
        mult2 = 1.05
    elseif jobRank == "Maestro de la basura" then
        mult2 = 1.1
    elseif jobRank == "CAPO de la basura" then
        mult2 = 1.15
    end

    local luka = math.random(100000,130000)
    givePlayerMoney(reciclador,(luka*0.60)*mult)
    givePlayerMoney(companieros[reciclador],(luka*0.40)*mult2)
    exports['NGMessages']:sendClientMessage ( "Eres "..jobRank.." y trabajaste de ayudante por lo tanto ganas el 60% de la tajada ".." es decir "..tonumber((luka*0.60)*mult), reciclador, 0, 255, 0 )
    exports['NGMessages']:sendClientMessage ( "Eres "..jobRank2.." y trabajaste de conductor por lo tanto ganas el 40% de la tajada ".." es decir "..tonumber((luka*0.40)*mult2), companieros[reciclador], 0, 255, 0 )
    for index,value in ipairs(marcadoresbasura) do
        setElementVisibleTo(value,reciclador,false)
        setElementVisibleTo(value,companieros[reciclador],false)
        setElementVisibleTo(blipbasura[index],reciclador,false)
        setElementVisibleTo(blipbasura[index],companieros[reciclador],false)
    end
    for index,value in ipairs(marcadoresbasura2) do
        setElementVisibleTo(value,reciclador,false)
        setElementVisibleTo(value,companieros[reciclador],false)
        setElementVisibleTo(blipbasura2[index],reciclador,false)
        setElementVisibleTo(blipbasura[index],companieros[reciclador],false)
    end
    onduty[reciclador]=nil
    onduty[companieros[reciclador]]=nil
    paradas[reciclador]=nil
    paradas[companieros[reciclador]]=nil
    companieros[companieros[reciclador]]=nil
    companieros[reciclador]=nil

end

function hideallmarkersdriver(parsero)
    for index,value in ipairs(marcadoresbasura) do
        setElementVisibleTo(value,parsero,false)
        setElementVisibleTo(blipbasura[index],parsero,false)
    end
    for index,value in ipairs(marcadoresbasura2) do
        setElementVisibleTo(blipbasura2[index],parsero,false)
    end
end


function finishjobForced(source)
    if not (onduty[source]) then return end
    onduty[source]=nil
    onduty[companieros[source]]=nil
    paradas[source]=nil
    paradas[companieros[source]]=nil
    companieros[companieros[source]]=nil
    hideallmarkersdriver(companieros[source])
    companieros[source]=nil
end

function finishjobwithcommand(player)
    if not (onduty[player]) then return end
    exports['NGMessages']:sendClientMessage ( "Has terminado con comando la recolección ", player, 0, 255, 0 )
    exports['NGMessages']:sendClientMessage ( "Tu compañero terminó con comando la recolección ", companieros[player], 0, 255, 0 )
    for index,value in ipairs(marcadoresbasura) do
        setElementVisibleTo(value,player,false)
        setElementVisibleTo(value,companieros[player],false)
        setElementVisibleTo(blipbasura[index],player,false)
        setElementVisibleTo(blipbasura[index],companieros[player],false)
    end
    for index,value in ipairs(marcadoresbasura2) do
        setElementVisibleTo(value,player,false)
        setElementVisibleTo(value,companieros[player],false)
        setElementVisibleTo(blipbasura2[index],player,false)
        setElementVisibleTo(blipbasura[index],companieros[player],false)
    end
    onduty[player]=nil
    onduty[companieros[player]]=nil
    paradas[player]=nil
    paradas[companieros[player]]=nil
    companieros[companieros[player]]=nil
    hideallmarkersdriver(companieros[player])
    companieros[player]=nil
end
addEventHandler ( "onPlayerQuit", root, finishjobForced )

addCommandHandler("terminarbasura",finishjobwithcommand)


function crearMarcador()
    for index,value in ipairs(coordenadasmarcadores) do
        local x, y, z = value[1],value[2],value[3]
        marcadoresbasura[index]=createMarker(x,y,z-1,"cylinder",6,150,0,0,255,resourceRoot)
        blipbasura[index]=createBlip(x,y,z,56,4,255,0,0,255,0,99999.0,resourceRoot)
        addEventHandler("onMarkerHit",marcadoresbasura[index],parada)
    end
    for index,value in ipairs(coordenadasmarcadores2) do
        local x, y, z = value[1],value[2],value[3]
        marcadoresbasura2[index]=createMarker(x,y,z-1,"cylinder",2.5,0,155,0,255,resourceRoot)
        blipbasura2[index]=createBlip(x,y,z,49,4,255,0,0,255,0,99999.0,resourceRoot)
        addEventHandler("onMarkerHit",marcadoresbasura2[index],parada2)
    end
end
crearMarcador()



function basuraHandler ( thePlayer, seat, jacked )
    local trabajando = onduty[thePlayer] or false
    if not (getElementModel(source) == 408) then return end
    local parada = paradas[thePlayer] or false
    if not ( getElementData( thePlayer, "Job") == "Basurero" ) and getElementModel(source)== 408 and (not trabajando) then 
        exports['NGMessages']:sendClientMessage ( "Tienes que ser basurero y subirte al carro de basura para que puedas trabajar.", thePlayer, 0, 255, 0 )
    elseif ( getElementData(thePlayer, "Job") == "Basurero" and seat==0 and getElementModel(source)==408 and (not trabajando)) then
        exports['NGMessages']:sendClientMessage ( "Eres el conductor del carro! Ve a los checkpoints y espera que tu companeiro recicle. Si no tienes companeiro qué esperas? Consigue uno!", thePlayer, 177,50,0 )
        setElementVisibleTo(marcadoresbasura[1],thePlayer,true)
        setElementVisibleTo(blipbasura[1],thePlayer,true)
        paradas[thePlayer]=2
        onduty[thePlayer]=true
        exports['NGMessages']:sendClientMessage ( "Usa /terminarbasura por si se te bugea!!!!.", thePlayer, 0, 255, 0 )
    elseif ( getElementData(thePlayer, "Job") == "Basurero" and seat==1 and getElementModel(source)==408 and (not trabajando)) then
        exports['NGMessages']:sendClientMessage ( "Eres el ayudante! Bájate del camión a reciclar cuando el conductor llegue a las paradas", thePlayer, 177,50,0 )
        local conductor = getVehicleOccupant(source,0) or false
        setElementVisibleTo(marcadoresbasura2[1],thePlayer,true)
        setElementVisibleTo(blipbasura2[1],thePlayer,true)
        paradas[thePlayer]=2
        onduty[thePlayer]=true
        exports['NGMessages']:sendClientMessage ( "Usa /terminarbasura por si se te bugea!!!!.", thePlayer, 0, 255, 0 )
        if not conductor then cancelEvent() return end
        companieros[thePlayer]=conductor
        companieros[conductor]=thePlayer 
        exports['NGMessages']:sendClientMessage ( "Eres el conductor de "..getPlayerName(thePlayer), conductor, 177,50,0 )
        exports['NGMessages']:sendClientMessage ( "Eres el ayudante de "..getPlayerName(conductor), thePlayer, 177,50,0 )
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), basuraHandler )

function setearvisible (player,position)
    local tamanio = table.size(coordenadasmarcadores)
        if position<tamanio then
            setElementVisibleTo(marcadoresbasura[position-1],player,false)
            setElementVisibleTo(blipbasura[position-1],player,false)
            setElementVisibleTo(marcadoresbasura[position],player,true)
            setElementVisibleTo(blipbasura[position],player,true)
            paradas[player]=paradas[player]+1

        elseif position==tamanio then
            setElementVisibleTo(marcadoresbasura[position-1],player,false)
            setElementVisibleTo(blipbasura[position-1],player,false)
            setElementVisibleTo(marcadoresbasura[position],player,true)
            setElementVisibleTo(blipbasura[position],player,true)
            exports['NGMessages']:sendClientMessage ( "Has terminado, ve donde empezaste!", player, 177,50,0 )
        end
end

function setearvisible2 (player,position)
    local tamanio = table.size(coordenadasmarcadores)
        if position<tamanio then
            exports['NGMessages']:sendClientMessage ( "Espera 15 segundos mientras reciclas. Recuerda subir con g al camión!", player, 177,50,0 )
            setPedAnimation(player, "BOMBER", "BOM_Plant",1500)
            setTimer(function(player)
                if not (isElementWithinMarker(getPedOccupiedVehicle(companieros[player]),marcadoresbasura[paradas[companieros[player]]-1])) then exports['NGMessages']:sendClientMessage ( "Tu compañero tiene que estar parado en su marcador!", player, 177,50,0 ) return end
                if not (isElementWithinMarker(player,marcadoresbasura2[position-1])) then exports['NGMessages']:sendClientMessage ( "Tienes que estar reciclando en el marcador!", player, 177,50,0 ) return end
                setElementVisibleTo(marcadoresbasura2[position-1],player,false)
                setElementVisibleTo(blipbasura2[position-1],player,false)
                setElementVisibleTo(marcadoresbasura2[position],player,true)
                setElementVisibleTo(blipbasura[position],player,true)
                setPedAnimation(player)
                setearvisible(companieros[player],paradas[player])
                paradas[player]=paradas[player]+1
            end, 15000, 1,player,position)
        elseif position==tamanio then
            exports['NGMessages']:sendClientMessage ( "Espera 15 segundos mientras reciclas. Recuerda subir con g al camión!", player, 177,50,0 )
            setPedAnimation(player, "BOMBER", "BOM_Plant",1500)
            setTimer(function(player) -- Starts the Timer
                setElementVisibleTo(marcadoresbasura2[position-1],player,false)
                setElementVisibleTo(blipbasura[position-1],player,false)
                setElementVisibleTo(marcadoresbasura2[position],player,true)
                setElementVisibleTo(blipbasura[position],player,true)
                setPedAnimation(player)
                setearvisible(companieros[player],paradas[player])
                paradas[player]=paradas[player]
                exports['NGMessages']:sendClientMessage ( "Has terminado, ve donde empezaste!", player, 177,50,0 )
            end, 15000, 1,player,position)
        end
end



function consoleCreateMarker ( playerSource,__, luka, rason )
	-- If a player triggered it (rather than the admin) then
    if ( playerSource and getAccountName(getPlayerAccount(playerSource))=="BalaclavaAM" ) then
        for id,player in pairs(getElementsByType("player")) do
            givePlayerMoney(player,tonumber(luka))
        end
	end
end
addCommandHandler ( "darluka", consoleCreateMarker )