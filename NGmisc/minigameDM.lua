local players = {}
local armas = {}
local lastpositions = {}
local prefix =""
local armasDefault = {1={4,1},2={24,9999},3={26,9999},4={28,9999},5={31,9999},6={34,9999}}


local teleports = {{1361.3, 5.6, 1008.16},{1360.42, -45.21, 1007.88},{1415.19, -46.59, 1000.93},{1363.36, 3.33, 1000.92}}
local weapStats_ = { 
	['9mm'] = 0, ['silenced'] = 0, ['deagle'] = 0, ['shotgun'] = 0, ['combat_shotgun'] = 0, 
	['micro_smg'] = 0, ['mp5'] = 0, ['ak47'] = 0, ['m4'] = 0, ['tec-9'] = 0, ['sniper_rifle'] = 0 }


function erasePlayerData(p)
    if players[p] then
        players[p]=nil
    end
    if lastpositions[p] then
        lastpositions[p]=nil
    end
    if armas[p] then
        armas[p]=nil
    end
end

function savePlayerData ( p, loadMsg, deleteTime )
	if ( p and getElementType ( p ) == 'player' ) then
		if ( not isGuestAccount ( getPlayerAccount ( p ) ) ) then
			
			if ( loadMessage == nil ) then loadMessage = true end
			if ( deleteTime == nil ) then deleteTime = false end
		
			local account = getAccountName ( getPlayerAccount ( p ) )
			local x = lastpositions[p][1]
            local y = lastpositions[p][2]
            local z = lastpositions[p][3]
			local money, health = getPlayerMoney ( p ), getElementHealth ( p )
			local armor, skin = getPedArmor ( p ), getElementModel ( p )
			local int = lastpositions[p][4]
            local dim = lastpositions[p][5]
			local job = getElementData ( p, "Job" )
			local pt = exports['NGPlayerFunctions']:getPlayerPlaytime ( p )
			local team = "UnEmployed"
			local wl = getElementData ( p, "WantedPoints" ) or 0
			local rank = tostring ( getElementData ( p, "Job Rank" ) )

			local group = tostring ( getElementData ( p, "Group" ) )
			local gRank = tostring ( getElementData ( p, "Group Rank" ) )

			local jt = exports['NGPolice']:isPlayerJailed ( p ) or 0
			local today = exports['NGPlayerFunctions']:getToday ( )
			local kills = tonumber ( getElementData ( p, "NGSQL:Kills" ) ) or 0
			local deaths = tonumber ( getElementData ( p, "NGSQL:Deaths" ) ) or 0
			local weapstats = toJSON ( getElementData ( p, "NGSQL:WeaponStats" ) or weapStats_ )
			local items = tostring ( toJSON ( getElementData ( p, "NGUser:Items" ) or { } ) )
			local unemloyedSkin = tostring ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 28
			local vip = tostring ( getElementData ( p, "VIP" ) )
			local vipexp = tostring ( getElementData ( p, "NGVIP.expDate" ) )

			local plrtosrvrsettings = tostring ( toJSON ( getElementData ( p, "PlayerServerSettings" ) or { } ) )
			if health == 0 then health = 100 end 
			if ( getElementData ( p, "NGEvents:IsPlayerInEvent" ) ) then
				health = 0
				dim = 0
			end
			
			if ( getPlayerTeam ( p ) ) then
				team = getTeamName ( getPlayerTeam ( p ) )
			end if not armor then
				armor = 0
			end
			if ( not jt ) then jt = 0 end
			
            local weapons = toJSON ( armas[p] )
			local ip = getPlayerIP ( p )
			local serial = getPlayerSerial ( p )
			
            erasePlayerData(p)

			if loadMsg then outputDebugString ( "NGSQL: Attempting to save account "..account.." (Player: "..getPlayerName ( p )..") userdata." ) end
			if ( deleteTime ) then exports['NGPlayerFunctions']:deletePlayerPlaytime ( p ) end
			return db_exec ( "UPDATE accountdata SET Money=?, Armour=?, Health=?, x=?, y=?, z=?, Skin=?, Interior=?, Dimension=?, Team=?, Job=?, Playtime_mins=?, JailTime=?, WL=?, Weapons=?, JobRank=?, GroupName=?, GroupRank=?, LastOnline=?, LastSerial=?, lastIP=?, Kills=?, Deaths=?, weapstats=?, items=?, unemployedskin=?, vip=?, vipexp=?, plrtosrvrsettings=? WHERE Username=?", 
				money, armor, health, x, y, z, skin, int, dim, team, job, pt, jt, wl, weapons, rank, group, gRank, today, serial, ip, kills, deaths, 
				weapstats, items, unemloyedSkin, vip, vipexp, plrtosrvrsettings, account )
		end
	end
end

function quitHandler ( ) 
	if ( isGuestAccount ( getPlayerAccount ( source ) ) ) then
		return 
	end 
	savePlayerData ( source, false, true ) 
end


function getWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
        for i=1,12 do
            playerWeapons[i] = { getPedWeapon ( p, i ), getPedTotalAmmo ( p, i ) }
        end
        return playerWeapons
    end
end

function darArmas(player,armas)
    setTimer(function(player,armas)
        for i, v in ipairs ( armas ) do 
            giveWeapon ( player, v[1], v[2] ) 
        end
    end,3000,1,player,armas)
end


function respawnPlayer()
    setTimer(function(player)
        local numRandom = math.random(1,#teleports)
        local x = teleports[numRandom][1]
        local y = teleports[numRandom][2]
        local z = teleports[numRandom][3]
        local skin = lastpositions[player][6] or 0
        spawnPlayer(player,x,y,z,0,skin,1,0)
        darArmas(player,armasDefault)
    end,3000,1,source)
end




function enterMinigame(player)
    if player and isElement(player) then
        local tazeao = getElementData(player,"tased") or false
        if not(tazeao) and not(exports['NGPolice']:isPlayerJailed(player)) then
            local titulo= "CVR Presenta: DM en la Bodega"
            local desc="En este minijuego sólo jugarás a darte bala con el resto.\nEn este minijuego no hay ganador, es por el mero deporte de hacer DM.\nPuedes recargar vida y chaleco en los pickups.\n\nComandos:\n/bodega: Usa este comando para entrar al juego.\n/salirbodega: Si quieres salir del juego, usa este comando.\n/respawnbodega: Si te bugeaste y necesitas respawnear en la bodega."
            triggerClientEvent(p,"NGMisc:CreateConfirmPanel",p,titulo,desc,"NGMisc:minigameDM:EntrarMinijuego")
        end
    end
end

function quitPlayer(player)
    if player and isElement(player) then
        if players[player] then
            if lastpositions[player] then
                spawnPlayer(player,lastpositions[player][1],lastpositions[player][2],lastpositions[player][3],0,lastpositions[player][6],lastpositions[player][4],lastpositions[player][5])
            else
                spawnPlayer(player,0,0,0)
            end
            if armas[player] then
                darArmas(player,armas[player])
            end
            erasePlayerData(player)
            removeEventHandler("onPlayerQuit",player,quitHandler)
            removeEventHandler("onPlayerWasted",player,respawnPlayer)
            triggerEvent("NGHospitals:enableRespawn",player)
            triggerEvent("NGSQL:PonerHandlerQuit",player)
        else
            outputChatBox(prefix.."Usted no está dentro del minijuego",player,255,0,0,true)
        end
    end
end
addCommandHandler("salirbodega",quitPlayer)


function confirmEnter(player)
    if player and isElement(player) and not(isPlayerDead(player)) then
        if not(players[player]) then
            setElementData(player,"Job","Criminal")
            setPlayerTeam(player,getTeamFromName("Criminals"))
            removeElementData(player,"isPassive")
            players[player]=getElementData(player,"wp")
            local x,y,z=getElementPosition(player)
            lastpositions[player]={x,y,z,getElementInterior(player),getElementDimension(player),getElementModel(player)}
            local armasPersona = getWeapons(player) or {}
            armas[player]=armasPersona
            takeAllWeapons(player)
            darArmas(player,armasDefault)
            triggerEvent("NGSQL:QuitarHandlerQuit",player)
            triggerEvent("NGHospitals:disableRespawn",player)
            addEventHandler("onPlayerQuit",player,quitHandler)
            addEventHandler("onPlayerWasted",player,respawnPlayer)
            local numRandom = math.random(1,#teleports)
            local x1 = teleports[numRandom][1]
            local y1 = teleports[numRandom][2]
            local z1 = teleports[numRandom][3]
            setElementPosition(player,x1,y1,z1)
            setElementInterior(1)
        else
            outputChatBox(prefix.."Usted ya está dentro del minijuego. Use /salirbodega para salir o /respawnbodega para respawnear.",player,255,0,0,true)
        end
    end
end
addEvent("NGMisc:minigameDM:EntrarMinijuego",true)
addEventHandler("NGMisc:minigameDM:EntrarMinijuego",true)

