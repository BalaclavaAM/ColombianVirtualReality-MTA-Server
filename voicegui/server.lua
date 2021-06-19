chans = {}
users = {}
chans[1] = "Main Chat"

function sendChannels()
	triggerClientEvent(client,"onReturnChannels",getRootElement(),chans)
end
addEvent("onRequestChannels",true)
addEventHandler("onRequestChannels",getRootElement(),sendChannels)

function sendUsers(chan)
	chanID = table.findindex(chans,chan)
	users = exports.voice:getPlayersInChannel(chanID)
	triggerClientEvent(client,"onReturnUsers",getRootElement(),users)
end
addEvent("onRequestUsers",true)
addEventHandler("onRequestUsers",getRootElement(),sendUsers)

function setChannel(chan)
	if not chan then
		chan = "Main Chat"
	end
	chanID = table.findindex(chans,chan)
	exports.voice:setPlayerChannel(client,chanID)
	triggerClientEvent(client,"onReturnSetChannel",getRootElement(),chan)
end
addEvent("onRequestSetChannel",true)
addEventHandler("onRequestSetChannel",getRootElement(),setChannel)

function addChannel(chan)
	chanID = table.firstempty(chans)
	chans[chanID] = chan
end
addEvent("onRequestAddChannel",true)
addEventHandler("onRequestAddChannel",getRootElement(),addChannel)

function removeChannel(chan)
	chanID = table.findindex(chans,chan)
	if chan == chans[1] then
		triggerClientEvent(client,"onReturnString",getRootElement(),"Error: The original channel cannot be deleted.")
	elseif chanID then
		users = exports.voice:getPlayersInChannel(chanID)
		for i,v in ipairs(users) do
			exports.voice:setPlayerChannel(v,1)
			triggerClientEvent(getElementsByType("remoteclient"),"onReturnSetChannel",getRootElement(),chans[1])
		end
		chans[chanID] = nil
	end
end
addEvent("onRequestRemoveChannel",true)
addEventHandler("onRequestRemoveChannel",getRootElement(),removeChannel)

function table.findindex(tbl,val)
	for i,v in pairs(tbl) do
		if v == val then
			return i
		end
	end
end

function table.firstempty(tbl)
	index = 1
	while tbl[index] do
		index = index + 1
	end
	return index
end