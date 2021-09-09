addCommandHandler ( 'getpos', function ( _, round )
	if not round then round = 'yes' end
	local x, y, z = getElementPosition ( localPlayer )
	local pos = nil
	if ( round == 'yes' ) then
		pos = table.concat ( { math.round ( x, 2 ), math.round ( y, 2 ), math.round ( z, 2 ) }, ", " );
	else
		pos = table.concat ( { x, y, z }, ', ' )
	end
	
	outputChatBox ( "Coordinates: "..pos.." (Copied!)", 255, 255, 0 )
	setClipboard ( pos )
	
end )

addCommandHandler ( 'getrot', function ( _, round )
	if not round then round = 'yes' end
	local x, y, z = getElementRotation( localPlayer )
	local pos = nil
	if ( round == 'yes' ) then
		pos = table.concat ( { math.round ( x, 2 ), math.round ( y, 2 ), math.round ( z, 2 ) }, ", " );
	else
		pos = table.concat ( { x, y, z }, ', ' )
	end
	
	outputChatBox ( "Coordinates: "..pos.." (Copied!)", 255, 255, 0 )
	setClipboard ( pos )
	
end )


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

local timer = {}
function Discord(player)
	if (timer[player]) and (getTickCount() - timer[player]) < 5000 then
		outputChatBox ( "Debes esperar 5 segundos antes de volver a usar el comando!", 255, 0, 0 )
	else 
		LinkDiscord = "https://discord.gg/xXpD6mhEkJ"
		outputChatBox ( "Invitacion del discord: "..LinkDiscord.." (Copiada!)", 255, 0, 0 )
		setClipboard(LinkDiscord)
		timer[player] = getTickCount()
	end
end
addCommandHandler("dc",Discord)
addCommandHandler("discord",Discord,false,false)

local timer2 = {}
function Foro(player)
	if (timer2[player]) and (getTickCount() - timer2[player]) < 5000 then
		outputChatBox ( "Debes esperar 5 segundos antes de volver a usar el comando!", 255, 0, 0 )
	else 
		LinkDiscord = "https://colombianvirtualreality.com/foro"
		outputChatBox ( "Link del foro: "..LinkDiscord.." (Copiado!)", 255, 0, 0 )
		setClipboard(LinkDiscord)
		timer2[player] = getTickCount()
	end
end
addCommandHandler("foro",Foro,false,false)