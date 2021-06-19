addEvent ( "NGPhone:App.Money:sendPlayerMoney", true )
addEventHandler ( "NGPhone:App.Money:sendPlayerMoney", root, function ( p, amount )
	if ( getPlayerMoney ( source ) < amount ) then
		return exports['NGMessages']:sendClientMessage ( "Tú no tienes suficiente dinero.", source, 255, 0, 0 )
	end
	if ( 4000 > amount ) then
		return exports['NGMessages']:sendClientMessage("El mínimo que puedes enviar de dinero es 4000.",source,255,0,0)
	end
	if ( isElement ( p ) ) then
		exports['NGMessages']:sendClientMessage ( "Enviando $"..amount.." a "..getPlayerName ( p ).."!", source, 0, 255, 0 )
		exports['NGMessages']:sendClientMessage ( getPlayerName ( source ).." te ha enviado $"..amount.."!", p, 0, 255, 0 )
		takePlayerMoney ( source, amount ) 
		givePlayerMoney ( p, amount )
		
		local acc1 = getAccountName ( getPlayerAccount ( source ) )
		local acc2 = getAccountName ( getPlayerAccount ( p ) )
		exports['NGLogs']:outputActionLog ( getPlayerName ( source ).."("..acc1..") envió "..getPlayerName(p).."("..acc2..") $"..amount )
	end
end )