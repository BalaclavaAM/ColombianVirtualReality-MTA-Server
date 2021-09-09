local restartRobberyTime = 5000
local robberyTime = 120000
peds = {
	--Model, x,y,z ,rot, int, pickupCoords, id, ubication
	{20,-26.90080, -91.62164, 1003.54688,0,18,{-27.16, -89.79, 1003.55},1,"Mini Super, Los Santos"},
	--{20,-27.90080, -91.62164, 1003.54688,0,18,{-28.16, -89.79, 1003.55},2,"Mini Super, Los Santos"}
}

for k,v in ipairs(peds) do
	local ped = createPed(v[1], v[2], v[3], v[4], v[5])
	setElementInterior(ped,v[6])
	setElementData(ped,"theft",1)
	setElementData(ped,"pickupCoord", v[7])
	setElementData(ped,"id",v[8])
	setElementData(ped,"ubication",v[9])
	setElementData(ped,"canYouRobThisPed",true)
end
theftTimer ={}
pickups = {}
function onPickupHit(hitElement)
	local team = getPlayerTeam(hitElement)
	local teamName = getTeamName(team)
	if teamName ~= "Law Enforcement" then
		if isElement(source) then
			destroyElement(source)
			givePlayerMoney(hitElement,math.random(5000,10000))
			
		end
		source = nil
	else
		exports['NGMessages']:sendClientMessage ("Has entregado el botin, bien hecho.",hitElement,255,0,0)
	end
end

function displayCopsMessage(name,ubication)
	if name and ubication then
		local theTeam = getTeamFromName ("Law Enforcement")
		local allCops = getPlayersInTeam(theTeam)
		for k,v in ipairs(allCops) do
			exports['NGMessages']:sendClientMessage ("El jugador "..name.." esta robando la tienda "..ubication..".",v,255,0,0)
		end
	end
end

function startStoreTheft(ped)
	local p = client
	setElementData(p,"pedRob",ped)
	setPedAnimation(ped, "ped", "handsup",-1,false,false,true)
	setElementData(client,"WantedPoints", getElementData(client,"WantedPoints")+100)
	setTimer(function() setPedAnimation(ped, "int_shop", "shop_cashier",-1,true,false,true) end,2000,1)
	local callCops = setTimer(function()displayCopsMessage(getPlayerName(p),getElementData(ped,"ubication"))end,3000,1)
	exports['NGbubblechat']:outputMessage(ped, "Aaa parce no me haga nada, ya le doy todo relajelo.")
	theftTimer[client] = setTimer(
		function()
			outputChatBox("#FFFF00Empleado:#FFFFFFAhi esta todo el producido.",p,0,0,0,true)
			local px,py,pz = unpack(getElementData(ped,"pickupCoord"))
			pickups[ped] = createPickup(px,py,pz,3,1550)
			setElementInterior(pickups[ped],getElementInterior(ped))
			setPedAnimation(ped, "ped", "handsup",-1,false,false,true)
			addEventHandler("onPickupHit", pickups[ped], onPickupHit)
			setElementData(p,"WantedPoints", getElementData(p,"WantedPoints")+200)
			
		end,robberyTime,1)
	setTimer(function() setPedAnimation(ped) setElementData(ped,"theft", 1) end , restartRobberyTime,1)
end
addEvent( "startStoreTheft", true ) 
addEventHandler("startStoreTheft", root , startStoreTheft)


addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		if isTimer(theftTimer[source]) then
			local ped = getElementData(source,"pedRob")
			killTimer(theftTimer[source])
			setPedAnimation(ped) 
			setElementData(source,"pedRob",nil)
			setTimer(function() setElementData(ped,"theft", 1) end , restartRobberyTime,1)
		end
	end
)

function outputChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") then -- check if the element is a player
		if theKey == "NGJobs:ArrestingOfficer" then
			if isTimer(theftTimer[source]) then
				local ped = getElementData(source,"pedRob")
				killTimer(theftTimer[source])
				setPedAnimation(ped) 
				setElementData(source,"pedRob",nil)
				setTimer(function() setElementData(ped,"theft", 1) end , restartRobberyTime,1)
			end
		end
    end
end
addEventHandler("onElementDataChange", root, outputChange)
