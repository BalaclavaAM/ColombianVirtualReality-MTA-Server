local pt = { }

exports.scoreboard:scoreboardAddColumn ( "Playtime", root, 50 )
addEventHandler ( "onResourceStart", resourceRoot, function ( )
	getAdminsStart()
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		pt [ v ] = 0
		local x = tonumber ( getElementData ( v, "PlayerFunct:HiddenPTMins" ) )
		if ( x ) then
			pt [ v ] = x
		end
	end
end )


addEventHandler ( "onResourceStop", resourceRoot, function  ( )
	saveAdminStop()
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local x = 0
		if ( pt [ v ] ) then
			x = pt [ v ]
		end
		setElementData ( v, "PlayerFunct:HiddenPTMins", x )
	end
end )

setTimer ( function ( ) 
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		if ( not pt [ v ] ) then
			pt [ v ] = 0
		end
		pt [ v ] = pt [ v ]  + 1
		updatePlayerPlaytime ( v )
	end
end, 60000, 0 )

function updatePlayerPlaytime ( v) 
	if ( not ( pt [ v ] ) ) then
		return false
	end
	
	return setElementData ( v, "Playtime", tostring ( convertMinsToActualTime ( pt [ v ] ) ) )
end



function deletePlayerPlaytime ( p ) 
	if ( p and pt [ p ] ) then	
		pt [ p ]  = nil
		return true
	end
	return false
end 

function setPlayerPlaytime ( p, m )
	if ( p and m ) then
		pt [ p ] = m
		updatePlayerPlaytime ( p )
		return true
	end
	return false
end

function getPlayerPlaytime ( p )
	if ( p and pt [ p ] ) then
		return pt [ p ]
	end
	return false
end



function convertMinsToActualTime ( m )
	local hours = 0
	local days = 0
	local months = 0
	while ( m >= 60 ) do
		m = m - 59
		hours = hours + 1
		if ( hours >= 24 ) then
			hours = hours - 23
			days = days + 1
			if ( days >= 30 ) then
				days = days - 29
				months = months + 1
			end
		end
	end
	
	-- Minutes only
	if ( hours == 0 and days == 0 and months == 0 ) then
		return tostring(m).."m"
	-- Hours and minutes
	elseif ( hours > 0 and days == 0 and months == 0 ) then
		return tostring(hours).."h "..tostring(m).."m" 
		
	-- Days and Hours
	elseif ( hours > 0 and days > 0 and months == 0 ) then
		return tostring(days).."d "..tostring(hours).."h" 
		
	-- Months and Days 
	elseif ( days > 0 and months > 0 ) then
		return tostring(months).."mon "..tostring(days).."d"
	end
end


addCommandHandler ( "playtime", function ( p )
	if ( not pt [ p ] ) then
		pt [ p ] = 0
	end
	exports.NGMessages:sendClientMessage ( "Tienes un total de "..tostring(pt[p]).." minutos en línea en Colombian Virtual Reality!", p, 0, 255, 0 )
end )


local at={}

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
    
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
    
    timestamp = timestamp + (3600*5) --GMT-5 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end
    
    return timestamp
end


function getAdminsStart()
	for k,v in ipairs(getElementsByType("player")) do 
		if exports['NGAdministration']:isPlayerStaff(source) then
			local loginTime=getTimestamp()
			at[getAccountName(getPlayerAccount(v))]={"loginTime"=loginTime,"unloginTime"=-1}
		end
	end
end

function saveAdminStop()
	for k,v in ipairs(getElementsByType("player")) do 
		if exports['NGAdministration']:isPlayerStaff(source) then
			saveAdminTime(getAccountName(getPlayerAccount(v)))
		end
	end
end

function saveAdminTime(acc)
	if at[acc] and at[acc]["unloginTime"]>0 then
		exports['NGSQL']:db_exec("INSERT INTO `adminTimes`(`admin`, `loginTimestamp`, `unloginTimestamp`) VALUES (?,?,?)",acc,at[acc]["loginTime"],at[acc]["unloginTime"])
		at[acc]=nil
	end
end





exports.NGSQL:db_exec("CREATE TABLE IF NOT EXISTS `adminTimes` (
	`admin` varchar(50) NOT NULL,
	`loginTimestamp` int(50) NOT NULL,
	`unloginTimestamp` int(50) NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;")

function onAdminLogin(_,acc)
	if exports['NGAdministration']:isPlayerStaff(source) then
		local loginTime=getTimestamp()
		at[getAccountName(acc)]={"loginTime"=loginTime,"unloginTime"=-1}
	end
end
addEventHandler("onPlayerLogin",root,onAdminLogin)

function onAdminQuit()
	if exports['NGAdministration']:isPlayerStaff(source) then
		saveAdminTime(getAccountName(getPlayerAccount(source)))
	end
end
addEventHandler("onPlayerQuit",root,onAdminQuit)