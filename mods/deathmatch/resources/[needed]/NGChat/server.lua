spammers = { }
possiblyMuted = { }
spamTimers = { }
muteLog = { }
maxMutes = 3
spamTimer = 1000
local ignores={}--Tabla con la siguiente estructura: llave: Cuenta ignorada, clave: personas que no desean ver msg de la llave
local ignorados={} --Tabla con la siguiente estructura: llave: Jugador , clave: cuentas de las personas que se desea ignorar
local cuentas={} --Tabla para tener a la mano todas las cuentas y así no estar llamando getPlayerAccount en cada mensaje :)

function buscarentabla(elemento,tabla)
	for k,v in ipairs(tabla) do
		if v==elemento then
			return true
		end
	end
	return false
end

--Revisa si player2 está ignorando a player
function isIgnoredBy(player,player2)
	if ignores[cuentas[player]] then
		for k,v in ipairs(ignores[cuentas[player]]) do
			if v==player2 then
				return true
			end
		end
	end
	return false
end

function getClubTag(player)
	local retorno = ""
	local club = getElementData(player,"Club")
	if club then
		retorno = "|"..exports['CVRClubs']:getClubTag(club)
	end
	return retorno
end

function table.removeValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            table.remove(tab, index)
            return index
        end
    end
    return false
end

function ignore(player,_,P2) 
	if P2 then
		local P2n = getPlayerFromName (P2) or exports["NGPlayerFunctions"]:getPlayerFromNamePart (P2)
		if P2n then
			if not(exports['NGAdministration']:isPlayerStaff(P2n)) or exports['NGAdministration']:isPlayerStaff(player) then
				if not(isGuestAccount(getPlayerAccount(P2n))) then
					local aP2n=getAccountName(getPlayerAccount(P2n))
					local ignoraos=getAccountData(getPlayerAccount(player),"ignore")
					if ignoraos then
						ignoraos=fromJSON(ignoraos)
					else
						ignoraos={}
					end
					if not(buscarentabla(aP2n,ignoraos)) then
						if ignorados[player] then
							table.insert(ignorados[player],aP2n)
						else
							ignorados[player]={}
							table.insert(ignorados[player],aP2n)
						end
						table.insert(ignoraos,aP2n)
						if ignores[aP2n] then
							table.insert(ignores[aP2n],player)
						else
							ignores[aP2n]={}
							table.insert(ignores[aP2n],player)
						end
						setAccountData(getPlayerAccount(player),"ignore",toJSON(ignoraos))
						outputChatBox("Ahora estás ignorando a "..getPlayerName(P2n),player,255,0,0)
						triggerClientEvent(player,"proximity-voice::actualizarStreamForced",player)
					else
						outputChatBox("Ya ignorabas a este jugador",player,255,0,0)
					end
				else
					outputChatBox("El jugador al que quieres ignorar no está siquiera logeado.",player,255,0,0)
				end
			else
				outputChatBox("No puedes ignorar a un staff.",player,255,0,0)
				outputChatBox("Si tienes un problema con su comportamiento, reporta en discord!",player,255,0,0)
			end
		else
			outputChatBox("El jugador al que quieres ignorar no existe o no está conectado.",player,255,0,0)
		end
	else
		outputChatBox("Sintaxis: /ignore player",player,255,0,0)
	end
end
addCommandHandler("ignore",ignore)



function designore(player,_,P2) 
	if P2 then
		local ignoraos=getAccountData(getPlayerAccount(player),"ignore")
		if ignoraos then
			ignoraos=fromJSON(ignoraos)
			if (buscarentabla(P2,ignoraos)) then
				if ignores[P2] then
					table.removeValue(ignores[P2],player)
					if #ignores[P2]<1 then
						ignores[P2]=nil
					end
				end
				if ignorados[player] then
					table.removeValue(ignorados[player],P2)
					if #ignorados[player]<0 then
						ignorados[player]=nil
					end
				end
				table.removeValue(ignoraos,P2)
				setAccountData(getPlayerAccount(player),"ignore",toJSON(ignoraos))
				outputChatBox("Has dejado de ignorar a "..P2,player,255,0,0)
				triggerClientEvent(player,"proximity-voice::actualizarStreamForced",player)
			else
				outputChatBox("No estás ignorando a este jugador.",player,255,0,0)
				outputChatBox("Los jugadores que ignoras son:",player,255,0,0)
				for k,v in ipairs(ignoraos) do
					outputChatBox(k..". "..v,player,255,255,0)
				end
			end
		else
			outputChatBox("Tú no tienes jugadores ignorados.",player,255,0,0)
			outputChatBox("Los jugadores que ignoras son:",player,255,0,0)
			for k,v in ipairs(ignoraos) do
				outputChatBox(k..". "..v,player,255,255,0)
			end
		end
	else
		local ignoraos=getAccountData(getPlayerAccount(player),"ignore") or "[ [ ] ]"
		ignoraos=fromJSON(ignoraos)
		if #ignoraos >0 then
			outputChatBox("Los jugadores que ignoras son:",player,255,0,0)
			for k,v in ipairs(ignoraos) do
				outputChatBox(k..". "..v,player,255,255,0)
			end
		else
			outputChatBox("Tú no tienes jugadores ignorados.",player,255,0,0)
		end
	end
end
addCommandHandler("designore",designore)

function sacarEnChat(msg,plr,tabla,r,g,b)
	if not r then
		r=255
	end
	if not g then
		g=0
	end
	if not b then
		b=0
	end

	if ignores[cuentas[plr]] then
		for k,v in ipairs(tabla) do
			if not(buscarentabla(v,ignores[cuentas[plr]])) then
				outputChatBox(msg,v,r,g,b,true)
			end
		end
	else
		outputChatBox(msg,root,r,g,b,true)
	end
end

function pillarIgnores(plr)
	outputChatBox(inspect(ignores),plr,255,0,0,true) 
	outputChatBox(inspect(ignorados),plr,255,0,0,true) 
end
addCommandHandler("pi",pillarIgnores)


addEventHandler ( "onPlayerChat", root, function  ( msg, tp )
	cancelEvent ( )
	if ( isGuestAccount ( getPlayerAccount ( source ) ) ) then
		return outputChatBox ( "Please wait until you're logged into the server to use the chat.", source, 255, 140, 25 )
	end
	if ( spammers[source] ) then
		if ( possiblyMuted[source] ) then
			muteLog[source] = muteLog[source] + 1
			if ( muteLog[source] >= maxMutes ) then
				exports['NGMessages']:sendClientMessage ( getPlayerName ( source ).." was kicked for spamming ("..maxMutes.."/"..maxMutes..")", root, 255, 140, 25 )
				kickPlayer ( source, "You were kicked for being muted "..maxMutes.." times for spam." )
				exports['NGLogs']:outputPunishLog ( getPlayerName ( source ).." kicked for spam" )
			else
				exports['admin']:aSetPlayerMuted ( source, true, 60 )
				exports['NGMessages']:sendClientMessage ( getPlayerName ( source ).." was muted for spamming ("..muteLog[source].."/"..maxMutes..")", root, 255, 140, 25 )
				exports['NGLogs']:outputPunishLog ( getPlayerName ( source ).." muted for spamming (1 minute)" )
			end
		end
		if ( isElement ( source ) ) then
			possiblyMuted[source] = true
			if ( isTimer ( spamTimers[source] ) ) then
				resetTimer ( spamTimers[source] )
			end
			return exports['NGMessages']:sendClientMessage ( "Please, refrain yourself from spamming the chatbox. Two messages every second max, time reset.", source, 255, 140, 25 )
		end
	end
	
	local tags = getPlayerTags ( source )
	local r, g, b = 255, 255, 255
	if ( getPlayerTeam ( source ) ) then
		r, g, b = getTeamColor ( getPlayerTeam ( source ) )
	end
	local playerName = getPlayerName ( source ):gsub ( '#%x%x%x%x%x%x', '' )
	if ( tp == 0 ) then
		local color = ""
		if getElementData(source,"Club") and getElementData(source,"Job")=="Drifter" then
			color=string.sub(getClubTag(source),2,8)
		end
		exports['NGLogs']:outputChatLog ( "Global", tags..color..playerName..getClubTag(source)..": "..msg  )
		sacarEnChat(tags..color..playerName..getClubTag(source)..": #ffffff"..msg,source,getElementsByType("player"),r,g,b)
	elseif ( tp == 2 ) then
		if ( getPlayerTeam ( source ) ) then
			local tags_ = tags
			local tags = "(TEAM)"..tags_
			exports['NGLogs']:outputChatLog ( "Team - "..getTeamName(getPlayerTeam(source)), tags..playerName..": "..msg )
			sacarEnChat ( tags..playerName..": #ffffff"..msg,source,getPlayersInTeam ( getPlayerTeam ( source ) ), r, g, b, true )
		else
			outputChatBox ( "You're not in a team.", source, 255, 0, 0 )
		end
	end
	
	spammers[source] = true
	spamTimers[source] = setTimer ( function ( p )
		spammers[p] = nil
		possiblyMuted[p] = nil
	end, spamTimer, 1, source )
	
end )

function getLocalAreaPlayers ( plr ) 
	local x, y, z = getElementPosition ( plr )
	local plrs = { }
	for i, v in ipairs ( getElementsByType ( 'player' ) ) do
		local px, py, pz = getElementPosition ( v )
		if ( getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) <= 50 ) then
			table.insert ( plrs, v )
		end
	end
	return plrs
end

function outputLocalMessage ( plr, _, ... )
	if ( ... ) then
		if ( isPlayerMuted ( plr ) ) then
			return exports['NGMessages']:sendClientMessage ( "You cannot use the chat while you're muted.", plr, 255, 0, 0 )
		end
		
		if ( spammers[plr] ) then
			return exports['NGMessages']:sendClientMessage ( "Please, refrain yourself from spamming the chatbox. Two messages every two seconds max.", plr, 255, 0, 0 )
		end
		
		local msg = table.concat ( { ... }, " " )
		local players = getLocalAreaPlayers ( plr )
		local count = #players-1
		local tags="(LOCAL)["..count.."]"..getPlayerTags ( plr )
		local r, g, b = 255, 255, 255
		if ( getPlayerTeam ( plr ) ) then
			r, g, b = getTeamColor ( getPlayerTeam ( plr ) )
		end
		local playerName = getPlayerName ( plr ):gsub ( '#%x%x%x%x%x%x', '' )
		exports['NGLogs']:outputChatLog ( "Local", tags..playerName..": ".. msg )
		local color = ""
		if getElementData(plr,"Club") and getElementData(plr,"Job")=="Drifter" then
			color=string.sub(getClubTag(plr),2,8)
		end
		for i, v in ipairs ( players ) do
			if not(isIgnoredBy(plr,v)) then
				outputChatBox ( tags..color..playerName..getClubTag(plr)..": #ffffff".. msg, v, r, g, b, true )
			end
		end
		exports['NGbubblechat']:outputMessage(plr, msg)
		spammers[plr] = true
		setTimer ( function ( p )
			spammers[p] = nil
		end, spamTimer, 1, plr )
	end
end
addCommandHandler ( 'LocalChat', outputLocalMessage )

for i, v in ipairs ( getElementsByType ( 'player' ) ) do
	if ( not isGuestAccount ( getPlayerAccount ( v ) ) ) then
		bindKey ( v, "u", "down", "chatbox", "LocalChat" )
	end
end
local cooldownadmin = {}
function chatadmin(player,_,...)
	if exports['NGAdministration']:isPlayerStaff ( player ) then
		if not(cooldownadmin[player]) or getTickCount()-cooldownadmin[player]>1500 then
			cooldownadmin[player]=getTickCount()
			local message = table.concat({...}," ")
			outputAdminMessage(message,player)
		else
			outputChatBox("Sólo puedes enviar mensajes por AC cada segundo y medio",player,255,0,0,false)
		end
	end
end
addCommandHandler("ac",chatadmin)


function outputAdminMessage(message,player)
	local level = "Consola"
	local playerName = ""
	local white = ""
	if player then
		level = exports['NGAdministration']:getPlayerStaffLevel(player)
		playerName = getPlayerName(player)
		white = "#FFFFFF "
	end
	for k, playere in ipairs(getElementsByType("player")) do
		if exports['NGAdministration']:isPlayerStaff ( playere ) then
			outputChatBox("#FFFFFF[#FFFFFFAdmins #FFEC08C#0808FFV#FF0F00R#FFFFFF]#939393:".." |"..level.."| "..playerName..white..message,playere,0,255,0,true)	
		end
	end
end


local cooldowndj = {}
function chatdj(player,_,...)
	local accName=getAccountName(getPlayerAccount(player))
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "DJ" ) ) then
		if not(cooldowndj[player]) or getTickCount()-cooldowndj[player]>1500 then
			cooldowndj[player]=getTickCount()
			for k, playere in ipairs(getElementsByType("player")) do
				local accName2=getAccountName(getPlayerAccount(playere))
				if isObjectInACLGroup ("user."..accName2, aclGetGroup ( "DJ" ) ) then
					outputChatBox("#FFFFFF[#FFFFFFDJ's #FFEC08C#0808FFV#FF0F00R#FFFFFF]#00C881"..getPlayerName(player)..": #FFFFFF"..table.concat({...}," "),playere,0,255,0,true)	
				end
			end
		else
			outputChatBox("Sólo puedes enviar mensajes por DJC cada segundo y medio",player,255,0,0,false)
		end
	end
end
addCommandHandler("djc",chatdj)

local cooldownclub = {}
function chatclub(player,_,...)
	local club = getElementData(player,"Club")
	if club then
		if not(cooldownclub[player]) or getTickCount()-cooldownclub[player]>1500 then
			cooldownclub[player]=getTickCount()
			local prefijo = getClubTag(player)
			for k, playere in ipairs(getElementsByType("player")) do
				if getElementData(playere,"Club")==club then
					local level = getElementData(player,"Club Rank")
					outputChatBox("#FFFFFF["..string.sub(prefijo,2).."#FFFFFF]"..string.sub(prefijo,1,8).." |"..level.."| "..getPlayerName(player).."  #FFFFFF"..table.concat({...}," "),playere,0,255,0,true)	
				end
			end
		else
			outputChatBox("Sólo puedes enviar mensajes por clubchat cada segundo y medio",player,255,0,0,false)
		end
	else
		outputChatBox("Tienes que estar en un club para usar este comando.",player,255,0,0,false)
	end
end
addCommandHandler("cclub",chatclub)



addCommandHandler ( 'r', function ( source, command, ... ) 
	if ( isGuestAccount ( getPlayerAccount ( source ) ) ) then
		return outputChatBox ( "Please wait until you're logged into the server to use the chat.", source, 255, 140, 25 )
	end

	local team = "" 
	if ( getPlayerTeam ( source ) ) then
		team = getTeamName ( getPlayerTeam ( source ) )
	end
	if ( not exports['NGPlayerFunctions']:isTeamLaw ( team ) and getTeamName(getPlayerTeam(source))~="Staff" ) then
		return exports['NGMessages']:sendClientMessage ( "You're not part of law enforcement.", source, 255, 255, 0 )
	end
	
	if ( isPlayerMuted ( source ) ) then
		return exports['NGMessages']:sendClientMessage ( "This action is disabled while you're muted.", source, 255, 255, 0 )
	end
	
	if not ... then
		return outputChatBox ( "Syntax: /"..command.." [message]", source, 255, 255, 0 )
	end
	
	local msg = table.concat ( { ... }, " " )
	
	if ( spammers[source] ) then
		if ( possiblyMuted[source] ) then
			muteLog[source] = muteLog[source] + 1
			if ( muteLog[source] >= maxMutes ) then
				exports['NGMessages']:sendClientMessage ( getPlayerName ( source ).." was kicked for spamming ("..maxMutes.."/"..maxMutes..")", root, 255, 140, 25 )
				kickPlayer ( source, "You were kicked for being muted "..maxMutes.." times for spam." )
				exports['NGLogs']:outputPunishLog ( getPlayerName ( source ).." kicked for spam" )
			else
				exports['admin']:aSetPlayerMuted ( source, true, 60 )
				exports['NGMessages']:sendClientMessage ( getPlayerName ( source ).." was muted for spamming ("..muteLog[source].."/"..maxMutes..")", root, 255, 140, 25 )
				exports['NGLogs']:outputPunishLog ( getPlayerName ( source ).." muted for spamming (1 minute)" )
			end
		end
		if ( isElement ( source ) ) then
			possiblyMuted[source] = true
			if ( isTimer ( spamTimers[source] ) ) then
				resetTimer ( spamTimers[source] )
			end
			return exports['NGMessages']:sendClientMessage ( "Please, refrain yourself from spamming the chatbox. Two messages every second max, time reset.", source, 255, 140, 25 )
		end
	end
	
	local tags = getPlayerTags ( source )
	local playerName = getPlayerName ( source ):gsub ( '#%x%x%x%x%x%x', '' )
	exports['NGLogs']:outputChatLog ( "Law", tags..playerName..": "..msg  )
	outputLawMessage ( tags..playerName..": #ffffff"..msg, 0, 140, 255, true )
	
	local r, g, b = getTeamColor ( getPlayerTeam ( source ) )
	triggerClientEvent ( root, "NGPolice:Modules->Panel:OnClientPoliceRadioChat", root, tags..playerName, msg, r, g, b )
	spammers[source] = true
	spamTimers[source] = setTimer ( function ( p )
		spammers[p] = nil
		possiblyMuted[p] = nil
	end, spamTimer, 1, source )
end )

function outputLawMessage ( message, r, g, b, hex )
	local r = r or 255
	local g = g or 255
	local b = b or 255
	local hex = hex or false
	local message = "(LAW)"..message
	for i, v in ipairs ( getElementsByType ( 'team' ) ) do 
		if ( exports['NGPlayerFunctions']:isTeamLaw ( getTeamName ( v ) ) ) then
			for i, v in ipairs ( getPlayersInTeam ( v ) ) do
				outputChatBox ( message, v, r, g, b, hex )
			end
		end
	end
	exports['NGLogs']:outputChatLog ( "Law", message )
end






function getChatLine ( player, message )
	local playername = getPlayerName ( player ):gsub ( "#%x%x%x%x%x%x", "" )
	local playername = getPlayerTags ( player )..playername
	return playername..": #ffffff"..message
end

function disguise(p)
	local hidden=getElementData(p,"disguise") or false
	if hidden==false then
		setElementData(p,"disguise",true)
		exports['NGMessages']:sendClientMessage ("Escondio",p,255,0,0)
	else
		setElementData(p,"disguise",false)
		exports['NGMessages']:sendClientMessage ("Desescondio",p,255,0,0)
	end
end
addCommandHandler("hideme",disguise)

function disguise2(p)
	local hidden=getElementData(p,"disguise2") or false
	if hidden==false then
		setElementData(p,"disguise2",true)
		exports['NGMessages']:sendClientMessage ("Escondio",p,255,0,0)
	else
		setElementData(p,"disguise2",false)
		exports['NGMessages']:sendClientMessage ("Desescondio",p,255,0,0)
	end
end
addCommandHandler("dj",disguise2)
addCommandHandler("prod",disguise2)


function getPlayerTags (p )
	local tags = ""
	local hidden=getElementData(p,"disguise") or false
	local hidden2=getElementData(p,"disguise2") or false
	local team = getTeamName( getPlayerTeam(p) )
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if (exports['NGAdministration']:isPlayerStaff ( p ) and hidden==false ) then
		tags = tags.."#7F7F7F|ADM|" --
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "DJ" ) ) and hidden2==false then
			tags = tags.."|DJ|"
		end
		if (isObjectInACLGroup ("user."..accName, aclGetGroup("GangLeader"))) then
			tags = tags.."|LG|"
		end
		if accName == "DannyUnU" then
			tags= tags.."|LiderCelacho|"
		end
		if team == "Staff" then
			tags= tags.."#FF8C00"
		end
		if team == "Criminals" then
			tags= tags.."#FF0000"
		end
		if team == "Law Enforcement" then 
			tags= tags.."#0064FF"
		end
		if team == "Services" then
			tags= tags.."#FFFF00"
		end
		if team == "Emergency" then
			tags= tags.."#00FFFF"
		end
		if team == "Unemployed" then
			tags= tags.."#A10576"
		end
		if team == "Fuerzas Armadas" then
			tags= tags.."#00FF00"
		end
	elseif (isObjectInACLGroup ("user."..accName, aclGetGroup("GangLeader"))) then
		tags = tags.."#7F7F7F|LG|"
		if team == "Staff" then
			tags= tags.."#FF8C00"
		end
		if team == "Criminals" then
			tags= tags.."#FF0000"
		end
		if team == "Law Enforcement" then 
			tags= tags.."#0064FF"
		end
		if team == "Services" then
			tags= tags.."#FFFF00"
		end
		if team == "Emergency" then
			tags= tags.."#00FFFF"
		end
		if team == "Unemployed" then
			tags= tags.."#A10576"
		end
		if team == "Fuerzas Armadas" then
			tags= tags.."#00FF00"
		end
	elseif ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "DJ" ) ) and hidden2==false ) then
		tags = tags.."#7F7F7F|DJ|"
		if accName== "soypercy08" then
			tags= tags.."|Cacorrin|"
		end
		if accName == "karamelo" then
			tags= tags.."|Coomo?|"
		end
		if team == "Staff" then
			tags= tags.."#FF8C00"
		end
		if team == "Criminals" then
			tags= tags.."#FF0000"
		end
		if team == "Law Enforcement" then 
			tags= tags.."#0064FF"
		end
		if team == "Services" then
			tags= tags.."#FFFF00"
		end
		if team == "Emergency" then
			tags= tags.."#00FFFF"
		end
		if team == "Unemployed" then
			tags= tags.."#A10576"
		end
		if team == "Fuerzas Armadas" then
			tags= tags.."#00FF00"
		end
	elseif ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Productores" ) ) and hidden2==false ) then
		tags = tags.."#00146C|#A4B5FFPROD#00146C|"
		if team == "Staff" then
			tags= tags.."#FF8C00"
		end
		if team == "Criminals" then
			tags= tags.."#FF0000"
		end
		if team == "Law Enforcement" then 
			tags= tags.."#0064FF"
		end
		if team == "Services" then
			tags= tags.."#FFFF00"
		end
		if team == "Emergency" then
			tags= tags.."#00FFFF"
		end
		if team == "Unemployed" then
			tags= tags.."#A10576"
		end
		if team == "Fuerzas Armadas" then
			tags= tags.."#00FF00"
		end
	elseif accName=="Aluna" then
			tags= tags.. "#7F7F7FGataOficial>"
			if team == "Staff" then
				tags= tags.."#FF8C00"
			end
			if team == "Criminals" then
				tags= tags.."#FF0000"
			end
			if team == "Law Enforcement" then 
				tags= tags.."#0064FF"
			end
			if team == "Services" then
				tags= tags.."#FFFF00"
			end
			if team == "Emergency" then
				tags= tags.."#00FFFF"
			end
			if team == "Unemployed" then
				tags= tags.."#A10576"
			end
			if team == "Fuerzas Armadas" then
				tags= tags.."#00FF00"
			end
	end
	return tags
end



addEventHandler ( 'onPlayerLogin', root, function ( _, theCurrentAccount )
	bindKey ( source, "u", "down", "chatbox", "LocalChat" )
	muteLog[source] = 0
	cuentas[source]=getAccountName(theCurrentAccount)
	if getAccountData(theCurrentAccount,"ignore") then
		ignorados[source]={}
		for k,cuenta in ipairs(fromJSON(getAccountData(theCurrentAccount,"ignore"))) do
			if ignores[cuenta] then
				table.insert(ignores[cuenta],source)
			else
				ignores[cuenta] = {}
				table.insert(ignores[cuenta],source)
			end
			table.insert(ignorados[source],cuenta)
		end
	end
end ) 

addEventHandler ( "onPlayerLogout", root, function ( )
	if ( muteLog[source] ) then
		muteLog[source] = nil
	end
end ) 

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

addEventHandler ( "onPlayerQuit", root, function ( )
	if cuentas[source] then
		cuentas[source]=nil
	end
	if ignorados[source] then
		for k,v in ipairs(ignorados[source]) do
			table.removeValue(ignores[v],source)
			if table.size(ignores[v])==0 then
				ignores[v]=nil
			end
		end
		ignorados[source]=nil
	end
end )
	
addEventHandler ( "onResourceStart", root, function ( )
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		muteLog[v] = 0
		local acc=getPlayerAccount(v)
		cuentas[v]=getAccountName(acc)
		if not (isGuestAccount(acc)) then
			if getAccountData(acc,"ignore") then
				ignorados[v]={}
				for k,cuenta in ipairs(fromJSON(getAccountData(acc,"ignore"))) do
					table.insert(ignorados[v],cuenta)
					if ignores[cuenta] then
						table.insert(ignores[cuenta],v)
					else
						ignores[cuenta] = {}
						table.insert(ignores[cuenta],v)
					end
				end
			end
		end
	end
end )


function tagPlayer ( source, command, thePlayer, tag )
	-- Attempt to grab the element id for the player from the parsed name.
	local sPlayerElement = getPlayerFromName ( thePlayer )
	-- Check to see if the player were changing the tag for exists.
	if ( sPlayerElement ) then
		-- make sure that the element type of thePlayer is acctually pointing to a player element
		if getElementType ( sPlayerElement ) == "player" then
			-- we store the player's current name,
			local oldName = getPlayerName ( sPlayerElement )
			-- append the tag passed to this function before it
			local taggedName = tag
			-- then set it as his new name
			setPlayerName ( sPlayerElement, taggedName )
			-- Tell the player who triggerd the command that the tag has been applied
			outputChatBox ( "Player " .. thePlayer .. "'s tag changed to " .. taggedName, source )
		end
	else
		-- Tell the player who triggerd the command that the player could not be found
		outputChatBox ( "Unable to change player tag: Player " .. thePlayer .. " not found", source )
	end
end
-- Add a command handler for either the console or / chat commands
-- Example: /changetag <playername> <tag>
addCommandHandler ( "cambiarnombre", tagPlayer )



-- Cancel out private messages --
addEventHandler ( "onPlayerPrivateMessage", root, function ( ) 
	cancelEvent ( )
	exports.NGMessages:sendClientMessage ( "Private messages are disabled. Please use the SMS app (F3) for messages.", source, 255, 255, 0 )
end )

local mensajes={}
function MensajePrivado(P, _, P2, ...)
    if P2 then
        local jugador2=getPlayerFromName (P2) or exports["NGPlayerFunctions"]:getPlayerFromNamePart (P2)
        if jugador2 then 
           if not isPlayerMuted (P) then
            if (not (mensajes[P]) or (getTickCount()-mensajes[P]>5000)) and not(isIgnoredBy(P,jugador2)) then 
                mensajes[P]=getTickCount()
				outputChatBox("[Msg] de "..getPlayerName(P)..": "..table.concat({...}," "), jugador2,0,255,0,false)
				outputChatBox("Mensaje enviado a: "..getPlayerName(jugador2), P,255,255,0,false)
				exports["NGLogs"]:outputChatLog("[Msg] de "..getPlayerName(P).." para ".. getPlayerName(jugador2)..": "..table.concat({...}," "))
				for k, player in ipairs(getElementsByType("player")) do
					acc=getPlayerAccount(player)
					accName = getAccountName(acc)
					if not isGuestAccount(acc) and (isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 4" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 3" ))) then
						outputChatBox("[Msg] de "..getPlayerName(P).."-"..getPlayerName(jugador2).." #F7DCBC"..table.concat({...}," "), player,255,155,50,true)
					end
				end
            else
                exports["NGMessages"]:sendClientMessage("Error, solo se pueden enviar mensajes cada 5 segundos",P,255,0,0)
            end
           else
            exports["NGMessages"]:sendClientMessage("Error, no puedes enviar un mensaje, estas muteado",P,255,0,0)
           end 
        else
            exports["NGMessages"]:sendClientMessage("No existe un jugador llamado "..P2,P,255,255,0)
        end
    else
        exports["NGMessages"]:sendClientMessage("Syntax: /MP (nombre del jugador) (mensaje)",P,255,0,0)
    end
end
addCommandHandler("mp",MensajePrivado)






function compararCarro(p)
	local vehiculo = getPedOccupiedVehicle(p)
	if vehiculo then
		outputChatBox("Estás en un vehículo!",p,255,0,0,true)
	else
		outputChatBox("Estás a pata!",p,255,0,0,true)
	end
end
addCommandHandler("estoycarro",compararCarro)