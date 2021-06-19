addEvent ( "NGInventory:onClientUseItem", true )
addEventHandler ( "NGInventory:onClientUseItem", root, function ( i )
	exports.NGLogs:outputActionLog ( getPlayerName ( source ).." ("..getAccountName(getPlayerAccount(source))..") used a(n) "..tostring(i) )
end )

local pickups = { }
addEvent( "NGInventory:onClientDropItem", true )
addEventHandler ( "NGInventory:onClientDropItem", root, function ( item, amount, name )
	local x, y, z = getElementPosition ( source )
	local rot = findRotation ( x, y, x+1, y+1 )
	local x, y = getPointFromDistanceRotation ( x, y, 1.5, rot )
	local p = createPickup ( x-1, y+1, z, 3, item, 5000 )
	pickups[p] = { itemID=item, amount=amount, itemName = name }
	addEventHandler ( "onPickupHit", p, OnPickupHit )

	pickups[p].interior = source.interior
	pickups[p].dimension = source.dimension
end )

function OnPickupHit ( p )
	if ( p and isElement ( p ) and getElementType ( p ) == "player" and not isPedInVehicle ( p ) ) then
		local d = getElementData ( p, "NGUser:Items" )
		local pI = pickups [ source ]
		if ( not d ) then
			d = { }
			setElementData ( p, "NGUser:Items", { } )
		end
		if ( not d [ pI.itemName ] ) then
			d[pI.itemName] = 0
			setElementData ( p, "NGUser:Items", d )
		end
		d[pI.itemName] = d[pI.itemName] + pI.amount
		setElementData ( p, "NGUser:Items", d )
		exports.NGMessages:sendClientMessage ( "You have picked up "..tostring(pI.amount).." of this item.", p, 0, 255, 0 )
		removeEventHandler ( "onPickupHit", p, OnPickupHit )
		destroyElement ( source )
	end
end




function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end

function findRotation(x1,y1,x2,y2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
end


--Eventos Server


local bebiendo={}
local politas={}
local guaros={}
local chambers={}

function liquor(licor)
	local am=getElementData(source,"NGUser:Items")
	if am[licor]>=1 then
		am[licor] = am[licor] -1 
		setElementData ( source, "NGUser:Items", am )
		if licor=="Polita" then
			p=source
			setElementData ( p, "NGUser:Items", am )
			setPedWalkingStyle(p,126)
			setPedAnimation(p, "bar", "dnk_stndf_loop", 3000, false, false, false, false)
			if not bebiendo[p] then
				bebiendo[p]=20
				triggerClientEvent ( p, "NGInventory:ClientEffect", p, "Polita", bebiendo[p] )
				local x, y, z = getElementPosition (p)
				politas[p] = createObject (1509, x, y, z)
				local interior = getElementInterior(p)
				setElementInterior(politas[p],interior)
				exports['bone_attach']:attachElementToBone (politas[p], p, 12, 0.1, 0.05, 0.1, 0, 90, 180)
				addEventHandler("onPlayerQuit",source,destroypola)
			else
				bebiendo[p]=bebiendo[p]+20
				niveldebebido=bebiendo[p]
				triggerClientEvent ( p, "NGInventory:ClientEffect", p, "Polita", niveldebebido )
			end
		elseif licor=="Guaro" then
			setPedWalkingStyle(source,126)
			setPedAnimation(source, "bar", "dnk_stndf_loop", 6000, false, false, false, false)
			setElementData(source,"guaro",true)
			if not guaros[source] then
				triggerClientEvent ( source, "NGInventory:ClientEffect", source, "Guaro" )
				local x, y, z = getElementPosition (source)
				guaros[source] = createObject (1668, x, y, z)
				local interior = getElementInterior(source)
				setElementInterior(guaros[source],interior)
				exports['bone_attach']:attachElementToBone (guaros[source], source, 12, 0.1, 0.05, 0.1, 0, 90, 180)
				addEventHandler("onPlayerQuit",source,destroyguaro)
			else
				triggerClientEvent ( source, "NGInventory:ClientEffect", source, "Guaro" )
			end
		elseif licor=="Chamber" then
			setPedWalkingStyle(source,126)
			setPedAnimation(source, "bar", "dnk_stndf_loop", 2000, false, false, false, false)
			if not chambers[source] then
				triggerClientEvent ( source, "NGInventory:ClientEffect", source, "Chamber" )
				local x, y, z = getElementPosition (source)
				chambers[source] = createObject (1520, x, y, z)
				local interior = getElementInterior(source)
				setElementInterior(chambers[source],interior)
				exports['bone_attach']:attachElementToBone (chambers[source], source, 12, 0.1, 0.05, 0.1, 0, 90, 180)
				addEventHandler("onPlayerQuit",source,destroychamber)
			else
				triggerClientEvent ( source, "NGInventory:ClientEffect", source, "Chamber" )
			end
		end
	end
end
addEvent("NGInventory:LicorServer",true)
addEventHandler("NGInventory:LicorServer",root,liquor)




local markerBuyHerramienta = createMarker(1019.98, -1031.81, 30.95,"cylinder",2)

function buyHerramienta(he,md)
	if md and isElement(he) and getElementType(he)=="player" then
		if getElementData(he,"Job")=="Mechanic" then
			triggerClientEvent(he,"NGMisc:CreateConfirmPanel",he,"Comprar Herramienta","¿Deseas comprar 1 herramienta de reparación por 5000?","onBuyHerramienta")
		else
			outputChatBox("Tienes que tener trabajo de mecanico para comprar herramienta",he,255,0,0,true)
		end
	end
end
addEventHandler("onMarkerHit",markerBuyHerramienta,buyHerramienta)

function buyHerramientaConfirm()
	local d = getElementData ( source, "NGUser:Items" )
	if not(d['herramientas']) or d['herramientas']<10 then
		if getPlayerMoney(source)>=5000 then
			local cantidad = 0
			if d['herramientas'] then
				cantidad=d['herramientas']
			end
			takePlayerMoney(source,5000)
			d['herramientas']=cantidad+1
			setElementData(source,"NGUser:Items",d)
			outputChatBox("Compraste 1 herramienta por 5000",source,255,255,0,true)
		else
			outputChatBox("No tienes los 5000 necesarios para comprar la herramienta.",source,255,0,0,true)
		end
	end
end
addEvent("onBuyHerramienta",true)
addEventHandler("onBuyHerramienta",root,buyHerramientaConfirm)







function endEffect(licor)
	if licor=="Polita" then
		setPedWalkingStyle(source,0)
		destroyElement(politas[source])
		politas[source]=nil
		bebiendo[source]=nil
		removeEventHandler("onPlayerQuit",source,destroypola)
	elseif licor=="Guaro" then
		removeElementData(source,"guaro")
		setPedWalkingStyle(source,0)
		destroyElement(guaros[source])
		guaros[source]=nil
		removeEventHandler("onPlayerQuit",source,destroyguaro)
	elseif licor=="Chamber" then
		setPedWalkingStyle(source,0)
		destroyElement(chambers[source])
		chambers[source]=nil
		removeEventHandler("onPlayerQuit",source,destroychamber)
	end
end
addEvent("EndEffect",true)
addEventHandler("EndEffect",root,endEffect)

function destroypola()
	destroyElement(politas[source])
	politas[source]=nil
	bebiendo[source]=nil
end

function destroyguaro()
	destroyElement(guaros[source])
	guaros[source]=nil
end

function destroychamber()
	destroyElement(chambers[source])
	chambers[source]=nil
end

function compras(licor,dinero)
	if getPlayerMoney(source)>=dinero then
		takePlayerMoney(source,dinero)
		local am=getElementData(source,"NGUser:Items")
		if am[licor] then
			am[licor] = am[licor] +1 
		else
			am[licor] = 1
		end
		setElementData ( source, "NGUser:Items", am )
		outputChatBox("Compraste "..licor.." por "..dinero.." tenías "..tostring(am[licor]-1).." y ahora tienes "..tostring(am[licor]),source,255,255,0)
	else
		outputChatBox("No tienes los "..dinero.." necesarios para comprar "..licor,source,255,0,0)
	end
end
addEvent("NGInventory:ButLiquor",true)
addEventHandler("NGInventory:ButLiquor",root,compras)

function abrirpanelcliente(he,md)
	if isElement(he) and getElementType(he)=="player" and md then
		triggerClientEvent(he,"NGInventory:OpenClientMenu",source)
	end
end


local marker=createMarker(251.68, -56.28, 0.57,"cylinder", 1.5, 255, 100, 0, 0)
addEventHandler("onMarkerHit",marker,abrirpanelcliente)

local ped=createPed(179,251.4, -54.83, 1.58, 180, false)
setElementFrozen(ped,true)

function revivirPed()
	if isPedDead(ped) then
		destroyElement(ped)
		ped=createPed(179,251.4, -54.83, 1.58, 180, false)
		setElementFrozen(ped,true)
	end
end
setTimer(revivirPed,30000,0)

local blip=createBlip(253.75, -62.1, 1.58,49,1,255,0,0,255,0,3000,root)