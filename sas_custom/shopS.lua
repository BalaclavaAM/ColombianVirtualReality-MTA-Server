-- [[   Written by Steve Scott  ]]--
-- [[ SeeMTA v3	Clothes-System	]]--
-- [[    All rights reserved    ]]--

local host = "127.0.0.1"
local username = "dhoyosg"
local password = "20MTAmed03"
local database = "zdhoyosg0"
local connection = dbConnect( "mysql", "dbname="..database..";host="..host, username, password, "charset=utf8" )
local clothesErstellt = {}


function buyClothesServer (playerSource, type,objID, name, money)
	if not playerSource then return end
	local CreateSQL = dbExec(connection, "INSERT INTO clothes SET Type = ?, ObjectID = ?, Name =?, Owner =?", type, objID, name, getElementData(playerSource,"dbid"))
	if CreateSQL then
		takePlayerMoney(playerSource,money)
	end
end
addEvent("buyClothesServer", true)
addEventHandler("buyClothesServer", root, buyClothesServer)


addEvent("deleteClothesServer", true)
addEventHandler("deleteClothesServer", root, function(dbid)
	dbPoll(dbQuery(connection, "DELETE FROM clothes WHERE ID = ?", dbid), -1)
end)


function callback(qh, client, type)
	local result = dbPoll(qh, 0)
	--result[1]["premiumPoints"]
	triggerClientEvent(client, "requestDatas", client, type, result)
end

addEvent("requestDatas", true )
addEventHandler("requestDatas", getRootElement(),
	function (accID, id)
		dbQuery(callback, {client, "clothes"}, connection, "SELECT * FROM clothes WHERE Owner=?", id)
	end
)

function deleteKleidungServer(playerSource, dbid)
	destroyElement(clothesErstellt[playerSource][dbid])
end
addEvent("deleteKleidungServer", true)
addEventHandler("deleteKleidungServer", root, deleteKleidungServer)

function eliminarensalida(source)
	if clothesErstellt[source] then
	for k,v in ipairs(clothesErstellt[source]) do
		destroyElement(v)
	end
end
end
addEventHandler ( "onPlayerQuit", root, eliminarensalida )


function makeItToServer(playerSource, objID, x,y,z, rx,ry,rz, bone, dbid, sX, sY, sZ)
	if not clothesErstellt[playerSource] then
		clothesErstellt[playerSource] = {}
	end
	clothesErstellt[playerSource][dbid] = createObject(objID, 0,0,0)
	--outputChatBox("eXServer: "..x)
--	outputChatBox("boneidS: "..bone)
	exports.bone_attach:attachElementToBone(clothesErstellt[playerSource][dbid],playerSource,bone, 0,0,0,0,0,0)
	exports.bone_attach:setElementBonePositionOffset(clothesErstellt[playerSource][dbid], x,y,z)
	exports.bone_attach:setElementBoneRotationOffset(clothesErstellt[playerSource][dbid],rx,ry,rz)
	setObjectScale(clothesErstellt[playerSource][dbid],sX, sY, sZ)
end
addEvent("makeItToServer", true)
addEventHandler("makeItToServer", root, makeItToServer)

addEvent("buySlotPPServer", true)
addEventHandler("buySlotPPServer", root, function(playerSource, amount)
	takePlayerMoney(playerSource,amount)
	local slots = getAccountData ( getPlayerAccount(playerSource), "slots") or 2
	setAccountData ( getPlayerAccount(playerSource), "slots", slots+1 )
end)


function handleSlots(source)
	local slots = getAccountData(getPlayerAccount(source),"slots") or 2
	if getElementData(source,"VIP") == "Esmeralda" then
		slots=7
	end
	setElementData(source,"slots",slots)
end
addEvent("checkSlots", true)
addEventHandler("checkSlots", root, handleSlots)