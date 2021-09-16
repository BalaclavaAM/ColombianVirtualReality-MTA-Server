root = getRootElement ()
players = {}
players = getElementsByType ( "player" )
local vipCars = {}
local vehTimers = {}
function applyClothing ( incredibleTable )
	if getElementModel ( source ) ~= 0 then
		 setElementModel ( source, 0 )
	end

	count = 0
	while count ~= 18 do
		
		if tostring(incredibleTable[count].storedValue) == "x" then
			removePedClothes ( source, count )
		elseif tostring(incredibleTable[count].storedValue) ~= "" then --blank fields do nothing
			texture, model = getClothesByTypeIndex ( count, tostring(incredibleTable[count].storedValue) )
			addPedClothes ( source, texture, model, count )  
			--outputChatBox ( "texture: "..texture.."       model: "..model.."       count: "..count )
		end
		count = count + 1
	end
	if tostring(incredibleTable[18].storedValue) ~= "" then
		setPedStat ( source, 21, incredibleTable[18].storedValue )
		--outputChatBox ( "Fat stuff triggered" )
	end
	if tostring(incredibleTable[19].storedValue) ~= "" then
		setPedStat ( source, 23, incredibleTable[19].storedValue )
		--outputChatBox ( "Strong stuff triggered" )
	end	
end
addEvent("applyClothes", true, "incredibleTable" )
addEventHandler("applyClothes", getRootElement(), applyClothing)

function setWeaponSpray(quantity)
	if not quantity then
		quantity=9999
	end
	giveWeapon ( client ,41,quantity,true )
end
addEvent( "setSpray", true ) 
addEventHandler("setSpray", root , setWeaponSpray)

function setWeaponC4()
	giveWeapon ( client ,39,9999,true )
end
addEvent( "setC4", true ) 
addEventHandler("setC4", root , setWeaponC4)

function setSHealth()
	if exports.NGEvents:isPlayerInEvent(client) then return end
	setElementHealth(client, 200)
end
addEvent( "setHealth", true ) 
addEventHandler("setHealth", root , setSHealth)

function setSArmour()
	if exports.NGEvents:isPlayerInEvent(client) then return end
	setPedArmor ( client, 100 )
end
addEvent( "setArmour", true ) 
addEventHandler("setArmour", root , setSArmour)

function giveSVehicle(id,cmd)
	if exports.NGEvents:isPlayerInEvent(client) then return end
	if isTimer( vehTimers[client] ) then
		outputChatBox("Espera un momento...", client, 255,0,0)
	else
		if cmd == "spawn" then
			local x, y, z = getElementPosition ( client )
			if not isElement(vipCars[client]) then
				vipCars[client] =  createVehicle ( id, x+3, y+3, z )
				if id == 411 then
					addVehicleUpgrade ( vipCars[client], 1010 )
				end
			else
				destroyElement(vipCars[client])
			end
			 vehTimers[client] = setTimer( function () end,3000,1)
		elseif cmd == "rainbow" then
			if isElement(vipCars[client]) then
				local r, g, b = math.random( 255 ), math.random( 255 ), math.random( 255 )
				setVehicleColor( vipCars[client], r, g, b )
			end
		end
	end
end
addEvent( "giveVehicle", true ) 
addEventHandler("giveVehicle", root , giveSVehicle)

function updateFightStyle(id)
	setPedFightingStyle ( client, id )
end
addEvent( "updateFight", true ) 
addEventHandler("updateFight", root , updateFightStyle)

function setPStats()
	for stat = 69, 79 do 
		setPedStat( client, stat, 1000)
	end 
end
addEvent( "giveStats", true ) 
addEventHandler("giveStats", root ,setPStats)


function checkearPropio(veh,player)
	local cuenta = getElementData ( veh, "NGVehicles:VehicleAccountOwner") or false
	if cuenta then
		if cuenta==getAccountName(getPlayerAccount(player)) then
			return true
		end
	end
	outputChatBox("Este vehiculo no es tuyo, por lo tanto no puedes realizar modificaciones en él",player,255,0,0)
	return false
end

function checkifAlreadyHigh(veh)
	local hand = getVehicleHandling(veh)
	local oghand = getOriginalHandling(getElementModel(veh))
	if hand['centerOfMass'][3] >= oghand['centerOfMass'][3] then
		if hand['suspensionLowerLimit'] >= oghand['suspensionLowerLimit'] then
			return true
		end
	end
	return false
end


function makeVehicleHigh(veh)
	if checkearPropio(veh,source) then
        if checkifAlreadyHigh(veh) then
            local hand = getVehicleHandling(veh)
            local sentrodemasa=hand['centerOfMass']
            sentrodemasa[3]=sentrodemasa[3]-2
            setVehicleHandling(veh,'centerOfMass',sentrodemasa)
            setVehicleHandling(veh,'suspensionLowerLimit',hand['suspensionLowerLimit']-2)
            setElementData ( veh, "FLAGSELL", 1)
        else
            outputChatBox("Este vehiculo ya tiene esta propiedad",source,255,0,0)
        end
	end
end
addEvent( "modHigh", true ) 
addEventHandler("modHigh", root ,makeVehicleHigh)

function resetvehicleHandling(veh)
	if checkearPropio(veh,source) then
		local hnd = exports['NGVehicles']:getVehicleHandlingg(getElementModel(veh))
		for k,v in pairs(hnd) do
			setVehicleHandling(veh,k,v)
		end
		setElementData ( veh, "FLAGSELL", 0)
	end
end
addEvent( "modReset", true ) 
addEventHandler("modReset", root ,resetvehicleHandling)

function makeHighSpeedHandling(veh)
	if checkearPropio(veh,source) then
		setElementData ( veh, "FLAGSELL", 1)
		local handling = getOriginalHandling(getElementModel(veh))
		setVehicleHandling(veh,'engineAcceleration',handling['engineAcceleration']+30)
		setVehicleHandling(veh,'maxVelocity',handling['maxVelocity']+200)
		setVehicleHandling(veh,'tractionMultiplier',handling['tractionMultiplier']+0.4)
	end
end
addEvent( "modSpeed", true ) 
addEventHandler("modSpeed", root ,makeHighSpeedHandling)

function handleMiniHedit(veh,traction,lowsusp,highsusp,accel,tractionloss)
	if checkearPropio(veh,source) then
		setElementData ( veh, "FLAGSELL", 1)
		setVehicleHandling(veh,'tractionMultiplier',traction)
		setVehicleHandling(veh,'suspensionLowerLimit',lowsusp)
		setVehicleHandling(veh,'suspensionUpperLimit',highsusp)
		setVehicleHandling(veh,'engineAcceleration',accel)
		setVehicleHandling(veh,'tractionLoss',tractionloss)
		outputChatBox("Cambios aplicados satisfactoriamente",source,255,0,0,false)
	end
end
addEvent( "handleMiniH", true ) 
addEventHandler("handleMiniH", root ,handleMiniHedit)
		

local cooldownextrah={}
function giveExtraHealth()
	local acc = getAccountName(getPlayerAccount(source))
	if not cooldownextrah[acc] or getTickCount()-cooldownextrah[acc]>1800000 then
		setPedStat(source, 24, 1000)
        setElementHealth(source, 200)
		cooldownextrah[acc]=getTickCount()
		setTimer(function(source)
			setPedStat(source, 24, 570)
		end,300000,1,source)
	else
		outputChatBox("Usa la salud extra cada 30 minutos",source,255,0,0)
	end
end
addEvent( "NGVIP:ExtraHealth",true )
addEventHandler("NGVIP:ExtraHealth", root , giveExtraHealth)

local cooldownpolice={}
function removeWantedPoints()
	local cuenta = getAccountName(getPlayerAccount(source))
	if not cooldownpolice[cuenta] or getTickCount()-cooldownpolice[cuenta]>10800000 then
		setElementData(source,"WantedPoints",0)
		cooldownpolice[cuenta]=getTickCount()
	else
		outputChatBox("Sólo puedes quitarte las estrellas cada 180 minutos.",source,255,0,0,false)
	end
end
addEvent( "NGVIP:RemoveStars",true )
addEventHandler("NGVIP:RemoveStars", root , removeWantedPoints)