local connection
local driftRecords = {}
local loadedClients = {}
local recordListMaxPosition = 50

local excludedUsernames = -- Add accountnames of who you want to blacklist from ranking, like to prevent players tracking (undercover) admins through F5 (current nick + username)
{
	["Adminusername1"] = true,
	["Test2"] = true,
}

local function comp(a,b)

	return a.score > b.score

end

local function checkDriftRecord(score)

	if not client.account then return end
	if excludedUsernames[client.account.name] then return end
	
	local acc = (client.account.name~="guest" and client.account.name or hash("sha512",client.serial))

	local name = client.name
	while name:find("#%x%x%x%x%x%x") do
		name = name:gsub("#%x%x%x%x%x%x","")
	end

	local oldJSON = toJSON(driftRecords)
	local isGuest = tostring(isGuestAccount(client.account))
	
	if driftRecords[#driftRecords] == nil or (score > driftRecords[#driftRecords].score or #driftRecords < recordListMaxPosition) then
		local existingPosition = false
		for position,record in ipairs(driftRecords) do
			if record.username == acc then
				existingPosition = position
				break
			end
		end
		if existingPosition and score > driftRecords[existingPosition].score then
			driftRecords[existingPosition].score = score
			driftRecords[existingPosition].playername = name
		elseif not existingPosition then
			table.insert(driftRecords,{username=acc,score=score,playername=name,isGuest=isGuest})
		end
	else
		return
	end
	
	table.sort(driftRecords,comp)
	
	if #driftRecords > recordListMaxPosition then
		for position=recordListMaxPosition+1,#driftRecords do
			driftRecords[position]=nil
		end
	end
	
	if oldJSON == toJSON(driftRecords) then
		return
	end
	
	for player,_ in pairs(loadedClients) do
		triggerClientEvent(player,"Drift:loadRecords",player,driftRecords,recordListMaxPosition,player.account.name)
	end
	
	connection:exec("DELETE FROM records2")
	
	for position,record in ipairs(driftRecords) do
		connection:exec("INSERT INTO records2 VALUES (?,?,?,?)",record.username,record.playername,record.score,record.isGuest)
	end
	
end

local function recheckPlayer()

	triggerClientEvent(source,"Drift:loadRecords",source,driftRecords,recordListMaxPosition,source.account.name)

end

local function resetPlayer()

	loadedClients[source] = nil

end

addEventHandler("onElementDataChange",getRootElement(), 
	function ( ElementData ) 
	if getElementData(source,"Job") == "Drifter" then 
        if ( ElementData == "Last Drift" ) then 
		puntos = getElementData(source,ElementData)
		wp = getElementData(source,"WantedPoints")
		local jobRank = getElementData(source,"Job Rank")
			if jobRank == "None" then
				mult = 0.6
			elseif jobRank == "Drifter Novato" then
				mult = 0.6
			elseif jobRank == "Drifter" then
				mult = 0.7
			elseif jobRank == "Drifter Especialista" then
				mult = 0.8
			elseif jobRank == "Han" then
				mult = 0.9
			elseif jobRank == "Keisuke Takahashi" then
				mult = 1
			elseif jobRank == "Ryosuke Takahashi" then
				mult = 1.1
			elseif jobRank == "Takumi Fujiwara" then
				mult = 1.2
			end
			plata = math.floor(tonumber((getElementData(source,ElementData)*mult/13)*0.6))
            givePlayerMoney(source, plata)
			exports['NGMessages']:sendClientMessage ( "#CD5C5CTe pagaron $#FFA07A"..plata .." #CD5C5Cpor derrapar!. Gracias a que tu rango es: #FA8072"..jobRank.." #CD5C5Ctienes un multiplicador de x#E9967A"..mult.."#CD5C5C!", source, 0, 255, 0 )
			setElementData ( source, "WantedPoints", wp + plata/50 )
			
			if puntos > 10000 then
				triggerClientEvent ( source, "updateDrifterJob", source )
			end
		end
    end 
end 
) 

function enablenitro ( carrazo )  
	addVehicleUpgrade( carrazo, 1010 );
end
addEvent( "ponernitro", true )
addEventHandler( "ponernitro", resourceRoot, enablenitro )

function disablenitro ( carrazo )  
	removeVehicleUpgrade( carrazo, 1010 );
end
addEvent( "quitarnitro", true )
addEventHandler( "quitarnitro", resourceRoot, disablenitro )

local function clientLoaded()

	if source~=client then return end
	
	triggerClientEvent(client,"Drift:loadRecords",client,driftRecords,recordListMaxPosition,client.account.name)
	addEventHandler("onDriftEnd",client,checkDriftRecord)
	loadedClients[client] = true
	addEventHandler("onPlayerLogin",client,recheckPlayer)
	addEventHandler("onPlayerLogout",client,recheckPlayer)
	addEventHandler("onPlayerQuit",client,resetPlayer)
	
end

local function initScript()
	
	connection = Connection("sqlite",":/drift.db")
	connection:exec("CREATE TABLE IF NOT EXISTS records2 (username TEXT, playername TEXT, score NUMBER, isGuest TEXT)")
	
	local handle = connection:query("SELECT * FROM records2")
	driftRecords = handle:poll(-1)
	
	addEvent("Drift:scriptLoaded",true)
	addEvent("onDriftEnd",true)
	
	addEventHandler("Drift:scriptLoaded",root,clientLoaded)
	
end

addEventHandler("onResourceStart",resourceRoot,initScript)