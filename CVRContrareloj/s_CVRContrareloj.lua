exports.NGSQL:db_exec([[CREATE TABLE IF NOT EXISTS racedata ( Username VARCHAR(200), besttime INT, race VARCHAR(20), club VARCHAR(20) )]]);


local prefix="#870000[#F18E8ECVRContrareloj#870000]#FFFFFF"
local startcoords={}

startcoords['Akina']={-3307.67, 876.31, 320.89,358.76928710938, 359.92431640625, 139.94030761719}
startcoords['Bigear']={-302.6, 1513.71, 75.36,359.54052734375 , 359.99975585938 , 183.01892089844}
startcoords['Hotel']={1966.57, 1764.75, 12.26,0.44622322916985, 0.00038359529571608, 271.26150512695}
startcoords['SFRun']={-2159.41, 317.84, 34.69,  359.51135253906, 359.99975585938, 270.03576660156}
startcoords['HotelSpiral']={2223.68, 1964.33, 31.3,359.54028320313, 359.99951171875, 269.96179199219}
startcoords['Parking']={2326.66, 1391.64, 42.33, 0.4737283885479, 0.00071944249793887, 357.29214477539}
startcoords['Parking2']={2387.73, 2545.86, 10.08,359.99987792969, 0.00030517578125 , 182.47485351562}
startcoords['tsan']={2141.9, -2856.38, 1002.92,0,0,8}
local cars={
}

local racers={
}

function deleteCar(player)
    destroyElement(cars[player])
    cars[player]=nil
end


function openMenu(hitElement, md)
    if getElementType(hitElement)=="player" and md then
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

local marker4=createMarker(-2161.43, 312.89, 34.32,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker4,"Race","SFRun")
addEventHandler("onMarkerHit",marker4,openMenu)

local marker5=createMarker(2243.14, 1970.7, 31.01,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker5,"Race","HotelSpiral")
addEventHandler("onMarkerHit",marker5,openMenu)

local marker6=createMarker(2320.69, 1393.57, 41.82,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker6,"Race","Parking")
addEventHandler("onMarkerHit",marker6,openMenu)

local marker7=createMarker(2380.7, 2555.79, 9.82,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker7,"Race","Parking2")
addEventHandler("onMarkerHit",marker7,openMenu)

local marker8=createMarker(2137.83, -2867.18, 1002.7,"cylinder", 1.5, 255, 100, 0, 170)
setElementData(marker8,"Race","tsan")
addEventHandler("onMarkerHit",marker8,openMenu)


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
                local club=getElementData(player,"Club") or "NoNe"
                updateGreatestTime(time,accname,racename,club)
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
            setTimer(function(player,x,y,z)
                setElementPosition(player,x-3,y,z)
            end,1500,1,player,x,y,z)
        else
            endMinigameError(player)
        end
    else
        endMinigameError(player)
    end
end
addEvent("serverWin",true)
addEventHandler("serverWin",root,endMinigameWin)

function updateGreatestTime(time,accname,racename,club)
    return exports['NGSQL']:db_exec ( "UPDATE `racedata` SET `besttime`=?, `club`=? WHERE Username=? and race=?",time,club,accname,racename )
end

function getBestTimes(player,race)
    local acc=getPlayerAccount(player)
    local data = exports['NGSQL']:db_query ( "SELECT * FROM `racedata` WHERE race=? ORDER BY `racedata`.`besttime` ASC",race )
    local data2 = exports['NGSQL']:db_query ( "SELECT * FROM racedata WHERE Username=? LIMIT 1", getAccountName ( acc ) )
    local greatestTime = 'Mejor tiempo: No registrado'
    if ( type ( data2 ) == "table" or #data > 0 ) then
        local info=exports['NGSQL']:db_query ( "SELECT besttime FROM racedata WHERE Username=? and race=?", getAccountName ( acc ),race )
        if info[1] then
            local besttime = info[1]['besttime']
            greatestTime = ('Mejor tiempo:'..secondsToTimeDesc(besttime/1000))
        end
    end
    local gangdominante=getBestGangforRace(race)
    triggerClientEvent(player,"AlimentarTabla",player,data,greatestTime,gangdominante)
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


function startMinigame(player,race)
    if getElementData(player,"Job")=="Drifter" then
        local elclub=getElementData(player,"Club") or "NoNe"
        racers[player]=race
        local acc=getPlayerAccount(player)
        local data = exports['NGSQL']:db_query ( "SELECT * FROM racedata WHERE Username=? and race=? LIMIT 1", getAccountName ( acc ), race )
        if ( type ( data ) ~= "table" or #data < 1 ) then
            exports['NGSQL']:db_exec ( "INSERT INTO racedata ( `Username`, `besttime`, `race`, `club`) VALUES ( ?,?,?,? );", getAccountName ( acc ),99999999999,race,elclub)
        end
        local data=exports['NGSQL']:db_query ( "SELECT besttime FROM racedata WHERE Username=? and race=?", getAccountName ( acc ),race )
        local greatestTime = data[1]['besttime']
        triggerClientEvent(player,"sendGreatestTime",player,greatestTime)
        local x,y,z,xr,yr,zr=startcoords[race][1],startcoords[race][2],startcoords[race][3],startcoords[race][4],startcoords[race][5],startcoords[race][6]
        cars[player]=createVehicle(562,x,y,z,xr,yr,zr,"CVRTime", false)
        setVehicleLocked(cars[player],true)
        warpPedIntoVehicle(player,cars[player])
        addEventHandler("onPlayerVehicleExit",player,exitHandler)
        addEventHandler("onPlayerQuit",player,deleteCar)
        setElementFrozen(cars[player],true)
        setTimer(function(carro)
            setElementFrozen(carro,false)
            triggerClientEvent(player,"CreateClientCheckpoints",player,race)
            triggerClientEvent(player,"activarAntiChoque",player,cars[player])
        end,3000,1,cars[player])
    else
        outputChatBox(prefix.." Tienes que tener job de drifter para jugar",player,255,0,0,true)
    end
end
addEvent("startMinigameServer",true)
addEventHandler("startMinigameServer",root,startMinigame)

function getBestGangforRace(race)
    local data,last = exports['NGSQL']:db_query ( "SELECT * FROM racedata WHERE race=? ORDER BY `besttime` ASC LIMIT 20", race )
    local retorno = "None"
    if ( type ( data ) == "table" and #data >0 ) then
        local tablaxd={}
        for k,v in ipairs(data) do
            local gang=data[k]['club']
            if gang~="NoNe" and gang~=nil then
                if not (tablaxd[gang]) then 
                    tablaxd[gang]=0 
                end
                local points=tonumber(data[k]['besttime'])
                tablaxd[gang]=tablaxd[gang]+(data[last]['besttime']/points)
            end
        end
        local bestgang=""
        local bestpoints=0
        for gang,points in pairs(tablaxd) do
            if points>bestpoints then
                bestgang=gang
                bestpoints=points
            end
        end
        retorno = bestgang
    end
    return retorno
end