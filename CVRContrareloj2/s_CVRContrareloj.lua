local connection
local driftRecords = {}
local loadedClients = {}
local recordListMaxPosition = 50

function initScript()

	connection = dbConnect ("sqlite",":/momos.db")
	dbExec(connection,"CREATE TABLE IF NOT EXISTS racedata ( Username VARCHAR(200), besttime INT, race VARCHAR(20) )")
	
	
end

addEventHandler("onResourceStart",root,initScript)




local prefix="#870000[#F18E8ECVRContrareloj#870000]#FFFFFF"
local startcoords={}

startcoords['Akina']={-3307.67, 876.31, 320.89,358.76928710938, 359.92431640625, 139.94030761719}
startcoords['Bigear']={-302.6, 1513.71, 75.36,359.54052734375 , 359.99975585938 , 183.01892089844}
startcoords['Hotel']={1966.57, 1764.75, 12.26,0.44622322916985, 0.00038359529571608, 271.26150512695}

local cars={
}

local racers={
}

function deleteCar(player)
    destroyElement(cars[player])
    cars[player]=nil
end


function openMenu(hitElement)
    if getElementType(hitElement)=="player" then
        local race=getElementData(source,"Race")
        getBestTimes(hitElement,race)
        triggerClientEvent(hitElement,"openClientMenu",hitElement,race)
    end
end

local marker=createMarker(-305.12, 1537.04, 74.56,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker,"Race","Bigear")
addEventHandler("onMarkerHit",marker,openMenu)

local marker2=createMarker(-3311.69, 859.61, 319.61,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker2,"Race","Akina")
addEventHandler("onMarkerHit",marker2,openMenu)

local marker3=createMarker(1985.97, 1757.9, 10.45,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker3,"Race","Hotel")
addEventHandler("onMarkerHit",marker3,openMenu)

function secondsToTimeDesc( seconds )
	if seconds then
		local results = {}
		local sec = ( seconds %60 )
		local min = math.floor ( ( seconds % 3600 ) /60 )
		local hou = math.floor ( ( seconds % 86400 ) /3600 )
		local day = math.floor ( seconds /86400 )
		
		if day > 0 then table.insert( results, day .. ( day == 1 and " dia" or " días" ) ) end
		if hou > 0 then table.insert( results, hou .. ( hou == 1 and " hora" or " horas" ) ) end
		if min > 0 then table.insert( results, min .. ( min == 1 and " minuto" or " minutos" ) ) end
		if sec > 0 then table.insert( results, sec .. ( sec == 1 and " segundo" or " segundos" ) ) end
		
		return string.reverse ( table.concat ( results, ", " ):reverse():gsub(" ,", " y ", 1 ) )
	end
	return ""
end


function endMinigameWin(player,time,besttime,racename)
    if getPedOccupiedVehicle(player) then
        if getPedOccupiedVehicle(player) == cars[player] then
            if time<besttime then
                local acc=getPlayerAccount(player)
                local accname=getAccountName(acc)
                updateGreatestTime(time,accname,racename)
                outputChatBox(prefix.."Superaste tu tiempo de #CA0505"..secondsToTimeDesc(besttime/1000).." #FFFFFFpor #CA0505"..secondsToTimeDesc((besttime-time)/1000),player,255,0,0,true)
                if (besttime-time)/1000<60 then
                    outputChatBox(prefix.."El jugador #CA0505"..getPlayerName(player).." #FFFFFFregistró un tiempo de #CA0505"..secondsToTimeDesc((time)/1000).." #FFFFFF en la carrera #CA0505"..racename.." #FFFFFFintenta superar su record!",root,255,0,0,true)
                end
            end    
            destroyElement(cars[player])
            cars[player]=nil
            removeEventHandler("onPlayerQuit",player,deleteCar)
            outputChatBox(prefix.."Lograste un tiempo de: #CA0505 "..secondsToTimeDesc(time/1000),player,255,0,0,true)
            outputChatBox(prefix.."Se te ha añadido 1 acción drifter",player,255,0,0,true)
            exports['NGJobs']:updateJobColumn(player, "DriftPoints", "AddOne")
            removeEventHandler("onPlayerVehicleExit",player,exitHandler)
            local x,y,z=startcoords[racename][1],startcoords[racename][2],startcoords[racename][3]
            setElementPosition(player,x,y,z)
        else
            endMinigameError(player)
        end
    else
        endMinigameError(player)
    end
end
addEvent("serverWin",true)
addEventHandler("serverWin",root,endMinigameWin)

function updateGreatestTime(time,accname,racename)
    return dbExec(connection, "UPDATE `racedata` SET `besttime`=? WHERE Username=? and race=?",time,accname,racename )
end

function getBestTimes(player,race)
    local acc=getPlayerAccount(player)
    local data = dbQuery(connection,"SELECT * FROM `racedata` WHERE race=? ORDER BY `racedata`.`besttime` ASC", race)
    local data2 = dbQuery(connection, "SELECT * FROM racedata WHERE Username=? LIMIT 1", getAccountName ( acc ) )
    dbFree(data)
    outputChatBox(data)
    local greatestTime = 'Mejor tiempo: No registrado'
    if ( type ( data2 ) == "table" or #data > 0 ) then
        local info=dbQuery(connection, "SELECT besttime FROM racedata WHERE Username=? and race=?", getAccountName ( acc ),race )
        if info[1] then
            local besttime = info[1]['besttime']
            greatestTime = ('Mejor tiempo:'..secondsToTimeDesc(besttime/1000))
        end
    end
    triggerClientEvent(player,"AlimentarTabla",player,data,greatestTime)
end

function endMinigameError(player)
    local race = racers[player]
    local x,y,z=startcoords[race][1],startcoords[race][2],startcoords[race][3]
    setElementPosition(player,x,y,z)
    triggerClientEvent(player,"ForceEnd",player)
    destroyElement(cars[player])
    cars[player]=nil
    removeEventHandler("onPlayerVehicleExit",player,exitHandler)
    removeEventHandler("onPlayerQuit",player,deleteCar)
end


function exitHandler(theVehicle,seat,jacker,forcedByScript)
    endMinigameError(source)
end

local turno=false

function startMinigame(player,race)
    if not turno then
        racers[player]=race
        local acc=getPlayerAccount(player)
        local data = dbQuery(connection, "SELECT * FROM racedata WHERE Username=? and race=? LIMIT 1", getAccountName ( acc ), race )
        if ( type ( data ) ~= "table" or #data < 1 ) then
            dbExec(connection, "INSERT INTO racedata ( `Username`, `besttime`, `race`) VALUES ( '"..getAccountName ( acc ) .."', '99999999999', '"..race.."' );" )
        end
        local data=dbQuery(connection, "SELECT besttime FROM racedata WHERE Username=? and race=?", getAccountName ( acc ),race )
        local greatestTime = data[1]['besttime']
        triggerClientEvent(player,"sendGreatestTime",player,greatestTime)
        local x,y,z,xr,yr,zr=startcoords[race][1],startcoords[race][2],startcoords[race][3],startcoords[race][4],startcoords[race][5],startcoords[race][6]
        cars[player]=createVehicle(562,x,y,z,xr,yr,zr,"CVRTime", false)
        warpPedIntoVehicle(player,cars[player])
        addEventHandler("onPlayerVehicleExit",player,exitHandler)
        addEventHandler("onPlayerQuit",player,deleteCar)
        setElementFrozen(cars[player],true)
        turno=true
        setTimer(function(carro)
            setElementFrozen(carro,false)
            triggerClientEvent(player,"CreateClientCheckpoints",player,race)
            triggerClientEvent(player,"activarAntiChoque",player,cars[player])
            setTimer(function() 
                turno=false 
            end,1500,1)
        end,3000,1,cars[player])
    else
        outputChatBox(prefix.." Hay alguien en la línea de salida. Espera que este jugador salga y pide tu turno",player,255,0,0,true)
    end
end
addEvent("startMinigameServer",true)
addEventHandler("startMinigameServer",root,startMinigame)