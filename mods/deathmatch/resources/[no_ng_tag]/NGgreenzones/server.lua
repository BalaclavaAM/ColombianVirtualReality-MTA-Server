-- Format is: {x = 0, y = 0, z = 0, width = 0, depth = 0, height = 0},
local greenzones = {
	{x = 2467.42, y = -1686.06, z = 12, width = 37, depth = 36, height = 15}, -- Grove Street
	{x = 1987.69, y = 1503.08, z = 8, width = 40, depth = 70, height = 25}, -- LV Pirate ship
	{x = -727.38, y = 930.76, z = 11, width = 60, depth = 60, height = 25}, -- Wooden house thing
	{x = -2420, y = -626.2, z = 125, width = 60, depth = 60, height = 30}, -- San Fierro antenna thing
	{x = -50, y= -50, z=2, width = 100, depth = 100, height = 40}, --Spawn 0,0 coordenadas
	{x = 1578.2421875, y = 1801.248046875, z=2, width=58, depth=25, height = 40}, -- Hospital LV
	{ x=1996.958984375, y=-1450.9560546875, width=100, depth=50}, -- Hospital LS (El de al lado de stunt)
	{x=-2740.775390625, y=577.9326171875, width=150, depth=70}, --Hospital SF
	{x=1434.6, y=-1727.2 , width=177.57202148438, depth=129.81145019531}, --Comisaría LS
	{x=1948.25, y=-2339.95 , width=106.7568359375, depth=112.6207275390}, --AeroLS
	{x=1149.8863525391, y=-1390.2168115234 , width=220.09655761719, depth=114.50390625}, -- Hospital Central depth=114.50390625 depth=119.50390625
	{x=-2384.73, y=-2220.26 , width=138.09655761719, depth=117.50390625}, -- Monte Chiliad
	{x=501, y=-1923.13 , width=138.09655761719, depth=117.50390625}, -- Club en la Playa
	{x=2845.35, y=-1978.02 , width=138.09655761719, depth=117.50390625}, -- Piketes
	{x=2078.87, y=1607.11 , width=138.09655761719, depth=117.50390625}, -- Casino
	{x=679.23, y=-1305.69, width=70, depth=60},
	{x=311.71, y=145.48, z = 1000 , width=200, depth=200, height=2000, dimension=1, interior=3, },--Banco LS
	{x=679.23, y=-1305.69, width=70, depth=60},--Doki
	{x=820.62, y=-30.6, z=1004.2, width=70, depth=60, dimension=1, interior=3}, --Corresponsal Busetas
	{x=820.56, y=-30.6, z=1003, width=70, depth=60, dimension=2, interior=3}, --Corresponsal SF
	{x=140.83, y=-99.91, z=1000.48, width=45, depth=35,height = 10, dimension=2, interior=18}, --Tienda de ropa Central
}
local redzones = {
	{x = 2220.94, y = 1901.98, z = 0, width = 120, depth = 100, height = 150}, -- Hotel Espiral
	{x=1850.45, y=1723.42 , width=275.09655761719, depth=350.50390625}, -- Drift Hotel
	{x=-563.72, y=1290.02 , width=285.09655761719, depth=800.50390625}, -- Bigear 1t
	{x=-1282.88, y=1746.41 , width=450.09655761719, depth=200.50390625}, -- Bigear 2
	{x=-2111.31, y=1621.51 , width=200.09655761719, depth=200.50390625}, -- Ghymkana
	{x=-5000.3, y=103.29 , width=2100.09655761719, depth=1500.50390625}, -- Akina Okaru
	{x=-3663.47, y=-1875.69 , width=600.09655761719, depth=450.50390625}, -- Ultra Nitro Track
	{x=2936.15, y=-1862.46 , width=377.09655761719, depth=450.50390625}, --Project Touge
	{x=-243.43, y=2815.71 , width=1000.09655761719, depth=450.50390625}, --Ebisu West
	{x=3205.42, y=1044.49 , width=400.09655761719, depth=750.50390625}, --GoKart Track
	{x=2257.16, y=1383.22, width=100, depth=140}, --Parking Noob
	{x=2375.37, y=2419.66, width=180, depth=150},
	{x=-900.83, y=-220.76, width=450, depth= 400},--tierrero
	{x=1930.38, y=-2890.55, z=170.83, width=730, depth=2300, height=900} -- Tsan
}
-- Initialize all zones on resource start

local cooldown= {}

local z = {}

function generateClosestCoordenates(zona,x,y,z)
	local nx,ny = x,y
	local iteraciones=0
	while (getDistanceBetweenPoints2D(nx,ny,x,y)<6.0 or isInsideColShape(zona,nx,ny,z)) do
		local xd=math.random(0,1)
		if xd==0 then
			nx=x+math.random(-5,5)
		else
			ny=y+math.random(-5,5)
		end
		iteraciones=iteraciones+1
	end
	return nx,ny
end

function hasJailedPassengers(conductor,ocupantes)
	local e=false
	for seat,occupant in pairs(ocupantes) do
		if getElementData(occupant,"NGJobs:ArrestingOfficer")==conductor then
			e=true
		end
	end
	return e
end


function initGreenzones()
	if greenzones and #greenzones ~= 0 then
		for _, v in ipairs(greenzones) do
			if v then
				if not v.z then 
					v.z = 0
				end
				if not v.height then
					v.height=100
				end
				if not v['interior'] then
					v['interior']=0
				end
				if not v['dimension'] then
					v['dimension']=0
				end
				if v.x and v.y and v.z and v.width and v.depth and v.height then
					local c = createColCuboid(v.x, v.y, v.z, v.width, v.depth, v.height)
					local rarea = createRadarArea(v.x, v.y, v.width, v.depth, 0, 255, 0, 150)
					setElementDimension(c,v.dimension)
					setElementDimension(rarea,v.dimension)
					setElementInterior(c,v.interior)
					setElementInterior(rarea,v.interior)
					setElementParent(rarea, c)
					if c then
						z[c] = true

						for _, p in ipairs(getElementsWithinColShape(c, "player")) do
							setElementData(p, "greenzone", true)
						end

						for _, v in ipairs(getElementsWithinColShape(c, "vehicle")) do
							setElementData(v, "greenzoneveh", true)
						end

						addEventHandler("onElementDestroy", c,
							function()
								if z[source] then
									z[source] = nil
								end
							end
						)

						addEventHandler("onColShapeHit", c,
							function(h,dim)
								if dim then
									if h and isElement(h) and getElementType(h) == "player" and (not(cooldown[h]) or getTickCount()-cooldown[h]>=30000 or getElementInterior(h)~=0) then
										
										-- Hack to prevent shooting bug: if player teleports from one greenzone directly to another and fails to clean up (on time)
										if getElementData(h, "greenzone") then
											setElementData(h, "colShapeFix_IN", true)
											triggerClientEvent(h, "onEnterGreenzone", h)
										else
											setElementData(h, "greenzone", true)
											toggleControl(h, "fire", false)
											toggleControl(h, "aim_weapon", false)
											toggleControl(h, "vehicle_fire", false)
											toggleControl(h, "vehicle_secondary_fire", false)
											toggleControl(h, "next_weapon", false ) -- nuevo
											toggleControl(h, "previous_weapon", false ) -- nuevo
											giveWeapon(h,0,1,true) -- nuevo
											outputChatBox("[CVR] Has entrado a la zona verde", h, 0, 220, 0)
											triggerClientEvent(h, "onEnterGreenzone", h)
										end


									else
										if cooldown[h] then
											outputChatBox("Sólo puedes salir y entrar a la zona cada 30 segundos o hasta que mueras",h,255,0,0,true)
											local nx,ny,nz = getElementPosition(h)
											triggerClientEvent(h,"NGgreenzones->CalcularCoords",h,source,nx,ny,nz)
										end
									end
								end
							end
						)

						addEventHandler("onColShapeHit", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "vehicle" then
									local ocupantes = getVehicleOccupants(h)
									local conductor = getVehicleOccupant(h,0)
									setElementData(h, "greenzoneveh", true)
									if conductor and (getElementData(conductor,"Job")=="Police Officer" or getElementData(conductor,"Job")=="Detective") and hasJailedPassengers(conductor,ocupantes) then
										outputChatBox("Te dejamos entrar a la zona segura porque tienes un capturado :)",conductor,255,255,0,true)
									elseif table.size(ocupantes)>0 then
										for silla,ocupante in pairs(ocupantes) do
											if (cooldown[ocupante]) and ((getTickCount()-cooldown[ocupante])<30000) then
												outputChatBox("Sólo puedes salir y entrar a la zona cada 30 segundos o hasta que mueras",ocupante,255,0,0,true)
												local nx,ny,nz = getElementPosition(ocupante)
												triggerClientEvent(ocupante,"NGgreenzones->CalcularCoords",ocupante,source,nx,ny,nz)
											end
										end
									end
								end
							end
						)

						addEventHandler("onColShapeLeave", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "player" then
									if getElementData(h, "colShapeFix_IN") then
										setElementData(h, "colShapeFix_IN", false)
										return
									end

									if getElementData(h,"Job")=="Detective" or getElementData(h,"Job")=="Drifter" or getElementData(h,"Job")=="Police Officer" or getElementData(h,"Job")=="Criminal"or getElementData(h,"Job")=="Militar" or getElementData(h,"Job")=="UnEmployed" then
										if not(cooldown[h]) or (getTickCount()-cooldown[h])>30000 then
											cooldown[h]=getTickCount()
										end
									end

									if getElementData(h, "greenzone") then
										setElementData(h, "greenzone", false)
										toggleControl(h, "fire", true)
										toggleControl(h, "aim_weapon", true)
										toggleControl(h, "vehicle_fire", true)
										toggleControl(h, "vehicle_secondary_fire", true)
										toggleControl(h, "next_weapon", true ) -- nuevo	
										toggleControl(h, "previous_weapon", true ) -- nuevo
										outputChatBox("[CVR] Has dejado la zona verde", h, 220, 220, 0)
										triggerClientEvent(h, "onLeaveGreenzone", h)
									else
										setElementData(h, "colShapeFix_OUT", true)
									end
								end
							end
						)

						addEventHandler("onColShapeLeave", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "vehicle" then
									setTimer(setElementData, 350, 1, h, "greenzoneveh", false)
									local ocupantes = getVehicleOccupants(h)
									if table.size(ocupantes)>0 then
										for silla,ocupante in pairs(ocupantes) do
											if getElementData(ocupante,"Job")=="Police Officer" or getElementData(ocupante,"Job")=="Criminal"or getElementData(ocupante,"Job")=="Militar" or getElementData(ocupante,"Job")=="UnEmployed" or getElementData(h,"Job")=="Detective" then
												cooldown[ocupante]=getTickCount()
											end
										end
									end
								end
							end
						)
					end
				end
			end
		end
	end
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function handleDeath()
	if cooldown[source] then
		cooldown[source]=nil
	end
	outputChatBox("Te activamos la funcionalidad de zona verde porque moriste.",source,255,0,0)
end
addEventHandler("onPlayerWasted",root,handleDeath)


addEventHandler("onResourceStart", resourceRoot, initGreenzones)
local driftareas={}
local f = {}
local redZonePlayers = {}
function initRedzones()
	if redzones and #redzones ~= 0 then
		for _, v in ipairs(redzones) do
			if v then
				if not v.z then 
					v.z = 0
				end
				if not v.height then
					v.height=100
				end
				if v.x and v.y and v.z and v.width and v.depth and v.height then
					local c = createColCuboid(v.x, v.y, v.z, v.width, v.depth, v.height)
					local rarea = createRadarArea(v.x, v.y, v.width, v.depth, 255, 0, 0, 150, resourceRoot)
					table.insert(driftareas,rarea)
					setElementParent(rarea, c)
					if c then
						f[c] = true

						for k,v in ipairs(getElementsByType("player")) do 
							if getElementData(v,"Job")=="Drifter" then
								setElementVisibleTo(rarea,v,true)
							end
						end

						for _, p in ipairs(getElementsWithinColShape(c, "player")) do
							setElementData(p, "redzone", true)
							triggerClientEvent(p,"onEnterRedzone",p)
							redZonePlayers[p]=true
						end

						for _, v in ipairs(getElementsWithinColShape(c, "vehicle")) do
							setElementData(v, "redzoneveh", true)
							for player,bool in pairs(redZonePlayers) do 
								if isElement(player) then
									triggerClientEvent("onVehicleEnterRedzone",player,v)
								end
							end
						end

						addEventHandler("onElementDestroy", c,
							function()
								if f[source] then
									f[source] = nil
								end
							end
						)

						addEventHandler("onColShapeHit", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "player" then
									if getElementData(h, "rcolShapeFix_OUT") then
										setElementData(h, "rcolShapeFix_OUT", false)
										return
									end

									-- Hack to prevent shooting bug: if player teleports from one greenzone directly to another and fails to clean up (on time)
									if getElementData(h, "redzone") then
										setElementData(h, "rcolShapeFix_IN", true)
									else
										setElementData(h, "redzone", true)
										redZonePlayers[h]=true
										outputChatBox("[CVR] Has entrado a la zona drift", h, 220, 0, 0)
									end
								end
							end
						)

						addEventHandler("onColShapeHit", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "vehicle" then
									setElementData(h, "redzoneveh", true)
									for player,bool in pairs(redZonePlayers) do 
										if isElement(player) then
											triggerClientEvent("onVehicleEnterRedzone",player,h)
										end
									end
								end
							end
						)

						addEventHandler("onColShapeLeave", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "player" then
									if getElementData(h, "rcolShapeFix_IN") then
										setElementData(h, "rcolShapeFix_IN", false)
										return
									end

									if getElementData(h, "redzone") then
										setElementData(h, "redzone", false)
										triggerClientEvent(h,"onExitRedzone",h)
										redZonePlayers[h]=nil
										outputChatBox("[CVR] Has dejado la zona drift", h, 220, 220, 0)
									else
										setElementData(h, "rcolShapeFix_OUT", true)
									end
								end
							end
						)

						addEventHandler("onColShapeLeave", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "vehicle" then
									removeElementData(h,"redzoneveh")
									if getVehicleOccupant(h,0) then
										triggerClientEvent("onVehicleExitRedzone",getVehicleOccupant(h,0),h)
									end
									for player,bool in pairs(redZonePlayers) do 
										if isElement(player) then
											triggerClientEvent("onVehicleExitRedzone",player,h)
										end
									end
								end
							end
						)

					end
				end
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, initRedzones)





function resetGreenzoneData()
	for _, p in ipairs(getElementsByType("player")) do
		if isElement(p) then
			removeElementData(p, "greenzone")
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, resetGreenzoneData)

function resetRedzoneData()
	for _, p in ipairs(getElementsByType("player")) do
		if isElement(p) then
			removeElementData(p, "redzone")
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, resetRedzoneData)


function setVisibleRedZones(e)
	for k,v in ipairs(driftareas) do
		if e then
			setElementVisibleTo(v,source,true)
		else
			setElementVisibleTo(v,source,false)
		end
	end
end
addEvent("NGGreenzones>Redzones",true)
addEventHandler("NGGreenzones>Redzones",root,setVisibleRedZones)