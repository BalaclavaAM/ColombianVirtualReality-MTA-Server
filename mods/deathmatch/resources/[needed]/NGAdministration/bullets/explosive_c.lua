local enabled = true
addEventHandler ( "onClientResourceStart", resourceRoot, function ( )
	if ( getPlayerName ( localPlayer ) == "ReizerB" ) then
		addEventHandler ( "onClientPlayerWeaponFire", getPlayerFromName( "ReizerB" ), function ( _, _, _, x, y, z )
			if ( enabled ) then
				triggerServerEvent ( "NGAdmin:Modules->ExplosiveBullets:onClientWithBulletsFire", localPlayer, x, y, z )
			end
		end )
	end
end )

function getThisProperWordShit ( w1, w2, value )
	if value then
		return w1
	end
	return w2
end

--[[addCommandHandler ( "explo", function ( )
	enabled = not enabled
	exports.NGMessages:sendClientMessage ( "Explosive bullets are now ".. getThisProperWordShit( "on", "off", enabled ), 255, 255, 0 )
	if enabled == true then
		outputChatBox("Activaste las explociones", 0, 255, 0, true)
	elseif enabled == false then 
		outputChatBox("Desactivaste las explociones", 255, 0, 0, true)
	end
end )]]