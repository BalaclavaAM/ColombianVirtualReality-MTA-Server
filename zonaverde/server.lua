-- Format is: {x = 0, y = 0, z = 0, width = 0, depth = 0, height = 0},
local greenzones = {
	{x = 2467.42, y = -1686.06, z = 12, width = 37, depth = 36, height = 15}, -- Grove Street
	{x = 1987.69, y = 1503.08, z = 8, width = 40, depth = 70, height = 25}, -- LV Pirate ship
	{x = -727.38, y = 930.76, z = 11, width = 60, depth = 60, height = 25}, -- Wooden house thing
	{x = -2420, y = -626.2, z = 125, width = 60, depth = 60, height = 30}, -- San Fierro antenna thing
	{x = -50, y= -50, z=2, width = 100, depth = 100, height = 40}, --Spawn 0,0 coordenadas
	{x = 1578.2421875, y = 1801.248046875, z=2, width=58, depth=25, height = 40}, -- Hospital LV
	{ x=1996.958984375, y=-1450.9560546875, width=100, depth=50}, -- Hospital LS (El de al lado de stunt)
	{x=-2740.775390625, y=577.9326171875, width=150, depth=50}, --Hospital SF
	{x=1428.2943115234, y=-1736.4764404297 , width=184.57202148438, depth=136.61145019531}, --Comisaría LS
	{x=1948.25, y=-2339.95 , width=139.7568359375, depth=104.6207275390}, --AeroLS
	{x=1149.8863525391, y=-1392.8568115234 , width=138.09655761719, depth=117.50390625}, -- Hospital Central
	{x=-2384.73, y=-2220.26 , width=138.09655761719, depth=117.50390625}, -- Monte Chiliad
	{x=501, y=-1923.13 , width=138.09655761719, depth=117.50390625}, -- Club en la Playa
	{x=2845.35, y=-1978.02 , width=138.09655761719, depth=117.50390625}, -- Piketes
	{x=2078.87, y=1607.11 , width=138.09655761719, depth=117.50390625} -- Casino
}
local redzones = {
	{x = 2220.94, y = 1901.98, z = 0, width = 120, depth = 100, height = 150}, -- Hotel Espiral
	{x=1850.45, y=1723.42 , width=275.09655761719, depth=350.50390625}, -- Drift Hotel
	{x=-563.72, y=1290.02 , width=285.09655761719, depth=800.50390625}, -- Bigear 1
	{x=-1282.88, y=1746.41 , width=450.09655761719, depth=200.50390625}, -- Bigear 2
	{x=-2111.31, y=1621.51 , width=200.09655761719, depth=200.50390625}, -- Ghymkana
	{x=-5000.3, y=103.29 , width=2100.09655761719, depth=1500.50390625}, -- Akina Okaru
	{x=-3663.47, y=-1875.69 , width=600.09655761719, depth=450.50390625}, -- Ultra Nitro Track
	{x=2936.15, y=-1862.46 , width=377.09655761719, depth=450.50390625}, --Project Touge
	{x=-243.43, y=2815.71 , width=1000.09655761719, depth=450.50390625}, --Ebisu West
	{x=3205.42, y=1044.49 , width=400.09655761719, depth=750.50390625} --GoKart Track
}
-- Initialize all zones on resource start
local z = {}
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
				if v.x and v.y and v.z and v.width and v.depth and v.height then
					local c = createColCuboid(v.x, v.y, v.z, v.width, v.depth, v.height)
					local rarea = createRadarArea(v.x, v.y, v.width, v.depth, 0, 255, 0, 150)
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
							function(h)
								if h and isElement(h) and getElementType(h) == "player" then
									if getElementData(h, "colShapeFix_OUT") then
										setElementData(h, "colShapeFix_OUT", false)
										return
									end

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
										outputChatBox("[CVR] Has entrado a la zona verde", h, 0, 220, 0)
										triggerClientEvent(h, "onEnterGreenzone", h)
									end
								end
							end
						)

						addEventHandler("onColShapeHit", c,
							function(h)
								if h and isElement(h) and getElementType(h) == "vehicle" then
									setElementData(h, "greenzoneveh", true)
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

									if getElementData(h, "greenzone") then
										setElementData(h, "greenzone", false)
										toggleControl(h, "fire", true)
										toggleControl(h, "aim_weapon", true)
										toggleControl(h, "vehicle_fire", true)
										toggleControl(h, "vehicle_secondary_fire", true)
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
								end
							end
						)

					end
				end
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, initGreenzones)

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
					local rarea = createRadarArea(v.x, v.y, v.width, v.depth, 255, 0, 0, 150)
					setElementParent(rarea, c)
					if c then
						f[c] = true

						for _, p in ipairs(getElementsWithinColShape(c, "player")) do
							setElementData(p, "redzone", true)
							redZonePlayers[p]=true
						end

						for _, v in ipairs(getElementsWithinColShape(c, "vehicle")) do
							setElementData(v, "isInRedZone", true)
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
									setElementData(h, "isInRedZone", true)
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
									removeElementData(h,"isInRedZone")
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