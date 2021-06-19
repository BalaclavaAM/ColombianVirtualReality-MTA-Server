cartelTime = 10000
function startCartelPlayer()
	if getPlayerCount() >= 4 then
		while(true) do
			randomPlayer = getRandomPlayer()
			if  getPlayerName(randomPlayer) == "XXXADMIN" then
				break
			end
		end
	outputChatBox("El jugador "..getPlayerName(randomPlayer).." se encuentra carteleado, asesinalo y obten 5000$(Icono calavera)",root,255,0,0)
	outputChatBox("Has sido carteleado, sobrevive por 5 minutos y gana 5000$, no ingreses a ningun interior o perderas!",randomPlayer,255,0,0)
	blip = createBlipAttachedTo ( randomPlayer, 23)
	preventInterior()
	surviveTimer = setTimer( function()
					if randomPlayer then
						outputChatBox("El jugador "..getPlayerName(randomPlayer).." ha sobrevivido!",root,255,0,0)
						givePlayerMoney(randomPlayer, 5000)
						if isElement(blip) then
							destroyElement(blip)
						end
						randomPlayer = false
					end
						setTimer(startCartelPlayer,cartelTime,1)
						end,cartelTime,1)
	else
		setTimer(startCartelPlayer,cartelTime,1)
	end
end

function player_Wasted ( ammo, attacker, weapon, bodypart )
	if attacker and source == randomPlayer then
		outputChatBox("El jugador "..getPlayerName(attacker).." asesinó a "..getPlayerName(source).." y ha ganado $5000",root,255,0,0)
		givePlayerMoney(attacker, 5000)
		if isElement(blip) then
			destroyElement(blip)
		end
		killTimer(surviveTimer)
		randomPlayer = false
		setTimer(startCartelPlayer,cartelTime,1)
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player_Wasted )

function preventInterior()

		preventTimer = setTimer( function()
				if randomPlayer then
							if getElementInterior(randomPlayer) ~= 0 then
								outputChatBox("Has perdido 5000$ por intentar evadir el cartel",randomPlayer,255,0,0)
								outputChatBox("El jugador "..getPlayerName(randomPlayer).." ha perdido el cartel al tratar de evadirlo.",root,255,0,0)
								takePlayerMoney(randomPlayer, 5000)
								outputChatBox(getPlayerName(randomPlayer))
								randomPlayer = false
								if isTimer(preventTimer) then
									outputChatBox("si")
									killTimer(preventTimer)
								else
									outputChatBox("nda bn")
									
								end
								if isElement(blip) then
									destroyElement(blip) 
								end
								setTimer(startCartelPlayer,cartelTime,1)
							end
				end
					end,1000,6000)
end

function quitPlayer ( quitType )
	if source == randomPlayer then
		outputChatBox("El jugador "..getPlayerName(randomPlayer).." se ha rendido.",root,255,0,0)
		killTimer(surviveTimer)
		killTimer(preventTimer)
		setTimer(startCartelPlayer,cartelTime,1)
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

startCartelPlayer()