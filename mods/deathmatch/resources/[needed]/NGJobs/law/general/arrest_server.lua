arresties = { }
tased = { }
releaseTimers = {}
shoots= {}
shoottimers = {}
carTombos = {598, 596, 597, 599}
addEventHandler ( "onPlayerDamage", root, function ( cop, weapon, _, loss ) 
	-- arrest system
	
	if ( isElement ( cop ) and weapon and cop ~= source  ) then
		if getElementData(cop,"isinCapitan") then return end
		if ( getElementData ( cop, "NGEvents:IsPlayerInEvent" ) or getElementData ( source, "NGEvents:IsPlayerInEvent" ) ) then
			return 
		end
	
		if ( cop == source ) then return end
		if ( getElementType ( cop ) == 'vehicle' ) then
			cop = getVehicleOccupant ( cop )
		end
		if ( not isElement ( cop ) or getElementType ( cop ) ~= 'player' ) then return end
		if ( not getPlayerTeam ( cop ) ) then
			return
		end

		if ( exports['NGPlayerFunctions']:isTeamLaw ( getTeamName ( getPlayerTeam ( cop ) ) ) ) then
			if ( getElementData ( source, "isSpawnProtectionEnabled" ) == true ) then 
				return exports['NGMessages']:sendClientMessage ( "Este jugador tiene el spawn-protection activo.", cop, 255, 0, 0 ) 
			end
			
			if ( getPlayerTeam ( source ) and getTeamName ( getPlayerTeam ( source ) ) == "Staff" ) then 
				return exports['NGMessages']:sendClientMessage ( "You cannot arrest/tase on-duty staff.", cop, 255, 0, 0 ) 
			end
			
			if ( arresties[source] ) then 
				return exports['NGMessages']:sendClientMessage ( "Este jugador ya está arrestado.", cop, 255, 0, 0 ) 
			end
			if ( getPlayerWantedLevel ( source ) >= 1 ) then
				local x,y,z = getElementPosition(source) 
				local location = getZoneName ( x, y, z, true ) 
				if ( weapon == 3 ) then
					-- Arrest
					arrestPlayer ( source, cop )
					exports['NGMessages']:sendClientMessage ( "Has arrestado a "..getPlayerName ( source )..", llévalo pa la UPJ.", cop, 0, 255, 0 )
					exports['NGMessages']:sendClientMessage ( getPlayerName ( cop ).." te arrestó D:!", source, 255, 255, 0 )
					setElementHealth ( source, getElementHealth ( source ) + loss )
					setElementData ( source, "NGJobs:ArrestingOfficer", cop )

					addEventHandler ( "onPlayerQuit", source, onPlayerAttmemptArrestAvoid );
				elseif ( weapon == 23 and location ~= "San Fierro" ) then
					-- Taze Player
					if ( tased [ source ] ) then
						return exports.NGMessages:sendClientMessage ( "Este jugador ya está taseado", cop, 255, 255, 255 )
					end
					
					local a = cop
					local t = getPlayerTeam ( a )
					if ( not t ) then return end
					if ( getPlayerWantedLevel ( source ) == 0 ) then return end
					if ( exports.NGPlayerFunctions:isTeamLaw ( getTeamName ( t ) ) and not getElementData ( source, "NGJobs:ArrestingOfficer" ) ) then
						-- now we know:
						-- source 	-> wanted, not arrested
						-- w 		-> teaser
						toggleAllControls ( source, false )
						if ( isPedInVehicle ( source ) ) then
							removePedFromVehicle ( source )
						end
						setPedAnimation(source, "CRACK", "crckdeth2", 4000, false, true, false)
						
						exports.NGMessages:sendClientMessage ( "Has tazeado a ".. getPlayerName ( source ), a, 0, 255, 0 )
						setElementData(source,"tased",true)
						exports.NGMessages:sendClientMessage ( "Has sido tazeado por "..getPlayerName ( a ), source, 255, 0, 0 )
						tased [ source ] = true
						setTimer ( function ( p, c )
							if ( isElement ( p ) ) then
								setPedAnimation ( p )
								toggleAllControls ( p, true )
								exports.NGMessages:sendClientMessage ( "Ya no estás tazeado", p, 0, 255, 0 )
								setTimer(function() 
									removeElementData(p,"tased")
								end, 5000,1)
								
								if ( isElement ( c ) ) then
									exports.NGMessages:sendClientMessage ( getPlayerName ( p ).." ya no está tazeado!", c, 255, 255, 0 )
								end
							end
							tased [ p ] = false
						end, 4000, 1, source, a )
					end
				else
					if ( isPedInVehicle ( cop ) ) then return end 
					exports['NGMessages']:sendClientMessage ( "Usa el bolillo para arrestar y el taser para tasear.", cop, 255, 255, 255 )
				end
			else
				local f = math.floor ( loss * 1.2)
				setElementHealth ( cop, getElementHealth ( cop ) - f )
				exports['NGMessages']:sendClientMessage ( "Perdiste "..tostring ( f ).."% de salud por disparar a un ciudadano inocente.", cop, 255, 255, 0 )
			end
		end	
	end
end )

function onPlayerAttmemptArrestAvoid ( )
	local tTime = 0
	local time = math.floor ( ( getElementData ( source, "WantedPoints" ) * 2 ) or 50 )
	local orgTime = time
	local wLevel = getPlayerWantedLevel ( source )
	if wLevel > 0 and wLevel <= 1 then
		tTime = 120
	elseif wLevel > 1 and wLevel <= 2 then
		tTime = 180
	elseif wLevel > 2 and wLevel <= 3 then
		tTime = 240
	elseif wLevel > 3 and wLevel <= 4 then
		tTime = 300
	elseif wLevel > 4 and wLevel <= 5 then
		tTime = 360
	else
		tTime = 600
	end
	exports['NGSQL']:db_exec("UPDATE `accountdata` SET `JailTime`=? WHERE `Username`=?",tTime,getAccountName(getPlayerAccount(source)))
	outputChatBox ( getPlayerName ( source )..  " evadio arresto o lo está intentando!", root,255,0,0 )
	triggerEvent ( "ngpolice:onJailCopCrimals", getElementData ( source, "NGJobs:ArrestingOfficer" ) )
end


function release( p, _, p2 )
	if ( getPlayerTeam ( p ) and exports['NGPlayerFunctions']:isTeamLaw ( getTeamName ( getPlayerTeam ( p ) ) ) ) then
		if ( p2 ) then
			local c = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
			if c then
				if ( arresties[c] ) then
					if ( getElementData ( c, "NGJobs:ArrestingOfficer") == p ) then
						exports['NGMessages']:sendClientMessage ( "Has liberado "..getPlayerName ( c ), p, 0, 255, 0)
						exports['NGMessages']:sendClientMessage ( getPlayerName ( p ).." te soltó.", c, 0, 255, 0 )
						releasePlayer ( c )
						local arresties2 = { }
						for i, v in pairs ( arresties ) do
							if ( getElementData ( v, "NGJobs:ArrestingOfficer" ) == p ) then
								table.insert ( arresties2, v )
							end
						end
						triggerClientEvent ( root, "onPlayerEscapeCop", root, c, p, arresties2 )
					else exports['NGMessages']:sendClientMessage ( "You're not "..getPlayerName ( c ).."'s arresting officer, you cannot release him.", p, 255, 255, 0 ) end
				else exports['NGMessages']:sendClientMessage ( getPlayerName ( c ).." isn't being arrested", p, 255, 255, 0 ) end
			else exports['NGMessages']:sendClientMessage ( p2.." doesn't exist. ", p, 255, 255, 0 ) end
		else exports['NGMessages']:sendClientMessage ( "Syntax error. /release [player] o /soltar [Player]", p, 255, 255, 0 ) end
	else exports['NGMessages']:sendClientMessage ( "You're not a law officer.", p, 255, 255, 0 ) end
end
addCommandHandler ( "release", release)
addCommandHandler ( "soltar", release) 



local muertos={}
function cooldownTazer ( weapon )
	if (getTeamName ( getPlayerTeam ( source ) ) == "Law Enforcement" and weapon==23) then
		if (not shoots[source]) then
			shoots[source]=1
			shoottimers[source]=setTimer( function (source)
				shoots[source]=nil
			end, 10000,1,source)
		elseif (shoots[source]<2) then
			shoots[source]=shoots[source]+1
		elseif (shoots[source]==2) then
			exports['NGMessages']:sendClientMessage ( "Usa de nuevo el tazer en 5 segundos.", source, 255, 255, 0 )
			if isTimer(shoottimers[source]) then
				killTimer(shoottimers[source])
				shoottimers[source]=nil
			end
			takeWeapon( source, 23 ) 
			giveWeapon ( source, 3, 1000, true )
			local xd = false
			setTimer ( function ( source )
				xd = giveWeapon ( source, 23, 1000 )
				shoots[source]=nil
				exports['NGMessages']:sendClientMessage ( "Ya puedes usar el tazer.", source, 255, 255, 0 )
				if not (xd) then
					exports['NGHospitals']:saveTombo (source)
				end
			end, 5000, 1, source )
		end
	end
end
addEventHandler("onPlayerWeaponFire",root,cooldownTazer)




function arrestPlayer ( crim, cop )
	showCursor ( crim, true )
	arresties[crim] = true
	toggleControl ( crim, 'right', false )
	toggleControl ( crim, 'left', false )
	toggleControl ( crim, 'forwards', false )
	toggleControl ( crim, 'backwards', false )
	toggleControl ( crim, 'jump', false )
	toggleControl ( crim, 'sprint', false )
	toggleControl ( crim, 'walk', false )
	toggleControl ( crim, 'fire', false )
	onTimer ( crim, cop )
	setElementData(crim,"arrestTimer",true)
	triggerClientEvent ( root, "onPlayerStartArrested", root, crim, cop )
	if not isTimer( releaseTimers[crim]) and isElement(crim) then
		releaseTimers[crim] = setTimer( preventRaid, 180000,1,crim)
	end
end

function contarOcupantes(pseudoVehicle)
	local counter = 0
    local seats = getVehicleMaxPassengers ( pseudoVehicle ) + 1
    local i = 0
    while ( i < seats ) do
        if ( not getVehicleOccupant ( pseudoVehicle, i ) ) then
            counter = i
            break
        end
        i = i + 1
    end
    if ( i >= seats ) then
        counter = 10
    end
	return counter
end

function onTimer ( crim, cop )
	if ( isElement ( crim ) and isElement ( cop ) ) then
		if ( not getPlayerTeam ( cop ) or not exports['NGPlayerFunctions']:isTeamLaw ( getTeamName ( getPlayerTeam ( cop ) ) ) ) then return releasePlayer ( crim ) end
		if ( not arresties[crim] ) then return  end
		local cx, cy, cz = getElementPosition ( crim )
		local px, py, pz = getElementPosition ( cop )
		local rot = findRotation ( cx, cy, px, py )
		setPedRotation ( crim, rot )
		setCameraTarget ( crim, crim )
		local dist = getDistanceBetweenPoints3D ( cx, cy, cz, px, py, pz )
		if ( isPedInVehicle ( cop ) ) then
			if ( not isPedInVehicle ( crim ) ) then
				local carroPoli = getPedOccupiedVehicle ( cop )
				if contarOcupantes(carroPoli) < (getVehicleMaxPassengers (carroPoli) + 1) then
					warpPedIntoVehicle ( crim, carroPoli, contarOcupantes(carroPoli) )
				end
			end
		else
			if ( isPedInVehicle ( crim ) ) then
				removePedFromVehicle ( crim )
			end
		end
		if ( not isPedInVehicle ( crim ) ) then
			if ( dist >= 20 ) then
				setElementPosition ( crim, px +1, py+1, pz )
				showCursor(crim,true)
				giveWeapon(crim,0,1,true)
			elseif ( dist >= 15 ) then
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', true )
				setControlState ( crim, 'sprint', true )
				setControlState ( crim, "forwards", true )
				showCursor(crim,true)
				giveWeapon(crim,0,1,true)
			elseif ( dist >= 10 ) then
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', false )
				setControlState ( crim, 'sprint', true )
				setControlState ( crim, "forwards", true )
				showCursor(crim,true)
				giveWeapon(crim,0,1,true)
			elseif ( dist >= 7 ) then
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', true )
				setControlState ( crim, 'sprint', false )
				setControlState ( crim, "forwards", true )
				showCursor(crim,true)
				giveWeapon(crim,0,1,true)
			elseif ( dist >= 2 ) then
				setControlState ( crim, 'walk', true )
				setControlState ( crim, 'jump', false )
				setControlState ( crim, 'sprint', false )
				setControlState ( crim, "forwards", true )
				showCursor(crim,true)
				giveWeapon(crim,0,1,true)
			else
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', false )
				setControlState ( crim, 'sprint', false )
				setControlState ( crim, "forwards", false )
				showCursor(crim,true)
				giveWeapon(crim,0,1,true)
			end
		end
		crim.interior = cop.interior;
		crim.dimension = cop.dimension
		
		setTimer ( onTimer, 500, 1, crim, cop )

	else
		arresties[crim] = false
		if ( not isElement ( cop ) and isElement ( crim ) ) then
			releasePlayer ( crim )
			exports['NGMessages']:sendClientMessage ( "Su oficial que lo arrestó ha renunciado, por lo tanto, ha sido liberado.", crim, 0, 255, 0 )

		end
	end
end

function preventRaid(p)
	if isElement(p) then
		if  getElementData(p,"arrestTimer") then
			releasePlayer(p)
		end
	end 
end
function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end

function releasePlayer ( p )
	setControlState ( p, 'walk', false )
	setControlState ( p, 'jump', false )
	setControlState ( p, 'sprint', false )
	setControlState ( p, "forwards", false )
	toggleAllControls ( p, true )
	setElementData ( p, "NGJobs:ArrestingOfficer", nil )
	arresties[p] = nil
	showCursor ( p, false )
	removeEventHandler ( "onPlayerQuit", p, onPlayerAttmemptArrestAvoid );
end


function onJailCopCriminals( )
	for v, _ in pairs ( arresties ) do 
		if isElement(v) then
			if getElementType(v) == "player" then
				if ( getElementData ( v, "NGJobs:ArrestingOfficer" ) == source ) then
					local money = 0
					local tTime = 0
					releasePlayer ( v )
					local time = math.floor ( ( getElementData ( v, "WantedPoints" ) * 2 ) or 50 )
					local orgTime = time
					local wLevel = getPlayerWantedLevel ( v )
					if wLevel > 0 and wLevel <= 1 then
						tTime = 120
						money = 10000
					elseif wLevel > 1 and wLevel <= 2 then
						tTime = 180
						money = 14000
					elseif wLevel > 2 and wLevel <= 3 then
						tTime = 240
						money = 20000
					elseif wLevel > 3 and wLevel <= 4 then
						tTime = 300
						money = 25000
					elseif wLevel > 4 and wLevel <= 5 then
						tTime = 360
						money = 35000
					else
						tTime = 600
						money = 45000
					end
						
					local vip = getElementData ( v, "VIP" )
					if ( exports.NGVIP:getVipLevelFromName ( vip ) == 5 ) then
						tTime = tTime - ( tTime * 0.70 )
						exports.NGMessages:sendClientMessage ( "Gracias por ser VIP esmeralda! Tienes 75% de carcel por ser VIP Esmeralda! (Tiempo original: "..orgTime.." segundos)", v, 0, 255, 0 )
					elseif ( exports.NGVIP:getVipLevelFromName ( vip ) == 4 ) then
						tTime = tTime - ( tTime * 0.5 )
						exports.NGMessages:sendClientMessage ( "¡Estás cumpliendo un 50% menos de tiempo en la cárcel debido a Diamond VIP! (Original time: "..orgTime.." seconds)", v, 0, 255, 0 )
					elseif ( exports.NGVIP:getVipLevelFromName ( vip ) == 3  ) then
						tTime = tTime - ( tTime * 0.25 )
						exports.NGMessages:sendClientMessage ( "¡Estás cumpliendo un 25% menos de tiempo en la cárcel gracias a VIP Oro! (Original time: "..orgTime.." seconds)", v, 0, 255, 0 )
					elseif ( exports.NGVIP:getVipLevelFromName ( vip ) == 2 ) then
						tTime = tTime - ( tTime * 0.15 )
						exports.NGMessages:sendClientMessage ( "¡Estás cumpliendo un 15% menos de tiempo en la cárcel debido al VIP Plata! (Original time: "..orgTime.." seconds)", v, 0, 255, 0 )
					elseif ( exports.NGVIP:getVipLevelFromName ( vip ) == 1 ) then
						tTime = tTime - ( tTime * 0.05 )
						exports.NGMessages:sendClientMessage ( "¡Estás cumpliendo un 5% menos de tiempo en la cárcel debido al VIP de bronce! (Original time: "..orgTime.." seconds)", v, 0, 255, 0 )
					end
					local tTime = math.floor ( tTime )
					if isPedInVehicle (v) then
						removePedFromVehicle ( v )
					end
					setElementData ( v, "WantedPoints", 0 ) 
					setPlayerWantedLevel ( v, 0 )
					givePlayerMoney ( source,  money )
					exports['NGMessages']:sendClientMessage ( "Te pagaron $"..money .." por arrestar "..getPlayerName ( v ).."!", source, 0, 255, 0 )
					exports['NGPolice']:jailPlayer ( v, tTime, false, source, "Police Arrest" )
					updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), "Arrests", "AddOne" )
					releaseTimers[v] = nil
				end
			end
		end
	end
end

addEvent ( "ngpolice:onJailCopCrimals", true )
addEventHandler ( "ngpolice:onJailCopCrimals", root, onJailCopCriminals )

-- Prevent arrest avoid by disconnect

--[[function tasedQuit()
	for v, _ in pairs ( tased ) do 
		if isElement(v) then
			if getElementType(v) == "player" then
				local tTime = 0
				local time = math.floor ( ( getElementData ( v, "WantedPoints" ) * 2 ) or 50 )
				local orgTime = time
				local wLevel = getPlayerWantedLevel ( v )

				if wLevel > 0 and wLevel <= 1 then
					tTime = 240
				elseif wLevel > 1 and wLevel <= 2 then
					tTime = 360
				elseif wLevel > 2 and wLevel <= 3 then
					tTime = 480
				elseif wLevel > 3 and wLevel <= 4 then
					tTime = 600
				elseif wLevel > 4 and wLevel <= 5 then
					tTime = 720
				else
					tTime = 1200
				end
					
				local tTime = math.floor ( tTime )
				if isPedInVehicle (v) then
					removePedFromVehicle ( v )
				end
				setElementData ( v, "WantedPoints", 0 ) 
				setPlayerWantedLevel ( v, 0 )
			end
		end
	end
end
addEvent ( "ngpolice:tasedQuit", true )
addEventHandler ( "ngpolice:tasedQuit", root, tasedQuit )

function onPlayerTasedQuit ( )
	outputChatBox ( getPlayerName ( source )..  " evadio aresto o lo está intentando!" )
	tasedQuit(player) sin terminar
end]]

