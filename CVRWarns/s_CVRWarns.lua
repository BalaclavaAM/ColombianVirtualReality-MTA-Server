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