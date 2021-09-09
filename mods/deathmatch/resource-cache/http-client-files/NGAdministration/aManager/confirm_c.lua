local confirm = {}
local callback = nil
local args = nil
local sx, sy = guiGetScreenSize ( )
confirm.window = guiCreateWindow( ( sx / 2 - 324 / 2 ), ( sy / 2 - 143 /2 ), 324, 143, "Confirm", false)
confirm.text = guiCreateLabel(10, 35, 304, 65, "", false, confirm.window)
guiSetVisible ( confirm.window, false )
guiSetFont(confirm.text, "default-bold-small")
guiLabelSetHorizontalAlign(confirm.text, "left", true)
guiWindowSetSizable ( confirm.window, false )
confirm.yes = guiCreateButton(10, 100, 108, 25, "Confirm", false, confirm.window)
confirm.no = guiCreateButton(128, 100, 108, 25, "Deny", false, confirm.window)

function onConfirmClick( ) 
	if ( source ~= confirm.yes and source ~= confirm.no ) then return end
	
	removeEventHandler ( "onClientGUIClick", root, onConfirmClick )
	guiSetVisible ( confirm.window, false )
	local v = false
	if ( source == confirm.yes ) then
		v = true
	end
	callback ( v, unpack ( args ) )
	args = nil
	callback = nil
end

function askConfirm ( question, callback_, ... )
	if ( not callback_ or type ( callback_ ) ~= "function" ) then
		return false
	end
	
	guiSetVisible ( confirm.window, true )
	guiSetText ( confirm.text, tostring ( question ) )
	callback = callback_
	args = { ... }
	addEventHandler ( "onClientGUIClick", root, onConfirmClick )
	guiBringToFront ( confirm.window )
	return true
end


function clientadminfly()
    if not isWorldSpecialPropertyEnabled( "aircars" ) then
        setWorldSpecialPropertyEnabled( "aircars", true )
    else
        setWorldSpecialPropertyEnabled( "aircars", false )
    end
end
addEvent("NGAdministration:ToggleAdminFly",true)
addEventHandler("NGAdministration:ToggleAdminFly",root,clientadminfly)

function clientadminswim()
    if not isWorldSpecialPropertyEnabled( "hovercars" ) then
        setWorldSpecialPropertyEnabled( "hovercars", true )
    else
        setWorldSpecialPropertyEnabled( "hovercars", false )
    end
end
addEvent("NGAdministration:ToggleAdminSwim",true)
addEventHandler("NGAdministration:ToggleAdminSwim",root,clientadminswim)


function clientadminsjump()
    if not isWorldSpecialPropertyEnabled( "extrajump" ) then
        setWorldSpecialPropertyEnabled( "extrajump", true )
    else
        setWorldSpecialPropertyEnabled( "extrajump", false )
    end
end
addEvent("NGAdministration:ToggleAdminJump",true)
addEventHandler("NGAdministration:ToggleAdminJump",root,clientadminsjump)


function clientadminsbunny()
    if not isWorldSpecialPropertyEnabled( "extrabunny" ) then
        setWorldSpecialPropertyEnabled( "extrabunny", true )
    else
        setWorldSpecialPropertyEnabled( "extrabunny", false )
    end
end
addEvent("NGAdministration:ToggleAdminBunny",true)
addEventHandler("NGAdministration:ToggleAdminBunny",root,clientadminsbunny)

function clientAdminGodCar(theVehicle)
	if isVehicleDamageProof(theVehicle) then
		setVehicleDamageProof(theVehicle,false)
	else
		setVehicleDamageProof(theVehicle,true)
	end
end
addEvent("NGAdministration:ToggleAdminGodCar",true)
addEventHandler("NGAdministration:ToggleAdminGodCar",root,clientAdminGodCar)

local godmode=false

addEventHandler("onClientPlayerDamage", getLocalPlayer(),
function()
	if godmode then
		cancelEvent()
	end
end
)

local superspeed= false
function enableSuperSpeed()
	if superspeed then
		setGameSpeed(1)
		superspeed=false
	else
		setGameSpeed(10)
		superspeed=true
	end
end
addEvent("NGAdministration:ToggleSuperSpeed",true)
addEventHandler("NGAdministration:ToggleSuperSpeed",root,enableSuperSpeed)

local slow= false
function enableSlow()
	if slow then
		setGameSpeed(1)
		slow=false
	else
		setGameSpeed(0.1)
		slow=true
	end
end
addEvent("NGAdministration:ToggleSlow",true)
addEventHandler("NGAdministration:ToggleSlow",root,enableSlow)




function clientAdminGod()
	if godmode then
		godmode = false
	else
		godmode = true
	end
end
addEvent("NGAdministration:ToggleAdminGod",true)
addEventHandler("NGAdministration:ToggleAdminGod",root,clientAdminGod)

function clientAdminStunt()
	if canPedBeKnockedOffBike(localPlayer) then
		setPedCanBeKnockedOffBike ( localPlayer, false )
	else
		setPedCanBeKnockedOffBike ( localPlayer, true )
	end
end
addEvent("NGAdministration:ToggleAdminStunt",true)
addEventHandler("NGAdministration:ToggleAdminStunt",root,clientAdminStunt)

function mysplit (inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end


function saySearchQuery(query)
	for k,v in ipairs(query) do
		outputChatBox("------------------------------------",255,255,0,true)
		outputChatBox('Cuenta: '..query[k]['Account'],255,255,0,true)
		outputChatBox('Ip: '..query[k]['Ip'],255,255,0,true)
		outputChatBox('Serial: '..query[k]['Serial'],255,255,0,true)
		outputChatBox('Nicks usados: ',255,255,0,true)
		local nicks = fromJSON(query[k]['Nickname'])
		local counter = 0
		local venesuela = {}
		if table.size(nicks)<6 then
			for k,v in pairs(nicks) do
				outputChatBox("  "..k.." usado en la fecha "..v,255,255,0,true)
			end
		else
			local nlast=0
			for k,v in pairs(nicks) do
				local tablehours = mysplit(v,"-")
				local anho = tablehours[1]
				local mes = tablehours[2]
				local dia = tablehours[3]
				local cantidaddias = (anho*365)+(mes*30)+dia
				if not(venesuela[cantidaddias]) then
					venesuela[cantidaddias]={}
				end
				table.insert(venesuela[cantidaddias],{k,v})
				if cantidaddias>nlast then
					nlast=cantidaddias
				end
			end
			encontraos=5
			while encontraos>0 do
				if venesuela[nlast] then
					for k,v in ipairs(venesuela[nlast]) do
						outputChatBox("  "..v[1].." usado en la fecha "..v[2],255,255,0,true)
						encontraos=encontraos-1
					end
				end
				nlast=nlast-1
			end
		end
		outputChatBox("------------------------------------",255,255,0,true)
	end
end

addEvent("NGAdministration->SayTheQuery",true)
addEventHandler("NGAdministration->SayTheQuery",root,saySearchQuery)