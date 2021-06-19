local max_time = 15		-- Minutes

setTimer ( function ( )
	local max_milsecs = ( max_time * 60 ) * 1000
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		if ( not exports.NGAdministration:isPlayerStaff ( v ) ) then
			local idle = getPlayerIdleTime ( v )
			if ( idle > max_milsecs  ) then
				kickPlayer ( v, "Fuiste detectado estando AFK. Entra de nuevo - Colombian Virtual Reality" )
			elseif ( idle > max_milsecs ) then
				exports.NGMessages:sendClientMessage ( "Por favor muévete, serás kickeado en ".. math.floor ( ( max_milsecs - idle ) / 1000 ).." segundos si no te mueves.", v, 255, 0, 0 ) 
			end
		end
	end
end, 5000, 0 )