


function amOpenWindow ( p )
	if ( getPlayerStaffLevel ( p, 'int' ) >= 4 ) then
		local query = exports.NGSQL:db_query ( "SELECT * FROM accountdata  ORDER BY Username" )
		local accounts = { 
			valid = { },
			invalid = { }
		}
		for i, v in ipairs ( query ) do
			if ( getAccount ( v.Username ) ) then
				accounts.valid[ tostring ( v.Username ) ] = v
			else
				accounts.invalid[ v.Username] = v
				accounts.invalid[ v.Username].reason = "Account doesn't exist in server database"
			end
		end
		for i, v in ipairs ( getAccounts ( ) ) do
			local n = getAccountName ( v )
			if ( not accounts.valid [n] and not accounts.invalid[n] ) then
				accounts.invalid[n] = { }
				accounts.invalid[n].Username = n
				accounts.invalid[n].reason = "Account doesn't exist in MySQL database"
			end
		end
		triggerClientEvent ( p, "NGAdministration:AccountManager:onClientOpenWindow", p, accounts )
	end
end
addCommandHandler ( "am", amOpenWindow )

local removeAccount_ = removeAccount
-- remove account 
addEvent ( "NGAdmin:amManager:removeAccountFromHistory", true )
addEventHandler ( "NGAdmin:amManager:removeAccountFromHistory", root, function ( account )
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		if ( getAccountName ( getPlayerAccount ( v ) ) == account ) then
			return exports.NGMessages:sendClientMessage ( "You need to kick "..tostring(getPlayerName(v)).." before you can delete this account.", source, 255, 255, 0 )
		end
		removeAccount(account,source)
	end
end )


function removeAccount ( account, source )
	local user = ""
	if ( isElement ( source ) ) then
		user = getPlayerName ( source ).." ("..getAccountName(getPlayerAccount(source))..")"
	else
		user = "Console (Console)"
	end
	exports.NGSQL:db_exec ( "DELETE FROM accountdata WHERE Username=?", account )
	exports.NGSQL:db_exec ( "DELETE FROM bank_accounts WHERE Account=?", account )
	exports.NGSQL:db_exec ( "DELETE FROM bank_transactions WHERE account=?", account )
	exports.NGSQL:db_exec ( "DELETE FROM jobdata WHERE Username=?", account )
	exports.NGSQL:db_exec ( "DELETE FROM log_punish WHERE account=?", account )
	exports.NGSQL:db_exec ( "DELETE FROM user_shop WHERE seller_account=?", account )
	exports.NGSQL:db_exec ( "DELETE FROM vehicles WHERE Owner=?", account )
	local acc = getAccount ( account )
	if acc then removeAccount_ ( acc ) end
	exports.NGLogs:outputActionLog ( user.." deleted account "..tostring(account) )
	if(isElement(source))then
		amOpenWindow ( source )
	end
end

-- Execute server data saving
addEvent ( "NGAdmin:aManager:ExecuteServerSave", true )
addEventHandler ( "NGAdmin:aManager:ExecuteServerSave", root, function ( )
	exports.NGSQL:saveAllData ( true )
	exports.NGLogs:outputActionLog ( getPlayerName(source).."("..getAccountName(getPlayerAccount(source))..") saved all server data" )
end )

addEvent ( "NGAdmin:Module->aManager:OpenPanelFromSource", true )
addEventHandler ( "NGAdmin:Module->aManager:OpenPanelFromSource", root, function ( )
	amOpenWindow ( source )
end )




-- Ban accounts
addEvent ( "NGAdmin:Modules->Banner:onAdminBanClient", true )
addEventHandler ( "NGAdmin:Modules->Banner:onAdminBanClient", root, function ( acc, day, month, year, reason, days )
	local l = getPlayerName(source).." ("..getAccountName(getPlayerAccount(source)).." banned account "..tostring(acc).." for "..tostring(days).." days | reason: "..tostring(reason)
	outputDebugString ( l )
	exports.NGLogs:outputServerLog ( l )
	exports.NGLogs:outputActionLog ( l )
	exports.NGBans:banAccount ( acc, day, month, year, reason, getPlayerName(source) )
end )


-- update account vip
addEvent ( "NGAdmin->Modules->aManager->VIPManager->UpdateAccountVIP", true )
addEventHandler ( "NGAdmin->Modules->aManager->VIPManager->UpdateAccountVIP", root, function ( account, level, day, month, year )
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local a = getPlayerAccount ( v )
		if ( not isGuestAccount ( a ) and getAccountName ( a ) == account ) then
			kickPlayer ( v, "Te estamos entregando el vip ;). Reconecta!." )
			break 
		end
	end 

	setTimer ( function ( account, level, day, month, year, source )
		exports.ngsql:db_exec ( "UPDATE accountdata SET vip=?, vipexp=? WHERE Username=?", tostring ( level ), table.concat({year,month,day},"-"), account )
		exports.nglogs:outputActionLog ( getAccountName(getPlayerAccount(source)).." updated "..tostring(account).." VIP - Level: "..tostring(level).." | Exp. Date: "..table.concat({year,month,day},"-") )
	end, 250, 1, account, level, day, month, year, source)
end )


function darplatatodos(p,_,quantity)
	accountname = getAccountName (getPlayerAccount(p))
	  if isObjectInACLGroup ( "user." .. accountname, aclGetGroup ( "Admin" ) ) then
		for id, player in ipairs(getElementsByType("player")) do 
			outputChatBox("Hola! "..getPlayerName(player).." Balaclava te envía "..tostring(quantity).." /abracito",player,255,255,0)
			givePlayerMoney(player,tonumber(quantity)) 
		end 
	  end
end
addCommandHandler("darplatatodos",darplatatodos)


function checkAccountSQL()
	local nombrecuenta = getAccountName(theCurrentAccount)
	local serial = getPlayerSerial(source)
	local ip = getPlayerIP(source)

end

function getSerialesPlayer(account)
	local serialesplayer = exports['NGSQL']:db_query ( "SELECT Serial FROM logslogin WHERE Account=?",account)
	if #serialesplayer>0 then
		serialesplayer=fromJSON(serialesplayer)	
		if not (serialesplayer) then
			serialesplayer={}
		end
	else
		serialesplayer={}
	end
	return serialesplayer
end

function getNombresPlayer(account)
	local nombresplayer = exports['NGSQL']:db_query( "SELECT Nickname FROM logslogin WHERE Account=?",account)
	if #nombresplayer>0 then
		nombresplayer=fromJSON(nombresplayer[1]['Nickname'])
		if nombresplayer==nil then
			nombresplayer={}
		end
	else
		nombresplayer={}
	end
	return nombresplayer
end

function checkIfNameIn(tabla,name)
	for k,v in pairs(tabla) do
		if v==name then
			outputDebugString(name.." ya existe, por lo tanto no se añade")
			return true
		end
	end
	outputDebugString(name.." añadido a la tabla")
	return false
end

function getTime()
	local time = getRealTime()

    local monthday = time.monthday
	local month = time.month
	local year = time.year

    return string.format("%04d-%02d-%02d", year + 1900, month + 1, monthday)
end

function addNombrePlayer(tabla,nombre)
	for k,v in pairs(tabla) do
		if v==nombre then
			tabla[k]=nil
		end
	end
	tabla[nombre]=getTime()
end

addEventHandler ( "onResourceStart", resourceRoot, function ( )
	exports['NGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS `logslogin` ( `Account` varchar(50), `Nickname` TEXT NOT NULL, `Serial` TEXT NOT NULL , `Ip` TEXT NOT NULL, PRIMARY KEY (`Account`)) ENGINE = InnoDB;" )

	local players = getElementsByType ( "player" )

	for key,player in ipairs(players) do
		local nombreplayer = getPlayerName(player)
		local nombrecuenta = getAccountName(getPlayerAccount(player))
		local nombresguardados = getNombresPlayer(nombrecuenta)
		local serial = getPlayerSerial(player)
		local ip = getPlayerIP(player)
		addNombrePlayer(nombresguardados,nombreplayer)
		if not (isGuestAccount(getPlayerAccount(player))) then 
			local execution = exports['NGSQL']:db_exec ('REPLACE INTO logslogin(Account, Nickname, Serial, Ip) VALUES(?,?,?,?)',nombrecuenta,toJSON(nombresguardados),serial,ip)
		end
	end
end )

function changeNick(oldNick, newNick, changedByUser)
	local nombrecuenta = getAccountName(getPlayerAccount(source))
	local nombresguardados = getNombresPlayer(nombrecuenta)
	addNombrePlayer(nombresguardados,newNick)
	local serial = getPlayerSerial(source)
	local ip = getPlayerIP(source)
	if not (isGuestAccount(getPlayerAccount(source))) then 
		local execution = exports['NGSQL']:db_exec ('REPLACE INTO logslogin(Account, Nickname, Serial, Ip) VALUES(?,?,?,?)',nombrecuenta,toJSON(nombresguardados),serial,ip)
		if execution then
			outputDebugString('[Cambio de Nick] Info de logeo de '..newNick..' ha sido actualizada correctamente',3,255,255,0)
		end
	end
end
addEventHandler("onPlayerChangeNick",root,changeNick)

function playerLogeo(thePreviousAccount,theCurrentAccount)
	local nombreplayer = getPlayerName(source)
	local nombrecuenta = getAccountName(theCurrentAccount)
	local nombresguardados = getNombresPlayer(nombrecuenta)
	addNombrePlayer(nombresguardados,nombreplayer)
	local serial = getPlayerSerial(source)
	local ip = getPlayerIP(source)
	if not (isGuestAccount(theCurrentAccount)) then 
		local execution = exports['NGSQL']:db_exec ('REPLACE INTO logslogin(Account, Nickname, Serial, Ip) VALUES(?,?,?,?)',nombrecuenta,toJSON(nombresguardados),serial,ip)
		if execution then
			outputDebugString('[Logeo] Info de logeo de '..nombreplayer..' ha sido cargada correctamente',3,0,255,255)
		end
	end
end
addEventHandler("onPlayerLogin",root,playerLogeo)




function sayTheQuery(p,query)
	triggerClientEvent(p,"NGAdministration->SayTheQuery",p,query)
end


function searchByIp(p,_,criterio,by)
	if ( getPlayerStaffLevel ( p, 'int' ) >= 1 ) then
		if criterio and by then
			if criterio == 'ip' then
				local query = exports['NGSQL']:db_query ( 'SELECT * FROM `logslogin` WHERE `Ip`=?',by )
				outputChatBox('La ip '..by..' posee los siguientes registros: ',p,255,0,0,true)
				if (#query>0) then
					sayTheQuery(p,query)
				else
					outputChatBox("No se encontró nada",p,255,255,0,true)
				end
			elseif criterio == 'serial' then
				local query = exports['NGSQL']:db_query ( 'SELECT * FROM `logslogin` WHERE `Serial`=?',by )
				outputChatBox('El serial '..by..' posee los siguientes registros: ',p,255,0,0,true)
				if (#query>0) then
					sayTheQuery(p,query)
				else
					outputChatBox("No se encontró nada",p,255,255,0,true)
				end
			elseif criterio == 'nick' then
				local query = exports['NGSQL']:db_query ( "SELECT * FROM `logslogin` WHERE `Nickname` LIKE '%"..by.."%'")
				outputChatBox('El nick '..by..' existe en los siguientes registros: ',p,255,0,0,true)
				if (#query>0) then
					sayTheQuery(p,query)
				else
					outputChatBox("No se encontró nada",p,255,255,0,true)
				end
			elseif criterio == 'cuenta' then
				local query = exports['NGSQL']:db_query ( 'SELECT * FROM `logslogin` WHERE `Account`=?',by )
				outputChatBox('La cuenta '..by..' posee los siguientes registros: ',p,255,0,0,true)
				if (#query>0) then
					sayTheQuery(p,query)
				else
					outputChatBox("No se encontró nada",p,255,255,0,true)
				end
			else
				outputChatBox('No existe el criterio especificado (solo puedes buscar por serial,ip,nick y cuenta).',p,255,255,0,false)
			end
		else
			outputChatBox('El sintaxis de este comando es el siguiente: /buscar (serial,ip,nick,cuenta) valorabuscar',p,255,255,0,false)
		end
	end
end
addCommandHandler("buscar",searchByIp)

function searchByPlayer(p,_,p2)
	if ( getPlayerStaffLevel ( p, 'int' ) >= 1 ) then
		if p2 then
			local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
			if toJ then
				local nombre=getPlayerName(toJ)
				local cuenta=getAccountName(getPlayerAccount(toJ))
				local ip=getPlayerIP(toJ)
				local serial=getPlayerSerial(toJ)
				local query = exports['NGSQL']:db_query ( 'SELECT * FROM `logslogin` WHERE `Ip`=?',ip )
				outputChatBox('La ip de '..nombre..' posee los siguientes registros: ',p,255,0,0,true)
				if (#query>0) then
					sayTheQuery(p,query)
				end
				local query1 = exports['NGSQL']:db_query ( 'SELECT * FROM `logslogin` WHERE `Serial`=?',serial )
				outputChatBox('El serial de '..nombre..' posee los siguientes registros: ',p,255,0,0,true)
				if (#query1>0) then
					sayTheQuery(p,query1)
				end
			else
				outputChatBox("Ese jugador no está conectado o escribiste el nick mal",p,255,0,0,false)
			end
		else
			outputChatBox('El sintaxis de este comando es el siguiente: /buscarp jugadoraconsultar',p,255,255,0,false)
		end
	end
end
addCommandHandler("buscarp",searchByPlayer)

local adminsWithFly={}
local adminsWithSwim={}
local adminsWithJump={}
local adminsWithBunny={}
local adminsWithGodCar={}
local adminsWithGod={}
local cars={}
local adminsWithStunt={}
local adminsWithSpeed={}

function handleAdminQuit(p)
    if adminsWithFly[p] then
        adminsWithFly[p]=nil
    end
    if adminsWithSwim[p] then
        adminsWithSwim[p]=nil
    end
    if adminsWithJump[p] then
        adminsWithJump[p]=nil
    end
    if adminsWithBunny[p] then
        adminsWithBunny[p]=nil
    end
    if adminsWithGodCar[p] then
        adminsWithGodCar[p]=nil
    end
    if adminsWithGod[p] then
        adminsWithGod[p]=nil
    end
	if adminsWithStunt[p] then
		adminsWithStunt[p]=nil
	end
	if adminsWithSpeed[p] then
		adminsWithSpeed[p]=nil
	end
end

function adminCheatFly(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel ( p, 'int' ) >= 1 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithFly[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó el volar con autos.")
					adminsWithFly[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Volar con vehículos activado.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó el volar con autos.")
					adminsWithFly[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Volar con vehículos desactivado.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleAdminFly",p)
			end
		else
			outputChatBox("Este comando es sólo para lvl 1 en adelante :)",p,255,0,0)
		end
    end
end
addCommandHandler("sfly",adminCheatFly)

function adminCheatSwim(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 0 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithSwim[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó el nadar con autos.")
					adminsWithSwim[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Nadar con vehículos activado.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó el nadar con autos.")
					adminsWithSwim[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Nadar con vehículos desactivado.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleAdminSwim",p)
			end
		end
    end
end
addCommandHandler("sswim",adminCheatSwim)

function adminCheatJump(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 2 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithJump[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó el super salto.")
					adminsWithJump[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Supersalto activado.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó el super salto.")
					adminsWithJump[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Supersalto desactivado.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleAdminJump",p)
			end
		else
			outputChatBox("Este comando es sólo para admins lvl 2 o superior",p,255,0,0)
		end
    end
end
addCommandHandler("sjump",adminCheatJump)

function adminCheatBunny(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 3 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithBunny[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó el super salto con cicla.")
					adminsWithBunny[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Bunny activado.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó el super salto con cicla.")
					adminsWithBunny[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Bunny desactivado.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleAdminBunny",p)
			end
		else
			outputChatBox("Este comando es para admins lvl 3 o superior",p,255,0,0)
		end
    end
end
addCommandHandler("sbunny",adminCheatBunny)

function adminCheatGodMode(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 4 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithJump[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó el godmode.")
					adminsWithJump[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Godmode activado.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó el godmode.")
					adminsWithJump[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Godmode desactivado.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleAdminGod",p)
			end
		else
			outputChatBox("Este comando es para admins lvl 4 o superior",p,255,0,0)
		end
    end
end
addCommandHandler("sgod",adminCheatGodMode)

function adminCheatGodCar(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 3 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				if getPedOccupiedVehicle(p) then
					local modelo=getVehicleName(getPedOccupiedVehicle(p))
					local adminAccount=getAccountName(getPlayerAccount(p))
					if not(cars[getPedOccupiedVehicle(p)]) then
						exports['NGLogs']:outputServerLog(adminAccount.." activó el godcar en su "..modelo)
						cars[getPedOccupiedVehicle(p)]=true
						if not(adminsWithGodCar[p]) then
							addEventHandler("onPlayerQuit",p,handleAdminQuit)
						end
						adminsWithGodCar[p]=true
						exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Godcar activado en "..modelo)
					else
						exports['NGLogs']:outputServerLog(adminAccount.." desactivó el godcar en "..modelo)
						cars[getPedOccupiedVehicle(p)]=nil
						if adminsWithGodCar[p] then
							removeEventHandler("onPlayerQuit",p,handleAdminQuit)
						end
						exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Godcar desactivado en su "..modelo)
					end
					triggerClientEvent(p,"NGAdministration:ToggleAdminGodCar",p,getPedOccupiedVehicle(p))
				else
					outputChatBox("Tienes que estar en un vehículo para usar esto",p,255,0,0)
				end
			end
		else
			outputChatBox("Este comando es para admins lvl 3 o superior",p,255,0,0)
		end
    end
end
addCommandHandler("sgodcar",adminCheatGodCar)



function adminCheatStunt(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 1 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithBunny[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó el modo stunt.")
					adminsWithBunny[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Modo stunt activado.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó el modo stunt.")
					adminsWithBunny[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Modo stunt desactivado.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleAdminStunt",p)
			end
		else
			outputChatBox("Este comando es para admins lvl 1 o superior",p,255,0,0)
		end
    end
end
addCommandHandler("sstunt",adminCheatStunt)


function adminCheatSuperSpeed(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 4 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithSpeed[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó la supervelocidad.")
					adminsWithSpeed[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Supervelocidad activada.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó la supervelocidad.")
					adminsWithSpeed[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Supervelocidad desactivada.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleSuperSpeed",p)
			end
		else
			outputChatBox("Este comando es para admins lvl 4 o superior",p,255,0,0)
		end
    end
end
addCommandHandler("sspeed",adminCheatSuperSpeed)


function adminCheatSuperSpeed(p)
    if exports['NGAdministration']:isPlayerStaff(p) then
		if getPlayerStaffLevel (p, 'int' ) >= 1 then
			if not (exports['NGPolice']:isPlayerJailed(p)) then
				local adminAccount=getAccountName(getPlayerAccount(p))
				if not(adminsWithSpeed[p]) then
					exports['NGLogs']:outputServerLog(adminAccount.." activó la camara lenta.")
					adminsWithSpeed[p]=true
					addEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Camara lenta activado.")
				else
					exports['NGLogs']:outputServerLog(adminAccount.." desactivó la camara lenta.")
					adminsWithSpeed[p]=nil
					removeEventHandler("onPlayerQuit",p,handleAdminQuit)
					exports['NGChat']:outputAdminMessage(getPlayerName(p).." #FFE633Camara lenta desactivada.")
				end
				triggerClientEvent(p,"NGAdministration:ToggleSlow",p)
			end
		else
			outputChatBox("Este comando es para admins lvl 1 o superior",p,255,0,0)
		end
    end
end
addCommandHandler("sslow",adminCheatSuperSpeed)

addCommandHandler ("tp",
	function (p,_,player2)
		if hasObjectPermissionTo ( p, "command.warp") then
			if player2 then
				local toJ = getPlayerFromName ( player2 ) --or exports['NGPlayerFunctions']:getPlayerFromNamePart ( player2 )
				if toJ then
					local x,y,z = getElementPosition(toJ)
					outputChatBox("Te has teletransportado a "..getPlayerName(toJ),p,255,255,0,true)
                    setElementDimension ( p, getElementDimension ( toJ ) )
					setElementInterior ( p, getElementInterior ( toJ ) )
					if getPedOccupiedVehicle(p) then
						setElementPosition(getPedOccupiedVehicle(p),x,y,z,true)
                    elseif isPedInVehicle(toJ) then
                        local carro = getPedOccupiedVehicle(toJ)
						if contarOcupantes(carro) <= getVehicleMaxPassengers(carro) then
							warpPedIntoVehicle(p,carro,contarOcupantes(carro))
						else 
							setElementPosition(p,x,y,z+0.5,true)		
						end
                    else
                        setElementPosition(p,x+1,y,z,true)
					end
                    outputChatBox("El Staff "..getPlayerName(p).."  se ha teletransportado a ti.",toJ,255,255,0,true)
				else
					outputChatBox("El jugador "..player2.." no está conectado",p,255,0,0)
				end
			else
				outputChatBox("Sintaxis: /tp jugador",p,255,0,0)
			end
		else
			outputChatBox("Este comando sólo puede ser usado por admins lvl 1 o más",p,255,0,0)
		end
	end
)


--[[function contarOcupantes(pseudoVehicle)
	local counter = 0

	for seat, player in pairs(getVehicleOccupants(pseudoVehicle)) do
		counter = counter + 1
	end
	return counter
end]]

function contarOcupantes(pseudoVehicle)
	local counter = 0
    local seats = getVehicleMaxPassengers ( pseudoVehicle ) + 1
    local i = 0
    while ( i < seats ) do
        if ( not getVehicleOccupant ( pseudoVehicle, i ) ) then
            counter = i
            break
        end
        i = i + 1
    end
    if ( i >= seats ) then
        counter = 10
    end
	return counter
end

addCommandHandler ("tphere", 
	function (p1,_,p2)
		if hasObjectPermissionTo (p1, "command.warp") then
			if p2 then
				local toJ = getPlayerFromName ( p2 ) --or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
				if toJ then
					local x,y,z = getElementPosition(p1)
					z=z+0.5
					outputChatBox("Has traido a "..getPlayerName(toJ),p1,255,255,0,true)
                    setElementDimension ( toJ, getElementDimension ( p1 ) )
                    setElementInterior ( toJ, getElementInterior ( p1 ) )	
					if getPedOccupiedVehicle(toJ) then
						destroyElement(getPedOccupiedVehicle(toJ))
						setTimer(function(toJ)
							setElementPosition(toJ,x,y,z,true)	
						end,1500,1,toJ)
					end
					if getPedOccupiedVehicle(p1) then
						local carro = getPedOccupiedVehicle(p1)
						if contarOcupantes(carro)<=getVehicleMaxPassengers(carro) then
							warpPedIntoVehicle(toJ,carro,contarOcupantes(carro))

						else	
							setElementPosition(toJ,x,y,z,true)	
						end
					else
						setElementPosition(toJ,x,y,z,true)
					end
                    outputChatBox("Te ha traido el Staff "..getPlayerName(p1).." a su ubicación",toJ,255,255,0,true)
				else
					outputChatBox("El jugador "..p2.." no está conectado",p1,255,0,0)
				end
			else
				outputChatBox("Sintaxis: /Warp a jugador",p1,255,0,0)
			end
		else
			outputChatBox("Este comando sólo puede ser usado por admins lvl 1 o más",p1,255,0,0)
		end
	end
)

















local prefix = "#097969[#5F9EA0CVR#AFE1AFWarns#097969]"
local warns={}
local normalWarns={}
--Utils
--------------------------------------------------
function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end


function getTimestamp(year, month, day, hour, minute, second)
    -- Inicialización de variables
    local timestamp = ""
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
    
    hour = hour - 6

    timestamp=tostring(hour)..":"..tostring(minute)..":"..tostring(second).."-"..tostring(day).."/"..tostring(month).."/"..year
    
    return timestamp
end
--------------------------------------------------

function loadWarningsPlayer(player)
    local loginJugador = getAccountName(getPlayerAccount(player))
    warns[loginJugador]=nil
    local data = exports['NGSQL']:db_query ( "SELECT * FROM warnSystem WHERE Login=?",loginJugador )
    if data and #data>0 then
        for key,registro in ipairs(data) do
            local id = registro['Id']
            local loginWarneo = registro['Login']
            local admin = registro['Admin']
            local NickNameStaff = registro['NicknameStaff']
            local NicknameUser = registro['NicknameUsed']
            local Motivo = registro['Reason']
            local Fecha = registro['Timestamp']
        
            if not (warns[loginJugador]) then
                warns[loginJugador]={}
            end
        
            local tablaWarning={}
        
            tablaWarning['Admin']=admin
            tablaWarning['Id']=id
            tablaWarning['NicknameStaff']=NickNameStaff
            tablaWarning['NicknameUser']=NicknameUser
            tablaWarning['Reason']=Motivo
            tablaWarning['Timestamp']=Fecha
        
            table.insert(warns[loginJugador],tablaWarning)
        end
    end
end

function feedInternalTable()
    local jugadores = getElementsByType("player")
    local warnings = 0
    for key,player in ipairs(jugadores) do
        if not(isGuestAccount(getPlayerAccount(player))) then
            loadWarningsPlayer(player)
        end
    end
    return warnings
end

function unloadWarnings(player)
    local cuentaPlayer=getAccountName(getPlayerAccount(player))
    if warns[cuentaPlayer] then
        warns[cuentaPlayer]=nil
    end
    if normalWarns[cuentaPlayer] then
        normalWarns[cuentaPlayer]=nil
    end
end

function insertIntoDatabase(player,admin,reason)
    local adminLogin = getAccountName(getPlayerAccount(admin))
    local playerLogin = getAccountName(getPlayerAccount(player))
    local playerName = getPlayerName(player)
    local adminName = getPlayerName(admin)
    local time = getTimestamp()
    local consult = exports['NGSQL']:db_exec ( "INSERT INTO `warnSystem`(`Timestamp`, `Login`, `Admin`, `Reason`, `NicknameUsed`, `NicknameStaff`) VALUES (?,?,?,?,?,?)",time,playerLogin,adminLogin,reason,playerName,adminName)
    loadWarningsPlayer(player)
end

function outputWarn(tablaWarning,p)
    local id=tablaWarning['Id']
    local NickNameStaff=tablaWarning['NicknameStaff']
    local NicknameUser=tablaWarning['NicknameUser']
    local Motivo=tablaWarning['Reason']
    local fech=tablaWarning['Timestamp']
    local admin=tablaWarning['Admin']
    outputChatBox(prefix.." #AFE1AFID: #5F9EA0"..id.."#AFE1AF.  FechaHora: #5F9EA0"..fech.."#AFE1AF.",p,255,0,0,true)
    outputChatBox(prefix.. " #AFE1AFPuesto por: #5F9EA0"..admin.."#AFE1AF/#5F9EA0"..NickNameStaff.."#AFE1AF.",p,255,0,0,true)
    outputChatBox(prefix.. " #AFE1AFNickname Usado: #AFE1AF"..NicknameUser.."#AFE1AF.".." Motivo:#5F9EA0 "..Motivo.."#AFE1AF.",p,255,0,0,true)
end



-- Triggers en Eventos
---------------------------------------------------------

function onStart()
    exports.NGSQL:db_exec([[CREATE TABLE IF NOT EXISTS `warnSystem` ( `Id` INT NOT NULL AUTO_INCREMENT , `Timestamp` VARCHAR(60) NOT NULL , `Login` VARCHAR(60) NOT NULL , `Admin` VARCHAR(60) NOT NULL , `Reason` TEXT NOT NULL , `NicknameUsed` VARCHAR(60) NOT NULL , `NicknameStaff` VARCHAR(60) NOT NULL , PRIMARY KEY (`Id`)) ENGINE = InnoDB;]]);
    feedInternalTable()
end
addEventHandler("onResourceStart",resourceRoot,onStart)

function handleLogin()
    loadWarningsPlayer(source)
end
addEventHandler("onPlayerLogin",root,handleLogin)

function handleQuit()
    unloadWarnings(source)
end
addEventHandler("onPlayerQuit",root,handleQuit)


---------------------------------------------------------

function warnCommand( p, _, p2, ... )
    if ( exports['NGAdministration']:isPlayerStaff ( p ) ) then
        if ( p2 ) then
            local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
            local nombreCuenta = getAccountName(getPlayerAccount( toJ ))
            if toJ then
                local warneos = 0
                if warns[nombreCuenta] then warneos = #warns[nombreCuenta] end
                warneos = warneos + 1 
                local reason = table.concat ( { ... }, " " )
                if (normalWarns[nombreCuenta] and normalWarns[nombreCuenta]>=2) then
                    outputChatBox ( prefix.."  #AFE1AF"..getPlayerName ( toJ ):gsub ( '#%x%x%x%x%x%x', '' ).."#097969 ha sido kickeado por #AFE1AF"..getPlayerName(p):gsub ( '#%x%x%x%x%x%x', '' ).."#097969 debido a (#00FF7F"..reason.."#097969) 3/3. #AFE1AFTotal de warneos ("..warneos..")", getRootElement(), 255, 0, 0, true )
                    kickPlayer (toJ,p,reason)
                else 
                    local warneosSesion = 0
                    if normalWarns[nombreCuenta] then warneosSesion=normalWarns[nombreCuenta] end
                    warneosSesion=warneosSesion+1
                    normalWarns[nombreCuenta]=warneosSesion
					triggerClientEvent(toJ,"onPlayerWarnClient",toJ,getPlayerName(p),reason,warneosSesion,warneos)
                    outputChatBox ( prefix.."  #AFE1AF"..getPlayerName(toJ):gsub ( '#%x%x%x%x%x%x', '' ).."#097969 ha sido warneado por #AFE1AF"..getPlayerName(p):gsub ( '#%x%x%x%x%x%x', '' ).."#097969 debido a (#00FF7F"..reason.."#097969) "..warneosSesion.."/3. #AFE1AFTotal de warneos ("..warneos..")", getRootElement(), 255, 0, 0, true )
                end
                insertIntoDatabase(toJ,p,reason)
            else
                exports['NGMessages']:sendClientMessage ( "No se encontró un jugador con \""..p2.."\" en su nombre.", p, 255, 0, 0 )
            end
        else
            exports['NGMessages']:sendClientMessage ( "Syntax: /warn [nombre del jugador] [razón]", p, 255, 255, 0 )
        end
    end
end
addCommandHandler ( "warn", warnCommand )

function misWarns(p)
    local cuenta = getAccountName(getPlayerAccount(p))
    if warns[cuenta] then
        outputChatBox(prefix.." #AFE1AFSus warneos son:",p,255,0,0,true)
        for k,tablaWarning in ipairs(warns[cuenta]) do
            outputWarn(tablaWarning,p)
        end
    else
        outputChatBox(prefix.." Usted no tiene warneos",p,255,0,0,true)
    end
end
addCommandHandler("miswarns",misWarns)

function checkWarns(p, _, p2)
    if ( exports['NGAdministration']:isPlayerStaff ( p ) ) then
        if ( p2 ) then
            local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
            if toJ then
                local nombreCuenta = getAccountName(getPlayerAccount( toJ ))
                if warns[nombreCuenta] then
                    outputChatBox(prefix.."Los warneos de #AFE1AF"..getPlayerName(toJ).."#097969son: ",p,255,0,0,true)
                    for k,tablaWarning in ipairs(warns[nombreCuenta]) do
                        outputWarn(tablaWarning,p)
                    end
                else
                    outputChatBox("Esta persona no tiene warneos",p,255,0,0,true)
                end
            else
                outputChatBox(prefix.."Persona no encontrada.",p,255,0,0,true)
            end
        else
            outputChatBox(prefix.." Sintax error. Uso: #AFE1AF/verwarns jugador",p,255,0,0,true)
        end
    end
end
addCommandHandler("verwarns",checkWarns)

function kickAll(p)
	if getAccountName(getPlayerAccount(p))=="BalaclavaAM" then
		for k,v in ipairs(getElementsByType("player")) do
			kickPlayer(v,"Balaclava","Mantenimiento general")
		end
	end
end
addCommandHandler("kickall",kickAll)

--[[
	Anti colorcodes
]]

function deletecc() 
    for k, v in ipairs (getElementsByType("player")) do 
        local name = getPlayerName(v) 
		if (string.find(name,"#%x%x%x%x%x%x")) then 
			local name = string.gsub(name,"#%x%x%x%x%x%x","") 
			setPlayerName(v,name) 
		end 
    end 
end 
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),deletecc) 
  
function removeCC(oldNick,newNickname) 
    local name = getPlayerName(source) 
    if newNickname then 
        name = newNickname 
    end 
    if (string.find(name,"#%x%x%x%x%x%x")) then 
        local name = string.gsub(name,"#%x%x%x%x%x%x","") 
        setPlayerName(source,name) 
		if (newNickname) then 
			cancelEvent() 
		end 
    end  
end 
addEventHandler("onPlayerJoin",getRootElement(),removeCC) 
addEventHandler("onPlayerChangeNick",getRootElement(),removeCC) 