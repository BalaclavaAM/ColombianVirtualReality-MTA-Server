 --[[
Welcome to Las Vegas =)
Author: ck-Godless
Visit:
www.nonamemod.de and get scripting infos
www.chaoskrieger.com just so we get some hits =)

Config Starts Here
]]
function displayLoadedRes ()
	lmin  = 100	  --minimun Bet 
	limit = 100000 --maximum bet
	win = 2 --the Money you get when winning, default +50% of bet (1.5)
	sur = 0.5 --the Money you loose on surrender, default -50% from bet(0.5)
	-- Start of the Script <========================================================================|
	-- Edit at own Risk
	givencard = {}
	CPcards = {}
	CDcards = {}
	cards = {}
	Dcards={}
	Pcards={}
	GameOn ={}
	double ={}
	betglob ={}
	Money={}
end
addEventHandler ( "onResourceStart", getRootElement(), displayLoadedRes )

 function rand ()
        local time = getRealTime()
        local hour = time.hour
        local minute = time.minute
        local second = time.second
		local day = time.monthday
		local month = time.month
		local timestamp = ((((((month*30+day)*24)+hour)*60)+minute)*60)+second
		return timestamp
end
 
 function bjcall(player, command)
	math.randomseed(rand())
	outputChatBox("Starting Blackjack",player)
	double[player] = false
	GameOn[player] = false
	--local xen = getPlayerMoney(source)	
	--local ran = rand()
	triggerClientEvent ( "startBJ", player, lmin)
 end
 --addCommandHandler( "startBJ", bjcall )
 
function MarkerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler
    local elementType = getElementType( hitElement ) -- get the hit element's type
    if elementType == "player" then
		math.randomseed(rand())
		outputChatBox("Starting Blackjack",hitElement)
		double[hitElement] = false
		GameOn[hitElement] = false
		--local xen = getPlayerMoney(source)	
		--local ran = rand()
		triggerClientEvent ( "startBJ", hitElement, lmin)
	end
end


local myMarkers ={
	{2230.35, 1607.9, 1005.19},
	{2226.86, 1604.42, 1005.18},
	{2230.41, 1601.12, 1005.19},
	{2233.82, 1604.49, 1005.18}
}
for k,v in ipairs(myMarkers) do
	local marker = createMarker(v[1],v[2],v[3],'cylinder', 1.5, 255, 0, 0, 150) 
	setElementInterior(marker,1)
	addEventHandler( "onMarkerHit", marker, MarkerHit )
end

local pedDealers = {
	{2230.31, 1605.9, 1006.19,0,172},
	{2228.87, 1604.44, 1006.19,90,171},
	{2230.42, 1603.12, 1006.19,180,11},
	{2231.81, 1604.49, 1006.19,270,171}
}
for k,v in ipairs(pedDealers) do
	local dPed = createPed(v[5], v[1], v[2], v[3], v[4])
	setElementInterior(dPed,1)
end

function findcard(v)
local k
	for k = 0, givencard[source], 1 do 
		if (cards[source][k] == v) then
			return true
		end
    end 
    return false 
end

function getHandValue(v,x)
	local value = 0
	local value2 = 0
	local check = {}
	local y
	if (v == 2) then
		for y=1,x,1 do
			check[y] = Pcards[source][y]
		end 
	else
		for y=1,x,1 do
			check[y] = Dcards[source][y]
		end 
	end
	for y=1,x,1 do
		repeat
		if (check[y] <= 8 and check[y] >=0) then
			value = check[y] +2 +value
			break
		elseif (check[y] <= 11 and check[y] >=0) then
			value = 10 + value
			break
		elseif (check[y] == 12) then
			value = 11 + value
			value2 = value2 - 10
			break
		end
		check[y] = check[y] - 13
		until check[y] < -1
	end
	if ( value > 21) then
		value = value + value2
	end
	return value
end

function getRandCard ()
	local card = 0
	local value
	local x = 0
	repeat
		card = math.random ( 0, 51 )
		if (findcard(card) == false) then
			cards[source][givencard[source]] = card
			givencard[source] = givencard[source] + 1
			return card
		end
	until x < -1
end



function startGame()
	local card
	givencard[source] = 0
	CPcards[source] = 0
	CDcards[source] = 0
	cards[source] 	= {}
	Dcards[source] 	= {}
	Pcards[source] 	= {}
	card = getRandCard()
	triggerClientEvent("imgChBJ",source,1,1,card)
	Pcards[source][1]=card
	card = getRandCard()
	triggerClientEvent("imgChBJ",source,2,1,"back")
	Dcards[source][1]=card
	card = getRandCard()
	triggerClientEvent("imgChBJ",source,1,2,card)
	Pcards[source][2]=card
	card = getRandCard()
	triggerClientEvent("imgChBJ",source,2,2,card)
	Dcards[source][2]=card
	CPcards[source] = 2
	CDcards[source] = 2
	outputChatBox("The Game starts!",source)
	local PPoint = getHandValue(2,CPcards[source])
	triggerClientEvent("txtChBJ",source,1,PPoint)
	if (PPoint == 21) then
		showdown()
	end
	if (getHandValue(1,CDcards[source]) == 21) then
		showdown()
	end
	double[source] = true
end

function giveCard()
	local card
	CPcards[source] = CPcards[source] + 1
	card = getRandCard()
	triggerClientEvent("imgChBJ",source,1,CPcards[source],card)
	Pcards[source][CPcards[source]]=card
	triggerClientEvent("txtChBJ",source,1,getHandValue(2,CPcards[source]))
	if (CPcards[source] == 5) then
		showdown()
	end
	if (getHandValue(2,CPcards[source]) > 21) then
		outputChatBox("Te quemaste con ".. getHandValue(2,CPcards[source]) .." Points.",source)
		GameOver()
	end
	outputChatBox("Nueva carta para ti.",source)
end

function showdown()
	local PlayerHand = getHandValue(2,CPcards[source])
	local DealerHand = getHandValue(1,CDcards[source])
	local card
	triggerClientEvent("txtChBJ",source,1,PlayerHand)
	if (DealerHand < 17 and PlayerHand <= 21 and not(PlayerHand == 21 and CPcards == 2)) then
	CDcards[source] = CDcards[source] + 1
	card = getRandCard()
	triggerClientEvent("imgChBJ",source,2,CDcards[source],card)
	Dcards[source][CDcards[source]]=card
	DealerHand = getHandValue(1,CDcards[source])
	showdown()
	return
	end
	triggerClientEvent("txtChBJ",source,2,DealerHand)
	triggerClientEvent("imgChBJ",source,2,1,Dcards[source][1])
	if ( PlayerHand > 21) then
		outputChatBox("You Busted with ".. PlayerHand .." Points.",source)
		GameOver()
		return
	elseif ( DealerHand > 21) then
		outputChatBox("La casa se ha quemado con ".. DealerHand .." Points.",source)
		betglob[source] = math.floor(betglob[source] * win)
		outputChatBox("Felicitaciones, ganaste! "..betglob[source].."$",source)
		givePlayerMoney(source, betglob[source])
		GameOver()
		return
	elseif ( DealerHand > PlayerHand) then
		outputChatBox("Perdiste. La casa tiene una mano mayor.",source)
		GameOver()
		return
	elseif (PlayerHand == 21 and DealerHand == 21) then
		outputChatBox("Empate")
		givePlayerMoney(source, betglob[source])
		GameOver()
		return
	elseif (PlayerHand == 21 and CPcards[source] == 2 and DealerHand ~= 21) then
		betglob[source] = math.floor(betglob[source] * win)
		outputChatBox("Ganaste! "..betglob[source].."$ con " ..PlayerHand.. " Points.",source)
		givePlayerMoney(source, betglob[source])
		GameOver()
		return
	elseif (PlayerHand > DealerHand) then
		betglob[source] = math.floor(betglob[source] * win)
		outputChatBox("Ganaste! "..betglob[source].."$ con " ..PlayerHand.. " Points.",source)
		givePlayerMoney(source, betglob[source])
		GameOver()
		return
	elseif (PlayerHand == DealerHand and PlayerHand <= 21) then
		outputChatBox("Empate",source)
		givePlayerMoney(source, betglob[source])
		GameOver()
		return
	end
	outputChatBox("ERROR: Combination not Found")
	GameOver()
end

function GameOver()
	GameOn[source] = false
	outputChatBox("Juego terminado, apuesta de nuevo", source)
end

function restart()
	for i=1,5,1 do
	triggerClientEvent("imgChBJ",source,1,i,"empty")
	triggerClientEvent("imgChBJ",source,2,i,"empty")
	end
end

		
function pushBtn (BTN,button,bet)
	if (BTN == "btnBetMo") then
		Money[source] = getPlayerMoney(source)
		if (button == "left") then
			if (GameOn[source] == false) then
				outputChatBox("Nuevo juego", source)
				if (bet == nil) then
					outputChatBox("Ingresa un numero valido. numero 0-9, hasta 10 digitos.",source)
					return
				end
				if (bet > Money[source]) then
					outputChatBox("No tienes el dinero para realizar dicha apuesta",source)
					return
				end
				if ( lmin > bet or bet > limit) then
					outputChatBox("La apuesta minima es "..lmin.."$, el limite de la casa es "..limit.."$",source)
					return
				end
				outputChatBox("Has apostado.",source)
				takePlayerMoney(source, bet )
				betglob[source] = bet
				GameOn[source] = true
				restart()
				startGame()
			end
		end
	end
	if (BTN == "btnCard") then
		if (GameOn[source] == false) then
			outputChatBox("Necesitas apostar primero.",source)
			return
		end
		if (button == "left") then
			double[source] = false
			giveCard()
		end
	end
	if (BTN == "btnSur") then
		if (GameOn[source] == false) then
			outputChatBox("Debes apostar primero.",source)
			return
		end
		if (button == "left") then
			outputChatBox("Te has rendido.",source)
			betglob[source]= math.floor(betglob[source] * sur)
			givePlayerMoney(source, betglob[source])
			GameOver()
		end
	end
	if (BTN == "btnDouble") then
		if (GameOn[source] == false) then
			outputChatBox("Debes apostar primero.",source)
			return
		end
		if (double[source] == false) then
			outputChatBox("Solo puedes doblar con dos cartas.",source)
			return
		end
		if (button == "left") then
			if (Money[source]-betglob[source] > betglob[source]) then
				local card
				outputChatBox("Doble abajo, una carta mas.",source)
				takePlayerMoney(source, betglob[source] )
				betglob[source] = betglob[source] * 2
				CPcards[source] = CPcards[source] + 1
				card = getRandCard()
				triggerClientEvent("imgChBJ",source,1,CPcards[source],card)
				Pcards[source][CPcards[source]]=card
				showdown()
			else
				outputChatBox("No tienes el dinero suficiente para doblar.",source)
			return
			end
		end
	end
	if (BTN == "btnHold") then
		if (GameOn[source] == false) then
			outputChatBox("Debes apostar primero.",source)
			return
		end
		if (button == "left") then
			outputChatBox("Showdown",source)
			showdown()
		end
	end
	if (BTN == "btnExit") then
		if (button == "left") then
			if (GameOn[source] == false) then
				triggerClientEvent("BJend",source)
					givencard[source] = 0
					CPcards[source] = 0
					CDcards[source] = 0
					cards[source] 	= {}
					Dcards[source] 	= {}
					Pcards[source] 	= {}
				return
			end
			outputChatBox("Ya has apostado.",source)
		end
	end
end
addEvent( "BTNBJ", true )
addEventHandler("BTNBJ", getRootElement(), pushBtn)