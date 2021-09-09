--local drugMarkerJoin = createMarker(2540.3999023438, -1304, 34, 'cylinder', 2.0, 255, 0, 0, 150) 
--local drugMarkerLeft = createMarker(2541.55, -1304.08, 1024.07, 'cylinder', 2.0, 255, 0, 0, 150) 
--setElementInterior(drugMarkerLeft, 2, 2541.55, -1300.08, 1020.07)
--local myBlip = createBlipAttachedTo ( drugMarkerJoin, 26 )

local markers = {
	{2558.13, -1283.93, 1044.13},
	{2552.04, -1283.93, 1044.13},
	{2544.07, -1283.64, 1044.13},
	{2558.17, -1303.41, 1044.13},
	{2552.1, -1303.41, 1044.13},
	{2544.05, -1303.41, 1044.13}
}
addEventHandler("onResourceStart",resourceRoot, 
function () 
    for index, val in ipairs(markers) do 
        local marker = createMarker(val[1], val[2], val[3]-1, "cylinder", 1.5, 0, 255, 0, 150) 
        setElementInterior(marker, 2) 
        addEventHandler("onMarkerHit",marker,onMarkerHit) 
    end 
end)  

function onMarkerHit(hitPlayer, dim) 
     if not dim then return end  
     if getElementType ( hitPlayer ) == 'player'  then 
		triggerClientEvent ( hitPlayer, "onServerFactoryMarkerHit", hitPlayer )
   end 
end 

function MarkerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler
    local elementType = getElementType( hitElement ) -- get the hit element's type
	if elementType == "player" then
		if isPedInVehicle ( hitElement ) == false then
			local playerTeam = getPlayerTeam(hitElement)
			local teamName = getTeamName(playerTeam)
			if teamName == "Criminals" or teamName == "Staff" then
				setElementInterior(hitElement, 2, 2544.19, -1306.05, 1025.07)
				toggleControl (hitElement, "fire", false)
				toggleControl (hitElement, "next_weapon", false)
				toggleControl (hitElement, "previous_weapon", false)
				toggleControl (hitElement, "aim_weapon", false)
				toggleControl (hitElement, "vehicle_fire", false)
				setPlayerHudComponentVisible (hitElement, "ammo", false)
				setPlayerHudComponentVisible (hitElement, "weapon", false)
				triggerClientEvent (hitElement, "enableGodMode", hitElement)
			else
				outputChatBox("Para ingresar, debes ser criminal.",hitElement,255,0,0)
			end
		end
	end
end
addEventHandler( "onMarkerHit", drugMarkerJoin, MarkerHit ) 

function factoryLeaveTeleport( hitElement, matchingDimension ) -- define MarkerHit function for the handler
    local elementType = getElementType( hitElement ) -- get the hit element's type
	if elementType == "player" then
		setElementInterior(hitElement, 0, 2536.27, -1304.77, 35)
		toggleControl (hitElement, "fire", true)
		toggleControl (hitElement, "next_weapon", true)
		toggleControl (hitElement, "previous_weapon", true)
		toggleControl (hitElement, "aim_weapon", true)
		toggleControl (hitElement, "vehicle_fire", true)
		setPlayerHudComponentVisible (hitElement, "ammo", true)
		setPlayerHudComponentVisible (hitElement, "weapon", true)
		triggerClientEvent (hitElement, "disableGodMode", hitElement)
	end
end
addEventHandler( "onMarkerHit", drugMarkerLeft, factoryLeaveTeleport ) 

function setDrugs(drugType)
	local pAccount = getPlayerAccount(client)
	local ammount = math.random(1,3)
	if client then
		outputChatBox("Has fabricado un total de "..ammount.." drogas.",client,0,255,0)
		setElementData(client,drugType,getElementData(client,drugType)+ammount)
		setAccountData(pAccount,drugType, getElementData(client,drugType))
		setPedAnimation(client)
	end
end
addEvent( "sSetDrugs", true ) 
addEventHandler("sSetDrugs", root , setDrugs)

function setPlayerAnim()
	if client then
		setPedAnimation(client, "colt45", "colt45_reload",-1,true,false,true)
	end
end
addEvent( "sSetAnim", true ) 
addEventHandler("sSetAnim", root , setPlayerAnim)


addEventHandler("onPlayerCommand", root, 
function(cmd) 
     if cmd == "logout" then 
          cancelEvent() 
     end 
end) 