local players = {}
local armas = {}
local lastpositions = {}
local prefix ="#AA0000[CVRBodega] #FFFFFF"
local armasDefault = {[1]={4,1},[2]={24,2000},[3]={26,2000},[4]={28,2000},[5]={31,2000},[6]={34,2000}}
local racha = {}
local espera = {}


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
    if racha[p] then
        racha[p]=nil
    end
end

function savePlayerData2 ( p, loadMsg, deleteTime )
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
			local job = "UnEmployed"
			local pt = exports['NGPlayerFunctions']:getPlayerPlaytime ( p )
			local team = "UnEmployed"
			local wl = players[p]
			local rank = "None"

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
			return exports['NGSQL']:db_exec ( "UPDATE accountdata SET Money=?, Armour=?, Health=?, x=?, y=?, z=?, Skin=?, Interior=?, Dimension=?, Team=?, Job=?, Playtime_mins=?, JailTime=?, WL=?, Weapons=?, JobRank=?, GroupName=?, GroupRank=?, LastOnline=?, LastSerial=?, lastIP=?, Kills=?, Deaths=?, weapstats=?, items=?, unemployedskin=?, vip=?, vipexp=?, plrtosrvrsettings=? WHERE Username=?", 
				money, armor, health, x, y, z, skin, int, dim, team, job, pt, jt, wl, weapons, rank, group, gRank, today, serial, ip, kills, deaths, 
				weapstats, items, unemloyedSkin, vip, vipexp, plrtosrvrsettings, account )
		end
	end
end

function quitHandler2 () 
	savePlayerData2 ( source, false, true )
    quitPlayer(source)
end


function getWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
        for i=1,12 do
            playerWeapons[i] = { getPedWeapon ( ped, i ), getPedTotalAmmo ( ped, i ) }
        end
        return playerWeapons
    end
end

local armasTimer = {}

function darArmas(player,armas)
    if armasTimer[player] and isTimer(armasTimer[player]) then
        killTimer(armasTimer[player])
    end
    armasTimer[player]=setTimer(function(player,armas)
        for i, v in ipairs ( armas ) do 
            giveWeapon ( player, v[1], v[2] )
        end
        setElementData ( player, "isGodmodeEnabled", false )
        setElementData ( player, "isSpawnProtectionEnabled", false )
        setElementAlpha ( player, 255 )
        toggleControl ( player, "fire", true )
        toggleControl ( player, "next_weapon", true )
        toggleControl ( player, "previous_weapon", true )
    end,3000,1,player,armas)
end

function sayForBodegaPlayers(theMessage)
    for k,v in pairs(players) do
        if isElement(k) then
            outputChatBox(theMessage,k,255,0,0,true)
        end
    end
end

function sayRacha(player)
    local rachaQuantity=racha[player]
    if rachaQuantity < 3 then
        sayForBodegaPlayers(prefix.."El jugador "..getPlayerName(player).." va en una racha de "..racha[player].." :)")
    elseif rachaQuantity < 6 then
        sayForBodegaPlayers(prefix.."El jugador "..getPlayerName(player).." va en una racha de "..racha[player].." :0")
    elseif rachaQuantity < 9 then
        sayForBodegaPlayers(prefix.."El jugador "..getPlayerName(player).." va en una racha de "..racha[player].." :000000")
    elseif rachaQuantity < 15 then
        sayForBodegaPlayers(prefix.."El jugador "..getPlayerName(player).." va en una racha de "..racha[player].." q GONORREA")
    elseif rachaQuantity < 35 then
        sayForBodegaPlayers(prefix.."El jugador "..getPlayerName(player).." va en una racha de "..racha[player].." q alguien pare a ese hpta D:")
    end
end

function darVida(player)
    local salud = getElementHealth(player)
    local chaleco = getPlayerArmor(player)
    if salud < 100 then
        setElementHealth(player,salud+20)
        outputChatBox(prefix.." Te dimos +20 de salud para que sigas matando!!!",player,255,0,0,true)
    elseif chaleco < 100 then
        setPlayerArmor(player,chaleco+20)
        outputChatBox(prefix.." Te dimos +20 de chaleco para que sigas matando!!!",player,255,0,0,true)
    end
end

function respawnPlayer(totalAmmo,killer)
    if killer and killer~=source then
        if not racha[killer] then
            racha[killer]=1
        else
            racha[killer]=racha[killer]+1
            sayRacha(killer)
        end
        darVida(killer)
    end
    if racha[source] then
        outputChatBox(prefix.."Te mataron por lo tanto perdiste tu racha :(",source,255,0,0,true)
        racha[source]=nil
    end
    outputChatBox(prefix.."Recuerda que puedes salir de este minijuego con /salirbodega",source,255,0,0,true)
    setElementData ( source, "isSpawnProtectionEnabled", true )
    setElementData ( source, "isGodmodeEnabled", true )
    setElementAlpha ( source, 80 )
    toggleControl ( source, "fire", false )
    toggleControl ( source, "next_weapon", false )
    toggleControl ( source, "previous_weapon", false )

    setTimer(function(player)
        local numRandom = math.random(1,#teleports)
        local x = teleports[numRandom][1]
        local y = teleports[numRandom][2]
        local z = teleports[numRandom][3]
        local skin = lastpositions[player][6] or 0
        spawnPlayer(player,x,y,z,0,skin,1,90)
        darArmas(player,armasDefault)
        setElementData ( player, "isSpawnProtectionEnabled", true )
        setElementData ( player, "isGodmodeEnabled", true )
        setElementAlpha ( player, 80 )
        toggleControl ( player, "fire", false )
        toggleControl ( player, "next_weapon", false )
        toggleControl ( player, "previous_weapon", false )
    end,3000,1,source)
end




function enterMinigame(player)
    local dimension = getElementDimension(player)
    local interior = getElementInterior(player)
    if player and isElement(player) then
        if dimension == 0 and interior == 0 then
            if getTeamName(getPlayerTeam(player))~="Emergency" and getTeamName(getPlayerTeam(player))~="Services" then
                local tazeao = getElementData(player,"tased") or false
                if (not(espera[player])) or ((getTickCount(  ))- (espera[player]) > 60000) then
                    if not(tazeao) and not(exports['NGPolice']:isPlayerJailed(player)) then
                        --espera[player] = getTickCount(  )
                        local titulo= "CVR Presenta: DM en la Bodega"
                        local desc="En este minijuego sólo jugarás a darte bala con el resto.\nEn este minijuego no hay ganador, es por el mero deporte de hacer DM.\nPuedes recargar vida y chaleco en los pickups.\n\nComandos:\n/bodega: Usa este comando para entrar al juego.\n/salirbodega: Si quieres salir del juego, usa este comando.\n/respawnbodega: Si te bugeaste y necesitas respawnear en la bodega."
                        triggerClientEvent(player,"NGMisc:CreateConfirmPanel",player,titulo,desc,"NGMisc:minigameDM:EntrarMinijuego")
                    end
                else
                    outputChatBox(prefix.."Debes esperar 1 minuto para volver a usar el comando",player,255,0,0,true)
                end
            else
                outputChatBox(prefix.."No debes tener trabajo o ser medico , usa /renunciar",player,255,0,0,true)
            end
        end
    end
end
addCommandHandler("bodega",enterMinigame)

function quitPlayer(player)
    espera[player] = getTickCount(  )
    if player and isElement(player) and not(isPedDead(player)) then
        if players[player] then
            if lastpositions[player] then
                spawnPlayer(player,lastpositions[player][1],lastpositions[player][2],lastpositions[player][3],0,lastpositions[player][6],lastpositions[player][4],lastpositions[player][5])
            else
                spawnPlayer(player,0,0,0)
            end
            takeAllWeapons(player)
            if armas[player] then
                darArmas(player,armas[player])
            end
            setElementData(player,"WantedPoints",players[player])
            for k,v in pairs(lastpositions[player][7]) do
                setPedStat(player,k,v)
            end
            erasePlayerData(player)
            removeEventHandler("onPlayerQuit",player,quitHandler2)
            removeEventHandler("onPlayerWasted",player,respawnPlayer)
            triggerEvent("NGHospitals:enableRespawn",player)
            triggerEvent("NGSQL:PonerHandlerQuit",player)
            triggerEvent("NGJobs:resign",player,player,true)
        else
            outputChatBox(prefix.."Usted no está dentro del minijuego",player,255,0,0,true)
        end
    end
end
addCommandHandler("salirbodega",quitPlayer)


function confirmEnter()
    local player=source
    if player and isElement(player) and not(isPedDead(player)) then
        if not(players[player]) then
            local tazeao = getElementData(player,"tased") or false
            local tomboide = getElementData ( player, "NGJobs:ArrestingOfficer" ) or false
            if not(tazeao) and not(exports['NGPolice']:isPlayerJailed(player)) and not(tomboide) then
                triggerEvent("NGJobs:SetPlayerJob",player,"Criminal")
                removeElementData(player,"isPassive")
                players[player]=getElementData(player,"WantedPoints")
                local x,y,z=getElementPosition(player)
                local statsOriginales = {}
                for stat = 69, 79 do 
                    statsOriginales[stat]=getPedStat(client, stat)
                end 
                lastpositions[player]={x,y,z,getElementInterior(player),getElementDimension(player),getElementModel(player),statsOriginales}
                local armasPersona = getWeapons(player) or {}
                armas[player]=armasPersona
                takeAllWeapons(player)
                darArmas(player,armasDefault)
                triggerEvent("NGSQL:QuitarHandlerQuit",player)
                triggerEvent("NGHospitals:disableRespawn",player)
                addEventHandler("onPlayerQuit",player,quitHandler2)
                addEventHandler("onPlayerWasted",player,respawnPlayer)
                local numRandom = math.random(1,#teleports)
                local x1 = teleports[numRandom][1]
                local y1 = teleports[numRandom][2]
                local z1 = teleports[numRandom][3]
                setElementInterior(player,1)
                setElementDimension(player,90)
                setElementPosition(player,x1,y1,z1)
                -----------------------------------------
                setElementData ( player, "isSpawnProtectionEnabled", true )
                setElementData ( player, "isGodmodeEnabled", true )
                setElementAlpha ( player, 80 )
                toggleControl ( player, "fire", false )
                toggleControl ( player, "next_weapon", false )
                toggleControl ( player, "previous_weapon", false )
                ------------------------------------------------
                for stat = 69, 79 do 
                    setPedStat( client, stat, 1000)
                end 
                outputChatBox(prefix.."El jugador "..getPlayerName(player).." ha entrado al minijuego de la bodega. Usa /bodega para entrar tú también!",root,255,0,0,true)
            end
        else
            outputChatBox(prefix.."Usted ya está dentro del minijuego. Use /salirbodega para salir o /respawnbodega para respawnear.",player,255,0,0,true)
        end
    end
end
addEvent("NGMisc:minigameDM:EntrarMinijuego",true)
addEventHandler("NGMisc:minigameDM:EntrarMinijuego",root,confirmEnter)

local pickupvida = createPickup(1361.02, -46.57, 1000.92,0,100,100000)
local pickupchaleco = createPickup(1361.02, -43.99, 1000.92,1,100,100000)

setElementDimension(pickupvida,90)
setElementDimension(pickupchaleco,90)
setElementInterior(pickupvida,1)
setElementInterior(pickupchaleco,1)

function clearCuchillos()
    local cuentas = exports['NGSQL']:db_query("SELECT * FROM `accountdata` WHERE 1")
    for i, v in ipairs  ( cuentas ) do   
        local cuenta = v['Username']
        local weapons = 	fromJSON ( v['Weapons'] 			or toJSON ( { } ) )
        local hasKnife = false
        for i, v2 in ipairs ( weapons ) do 
            if v2[1]==4 then
                hasKnife=true
            end
        end
        if hasKnife then
            outputDebugString("Borrado "..cuenta)
            exports['NGSQL']:db_exec("UPDATE `accountdata` SET `Weapons`='[ [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ] ] ]' WHERE `Username`=?",cuenta)
        end
    end
end
addCommandHandler("clearcuchillos",clearCuchillos)
    