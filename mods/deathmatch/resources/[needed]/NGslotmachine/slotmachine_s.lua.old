--[[
Casino - slot machine
@author Hyperion/R3fr3Sh <r3fr3sh123@gmail.com>

@copyright 2017 Hyperion/R3fr3Sh <r3fr3sh123@gmail.com>
@license GPLv3
]]
local casinoJoin = createMarker(2196.78, 1677.17, 13.37, 'arrow', 2.0, 255, 255, 255, 150) 
local casinoLeft = createMarker(2233.97, 1714.68, 1013.38, 'arrow', 2.0, 255, 255, 255, 150) 
setElementInterior(casinoLeft, 1)
local myBlip = createBlipAttachedTo ( casinoJoin, 25 )

local function takeStake(stake)
	if source ~= client then
		outputDebugString("Possible cheater in casino", 2)
	end
	takePlayerMoney(client, stake)
end

local function givePrize(prize)
	if source ~= client then
		outputDebugString("Possible cheater in casino", 2)
	end
	givePlayerMoney(client, prize)
end

addEvent("casinoTakePlayerMoney", true)
addEvent("casinoGivePlayerMoney", true)
addEventHandler("casinoTakePlayerMoney", root, takeStake)
addEventHandler("casinoGivePlayerMoney", root, givePrize)


function MarkerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler
    local elementType = getElementType( hitElement ) -- get the hit element's type
	if elementType == "player" then
		if isPedInVehicle ( hitElement ) == false then
				setElementInterior(hitElement, 1, 2235.14, 1710.41, 1011.2)
				toggleControl (hitElement, "fire", false)
				toggleControl (hitElement, "next_weapon", false)
				toggleControl (hitElement, "previous_weapon", false)
				toggleControl (hitElement, "aim_weapon", false)
				toggleControl (hitElement, "vehicle_fire", false)
				showPlayerHudComponent (hitElement, "ammo", false)
				showPlayerHudComponent (hitElement, "weapon", false)
				triggerClientEvent (hitElement, "enableGodMode", hitElement)
		end
	end
end
addEventHandler( "onMarkerHit", casinoJoin, MarkerHit ) 

function casinoLeaveTeleport( hitElement, matchingDimension ) -- define MarkerHit function for the handler
    local elementType = getElementType( hitElement ) -- get the hit element's type
	if elementType == "player" then
		setElementInterior(hitElement, 0, 2188.09, 1673.78, 11.11)
		toggleControl (hitElement, "fire", true)
		toggleControl (hitElement, "next_weapon", true)
		toggleControl (hitElement, "previous_weapon", true)
		toggleControl (hitElement, "aim_weapon", true)
		toggleControl (hitElement, "vehicle_fire", true)
		showPlayerHudComponent (hitElement, "ammo", true)
		showPlayerHudComponent (hitElement, "weapon", true)
		triggerClientEvent (hitElement, "disableGodMode", hitElement)
	end
end
addEventHandler( "onMarkerHit", casinoLeft, casinoLeaveTeleport ) 