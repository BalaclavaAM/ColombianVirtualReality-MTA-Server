

local pickUps= { 
    {2504.54, -1710.65, 13.54, "Groove Street, home."}, 
    {1540.91, -1366.72, 326.21, "El edificio Coltejer en GTA."}, 
	{1990.85, -2013.82, 13.55, "Voy a vender mi Renault4 pintado en 10 millones."},
	{1385.71, -806.29, 86.33, "Hollywood."},
	{-2300.92, -1641.37, 483.7, "Tómate una bebida en las alturas de la montaña más alta."},
	{-2508.21, -675.06, 139.32, "En una punta de San Fierro, donde poco criminal veo."},
	{-2553.05, 192.24, 6.1, "Llegue a la farra kakorro."},
	{-2189.5, 2413.84, 5.16, "Recójeme y compra de paso un barquito."},
	{-1321.13, 2511.69, 92.54, "Entrena tu pvp en el desierto."},
	{2134.59, 1683.2, 13.01, "Lanza los dados y juégale a la suerte."},
	{1023.76, -297.17, 82.7, "Infíltrate en la casa de los Zetas antes de que se enteren."},
	{2317.27, -16.16, 32.53, "Revisa el sistema de ventilación del banco de Pesqueros."},
	{1734.57, 510.48, 34.19, "¡Arriba, que en este peaje la revolución es orden!"},
	{1310.6, 2780.74, 14.35, "A dar balín con los 2cB en su base, busca el cadáver del volador."},
	{2651.78, 1882.08, 19.73, "Ven a boxear con las panteras rosas de AUC."},
	{6239.05, -1963.26, 11.35, "Prueba que tu carro es el más rápido y llega hasta el final."},
	{1130.2, -2037.14, 69.01, "Deslúmbrate con las estrellas del observatorio de la ciudad."},
	{-2718.04, -320.67, 72.03, "Llega a la altura más alta de la casa roja inferior de San Fierro."},
	{-2675.91, 262.05, 4.63, "Cómete un pollito asado en San Fierro."},
	{-2660.81, 1421.95, 23.9, "Cae al techo de la mansión bajo el puente de San Francisco."},
	{-1968.76, 111.27, 27.69, "Toma un tren y viaja desde San Fierro."},
	{273.17, 1815.27, 1.01, "Adéntrate en el Área 51."},
	{262.69, 1886.06, -30.39, "Llega al punto más bajo del Área 51."},
	{-329.06, 1860.74, 44.38, "Llega a la fuente hídrica de la tienda favorita de Balaclava."},
	{-424.52, 2505.29, 124.3, "Tócale la cabeza al chimbo más grande del mapa."},
	{414.36, 2537.52, 19.15, "Practica tu vuelo antes de comprarle una hora de esbos al veci."},
	{-1024.73, 467.66, 14.55, "Puntea la pista de aterrizaje de San Fierro."},
	{2674.79, -1432, 16.25, "Callejón del parqueadero, cerca del estadio."},
	{2468.12, -945.04, 80.09, "Siloe, morro del Hotel Jefferson."},
	{2335.51, -1248.04, 22.5, "Parqueadero subtérraneo, cerca del motel."},
	{810.8, -1098.26, 25.91, "Cementerio, única tumba disponible en el purgatorio."},
	{615.61, -610.24, 17.23, "Departamento de Polícia Dillimore."},
	{2324.09, -3.78, 26.56, "Ven a almorzar antes de pescar."},
	{2573.74, 2438.42, 11.18, "Saca tu skate en la base CAPU."},
	{2846.26, 929.93, 11.68, "Los EVG tienen una rampa llena de droga dentro de su base."},
	{2031.92, -1777.44, 13.55, "Acércate al callejón de la primera peluquería a la que fue CJ."},
	{822.91, -1360.94, -0.51, "Baja a la estación cerca del campo de tennis."},
	{1299.52, -787.8, 88.31, "Residencia XXXCEJON."},
	{153.59, -1962.16, 3.77, "Ven al faro de la feria a ver el amanecer."},
	{1488.24, -1724.74, 6.72, "Busca en las cañerías cerca de la comisaría de LS."},
	{-1950.71, 486.43, 31.97, "A ver una película :D"},
	{-2623.63, 1410.39, 7.09, "El lugar favorito de Jizzy B."},
	{-2433.6, 1543.49, 2.12, "El navío de San Fierro."},
	{-2776.52, 782.7, 59.43, "Te invito a unas donas en San Fierro."},
	{1930.92, 1945.74, 7.6, "Drift en El Visaje."},
	{-662.38, 2305.9, 136.06, "Realiza un gran salto en Las Venturas."},
	{-838.27, 2761.98, 46, "A moteliar en la choza."},
	{2419.92, -1225.05, 25.08, "The Big Pen."},
	{-2752.21, -252.07, 7.19, "Club de Tennis de San Fierro."},
	{2223.23, 1094, 29.62, "Disneyland pirata :D."},
	{2022.11, 1008.22, 10.82,"Homelo Chino y el Hotel Chino."},
	{1654.33, 1733.37, 10.82,"Binco de Las Venturas."}	
} 
  

local prefix="#4D4D4D[#FFE800C#002BFFV#A60000R Drogas#4D4D4D]#FF0000"

function SpawnPicks ( ) 
    if ( not pickup ) then 
        local x, y, z, clue = unpack ( pickUps [ math.random ( #pickUps ) ] ) 
        pickup = createPickup ( x, y, z, 3, 1279 ) 
		outputChatBox ( prefix.."#FFFFFF"..clue.." #FF0000Ve a la pista para obtener recompensas.", getRootElement(), 255, 0, 0, true )
		setElementData(pickup,"clue",clue)
        addEventHandler ( "onPickupHit", pickup, onPickupHit ) 
    end 
end 
addEventHandler ( "onResourceStart", resourceRoot, SpawnPicks ) 

  
--[[function onPickupHit ( player ) 
    if isElement ( pickup ) then 
		local xd=getElementData(player,"isPassive") or false
		if not(xd) then
			destroyElement ( pickup ) 
			newClueTime = math.random(20,45)*60000
			
			local acc = getPlayerAccount(player)
			
			local baretaQty = math.random(0,3)
			local godQty = math.random(0,3)
			local speedQty = math.random(0,3)
			local lsdQty = math.random(0,3)
			local steroidsQty = math.random(0,3)
			local heroinQty = math.random(0,3)
			
			setAccountData(acc, "Weed", getElementData(player, "Weed")+baretaQty)
			setAccountData(acc, "God", getElementData(player, "God")+godQty)
			setAccountData(acc, "Speed", getElementData(player, "Speed")+speedQty)
			setAccountData(acc, "Lsd", getElementData(player, "Lsd")+lsdQty)
			setAccountData(acc, "Steroids", getElementData(player, "Steroids")+steroidsQty)
			setAccountData(acc, "Heroin", getElementData(player, "Heroin")+heroinQty)
			outputChatBox ( "[DROP]:#FFFFFFEl paquete contenia:Bareta"..tostring(baretaQty)..", popper:"..tostring(godQty)..", perica:"..tostring(speedQty)..", LSD:"..tostring(lsdQty)..", Bazuko:"..tostring(steroidsQty).." y Gale:"..tostring(heroinQty)..".", player, 255, 0, 0, true )
			outputChatBox ( prefix.."El jugador#FFFFFF "..getPlayerName(player).." #FF0000ha recogido el paquete misterioso, nuevo paquete en "..tostring(newClueTime/60000).." minutos.", getRootElement(), 255, 0, 0, true )
			clueTimer = setTimer ( SpawnPicks, newClueTime, 1 ) 
		else
			outputChatBox("Usted está en modo pasivo así que no es posible entregarle las drogas",player,255,0,0)
		end
    end 
  
    pickup = nil 
end ]]

function onPickupHit ( player ) 
    if isElement ( pickup ) then 
        
        local xd=getElementData(player,"isPassive") or false
        if not(xd) then
            destroyElement ( pickup ) 
            newClueTime = math.random(20,45)*60000
            
            local acc = getPlayerAccount(player)
            
            local baretaQty = math.random(0,3)
            local godQty = math.random(0,2)
            local speedQty = math.random(0,2)
            local lsdQty = math.random(0,3)
            local steroidsQty = math.random(0,2)
            local heroinQty = math.random(0,2)
            
            setAccountData(acc, "Weed", getElementData(player, "Weed")+baretaQty)
            setAccountData(acc, "God", getElementData(player, "God")+godQty)
            setAccountData(acc, "Speed", getElementData(player, "Speed")+speedQty)
            setAccountData(acc, "Lsd", getElementData(player, "Lsd")+lsdQty)
            setAccountData(acc, "Steroids", getElementData(player, "Steroids")+steroidsQty)
            setAccountData(acc, "Heroin", getElementData(player, "Heroin")+heroinQty)
            outputChatBox ( "[DROP]:#FFFFFFEl paquete contenia:Bareta"..tostring(baretaQty)..", popper:"..tostring(godQty)..", perica:"..tostring(speedQty)..", LSD:"..tostring(lsdQty)..", Bazuko:"..tostring(steroidsQty).." y Gale:"..tostring(heroinQty)..".", player, 255, 0, 0, true )
            outputChatBox ( prefix.."El jugador#FFFFFF "..getPlayerName(player).." #FF0000ha recogido el paquete misterioso, nuevo paquete en "..tostring(newClueTime/60000).." minutos.", getRootElement(), 255, 0, 0, true )
            clueTimer = setTimer ( SpawnPicks, newClueTime, 1 ) 
            pickup = nil --Movido pickup = nil
        else
            cancelEvent()  --Agregado cancelEvent()
            outputChatBox("Usted está en modo pasivo así que no es posible entregarle las drogas",player,255,0,0)
        end
    end 
    --pickup=nil
end 

function queryClue ( playerSource, commandName )
	-- If a player triggered it (rather than the admin) then
	if ( playerSource ) then
		if isElement( pickup) then 
			outputChatBox ( "Alerta de droga:#FFFFFF"..getElementData(pickup,"clue")..", ve a la pista para obtener recompensas.", playerSource, 255, 0, 0, true )
		else
			if not isTimer( clueTimer) then return end
			timeLeft, executions, interval =  getTimerDetails ( clueTimer )
			outputChatBox ( "Alerta de droga:#FFFFFFEn este momento no hay pista activa, nueva pista en "..tostring(math.floor(timeLeft/60000)).." minutos.", playerSource, 255, 0, 0, true )
		end
	end
end
addCommandHandler ( "pista", queryClue )