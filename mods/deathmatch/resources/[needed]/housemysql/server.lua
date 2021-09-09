-- MySQL Housesystem created & released by Noneatme(MuLTi), Do not remove credits! --
-- All Rights go to Noneatme --

--[[ Total time token: 
	- 3 hour
	- 1.5 hour
	________posX="-98.40039" posY="-648.7998" posZ="2023.618"
	
	4.5 hours
]]

------------------------
-- CONNECTION HANDLER --
------------------------
function setAccount(thePrev, theCur)
	setElementData(source,"account",getAccountName(theCur))
end
addEventHandler("onPlayerLogin", root, setAccount)

function startSetAccount ( res )
	for id, player in ipairs(getElementsByType("player")) do
		local acc = getPlayerAccount(player)
		if not isGuestAccount (acc)then
			setElementData(player,"account",getAccountName(acc))
		end
	end
end
addEventHandler ( "onResourceStart", getRootElement(), startSetAccount )
-- Here you can change some settings --
-- FIRST CONNECTION --

local mysqlhost1 = "127.0.0.1"
local mysqluser1 = "root"
local mysqlpassword1 = ""
local mysqldatabase1 = "cvrtest"

-- SECOND CONNECTION, OPTIONAL IF CONNECTION 1 DON'T WORK

local mysqlhost2 = "127.0.0.1"
local mysqluser2 = "root"
local mysqlpassword2 = ""
local mysqldatabase2 = "cvrtest"

local dbpTime = 500 -- How many Miliseconds will use the dbPoll function for waiting for a result

local max_player_houses = 2 -- Define the buyable houses per player
local sellhouse_value = 80 -- The ammount in percent that you get back if you sell a house
local open_key = "F4" -- Define the key for the infomenue and the housepanel

-- I don't know whats the right time for that --

-----------------------------------------------------------------
-- IF YOU CAN'T WRITE IN LUA, DO NOT EDIT ANYTHING ABOVE HERE! --
-----------------------------------------------------------------

-- EVENTS --

addEvent("onHouseSystemHouseCreate", true)
addEvent("onHouseSystemHouseLock", true)
addEvent("onHouseSystemHouseDeposit", true)
addEvent("onHouseSystemHouseWithdraw", true)
addEvent("onHouseSystemWeaponDeposit", true)
addEvent("onHouseSystemWeaponWithdraw", true)
addEvent("onHouseSystemRentableSwitch", true)
addEvent("onHouseSystemRentalprice", true)
addEvent("onHouseSystemTenandRemove", true)
addEvent("onHouseSystemInfoBuy", true)
addEvent("onHouseSystemInfoRent", true)
addEvent("onHouseSystemInfoEnter", true)

local handler -- local only, we don't need a global handler

local saveableValues = {
	["MONEY"] = "MONEY",
	["WEAP1"] = "WEAP1",
	["WEAP2"] = "WEAP2",
	["WEAP3"] = "WEAP3",
	["LOCKED"] = "LOCKED",
	["OWNER"] = "OWNER",
	["RENTABLE"] = "RENTABLE",
	["RENTALPRICE"] = "RENTALPRICE",
	["RENT1"] = "RENT1",
	["RENT2"] = "RENT2",
	["RENT3"] = "RENT3",
	["RENT4"] = "RENT4",
	["RENT5"] = "RENT5",
}


local created = false -- DONT EDIT
local houseid = 0 -- Define the Houseid, 

local house = {} -- The House array
local houseData = {} -- The House Data arry
local houseInt = {} -- The House Interior array
local houseIntData = {} -- The House Interior Data Array xD

local buildStartTick
local buildEndTick

local rentTimer

-- STARTUP EVENT HANDLER --

addEventHandler("onResourceStart", getResourceRootElement(), function()
	handler = dbConnect("mysql", "dbname="..mysqldatabase1..";host="..mysqlhost1, mysqluser1, mysqlpassword1, "autoreconnect=1")

	-- If the Handler 1 dont work
	if not(handler) then	
		outputServerLog("[HOUSESYSTEM]MySQL handler 1 not accepted! Trying secondary handler...")	
		handler = dbConnect("mysql", "dbname="..mysqldatabase2..";host="..mysqlhost2, mysqluser2, mysqlpassword2, "autoreconnect=1")
		if not(handler) then
			outputServerLog("[HOUSESYSTEM]MySQL handler 2 not accepted! Shutting down...")
			cancelEvent()
		else
			outputServerLog("[HOUSESYSTEM]MySQL handler 2 accepted!")
			housesys_startup()
		end
	else
		outputServerLog("[HOUSESYSTEM]MySQL handler 1 accepted!")
		housesys_startup()
	end
end)

-- SHUTDOWN EVENT HANDLER --
addEventHandler("onResourceStop", getResourceRootElement(), function()
	-- Free the arrays --
	for index, houses in pairs(house) do
		houses = nil
	end
	for index, houseDatas in pairs(houseData) do
		houseDatas = nil
	end
	for index, houseInts in pairs(houseInt) do
		houseInts = nil
	end
	for index, houseIntDatas in pairs(houseIntData) do
		houseIntDatas = nil
	end
	
	houseid = 0
	created = false
end)

--------------
-- COMMANDS --
--------------

-- /unrent --

addCommandHandler("unrent", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local id = tonumber(getElementData(thePlayer, "house:lastvisit"))
		if(isPlayerRentedHouse(thePlayer, id) == false) then
			exports.NGMessages:sendClientMessage ("No eres inquilino de esta casa!", thePlayer, 255, 0, 0)
			return
		end
		local sucess = removeHouseTenand(id, thePlayer)
		if(sucess == true) then
			exports.NGMessages:sendClientMessage ("Has terminado tu inquilinato!", thePlayer, 0, 255, 0)
		else
			exports.NGMessages:sendClientMessage ("An error occurred!", thePlayer, 255, 0, 0)
		end
	end
end)

-- /rent --

addCommandHandler("rent", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local id = tonumber(getElementData(thePlayer, "house:lastvisit"))
		if(houseData[id]["OWNER"] == getAccountName(getPlayerAccount(thePlayer))) then
			exports.NGMessages:sendClientMessage ("No puedes rentarla, es tu casa!", thePlayer, 255, 0, 0)
			return
		end
		if(tonumber(houseData[id]["RENTABLE"]) ~= 1) then
			exports.NGMessages:sendClientMessage ("Esta casa no esta en renta!", thePlayer, 255, 0, 0)
			return
		end
		if(getPlayerRentedHouse(thePlayer) ~= false) then
			exports.NGMessages:sendClientMessage ("Ya eres inquilino de una casa! Usa /unrent primero.", thePlayer, 255, 0, 0)
			return
		end
		local sucess = addHouseTenand(thePlayer, id)
		if(sucess == true) then
			exports.NGMessages:sendClientMessage ("Ahora eres inquilino de esta casa!", thePlayer, 0, 255, 0)
		else
			exports.NGMessages:sendClientMessage ("No puedes rentar esta casa!", thePlayer, 255, 0, 0)
		end
	end
end)

-- /createhouse --

addCommandHandler("createhouse", function(thePlayer)
	if(hasObjectPermissionTo ( thePlayer, "function.kickPlayer", false ) ) then
		if(getElementInterior(thePlayer) ~= 0) then
			exports.NGMessages:sendClientMessage ("No estas en el exterior!", thePlayer, 255, 0, 0)
			return
		end
		if(isPedInVehicle(thePlayer) == true) then
			exports.NGMessages:sendClientMessage ("Por favor sal del vehiculo.", thePlayer, 255, 0, 0)
			return
		end
		-- INSERT SECURITY OPTIONS LIKE ADMINLEVEL HERE( if(adminlevel > shit) then ...)
		triggerClientEvent(thePlayer, "onClientHouseSystemGUIStart", thePlayer)
	else
		exports.NGMessages:sendClientMessage ("No eres Admin!", thePlayer, 255, 0, 0)
	end
end)

-- /in --

addCommandHandler("in", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
			local id = tonumber(house)
			if(tonumber(houseData[id]["LOCKED"]) == 0) or (houseData[id]["OWNER"] == getAccountName(getPlayerAccount(thePlayer))) or (isPlayerRentedHouse(thePlayer, id) == true) then
				local int, intx, inty, intz, dim = houseIntData[id]["INT"], houseIntData[id]["X"], houseIntData[id]["Y"], houseIntData[id]["Z"], id
				setElementData(thePlayer, "house:in", true)
				setInPosition(thePlayer, intx, inty, intz, int, false, dim)
				unbindKey(thePlayer, open_key, "down", togglePlayerInfomenue, id)
				setElementData(thePlayer, "house:lastvisitINT", id)
				if(houseData[id]["OWNER"] == getAccountName(getPlayerAccount(thePlayer))) or (isPlayerRentedHouse(thePlayer, id) == true) then
					bindKey(thePlayer, open_key, "down", togglePlayerHousemenue, id)
				end
			else
				exports.NGMessages:sendClientMessage ("No tienes las llaves de esta casa!", thePlayer, 255, 0, 0)
			end
		end
	end
end)

-- /out --

addCommandHandler("out", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisitINT")) and (getElementData(thePlayer, "house:lastvisitINT") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisitINT")
		if(house) then
			local id = tonumber(house)
			local x, y, z = houseData[id]["X"], houseData[id]["Y"], houseData[id]["Z"]
			setElementData(thePlayer, "house:in", false)
			setInPosition(thePlayer, x, y, z, 0, false, 0)
		end
	end
end)

-- /buyhouse --

addCommandHandler("buyhouse", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
			local id = house
			local owner = houseData[id]["OWNER"]
			if(owner ~= "no-one") then
				exports.NGMessages:sendClientMessage ("No puedes comprar esta casa!", thePlayer, 255, 0, 0)
			else
				local houses = 0
				for index, col in pairs(getElementsByType("colshape")) do
					if(getElementData(col, "house") == true) and (houseData[getElementData(col, "ID")]["OWNER"] == getAccountName(getPlayerAccount(thePlayer))) then
						houses = houses+1
						if(houses == max_player_houses) then
							exports.NGMessages:sendClientMessage ("Ya tienes "..max_player_houses.." casas! Vende una casa para comprar esta.", thePlayer, 255, 0, 0)
							return
						end
					end
				end
				local price = houseData[id]["PRICE"]
				local cuenta = getAccountName(getPlayerAccount(thePlayer))
				if(exports['NGBank']:doesBankAccountExist(cuenta)) then
					local money = exports['NGBank']:getAccountBalance(cuenta)
					if money>=price then
						setHouseData(id, "OWNER", getAccountName(getPlayerAccount(thePlayer)))
						exports['NGBank']:sacarplata(thePlayer,price)
						exports.NGMessages:sendClientMessage ("Felicitaciones! Has comprado esta casa!", thePlayer, 0, 255, 0)
						setElementModel(houseData[id]["PICKUP"], 1272)
					else
						return exports.NGMessages:sendClientMessage ("No tienes el dinero suficiente en el banco! Necesitas "..(price-money).."$ mas!", thePlayer, 255, 0, 0) 
					end
				else
					return exports.NGMessages:sendClientMessage ("No tienes cuenta de banco para hacer la transacción!", thePlayer, 255, 0, 0) 
				end
			end
		end
	end
end)

-- /sellhouse --

addCommandHandler("sellhouse", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
			local id = house
			local owner = houseData[id]["OWNER"]
			if(owner ~= getAccountName(getPlayerAccount(thePlayer))) then
				exports.NGMessages:sendClientMessage ("No puedes vender esta casa!", thePlayer, 255, 0, 0)
			else
				local price = houseData[id]["PRICE"]
				local cuenta = getAccountName(getPlayerAccount(thePlayer))
				if not(price) or not(sellhouse_value) then 
					return outputChatBox("Hubo un error. Intenta nuevamente",thePlayer,255,0,0) 
				end
				local quantity = price/100*sellhouse_value
				if not tonumber(quantity) then return end
				exports['NGBank']:meterplata(thePlayer,quantity)
				setHouseData(id, "OWNER", "no-one")
				setHouseData(id, "RENTABLE", 0)
				setHouseData(id, "RENTALPRICE", 0)
				for i = 1, 5, 1 do
					setHouseData(id, "RENT"..i, "no-one")
				end
				local cuenta=getAccountName(getPlayerAccount(thePlayer))
				local spawn = getAccountData(getPlayerAccount(thePlayer),"houseSpawn")
				if spawn then
					spawn=fromJSON(spawn)
					if spawn[1] == houseData[id]["X"] then
						setAccountData(getPlayerAccount(thePlayer),"houseSpawn",false)
					end
				end
				exports.NGMessages:sendClientMessage ("Has vendido esta propiedad por $"..quantity.." !", thePlayer, 0, 255, 0)
				setElementModel(houseData[id]["PICKUP"], 1273)
			end
		end
	end
end)

-- /deletehouse --

addCommandHandler("deletehouse", function(thePlayer, cmd, id)
	if(hasObjectPermissionTo ( thePlayer, "function.kickPlayer", false ) ) then
		id = tonumber(id)
		if not(id) then return end
		if not(house[id]) then
			exports.NGMessages:sendClientMessage ("There is no house with the ID "..id.."!", thePlayer, 255, 0, 0)
			return
		end
		local query = dbQuery(handler, "DELETE FROM houses WHERE ID = '"..id.."';")
		local result = dbPoll(query, dbpTime)
		if(result) then
			if isElement(houseData[id]["BLIP"]) then
				destroyElement(houseData[id]["BLIP"])
			end
			if isElement(houseData[id]["PICKUP"]) then
				destroyElement(houseData[id]["PICKUP"])
			end
			if isElement(houseIntData[id]["PICKUP"]) then
				destroyElement(houseIntData[id]["PICKUP"])
			end
			houseData[id] = nil
			houseIntData[id] = nil
			if isElement(house[id]) then
			destroyElement(house[id])
			end
			if isElement(houseInt[id]) then
			destroyElement(houseInt[id])
			end
			exports.NGMessages:sendClientMessage ("House "..id.." destroyed sucessfully!", thePlayer, 0, 255, 0)
			house[id] = false
		else
			error("House ID "..id.." has been created Ingame, but House is not in the database! WTF")
		end
	else
		exports.NGMessages:sendClientMessage ("You are not an admin!", thePlayer, 255, 0, 0)
	end
end)

-- /househelp --

addCommandHandler("househelp", function(thePlayer)
	exports.NGMessages:sendClientMessage ("/buyhouse, /sellhouse, /rent", thePlayer, 0, 255, 255)
	exports.NGMessages:sendClientMessage ("/unrent, /in, /out", thePlayer, 0, 255, 255)
	exports.NGMessages:sendClientMessage ("For Admins: /createhouse, /deletehouse [id]", thePlayer, 0, 255, 255)
end)

-- INSERT INTO dbs_housesystem.houses (X, Y, Z, INTERIOR, INTX, INTY, INTZ, MONEY, WEAP1, WEAP2, WEAP3) values("0.1", "0.1", "0.1", "5", "0.2", "0.2", "0.2", "2000", "46,1", "22,200", "25, 200")

--------------------
-- BIND FUNCTIONS --
--------------------

function togglePlayerInfomenue(thePlayer, key, state, id)
	if(id) then
		local locked = houseData[id]["LOCKED"]
		local rentable = houseData[id]["RENTABLE"]
		local rentalprice = houseData[id]["RENTALPRICE"]
		local owner = houseData[id]["OWNER"]
		local price = houseData[id]["PRICE"]
		local x, y, z = getElementPosition(house[id])
		local house = getPlayerRentedHouse(thePlayer)
		if(house ~= false) then house = true end
		local isrentedin = isPlayerRentedHouse(thePlayer, id)
		triggerClientEvent(thePlayer, "onClientHouseSystemInfoMenueOpen", thePlayer, owner, x, y, z, price, locked, rentable, rentalprice, id, house, isrentedin)
	end
end

function togglePlayerHousemenue(thePlayer, key, state, id)
	if(id) then
		if(getElementInterior(thePlayer) ~= 0) then
			local locked = houseData[id]["LOCKED"]
			local money = houseData[id]["MONEY"]
			local weap1 = houseData[id]["WEAPONS"][1]
			local weap2 = houseData[id]["WEAPONS"][2]
			local weap3 = houseData[id]["WEAPONS"][3]
			local rentable = houseData[id]["RENTABLE"]
			local rent = houseData[id]["RENTALPRICE"]
			local tenands = getHouseTenands(id)
			local owner = false
			if(getAccountName(getPlayerAccount(thePlayer)) == houseData[id]["OWNER"]) then
				owner = true
			end
			local canadd = canAddHouseTenand(id)
			triggerClientEvent(thePlayer, "onClientHouseSystemMenueOpen", thePlayer, owner, locked, money, weap1, weap2, weap3, id, rentable, rent, tenands, canadd)
		end
	else
		triggerClientEvent(thePlayer, "onClientHouseSystemMenueOpen", thePlayer )
	end
end

-------------------------------
-- HOUSE CREATION ON STARTUP --
-------------------------------

-- BUILDHOUSE FUNCTION --

local function buildHouse(id, x, y, z, interior, intx, inty, intz, money, weapons, locked, price, owner, rentable, rentalprice, rent1, rent2, rent3, rent4, rent5)
	if(id) and (x) and(y) and (z) and (interior) and (intx) and (inty) and (intz) and (money) and (weapons) then
		houseid = id
		house[id] = createColSphere(x, y, z, 1.5) -- This is the house, hell yeah
		houseData[id] = {} 
		local house = house[id] -- I'm too lazy...
		setElementData(house, "house", true) -- Just for client code only 
		
		local houseIntPickup = createPickup(intx, inty, intz, 3, 1318, 100)
		setElementInterior(houseIntPickup, interior)
		setElementDimension(houseIntPickup, id)
		
		houseInt[id] = createColSphere(intx, inty, intz, 1.5) -- And this is the Exit
		setElementInterior(houseInt[id], interior)
		setElementDimension(houseInt[id], id) -- The House Dimension is the house ID
		setElementData(houseInt[id], "house", false)
		--------------------
		-- EVENT HANDLERS --
		--------------------
	
		-- IN --
		addEventHandler("onColShapeHit", house, function(hitElement)
			if isElement(hitElement) and (getElementType(hitElement) == "player") and getElementDimension(hitElement) == 0 then
				setElementData(hitElement, "house:lastvisit", id)
				triggerClientEvent(hitElement,"CVRPanelAyuda:setInHouse",hitElement,true)
				bindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
				exports.NGMessages:sendClientMessage ("Presiona "..open_key.." para abrir el panel de informacion.", hitElement, 0, 255, 255) 
			end
		end)
		
		addEventHandler("onColShapeLeave", house, function(hitElement)
			if isElement(hitElement) and (getElementType(hitElement) == "player") then
				setElementData(hitElement, "house:lastvisit", false)
				triggerClientEvent(hitElement,"CVRPanelAyuda:setInHouse",hitElement,false)
				unbindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
				--exports.NGMessages:sendClientMessage (id)
			end
		end)
		
		-- OUT --
		
		addEventHandler("onColShapeHit", houseInt[id], function(hitElement, dim)
			if(dim == true) then
				if(getElementType(hitElement) == "player") then
					unbindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
					setElementData(hitElement, "house:lastvisitINT", id)
					if(houseData[id]["OWNER"] == getAccountName(getPlayerAccount(hitElement))) or (isPlayerRentedHouse(hitElement, id) == true) then
						bindKey(hitElement, open_key, "down", togglePlayerHousemenue, id)
					end
					exports.NGMessages:sendClientMessage ("copia en el chat /out para salir. Presiona "..open_key.." para abrir el menu", hitElement, 0, 255, 255)
				end
			end
		end)
		
		addEventHandler("onColShapeLeave", houseInt[id], function(hitElement, dim)
			if(dim == true) then
				if(getElementType(hitElement) == "player") then
					setElementData(hitElement, "house:lastvisitINT", false)
					if(houseData[id]["OWNER"] == getAccountName(getPlayerAccount(hitElement))) or (isPlayerRentedHouse(hitElement, id) == true) then
						unbindKey(hitElement, open_key, "down", togglePlayerHousemenue, id)
					end
					--exports.NGMessages:sendClientMessage (id)
				end
			end
		end)
		
		-- Set data for HOUSE --
		houseData[id]["HOUSE"] = house
		houseData[id]["DIM"] = id
		houseData[id]["MONEY"] = money
		houseData[id]["WEAPONS"] = weapons
		houseData[id]["INTHOUSE"] = houseInt[id]
		houseData[id]["LOCKED"] = locked
		houseData[id]["PRICE"] = price
		houseData[id]["OWNER"] = owner
		houseData[id]["X"] = x
		houseData[id]["Y"] = y
		houseData[id]["Z"] = z
		houseData[id]["RENTABLE"] = rentable
		houseData[id]["RENTALPRICE"] = rentalprice
		houseData[id]["RENT1"] = rent1
		houseData[id]["RENT2"] = rent2
		houseData[id]["RENT3"] = rent3
		houseData[id]["RENT4"] = rent4
		houseData[id]["RENT5"] = rent5
		-- HOUSE PICKUP --
		local housePickup
		if(owner ~= "no-one") then
			housePickup = createPickup(x, y, z-0.5, 3, 1272, 100)
		else
			housePickup = createPickup(x, y, z-0.5, 3, 1273, 100)
		end
		-- HOUSE BLIP --
		local houseBlip
		if(owner ~= "no-one") then
			--houseBlip = createBlip(x, y, z, 32, 2, 255, 0, 0, 255, 0, 50)
		else
			--houseBlip = createBlip(x, y, z, 31, 2, 255, 0, 0, 255, 0, 50)
		end
		-- SET THE DATA --
		houseData[id]["PICKUP"] = housePickup
		houseData[id]["BLIP"] = houseBlip
		
		setElementData(house, "PRICE", price)
		setElementData(house, "OWNER", owner)
		setElementData(house, "LOCKED", locked)
		setElementData(house, "ID", id)
		setElementData(house, "RENTABLE", rentable)
		setElementData(house, "RENTALPRICE", rentalprice)
		
		-- SET DATA FOR HOUSEINTERIOR --
		houseIntData[id] = {}
		houseIntData[id]["OUTHOUSE"] = houseData[id]["HOUSE"]
		houseIntData[id]["INT"] = interior
		houseIntData[id]["X"] = intx
		houseIntData[id]["Y"] = inty
		houseIntData[id]["Z"] = intz
		houseIntData[id]["PICKUP"] = houseIntPickup
		outputServerLog("House with ID "..id.." created sucessfully!")
		buildEndTick = getTickCount()
		-- TRIGGER TO ALL CLIENTS THAT THE HOUSE HAS BEEN CREATEEEEEEEEEEEEEEEEEEEEEEED --
		setTimer(triggerClientEvent, 1000, 1, "onClientHouseSystemColshapeAdd", getRootElement(), house)
	else
		if not(id) then
			error("Arguments @buildHouse not valid! There is no Houseid!")
		else
			error("Arguments @buildHouse not valid! Houseid = "..id)
		end
	end	
end

-- TAKE PLAYER RENT --
function getPlayerFromAccountName(name) 
    local acc = getAccount (name)
    if name and acc and not isGuestAccount (acc) then
        return getAccountPlayer (acc)
    else
        return false
    end
end

local function takePlayerRent()
	for index, player in pairs(getElementsByType("player")) do
		if(getPlayerRentedHouse(player) ~= false) then
			local id = getPlayerRentedHouse(player)
			local owner = houseData[id]["OWNER"]
			local rentable = tonumber(houseData[id]["RENTABLE"])
			if(rentable == 1) then
				local rentprice = tonumber(houseData[id]["RENTALPRICE"])
				takePlayerMoney(player, rentprice) -- Takes the player money for the rent
				exports.NGMessages:sendClientMessage ("Has pagado $"..rentprice.." de renta!", player, 255, 255, 0)
				if(getPlayerFromAccountName(owner)) then
					givePlayerMoney(getPlayerFromAccountName(owner), rentprice) -- Gives the owner the rentalprice
					exports.NGMessages:sendClientMessage ("Has obtenido $"..rentprice.." de "..getPlayerName(player).." por la renta!", getPlayerFromAccountName(owner), 255, 255, 0)
				end
			end
		end
	end
end

-- HOUSE DATABASE EXECUTION --

function housesys_startup()
	if(created == true) then
		error("Houses Allready created!")
		return
	end
	buildStartTick = getTickCount()
	local query = dbQuery(handler, "SELECT * FROM houses;" )
	local result, numrows = dbPoll(query, dbpTime)
	if (result and numrows > 0) then
		for index, row in pairs(result) do
			local id = row['ID']
			local x, y, z = row['X'], row['Y'], row['Z']
			local int, intx, inty, intz = row['INTERIOR'], row['INTX'], row['INTY'], row['INTZ']
			local money, weap1, weap2, weap3 = row['MONEY'], row['WEAP1'], row['WEAP2'], row['WEAP3']
			local locked = row['LOCKED']
			local price = row['PRICE']
			local owner = row['OWNER']
			local rentable = row['RENTABLE']
			local rentalprice = row['RENTALPRICE']
			local rent1, rent2, rent3, rent4, rent5 = row['RENT1'],row['RENT2'], row['RENT3'], row['RENT4'], row['RENT5']
			local weapontable = {}
			weapontable[1] = weap1
			weapontable[2] = weap2
			weapontable[3] = weap3
			buildHouse(id, x, y, z, int, intx, inty, intz, money, weapontable, locked, price, owner, rentable, rentalprice, rent1, rent2, rent3, rent4, rent5)
		end
		dbFree(query)
	else
		error("Houses Table not Found/empty!")
	end
	created = true
	setTimer(function()
		local elapsed = (buildEndTick-buildStartTick)
		outputServerLog("It took "..(elapsed/1000).." seconds to build all houses.")
	end, 1000, 1)
	rentTimer = setTimer(takePlayerRent, 60*1000*60, 0)
end

-- House Data array set --

function setHouseData(ID, typ, value)
	-- Security array -- 
	houseData[ID][typ] = value
	setElementData(house[ID], typ, value)
	if(saveableValues[typ]) then
		local query = dbQuery(handler, "UPDATE houses SET "..saveableValues[typ].." = '"..value.."' WHERE ID = '"..ID.."';" )
		local result = dbPoll(query, dbpTime)
		if(result) then
			dbFree(query)
		else
			error("Can't save Data: "..typ.." with the value: "..value.." for house ID "..ID.."!")
		end
	end
end


--------------------
-- EVENT HANDLERS --
--------------------

-- INFO RENT -

addEventHandler("onHouseSystemInfoRent", getRootElement(), function(id, value)
	if(houseData[id]) then
		if(value == true) then
			executeCommandHandler("rent", source)
		else
			executeCommandHandler("unrent", source)
		end
	end
end)


-- INFO ENTER --

addEventHandler("onHouseSystemInfoEnter", getRootElement(), function(id)
	if(houseData[id]) then
		executeCommandHandler("in", source)
	end
end)

-- INFO BUY --
addEventHandler("onHouseSystemInfoBuy", getRootElement(), function(id, value)
	if(houseData[id]) then
		if(value == true) then
			executeCommandHandler("buyhouse", source)
		else
			executeCommandHandler("sellhouse", source)
		end
	end
end)


-- TENAND REMOVE --

addEventHandler("onHouseSystemTenandRemove", getRootElement(), function(id, value)
	if(houseData[id]) then
		local sucess = removeHouseTenand(id, value)
		if(sucess == true) then
			exports.NGMessages:sendClientMessage ("Has removido a "..value.." de inquilino!", source, 0, 255, 0)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "TENANDS", getHouseTenands(id))
		end
	end
end)

-- SET RENTALPRICE --

addEventHandler("onHouseSystemRentalprice", getRootElement(), function(id, value)
	if(houseData[id]) then
		local oldvalue = tonumber(houseData[id]["RENTALPRICE"])
		if(oldvalue < value) then
			local tenands = getHouseTenands(id)
			local users = {}
			for i = 1, 5, 1 do
				if(tenands[i] ~= "no-one") then
					users[i] = tenands[i]
				end
			end
			if(#users > 0) then
				exports.NGMessages:sendClientMessage ("No puedes subir el precio de renta ya que hay inquilinos en la casa!", source, 255, 0, 0)
				return
			end
		end
		setHouseData(id, "RENTALPRICE", value)
		exports.NGMessages:sendClientMessage ("Has puesto el precio de renta a $"..value.."!", source, 0, 255, 0)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTALPRICE", value)
	end
end)

-- RENTABLE SWITCH --
addEventHandler("onHouseSystemRentableSwitch", getRootElement(), function(id)
	if(houseData[id]) then
		local state = tonumber(houseData[id]["RENTABLE"])
		if(state == 0) then
			setHouseData(id, "RENTABLE", 1)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTABLE", true)
			exports.NGMessages:sendClientMessage ("La casa ahora esta en renta!", source, 0, 255, 0)
		else
			setHouseData(id, "RENTABLE", 0)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTABLE", false)
			exports.NGMessages:sendClientMessage ("La casa ahora no esta en renta!", source, 0, 255, 0)
		end
	end
end)


-- CREATE HOUSE --

addEventHandler("onHouseSystemHouseCreate", getRootElement(), function(x, y, z, int, intx, inty, intz, price)
	local query = dbQuery(handler, "INSERT INTO houses (X, Y, Z, INTERIOR, INTX, INTY, INTZ, PRICE) values ('"..x.."', '"..y.."', '"..z.."', '"..int.."', '"..intx.."', '"..inty.."', '"..intz.."', '"..price.."');")
	local result, numrows = dbPoll(query, dbpTime)
	if(result) then
		local newid = houseid+1
		exports.NGMessages:sendClientMessage ("House "..newid.." created sucessfully!", source, 0, 255, 0)
		local weapontable = {}
		weapontable[1] = 0
		weapontable[2] = 0
		weapontable[3] = 0
		buildHouse(newid, x, y, z, int, intx, inty, intz, 0, weapontable, 0, price, "no-one", 0, 0, "no-one", "no-one", "no-one", "no-one", "no-one")
	else
		exports.NGMessages:sendClientMessage ("An Error occurred while creating the house!", source, 255, 0, 0)
		error("House "..(houseid+1).." could not create!")
	end
end)

-- WITHDRAW WEAPON --

addEventHandler("onHouseSystemWeaponWithdraw", getRootElement(), function(id, value)
	local weapons = houseData[id]["WEAPONS"]
	if(gettok(weapons[value], 1, ",")) then
		local weapon, ammo = gettok(weapons[value], 1, ","), gettok(weapons[value], 2, ",")
		if weapon and ammo then
			giveWeapon(source, weapon, ammo, true)
			exports.NGMessages:sendClientMessage ("Has sacado la arma del slot "..value.."!", source, 0, 255, 0)
			weapons[value] = 0
			setHouseData(id, "WEAPONS", weapons)
			setHouseData(id, "WEAP1", weapons[1])
			setHouseData(id, "WEAP2", weapons[2])
			setHouseData(id, "WEAP3", weapons[3])
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "WEAPON", value, 0)
		else
			exports.NGMessages:sendClientMessage ("No tienes arma en el slot", source, 0, 255, 0)
		end
	end
end)

-- DEPOSIT WEAPON --


addEventHandler("onHouseSystemWeaponDeposit", getRootElement(), function(id, value)
	local weapons = houseData[id]["WEAPONS"]
	if(tonumber(weapons[value]) == 0) then
		local weapon = getPedWeapon(source)
		local ammo = getPedTotalAmmo(source)
		if(weapon) and (ammo) and(weapon ~= 0) and (ammo ~= 0) then 
			weapons[value] = weapon..", "..ammo
			takeWeapon(source, weapon)
			exports.NGMessages:sendClientMessage ("Has depositado una "..getWeaponNameFromID(weapon).." en tu armario!", source, 0, 255, 0)
			setHouseData(id, "WEAPONS", weapons)
			setHouseData(id, "WEAP1", weapons[1])
			setHouseData(id, "WEAP2", weapons[2])
			setHouseData(id, "WEAP3", weapons[3])
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "WEAPON", value, weapons[value])
		else
			exports.NGMessages:sendClientMessage ("No tienes un arma!", source, 255, 0, 0)
		end
	else
		exports.NGMessages:sendClientMessage ("Ya tienes un arma en ese slot", source, 255, 0, 0)
	end
end)

-- LOCK HOUSE --

addEventHandler("onHouseSystemHouseLock", getRootElement(), function(id)
	local state = tonumber(houseData[id]["LOCKED"])
	if(state == 1) then
		setHouseData(id, "LOCKED", 0)
		exports.NGMessages:sendClientMessage ("Has desbloqueado la casa.", source, 0, 255, 0)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "LOCKED", 0)
	else
		setHouseData(id, "LOCKED", 1)
		exports.NGMessages:sendClientMessage ("Has bloqueado la casa", source, 0, 255, 255)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "LOCKED", 1)
	end
end)

-- DEPOSIT MONEY --

addEventHandler("onHouseSystemHouseDeposit", getRootElement(), function(id, value)
	if(value > getPlayerMoney(source)-1) then return end
	setHouseData(id, "MONEY", tonumber(houseData[id]["MONEY"])+value)
	exports.NGMessages:sendClientMessage ("Has depositado "..value.."$ en tu armario!", source, 0, 255, 0)
	triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "MONEY", tonumber(houseData[id]["MONEY"]))
	givePlayerMoney(source, -value)
end)

-- WITHDRAW MONEY --

addEventHandler("onHouseSystemHouseWithdraw", getRootElement(), function(id, value)
	local money = tonumber(houseData[id]["MONEY"])
	if(money < value) then
		exports.NGMessages:sendClientMessage ("No tienes todo ese dinero para depositarlo!", source, 255, 0, 0)
		return
	end
	setHouseData(id, "MONEY", tonumber(houseData[id]["MONEY"])-value)
	exports.NGMessages:sendClientMessage ("Has retirado "..value.."$ de tu armario!", source, 0, 255, 0)
	triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "MONEY", money-value)
	givePlayerMoney(source, value)
end)


----------------------------
-- SETTINGS AND FUNCTIONS --
----------------------------


-- FADE PLAYERS POSITION --
local fadeP = {}
function setInPosition(thePlayer, x, y, z, interior, typ, dim)
	if not(thePlayer) then return end
	if (getElementType(thePlayer) == "vehicle") then return end
	if(isPedInVehicle(thePlayer)) then return end
	if not(x) or not(y) or not(z) then return end
	if not(interior) then interior = 0 end
	if(fadeP[thePlayer] == 1) then return end
	fadeP[thePlayer] = 1
	fadeCamera(thePlayer, false)
	setElementFrozen(thePlayer, true)
	setTimer(
		function()
		fadeP[thePlayer] = 0
		setElementPosition(thePlayer, x, y, z)
		setElementInterior(thePlayer, interior)
		if(dim) then setElementDimension(thePlayer, dim) end
		fadeCamera(thePlayer, true)
		if not(typ) then
			setElementFrozen(thePlayer, false)
		else
			if(typ == true)  then
				setTimer(setElementFrozen, 1000, 1, thePlayer, false)
			end
		end
	end, 1000, 1)
end


-- canAddHouseTenand
-- Checks if there is a free slot in the house

function canAddHouseTenand(id)
	if not(houseData[id]) then return false end
	for i = 1, 5, 1 do
		local name = houseData[id]["RENT"..i]
		if(name == "no-one") then
			return true, i
		end
	end
	return false;
end

-- addHouseTenand
-- Adds a player to a house as tenand

function addHouseTenand(player, id)
	if not(houseData[id]) then return false end
	for i = 1, 5, 1 do
		local name = houseData[id]["RENT"..i]
		if(name == "no-one") then
			setHouseData(id,"RENT"..i, getAccountName(getPlayerAccount(player)))
			return true, i
		end
	end
	return false;
end

-- removeHouseTenand
-- Removes a player from a house

function removeHouseTenand(id, player)
	if not(houseData[id]) then return false end
	if(type(player) == "string") then
		for i = 1, 5, 1 do
			local name = houseData[id]["RENT"..i]
			if(name == player) then
				setHouseData(id,"RENT"..i,"no-one")
				return true
			end
		end
	else
		for i = 1, 5, 1 do
			local name = houseData[id]["RENT"..i]
			if(name == getAccountName(getPlayerAccount(player))) then
				setHouseData(id,"RENT"..i,"no-one")
				return true
			end
		end
	end
	return false;
end

-- getHouseTenands(houseid)
-- Returns a table within all tenands in this house 

function getHouseTenands(id)
	if not(houseData[id]) then return false end
	local rent = {}
	for i = 1, 5, 1 do
		rent[i] = houseData[id]["RENT"..i]
	end
	return rent;
end

-- getPlayerRentedHouse
-- Gets the House where a player is rented in --

function getPlayerRentedHouse(thePlayer)
	for index, house in pairs(getElementsByType("colshape")) do
		if(getElementData(house, "house") == true) and (getElementData(house, "ID")) then
			local id = tonumber(getElementData(house, "ID"))
			if not(id) then return false end
			local rent = {}
			for i = 1, 5, 1 do
				rent[i] = houseData[id]["RENT"..i]
			end
			for index, player in pairs(rent) do
				if(player == getAccountName(getPlayerAccount(thePlayer))) then
					return id;
				end
			end
		end
	end
	return false;
end

-- isPlayerRentedHouse
-- Checks if a player is rented in a specific house

function isPlayerRentedHouse(thePlayer, id)
	if not(houseData[id]) then return false end
	local rent = {}
	for i = 1, 5, 1 do
		rent[i] = houseData[id]["RENT"..i]
	end
	for index, player in pairs(rent) do
		if(player == getAccountName(getPlayerAccount(thePlayer))) then
			return true;
		end
	end
	return false;
end

function setHouseasSpawn(id)
	if getAccountName(getPlayerAccount(source))==houseData[id]['OWNER'] then
		if not(getAccountData(getPlayerAccount(source),"houseSpawn")) then
			outputChatBox("La próxima vez que vuelvas a entrar al servidor spawnearás acá",source,255,0,0)
			local x, y, z = houseData[id]["X"], houseData[id]["Y"], houseData[id]["Z"]
			local table = {x,y,z}
			setAccountData(getPlayerAccount(source),"houseSpawn",toJSON(table))
		else
			setAccountData(getPlayerAccount(source),"houseSpawn",false)
			outputChatBox("Vuelves a tener tu spawn normal :)",source,255,0,0)
		end
	else
		outputChatBox("Esta casa no es tuya",source,255,0,0)
	end
end
addEvent("housemysql:SetSpawn",true)
addEventHandler("housemysql:SetSpawn",root,setHouseasSpawn)