-- Scripted by G&T Mapping & Loki

aclGroup = "Admin" -- This group can add and remove vips/staff.

function isPlayerInside(plr)
	if isElementWithinColShape(plr,cinemaCol) then
		return true
	end
end

function requestPlay(source,cmd,url)
    if url and isPlayerInside(source) then
        local url = url:gsub('&list=(.+)','') or url
        local id = url:match('v=(.+)&') or url:match('v=(.+)#') or url:match('v=(.+)') or url:match('tu.be/(.+)#') or url:match('tu.be/(.+)?') or url:match('tu.be/(.+)')
        if url and id then
			local url = "https://www.youtube.com/watch?v="..id
			if not isDuplicate(url) then
				getData(id,url,source)
			else
				triggerClientEvent(source,"onDxPopupMessage",resourceRoot,"This video has already been added",3000)
			end
        else
			triggerClientEvent(source,"onDxPopupMessage",resourceRoot,"This is not a valid URL.",3000)
		end
    end
end
addEvent("requestPlay",true)
addEventHandler("requestPlay",resourceRoot,requestPlay)

function isDuplicate(url)
	for _,v in pairs(playlist) do
		if v[1].url == url then
			return true
		end
	end
end

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

cooldown={}
function AUC(player)
	if getElementData(player,"Group")=="AUC" then
		if not(cooldown[player]) or getTickCount()-cooldown[player]>300000 then
			if getElementSpeed(player)==0 then
				setElementData(player,"SteroidsUse",true)
                setPedStat(player, 24, 1000)
                setTimer(function(player)
                    setPlayerArmor(player, 100) 
                end,2000,1,player)
				setElementHealth(player, 200)
				
				cooldown[player]=getTickCount()
			else
				outputChatBox("Solo puedes hacer esto quieto",player,255,0,0,true)
			end
		else
			local cuenta=300000+getTickCount()-cooldown[player]
			outputChatBox("Parcero te faltan "..tostring(cuenta).." para activar la protección",player,255,0,0,true)
		end
	end
end
addCommandHandler("AUC",AUC)

function INVOCACION(player)
    if getAccountName(getPlayerAccount(player))=="BalaclavaAM" or getAccountName(getPlayerAccount(player))=="MataTombos23" then
        local x,y,z = getElementPosition(player)
        for id, player in ipairs(getElementsByType("player")) do 
            if getElementData(player,"Group") == "AUC" then
                setElementPosition(player,x,y,z)
            end
        end 
    end
end
addCommandHandler("invocarauc",INVOCACION)

function requestStop(source)
    if isPlayerManager(source) then
        if isTimer(playTimer) then
            playlist = {nil}
            killTimer(playTimer)
            triggerClientEvent("stopRequest",resourceRoot)
            triggerClientEvent("syncRequest",resourceRoot,playlist)
        end
        if isTimer(restimer) then
            killTimer( restimer )
        end
    else
        triggerClientEvent(source,"onDxPopupMessage",resourceRoot,"You don't have permission to do this.",3500,255,255,255,255,0,0)
    end
end
addEvent("globalStop",true)
addEventHandler("globalStop",resourceRoot,requestStop)

function getURL(source)
    if isTimer(playTimer) and isPlayerInside(source) then
        outputChatBox(playlist[1][1]["url"],source,245,180,140,true)
    else
        outputChatBox("There's nothing playing",source,245,180,140,true)
    end
end
addCommandHandler("geturl",getURL)

function removeFromDxPlaylist(source,number)
    if isPlayerManager(source) and isPlayerInside(source) then
        if number == 1 then
            executeCommandHandler("skipvideo",source)
            return false
        end
        table.remove(playlist,tonumber(number))
        triggerClientEvent("syncRequest",resourceRoot,playlist)
        triggerClientEvent(source,"onDxPopupMessage",resourceRoot,"Number "..number.." has been removed from the playlist.",3500)
    else
        triggerClientEvent(source,"onDxPopupMessage",resourceRoot,"You don't have permission to do this.",3500,255,255,255,255,0,0)
    end
end
addEvent("requestRemove",true)
addEventHandler("requestRemove",resourceRoot,removeFromDxPlaylist)

function removeFromPlaylist(source,cmd,item)
    if isPlayerManager(source) and isPlayerInside(source) then
        if tonumber(item) then
            if tonumber(item) > 1 and tonumber(item) <= #playlist then
                table.remove(playlist,item)
            else
                outputChatBox("This track doesn't exist.",source,245,180,140,true)
            end
        else
            outputChatBox("ERROR: Syntax is /remove [number] e.g.: /remove 3",source,225,100,100,true)
        end
    else
        triggerClientEvent(source,"onDxPopupMessage",resourceRoot,"You don't have permission to do this.",3500,255,255,255,255,0,0)
    end
end

playersVoted = {}
maxVotes = 0
function voteToSkip(plr)
	if isTimer(playTimer) and isPlayerInside(plr) then
		local serial = getPlayerSerial(plr)
		for _,v in pairs(playersVoted) do
			if v:match(serial) then
				triggerClientEvent(plr,"onDxPopupMessage",resourceRoot,"You've already voted.")
				return
			end
		end
		table.insert(playersVoted,serial)
		triggerClientEvent("syncVotes",resourceRoot,#playersVoted,maxVotes)
		if maxVotes > 0 and #playersVoted == maxVotes then
			executeCommandHandler("skipvideo",plr)
		end
	end
end
addEvent("voteToSkip",true)
addEventHandler("voteToSkip",resourceRoot,voteToSkip)

local elemType = "player"

function enterCinema(player)
    player = player or client

    maxVotes = math.round(#getElementsWithinColShape(cinemaCol,elemType)*.65,0,"ceil")
    triggerClientEvent("syncVotes",resourceRoot,#playersVoted,maxVotes)
    
    if maxVotes > 0 and #playersVoted == maxVotes then
        executeCommandHandler("skipvideo",player)
    end
    
    -- resume playback for entered player
    triggerClientEvent(player,"syncRequest",resourceRoot,playlist)
    setTimer(triggerClientEvent,500,1,player,"playRequest",resourceRoot,playlist[1][1].url,playlist[1][1].title,playlist[1][1].length,playlist[1][1].nick,currentVideoTime)
end
addEvent('enterCinema', true)
addEventHandler("enterCinema",resourceRoot,enterCinema)

function onEnterCinema(hitElem,matchDim)
	if hitElem and matchDim then
		if getElementType(hitElem) == "player" and isTimer(playTimer) then
			enterCinema(hitElem)
		end
	end
end
addEventHandler("onColShapeHit",cinemaCol,onEnterCinema)

function onLeaveCinema(leftElem,matchDim)
	if leftElem and matchDim then
		if getElementType(leftElem) == "player" and isTimer(playTimer) then
			for i,v in pairs(playersVoted) do
				if v:match(getPlayerSerial(leftElem)) then
					-- remove vote when player leaves the cinema
					table.remove(playersVoted,i)
					maxVotes = math.round(#getElementsWithinColShape(cinemaCol,elemType)*.65,0,"ceil")
					triggerClientEvent("syncVotes",resourceRoot,#playersVoted,maxVotes)
				end
			end
		end
	end
end
addEventHandler("onColShapeLeave",cinemaCol,onLeaveCinema)

function onLeaveServer()
	if isTimer(playTimer) then
		for plr,serial in pairs(playersVoted) do
			if serial:match(getPlayerSerial(source)) then
				-- remove vote when player leaves the server while in the cinema
				maxVotes = math.round(#getElementsWithinColShape(cinemaCol,elemType)*.65,0,"ceil")
				table.remove(playersVoted,plr)
				triggerClientEvent("syncVotes",resourceRoot,#playersVoted,maxVotes)
			end
		end
	end
end
addEventHandler("onPlayerQuit",root,onLeaveServer)

function listPlaylist(source)
	if isPlayerInside(source) then
		for i,v in pairs(playlist) do
			setTimer(function()
				if i == 1 then outputChatBox("#F5B48C||| #F5B48CNow Playing #F5B48C|||",source,245,180,140,true) end
				if i == 2 then outputChatBox("#F5B48C||| Next Up |||",source,245,180,140,true) end
				local length = string.format("%.2d:%.2d:%.2d",v[1].length/(60*60),v[1].length/60%60,v[1].length%60)
				outputChatBox(i..". #FFFFFF"..v[1].title.."#F5B48C Length: #FFFFFF"..length,source,245,180,140,true)
			end,50,1)
		end
	end
end
addEvent("showPlaylist",true)
addEventHandler("showPlaylist",resourceRoot,listPlaylist)

function sendPlaylist(plr)
    triggerClientEvent(plr,"syncRequest",resourceRoot,playlist)
end
addEvent("syncRequestFromClient",true)
addEventHandler("syncRequestFromClient",resourceRoot,sendPlaylist)

function startPlaying(source,cmd)
    addCommandHandler("replay",startPlaying)
    addCommandHandler("skipvideo",startPlaying)
    
	-- set max votes
    if #getElementsWithinColShape(cinemaCol,elemType) == 2 then
        maxVotes = 2
    else
        maxVotes = math.round(#getElementsWithinColShape(cinemaCol,elemType)*.65,0,"ceil")
    end

    -- reset votes
    for i=1,#playersVoted do
		playersVoted[i] = nil
	end
    triggerClientEvent("syncVotes",resourceRoot,#playersVoted,maxVotes)
    
    -- handle playing
    if cmd == "replay" then
        if isTimer(playTimer) then
            killTimer(playTimer)
			triggerClientEvent("onDxPopupMessage",resourceRoot,"Replaying current song")
        end
	elseif cmd == "skipvideo" then
        if isTimer(playTimer) then
            killTimer(playTimer)
            table.remove(playlist,1)
            triggerClientEvent("onDxPopupMessage",resourceRoot,"The video was skipped by "..getPlayerName(source))
            if  #playlist == 0 then
                triggerClientEvent("stopRequest",resourceRoot)
                return false
            end
        end
    end
    if not isTimer(playTimer) then
        if playlist[1][1]["url"] then
            triggerClientEvent("playRequest",resourceRoot,playlist[1][1]["url"],playlist[1][1]["title"],playlist[1][1]["length"],playlist[1][1]["nick"],0)
            resumeTime()
            playTimer = setTimer(function()
                table.remove(playlist,1)
                if #playlist > 0 then
                    if isTimer(playTimer) then
                        killTimer(playTimer)
                    end
                    startPlaying()
                else
                    if isTimer(playTimer) then
                        killTimer(playTimer)
                    end
                    triggerClientEvent("stopRequest",resourceRoot)
                    triggerClientEvent("syncRequest",resourceRoot,playlist)
                end
            end,(playlist[1][1]["length"]*1000)+3000,1) -- added 3 secs to compensate for load times
        else
            outputChatBox("List is empty",source,245,180,140,true)
        end
    else
        outputChatBox("Playlist already running",source,245,180,140,true)
    end
    
    triggerClientEvent("syncRequest",resourceRoot,playlist)
end

function togglePanel(source)
    if cinemaCol then
        if isPlayerInside(source) then
            triggerClientEvent(source,"togglePanel",resourceRoot)
        end
    end
end
-- toggle key is in s-binds.lua

function adminCmds(cmd)
    if cmd == "replay" or cmd == "stopplay" or cmd == "stopsong" or cmd == "playall" or cmd == "skipvideo" or cmd == "remove" or cmd == "delete" then
        if isPlayerManager(source) then
            return false
        else
            triggerClientEvent(source,"onDxPopupMessage",resourceRoot,"You don't have permission to do this.",3500,255,255,255,255,0,0)
            cancelEvent()
        end
    end
	if cmd == "play" then
		
	end
end
addEventHandler("onPlayerCommand",root,adminCmds)

addCommandHandler("play",requestPlay)
addCommandHandler("stopplay",requestStop)
addCommandHandler("stopsong",requestStop)
addCommandHandler("playall",startPlaying)
addCommandHandler("remove",removeFromPlaylist)
addCommandHandler("delete",removeFromPlaylist)

outputDebugString("Successfully Loaded G&T & Loki's Cinema Experience")

-------------------
-- COLSHAPE STUF --
-------------------

function getPlayersInCol()
    local userlistTable = {}
    local playerTable = getElementsWithinColShape(cinemaCol,"player")
    if playerTable then
        for _,v in pairs(playerTable) do
            local name = getPlayerName(v)
            if isPlayerManager(v) then
                table.insert(userlistTable, {name = name, vip = true})
            else
                table.insert(userlistTable, {name = name, vip = false})
            end
        end
        triggerClientEvent("onAddToUserlist",resourceRoot,userlistTable)
    end
end
addEvent("onGetPlayersInCol",true)
addEventHandler("onGetPlayersInCol",resourceRoot,getPlayersInCol)

function resumeTime()
    if isTimer(restimer) then
        killTimer( restimer )
    end
    currentVideoTime = 3
    restimer = setTimer(
        function()
            currentVideoTime = currentVideoTime + 1
    end,1000,playlist[1][1]["length"]+3.5)
end