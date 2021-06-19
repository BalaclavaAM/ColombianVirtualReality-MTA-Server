local lottery = nil
local winningNum = nil

addEvent ( "NGLottery->onClientAttemptToBuyLotteryTicket", true )
addEventHandler ( "NGLottery->onClientAttemptToBuyLotteryTicket", root, function ( number ) 
	local a = getPlayerAccount ( source )
	if ( isGuestAccount ( a ) ) then
		return exports.NGMessages:sendClientMessage ( "Por favor loggeate para usar la loteria", source, 255, 0, 0 )
	end

	if ( lottery [ getAccountName ( a ) ] ) then
		return exports.NGMessages:sendClientMessage ( "Ya compraste un boleto de loteria con el numero \""..tostring(lottery[getAccountName(a)]).."\"", source, 255, 255, 0 )
	end

	for i, v in pairs ( lottery ) do
		if ( v == number ) then
			return exports.NGMessages:sendClientMessage ( "Este numero ya fue comprado.", source, 255, 255, 0 )
		end
	end

	if ( getPlayerMoney ( source ) < 50000 ) then
		return exports.NGMessages:sendClientMessage ( "No tienes el dinero suficiente para comprar un boleto de loteria", 255, 0, 0 )
	end

	takePlayerMoney ( source, 50000 )
	exports.NGMessages:sendClientMessage ( "Has comprado el boleto de loteria #"..tostring ( number ).."!", source, 0, 255, 0)
	lottery[getAccountName(a)] = number
end )

function winLottery ( )
	local winAccount = nil
	local winner = nil
	local num = getLotteryWinningNumber ( )
	for i, v in pairs ( lottery ) do
		if ( v == num ) then
			winAccount = i
		end
	end
	if ( winAccount ) then
		for i, v in pairs ( getElementsByType ( "player" ) ) do 
			local a = getPlayerAccount ( v )
			if ( not isGuestAccount ( a ) and getAccountName ( a ) == winAccount ) then
				winner = v
			end
		end
	end
	if ( winAccount and not winner ) then
		winner = winaccount.." #ff0000(offline)"
	elseif ( not winAccount ) then
		winner = nil
	end
	outputChatBox ( "====== Loteria de Medellin] =====", root, 255, 120, 0 )
	outputChatBox ( "Ganador: "..tostring(winer or "Nadie"), root, 255, 255, 255, true)
	outputChatBox ( "Numero ganador: #ffff00"..tostring ( num ), root, 255, 255, 255, true)
	outputChatBox ( "Premio: #00ff00$"..tostring ( prize ), root, 255, 255, 255, true )
	outputChatBox ( "==================", root, 255, 120, 0 )

	if ( winner ~= nil and getElementType ( winner ) == "player" ) then
		exports.NGMessages:sendClientMessage("Has ganado $"..tostring(prize).." de la loteria!", winner, 0, 255, 0)
		givePlayerMoney ( winner, prize )
	end

	generateNextLottery ( )
end 

function generateNextLottery ( )
	lottery = { }
	winningNum = math.random ( 1, 100 )
	prize = math.random(1500000,3000000)
	if ( isTimer ( lotTImer ) ) then
		killTimer ( lotTImer )
		lotTImer = nil
	end
	lotTImer = setTimer ( winLottery, 1800000, 1)
end 

function getLotteryWinningNumber ( )
	return winningNum
end

function getLotteryTimer ( )
	return lotTImer 
end

generateNextLottery ( )




addEvent ( "NGLotter->onClientRequestTimerDetails", true )
addEventHandler ( "NGLotter->onClientRequestTimerDetails", root, function ( ) 
	triggerClientEvent ( source, "NGLottery->onServerSendClientTimerDetails", source, convertMilSecsToTimer ( getTimerDetails ( getLotteryTimer ( ) ) ))
end )


function convertMilSecsToTimer ( mil )
	local h = 0
	local m = 0
	local s = 0

	while ( mil > 1000 ) do
		s = s + 1
		mil = mil - 1000
	end

	while ( s > 60 ) do
		s = s - 60
		m = m + 1
	end 

	while ( m > 60 ) do
		m = m - 60
		h = h + 1
	end

	return tostring ( h ).."h "..tostring(m).."m "..tostring (s).."s"
end 