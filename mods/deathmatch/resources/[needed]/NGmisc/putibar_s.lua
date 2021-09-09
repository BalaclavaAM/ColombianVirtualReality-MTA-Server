--entrance 2233.29, -1159.68, 25.89 
-- 2214.39, -1150.6, 1025.8

local blip = createBlip(2233.29, -1159.68, 26.89,21)
local price = 2000
whores = {
	{11,2236.02, -1154.15, 1030.49,180},
	{13,2246.56, -1165.67, 1030.49,0},
	{14,2235.68, -1165, 1030.49,180,180},
	{32,2231.01, -1183.51, 1030.52,90},
	{257,2223.9, -1177.03, 1030.44,270},
	{75,2204.22, -1193.81, 1030.52,270},
	{92,2211.61, -1200.34, 1030.44,90},
	{139,2198.44, -1178.84, 1030.49,0},
	{140,2204.82, -1171.34, 1030.44,180},
	{145,2198.47, -1162.95, 1030.49,0},
	{178,2204.8, -1154.92, 1030.44,180},
	{24,2187.84, -1151.59, 1030.49,180},
	{63,2181.54, -1158.73, 1030.44,0}

}
function startSex( thePlayer, matchingDimension )
	local ped = getElementAttachedTo ( source )  
	if getElementData(ped,"onDuty") == 1 then return end
	if getPlayerMoney(thePlayer) >= price then
		setPedAnimation(thePlayer,"sex","sex_1_cum_p",1,true,false)
		setPedAnimation(ped,"sex","sex_1_cum_w",1,true,false)
		setElementData(ped,"onDuty",1)
		exports['NGbubblechat']:outputMessage(ped, "Jueputa k rico")
		takePlayerMoney(thePlayer, price)
	else
		exports['NGbubblechat']:outputMessage(ped, "Si no tiene plata pal servicio abrase pirobo")
	end
end

function finishSex( thePlayer, matchingDimension)
	local ped = getElementAttachedTo ( source )
	setPedAnimation(ped,"strip","str_loop_a",1,true,false)
	setElementHealth(thePlayer, 100)
	setElementData(ped, "onDuty",0)
end

function displayLoadedRes ( res )
	for k,v in ipairs(whores) do
		local whore = createPed(v[1], v[2], v[3], v[4], v[5])
		local col = createColSphere(v[2],v[3],v[4],0.8)
		setElementData(whore,"onDuty",0)
		setElementInterior(whore,15)
		setElementInterior(col,15)
		attachElements(col,whore)
		addEventHandler ( "onColShapeHit", col, startSex )
		addEventHandler ( "onColShapeLeave", col, finishSex )
	end
end
addEventHandler ( "onResourceStart", resourceRoot, displayLoadedRes )

function lucesitas(source)
	P=source
	if isPedInVehicle(source) then
		  Carro = getPedOccupiedVehicle(source)
		  jugadorAsiento = getPedOccupiedVehicleSeat(source)
		  if Carro and jugadorAsiento == 0 then
			  if ( getVehicleOverrideLights(Carro) == 0 ) then
				  setVehicleOverrideLights(Carro, 2)
				  exports['NGMessages']: sendClientMessage ( "¡Ahora las luces de tu coche están encendidas!", P, 0, 255, 0 )
			  elseif ( getVehicleOverrideLights(Carro) == 2 ) then
				  setVehicleOverrideLights(Carro, 1)
				  exports['NGMessages']: sendClientMessage ( "¡Ahora las luces de tu coche están apagadas!", P, 255, 0, 0 )
			  elseif ( getVehicleOverrideLights(Carro) == 1 ) then
				   setVehicleOverrideLights(Carro, 0)
				   exports['NGMessages']: sendClientMessage ( "¡Ahora las luces de tu coche están en modo default!", P, 255, 255, 0 )
			  end
		  end
	else
	   exports['NGMessages']: sendClientMessage ( "¡Tienes que estar en un coche para utilizar este comando!", P, 255, 255, 0 )
	end
end
addCommandHandler ( "luces", lucesitas )


velitasCreadas = {}

function crearVela(source)
    local x, y, z = getElementPosition(source)
    local rotx, roty, rotz = getElementRotation(source)
    if not isPedInVehicle(source) then
        if not (velitasCreadas[source]) then
            velitasCreadas[source] = velas(x, y, z, rotz)
        else
            destroyElement(velitasCreadas[source])
            velitasCreadas[source]=nil
        end
    end
end

function velas(x, y, z, rotz)
    local velita = 1371
        if rotz <= 45 and rotz > 0 then
            velota = createObject(velita, x - 0.5, y + 1, z - 1, 0, 0, rotz, true)
        elseif rotz <= 90 and rotz > 45 then
            velota = createObject(velita, x - 1, y + 0.5, z - 1, 0, 0, rotz, true)
        elseif rotz <= 135 and rotz > 90 then
            velota = createObject(velita, x - 1, y - 0.5, z - 1, 0, 0, rotz, true)
        elseif rotz <= 180 and rotz > 135 then
            velota = createObject(velita, x - 0.5, y - 1, z - 1, 0, 0, rotz, true)
        elseif rotz <= 225 and rotz > 180 then
            velota = createObject(velita, x + 0.5, y - 1, z - 1, 0, 0, rotz, true)
        elseif rotz <= 270 and rotz > 225 then
            velota = createObject(velita, x + 1, y - 0.5, z - 1, 0, 0, rotz, true)
        elseif rotz <= 315 and rotz > 270 then
            velota = createObject(velita, x + 1, y + 0.5, z - 1, 0, 0, rotz, true)
        elseif rotz <= 360 and rotz > 315 then
            velota = createObject(velita, x + 0.5, y + 0.5, z - 1, 0, 0, rotz, true)
	end
	return velota
end
addCommandHandler("velitas", crearVela)

function destruirVela()
    if velitasCreadas[source] then
        destroyElement(velitasCreadas[source])
        velitasCreadas[source]=nil
    end
end
addEventHandler("onPlayerQuit", root, destruirVela)
-------------------------------------------------------------------------------------------------------------------------------------
sancochosCreados = {}
candelasCreados= {}
function crearSancocho(source)
    local x, y, z = getElementPosition(source)
    local rotx, roty, rotz = getElementRotation(source)
    if not isPedInVehicle(source) then
        if not (sancochosCreados[source] and candelasCreados[source]) then
          sancochosCreados[source] = sancocho(x, y, z, rotz)
          candelasCreados[source] = candela(x, y, z, rotz)
        else
           destroyElement(sancochosCreados[source])
           destroyElement(candelasCreados[source])
           sancochosCreados[source]=nil
           candelasCreados[source]=nil
        end
    end
end

function sancocho(x, y, z, rotz)
    local sancochito = 902
        if rotz <= 45 and rotz > 0 then
            sancochote = createObject(sancochito, x - 0.5, y + 1, z - 0.75, 0, 0, rotz, true)
        elseif rotz <= 90 and rotz > 45 then
            sancochote = createObject(sancochito, x - 1, y + 0.5, z - 0.75, 0, 0, rotz, true)
        elseif rotz <= 135 and rotz > 90 then
            sancochote = createObject(sancochito, x - 1, y - 0.5, z - 0.75, 0, 0, rotz, true)
        elseif rotz <= 180 and rotz > 135 then
            sancochote = createObject(sancochito, x - 0.5, y - 1, z - 0.75, 0, 0, rotz, true)
        elseif rotz <= 225 and rotz > 180 then
            sancochote = createObject(sancochito, x + 0.5, y - 1, z - 0.75, 0, 0, rotz, true)
        elseif rotz <= 270 and rotz > 225 then
            sancochote = createObject(sancochito, x + 1, y - 0.5, z - 0.75, 0, 0, rotz, true)
        elseif rotz <= 315 and rotz > 270 then
            sancochote = createObject(sancochito, x + 1, y + 0.5, z - 0.75, 0, 0, rotz, true)
        elseif rotz <= 360 and rotz > 315 then
            sancochote = createObject(sancochito, x + 0.5, y + 0.5, z - 0.75, 0, 0, rotz, true)
    end
    return sancochote
end
function candela(x, y, z, rotz)
        if rotz <= 45 and rotz > 0 then
            candelota = createObject(3525, x - 0.7, y + 1.2, z - 2.0, 0, 0, rotz, true)
        elseif rotz <= 90 and rotz > 45 then
            candelota = createObject(3525, x - 1.2, y + 0.7, z - 2.0, 0, 0, rotz, true)
        elseif rotz <= 135 and rotz > 90 then
            candelota = createObject(3525, x - 1.2, y - 0.7, z - 2.0, 0, 0, rotz, true)
        elseif rotz <= 180 and rotz > 135 then
            candelota = createObject(3525, x - 0.7, y - 1.2, z - 2.0, 0, 0, rotz, true)
        elseif rotz <= 225 and rotz > 180 then
            candelota = createObject(3525, x + 0.7, y - 1.2, z - 2.0, 0, 0, rotz, true)
        elseif rotz <= 270 and rotz > 225 then
            candelota = createObject(3525, x + 1.2, y - 0.7, z - 2.0, 0, 0, rotz, true)
        elseif rotz <= 315 and rotz > 270 then
            candelota = createObject(3525, x + 1.2, y + 0.7, z - 2.0, 0, 0, rotz, true)
        elseif rotz <= 360 and rotz > 315 then
            candelota = createObject(3525, x + 0.7, y + 0.7, z - 2.0, 0, 0, rotz, true)
        end
    setObjectScale(candelota, 0.1)
    setElementRotation(candelota, 352, 0, 0)
    return candelota
end
addCommandHandler("sancocho", crearSancocho)

function destruirSancocho()
    if sancochosCreados[source] and candelasCreados[source] then
        destroyElement(sancochosCreados[source])
        destroyElement(candelasCreados[source])
        sancochosCreados[source]=nil
        candelasCreados[source]=nil
    end
end

addEventHandler("onPlayerQuit", root, destruirSancocho)