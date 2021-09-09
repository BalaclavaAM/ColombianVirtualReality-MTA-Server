------------------------------------------
-- 			  TopBarChat				--
------------------------------------------
-- Developer: Braydon Davis				--
-- File: s.lua							--
-- Copyright 2013 (C) Braydon Davis		--
-- All rights reserved.					--	
------------------------------------------
sec = {{{{{{},{},{},{}}}}}}				--
------------------------------------------

local TheResourceName = getResourceName ( getThisResource ( ) )
function sendClientMessage ( msg, who, r, g, b, img, checkImagePath )
	if ( msg and who ) then
		if ( isElement ( who ) ) then
			
			if ( checkImagePath == nil ) then checkImagePath = true; end
			
			if ( img and sourceResource and checkImagePath ) then 
				img = ":"..tostring(getResourceName(sourceResource)).."/"..img;
			end 
			
			triggerClientEvent ( who, TheResourceName..":sendClientMessage", who, msg, r, g, b, img )
			
			return true
		else return false end
	else return false end
end


addEventHandler ( "onPlayerLogin", root, function ( _, acc )
	if ( not exports['NGAdministration']:isPlayerStaff ( source ) ) then
		sendClientMessage ( getPlayerName ( source ).." se ha logeado en CVR!", root, 0, 255, 0 )
	else
		local aviso = getAccountData(acc,"loginaviso") or true
		if aviso then
			local lvl = exports['NGAdministration']:getPlayerStaffLevel ( source, 'string' )
			outputChatBox ( "* "..getPlayerName ( source ).." se ha logeado - "..lvl, root, math.random ( 100, 250 ), math.random ( 100, 250 ), math.random ( 100, 250 ) )
		end
	end
end )


function aviso(source)
	if exports['NGAdministration']:isPlayerStaff ( source ) then
		local aviso = getAccountData(getPlayerAccount(source),"loginaviso")
		if aviso then
			outputChatBox("Has desactivado el aviso al logearte",source,255,0,0)
			setAccountData(getPlayerAccount(source),"loginaviso",false)
		else
			outputChatBox("Has activado el aviso al logearte",source,0,255,0)
			setAccountData(getPlayerAccount(source),"loginaviso",true)
		end
	end
end
addCommandHandler("hideaviso",aviso)