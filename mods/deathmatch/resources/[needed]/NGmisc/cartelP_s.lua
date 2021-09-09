cPlayer = false
cBlip = false
cTimer = false
startTime = 360000
bebiendo={}
politas={}
function cartelPlayer()
	if getPlayerCount() >= 10 then
		local i = 0
		while (true) do 
			if i ~= 20 then
				cPlayer = getRandomPlayer()
				local acc = getPlayerAccount(cPlayer)
				if getElementInterior(cPlayer) == 0 and not isGuestAccount(acc) and not getElementData(cPlayer,"isPassive") and getTeamName(getPlayerTeam(cPlayer))~="Services" and getTeamName(getPlayerTeam(cPlayer))~="Emergency" and (getElementDimension(cPlayer)==0) then
					break
				end
				i = i + 1
			else
				cPlayer = false
				setTimer(cartelPlayer,startTime,1)
				break
			end
		end
		if cPlayer == false then return end 
		if (exports['CVRCapturaelCamion']:isPlayerInMinigame(cPlayer) ) then return end
		exports['NGMessages']:sendClientMessage ("El jugador "..getPlayerName(cPlayer).." se encuentra carteleado, asesinalo y obten 25000(icono calavera).",root,255,0,0)
		exports['NGMessages']:sendClientMessage ("Has sido carteleado, sobrevive por "..tostring(startTime/60000).." minutos para ganar 25000, no entres a ningun interior o los perderas.",cPlayer,255,0,0)
		cBlip = createBlipAttachedTo(cPlayer,23)
		cTimer = setTimer(
			function()
				givePlayerMoney(cPlayer,25000)
				exports['NGMessages']:sendClientMessage ("El jugador "..getPlayerName(cPlayer).." ha sobrevivido y ha ganado 25000.",root,255,0,0)
				exports['NGMessages']:sendClientMessage ("Has sobrevivido y has ganado 25000.",cPlayer,255,0,0)
				if isElement(cBlip) then
					destroyElement(cBlip)
					cBlip = nil
				end
				killTimer(preventTimer)
				cPlayer = false
				setTimer(cartelPlayer,startTime,1)
			end
		,startTime,1)
		preventTimer = setTimer(
			function()
				if getElementInterior(cPlayer) ~= 0 or getElementDimension(cPlayer) ~= 0 or getElementData(cPlayer,"isPassive") or getTeamName(getPlayerTeam(cPlayer))=="Services" or getTeamName(getPlayerTeam(cPlayer))=="Emergency" then
					takePlayerMoney(cPlayer,25000) 
					exports['NGMessages']:sendClientMessage ("El jugador "..getPlayerName(cPlayer).." ha perdido 25000 por evadir el cartel.",root,255,0,0)
					exports['NGMessages']:sendClientMessage ("Has perdido por cambiar de interior, dimension, colocarte el ModoPasivo o ",cPlayer,255,0,0)
					exports['NGMessages']:sendClientMessage ("has tomado un trabajo (Incluyendo médico)",cPlayer,255,0,0)
					cPlayer = false
					if isElement(cBlip) then
						destroyElement(cBlip)
						cBlip = nil
					end
					killTimer(preventTimer)
					killTimer(cTimer)
					setTimer(cartelPlayer,startTime,1)
				end
			end
		,1000,0)
	else
		setTimer(cartelPlayer,startTime,1)
	end
end

function player_Wasted ( ammo, attacker, weapon, bodypart )
	if cPlayer ~= false then 
		if source == cPlayer then
			if ( attacker ) then
				if getElementType(attacker) == "player" then
					if isElement(cBlip) then
						destroyElement(cBlip) 
						cBlip = nil
					end
					givePlayerMoney(attacker, 25000)
					exports['NGMessages']:sendClientMessage ("El jugador "..getPlayerName(attacker).." ha ganado 25000 por asesinar a "..getPlayerName(source)..".",root,255,0,0)
					cPlayer = false
					killTimer(preventTimer)
					killTimer(cTimer)
					setTimer(cartelPlayer,startTime,1)
				end
			end
		end
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player_Wasted )

function displayLoadedRes (res)
	cartelPlayer()
end
addEventHandler ( "onResourceStart", resourceRoot, displayLoadedRes )

function quitPlayer ( quitType )	
	if source == cPlayer then
		killTimer(preventTimer)
		killTimer(cTimer)
		cPlayer = false
		if isElement(cBlip) then
			destroyElement(cBlip)
		end
		setTimer(cartelPlayer, startTime, 1)
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

function consoleCheckParameters ( playerSource)
	if playerSource then
		if cPlayer == false then
			exports['NGMessages']:sendClientMessage ("No hay ningun jugador carteleado",playerSource,255,0,0)
		else
			exports['NGMessages']:sendClientMessage ("El jugador carteleado es "..getPlayerName(cPlayer).." (icono de calavera en el mapa)",playerSource,255,0,0)
		end
	end
end
addCommandHandler ( "cartel", consoleCheckParameters )

function trabajadores(attacker,damage_causing)
	if attacker and (attacker ~= source) and (getElementType(attacker)=="player" ) then
		local equipoa = getPlayerTeam(source) or "None"
		local equipoat = getPlayerTeam(attacker) or "None"
		if equipoa == "None" or equipoat == "None" then return end
		local equipoatacado = getTeamName(equipoa) or "None"
		local equipoatacante = getTeamName(equipoat) or "None"
		if (equipoatacado == "Services" or equipoatacado == "Emergency") and (getPlayerWantedLevel (source) == 0) and (equipoatacante~="Emergency") then
			local f = math.floor ( damage_causing * 1.2)
			setElementHealth ( attacker, getElementHealth ( attacker ) - f )
			exports['NGMessages']:sendClientMessage ( "Perdiste "..tostring ( f ).."% de salud por disparar a un ciudadano inocente.", attacker, 255, 255, 0 )
		elseif (equipoatacante == "Services") then
			local f = math.floor ( damage_causing * 1.2)
			setElementHealth ( attacker, getElementHealth ( attacker ) - f )
			exports['NGMessages']:sendClientMessage ( "Perdiste "..tostring ( f ).."% de salud por disparar siendo trabajador.", attacker, 255, 255, 0 )
		end
	end
end
addEventHandler("onPlayerDamage",getRootElement(),trabajadores)

function momo(p)
	if (isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup ( "Admin" ))) then
		for id, player in ipairs(getElementsByType("player")) do 
			executeCommandHandler("LocalChat",player,"OjosTristes hijueputa")
		end 
	end
end
addCommandHandler("momo",momo)
