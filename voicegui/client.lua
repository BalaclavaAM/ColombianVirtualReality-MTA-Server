local menuKey = "b"

local screenX,screenY = guiGetScreenSize()
local voiceWindow = guiCreateWindow(screenX/2-200,screenY/2-150,400,300,"Voice Chat",false)
local chanList = guiCreateGridList(5,25,192,230,false,voiceWindow)
local userList = guiCreateGridList(203,25,192,230,false,voiceWindow)
local chanColumn = guiGridListAddColumn(chanList,"Channels",0.85)
local userColumn = guiGridListAddColumn(userList,"Users",0.85)
local joinButton = guiCreateButton(25,260,100,32,"Change To New Channel",false,voiceWindow)
local chanButton = guiCreateButton(150,260,100,32,"Add/Remove a Channel",false,voiceWindow)
local userButton = guiCreateButton(275,260,100,32,"Mute/Unmute a User",false,voiceWindow)
guiWindowSetSizable(voiceWindow,false)
guiGridListSetSortingEnabled(chanList,false)
guiGridListSetSortingEnabled(userList,false)
guiSetVisible(voiceWindow,false)
local joinWindow = guiCreateWindow(screenX/2-100,screenY/2-125,200,250,"Change To a New Channel",false)
local chanWindow = guiCreateWindow(screenX/2-100,screenY/2-125,200,250,"Add/Remove a Channel",false)
local userWindow = guiCreateWindow(screenX/2-100,screenY/2-125,200,250,"Mute/Unmute a User",false)
local joinList = guiCreateGridList(5,38,190,182,false,joinWindow)
local chanKList = guiCreateGridList(5,38,190,157,false,chanWindow)
local chanAddBox = guiCreateEdit(5,200,190,20,"",false,chanWindow)
local muteList = guiCreateGridList(5,38,190,88,false,userWindow)
local unmuteList = guiCreateGridList(5,132,190,88,false,userWindow)
local joinColumn = guiGridListAddColumn(joinList,"Channels",0.85)
local chanKColumn = guiGridListAddColumn(chanKList,"Channels",0.85)
local muteColumn = guiGridListAddColumn(muteList,"Current Channel Users",0.85)
local unmuteColumn = guiGridListAddColumn(unmuteList,"Muted Users",0.85)
local joinLabel = guiCreateLabel(10,20,180,16,"Choose a channel to join.",false,joinWindow)
local chanLabel = guiCreateLabel(10,20,180,16,"Select or type a channel.",false,chanWindow)
local userLabel = guiCreateLabel(10,20,160,16,"Select a user to (un)mute.",false,userWindow)
local okButton1 = guiCreateButton(30,225,60,20,"Ok",false,joinWindow)
local okButton2 = guiCreateButton(30,225,60,20,"Ok",false,chanWindow)
local okButton3 = guiCreateButton(30,225,60,20,"Ok",false,userWindow)
local cancelButton1 = guiCreateButton(110,225,60,20,"Cancel",false,joinWindow)
local cancelButton2 = guiCreateButton(110,225,60,20,"Cancel",false,chanWindow)
local cancelButton3 = guiCreateButton(110,225,60,20,"Cancel",false,userWindow)
guiEditSetMaxLength(chanAddBox,15)
guiSetVisible(joinWindow,false)
guiSetVisible(chanWindow,false)
guiSetVisible(userWindow,false)
local chans = {}
local users = {}
local row = {}
local showVoiceGUI = false
local currentChan = ""

function updateChans(theChans)
	chans = theChans
end
addEvent("onReturnChannels",true)
addEventHandler("onReturnChannels",getRootElement(),updateChans)

function updateUsers(theUsers)
	users = theUsers
end
addEvent("onReturnUsers",true)
addEventHandler("onReturnUsers",getRootElement(),updateUsers)

function clickedGUIAction(button)
	if button == "left" then
		if source == joinButton then
			guiSetVisible(joinWindow,true)
			guiBringToFront(joinWindow)
			listChannels(2)
		elseif source == chanButton then
			guiSetVisible(chanWindow,true)
			guiBringToFront(chanWindow)
			listChannels(3)
		elseif source == userButton then
			guiSetVisible(userWindow,true)
			guiBringToFront(userWindow)
			listUsers(2)
		elseif source == okButton1 then
			local selected = guiGridListGetSelectedItem(joinList)
			local newChan = guiGridListGetItemText(joinList,selected,joinColumn)
			if newChan == "" then
				outputChatBox("Error: Make a selection.")
			else
				triggerServerEvent("onRequestSetChannel",getRootElement(),newChan)
				guiSetVisible(joinWindow,false)
			end
		elseif source == okButton2 then
			local newChan = guiGetText(chanAddBox)
			if newChan == "" then
				local selected = guiGridListGetSelectedItem(chanKList)
				local oldChan = guiGridListGetItemText(chanKList,selected,chanKColumn)
				if oldChan == "" then
					outputChatBox("Error: Make a selection.")
				else
					triggerServerEvent("onRequestRemoveChannel",getRootElement(),oldChan)
					guiSetVisible(chanWindow,false)
				end
			else
				triggerServerEvent("onRequestAddChannel",getRootElement(),newChan)
				guiSetVisible(chanWindow,false)
			end
		elseif source == okButton3 then
			local selected = guiGridListGetSelectedItem(muteList)
			local mutePlayer = guiGridListGetItemText(muteList,selected,muteColumn)
			if mutePlayer == "" then
				local selected2 = guiGridListGetSelectedItem(unmuteList)
				local unmutePlayer = guiGridListGetItemText(unmuteList,selected2,unmuteColumn)
				if unmutePlayer == "" then
					outputChatBox("Error: Make a selection.")
				else
					exports.voice:setPlayerMuted(getPlayerFromName(unmutePlayer),false)
					guiSetVisible(userWindow,false)
				end
			else
				exports.voice:setPlayerMuted(getPlayerFromName(mutePlayer),true)
				guiSetVisible(userWindow,false)
			end
		elseif source == cancelButton1 then
			guiSetVisible(joinWindow,false)
		elseif source == cancelButton2 then
			guiSetVisible(chanWindow,false)
		elseif source == cancelButton3 then
			guiSetVisible(userWindow,false)
		elseif source == chanKList then
			guiSetText(chanAddBox,"")
		elseif source == chanAddBox then
			guiGridListSetSelectedItem(chanKList,0,0)
		elseif source == muteList then
			guiGridListSetSelectedItem(unmuteList,0,0)
		elseif source == unmuteList then
			guiGridListSetSelectedItem(muteList,0,0)
		end
	end
end
addEventHandler("onClientGUIClick",getRootElement(),clickedGUIAction)

function setDefaultChannel(startedResource)
	if startedResource == getThisResource() then
		triggerServerEvent("onRequestSetChannel",getRootElement())
	end
end
addEventHandler("onClientResourceStart",getRootElement(),setDefaultChannel)

function refreshInfo()
	triggerServerEvent("onRequestChannels",getRootElement())
	triggerServerEvent("onRequestUsers",getRootElement(),currentChan)
	setTimer(updateInfo,100,1)
end
refreshTimer = setTimer(refreshInfo,500,0)

function updateInfo()
	listChannels(1)
	listUsers(1)
end

function listChannels(gui)
	if gui == 1 then
		guiGridListRemoveColumn(chanList,chanColumn)
		chanColumn = guiGridListAddColumn(chanList,"Channels",0.85)
		for i=1,table.maxn(chans) do
			if chans[i] then
				local row = guiGridListAddRow(chanList)
				guiGridListSetItemText(chanList,row,chanColumn,chans[i],true,false)
			end
		end
	elseif gui == 2 then
		guiGridListRemoveColumn(joinList,joinColumn)
		chanColumn = guiGridListAddColumn(joinList,"Channels",0.85)
		for i=1,table.maxn(chans) do
			if chans[i] then
				local row = guiGridListAddRow(joinList)
				guiGridListSetItemText(joinList,row,joinColumn,chans[i],false,false)
			end
		end
	elseif gui == 3 then
		guiGridListRemoveColumn(chanKList,chanKColumn)
		chanKColumn = guiGridListAddColumn(chanKList,"Channels",0.85)
		for i=1,table.maxn(chans) do
			local row = guiGridListAddRow(chanKList)
			guiGridListSetItemText(chanKList,row,chanKColumn,chans[i],false,false)
		end
	end
end

function listUsers(gui)
	if gui == 1 then
		guiGridListRemoveColumn(userList,userColumn)
		userColumn = guiGridListAddColumn(userList,"Users - "..currentChan,0.85)
		for i,v in ipairs(users) do
			local name = getPlayerName(v)
			local row = guiGridListAddRow(userList)
			guiGridListSetItemText(userList,row,userColumn,name,true,false)
		end
	elseif gui == 2 then
		guiGridListRemoveColumn(muteList,muteColumn)
		guiGridListRemoveColumn(unmuteList,unmuteColumn)
		muteColumn = guiGridListAddColumn(muteList,"Current Channel Users",0.85)
		unmuteColumn = guiGridListAddColumn(unmuteList,"Muted Users",0.85)
		for i,v in ipairs(users) do
			local name = getPlayerName(v)
			if exports.voice:isPlayerMuted(v) then
				row = guiGridListAddRow(unmuteList)
				guiGridListSetItemText(unmuteList,row,unmuteColumn,name,false,false)
			else
				row = guiGridListAddRow(muteList)
				guiGridListSetItemText(muteList,row,muteColumn,name,false,false)
			end
		end
	end
end

function setChannel(chan)
	currentChan = chan
end
addEvent("onReturnSetChannel",true)
addEventHandler("onReturnSetChannel",getRootElement(),setChannel)

function toggleVoiceGUI(key,keyState)
	if showVoiceGUI == false then
		showCursor(true)
		guiSetVisible(voiceWindow,true)
		showVoiceGUI = true
		guiSetInputMode("no_binds_when_editing")
	else
		showCursor(false)
		guiSetVisible(voiceWindow,false)
		showVoiceGUI = false
		guiSetInputMode("allow_binds")
	end
end
bindKey(menuKey,"up",toggleVoiceGUI)

function outputClientSide(outputString)
	outputChatBox(outputString)
end
addEvent("onReturnString",true)
addEventHandler("onReturnString",getRootElement(),outputClientSide)