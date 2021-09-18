function camilitomelapela ( exitingPed, seat, jacked, door )
	if ( getElementModel ( source ) == 574 ) then
	  if exitingPed then
		  triggerClientEvent ( exitingPed, "disableZorra", exitingPed )
	  end
	end
end

addEventHandler ( "onVehicleStartExit", getRootElement(), camilitomelapela )
addCommandHandler ( "quitarestrellas", function ( p, _, p2)
	if ( exports['NGAdministration']:isPlayerStaff ( p ) ) then
		if ( p2 ) then
			local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
			if toJ then
				setElementData ( toJ, "WantedPoints", 0 )
				exports['NGMessages']:sendClientMessage ( "Se le quitaron las estrellas a \""..p2.."\".", p, 255, 0, 0 )
			else
				exports['NGMessages']:sendClientMessage ( "No se encontró un jugador con \""..p2.."\" en su nombre.", p, 255, 0, 0 )
			end
		else
			exports['NGMessages']:sendClientMessage ( "Syntax: /quitarestrellas [nombre del jugador] [razón]", p, 255, 255, 0 )
		end
	end
end )

  
exports['Scoreboard']:scoreboardAddColumn  ( "FPS", root, 40, "FPS", 15 )
  addCommandHandler ( "desvalijar", function ( p, _, part)
	  part = tonumber(part)
	  if part then
		  local vehicle = getPedOccupiedVehicle(p)
		  if vehicle then
			  setVehicleDoorState(vehicle,tonumber(part),4)
		  end
	  else
		  outputChatBox("Pon /desvalijar (número del 0 al 5) 0= capó, 1= baúl, 2 = Puerta izq, 3 = Puerta der", p, 0, 154, 255)
	  end
  end )
  
  addCommandHandler ( "desvalijar2", function ( p, _, part)
	  part = tonumber(part)
	  if part then
		  local vehicle = getPedOccupiedVehicle(p)
		  if vehicle then
			  setVehiclePanelState(vehicle,tonumber(part),5)
		  end
	  else
		  outputChatBox("Pon /desvalijar2 (número del 0 al 5) 0= capó, 1= baúl, 2 = Puerta izq, 3 = Puerta der", p, 0, 154, 255)
	  end
  end )
  
  function getPedMaxHealth(ped)
	  -- Output an error and stop executing the function if the argument is not valid
	  assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
  
	  -- Grab his player health stat.
	  local stat = getPedStat(ped, 24)
  
	  -- Do a linear interpolation to get how many health a ped can have.
	  -- Assumes: 100 health = 569 stat, 200 health = 1000 stat.
	  local maxhealth = 100 + (stat - 569) / 4.31
  
	  -- Return the max health. Make sure it can't be below 1
	  return math.max(1, maxhealth)
  end
  
  local pbala = "#717D7E|Dueño|#FF5656BalaclavaAM: #FFFFFF"
  
  function displayLoadedRes ( res )
	  local Balabot = createPed(91,1210.67, -1323.93, 13.4,90,false)
	  attachElements(Balabot,colBalabot)
	  setElementFrozen(Balabot,true)
  end
  addEventHandler ( "onResourceStart", getResourceRootElement(), displayLoadedRes )
  
  
  
  local colBalabot = createColSphere ( 1210.67, -1323.93, 13.4, 1 )
  --1210.67, -1323.93, 13.4
  
  
  function tocarBalaBot ( player, matchingDimension )
	  if getElementType(player) == "player" and matchingDimension then --ensure its a claymore
		  outputChatBox(pbala.."Hola parcerin",player,255,0,0,true)
		  triggerClientEvent(player,"NGMisc->AbrirBalaBot",player)
	  end
  end
  addEventHandler ( "onColShapeHit", colBalabot, tocarBalaBot )
  
  
  
  function checkearifCanBuy()
	  if getPlayerMoney(source)>=75000000 then
		  local time = getRealTime()
		  local monthday = time.monthday
		  local month = time.month +2
		  local year = time.year +1900
  
		  takePlayerMoney(source,75000000)
		  outputChatBox(pbala.."Has comprado 1 mes de VIP Bronze por 75 millones!",source,255,0,0,true)
		  triggerEvent("NGAdmin->Modules->aManager->VIPManager->UpdateAccountVIP",source,getAccountName(getPlayerAccount(source)),"Bronze",monthday,month,year)
	  else
		  outputChatBox(pbala.."No tienes suficiente dinero para comprar este item.",source,255,0,0,true)
	  end
  end
  addEvent("NGMisc->CheckIfCanBuyVIP",true)
  addEventHandler("NGMisc->CheckIfCanBuyVIP",root,checkearifCanBuy)
  
  function takeWeapon(arma)
	  outputChatBox(arma)
	  takeWeapon(source,arma)
	  outputChatBox("Te hemos quitado el arma",source,255,0,0)
  end
  addEvent("NGMisc->PedirArma",true)
  addEventHandler("NGMisc->PedirArma",root,takeWeapon)

function is_valid_date(m,d,y)
	m, d, y = tonumber(m), tonumber(d), tonumber(y)

	if d < 0 or d > 31 or m < 0 or m > 12 or y < 0 then
		-- Cases that don't make sense
		return false
	elseif m == 4 or m == 6 or m == 9 or m == 11 then 
		-- Apr, Jun, Sep, Nov can have at most 30 days
		return d <= 30
	elseif m == 2 then
		-- Feb
		if y%400 == 0 or (y%100 ~= 0 and y%4 == 0) then
			-- if leap year, days can be at most 29
			return d <= 29
		else
			-- else 28 days is the max
			return d <= 28
		end
	else 
		-- all other months can have at most 31 days
		return d <= 31
	end
end


function giveVipCommand(p,_,d,m,y,vip,acc)
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 4" ) ) then
		if not(d or m or y) then return outputChatBox("El comando es /darvip dia mes año vip(b,p,o,d,e) cuenta",p,255,0,0) end
		if not(is_valid_date(m,d,y)) then return outputChatBox("La fecha no es válida. Formato: /darvip dia mes año vip cuenta",p,255,0,0) end

		local monthday = tonumber(d)
		local month = tonumber(m)
		local year = tonumber(y)

		if acc and vip then
			if getAccount(acc) then					
				if vip=="b" then
					vip="Bronze"
				elseif vip=="p" then
					vip="Silver"
				elseif vip=="o" then
					vip="Gold"
				elseif vip=="d" then
					vip="Diamond"
				elseif vip=="e" then
					vip="Esmeralda"
				else
					return outputChatBox("El vip lo debes específicar como (b|p|o|d|e), siendo cada letra la inicial del vip",p,255,0,0)
				end
				outputChatBox("Le diste vip "..vip.." a "..acc.." hasta el "..d.."/"..m.."/"..y..".",p,255,255,0,true)
				triggerEvent("NGAdmin->Modules->aManager->VIPManager->UpdateAccountVIP",p,acc,vip,monthday,month,year)	
			else
				outputChatBox("Cuenta no encontrada!",p,255,0,0)
			end
		else
			outputChatBox("El comando es /darvip dia mes año vip(b,p,o,d,e) cuenta",p,255,0,0)
		end
	end
end
addCommandHandler("darvip",giveVipCommand)
  
local i=0
function seeSkins(p)
	if exports['NGAdministration']:isPlayerStaff(p) then		
		setTimer(function(p) 
			setElementModel(p,i)
			i=i+1
			outputChatBox("Estás probando la skin "..i)
		end,2000,312,p)
	end
end
addCommandHandler("probarskins",seeSkins)

function quitarNitro(player)
	carro = getPlayerOccupiedVehicle(player)
	local duenho = getElementData(carro,"NGVehicles:VehiclePlayerOwner")
	if getElementData(player,"Job") ~="Drifter" and duenho then
		if  getVehicleUpgradeOnSlot(carro, 8) then
			removeVehicleUpgrade(carro, 1010) 
		end
	end
end
--addEventHandler("onVehicleEnter",root, quitarNitro)

function setMyVehiclesVariant(theUser, command, var1)
    local var1 = tonumber(var1)-- If anything was passed make sure its number or nil
    local myVeh = getPlayerOccupiedVehicle(theUser) -- Get the vehicle that they're in
    if myVeh then -- Make sure they're in control
        local wasSet = setVehicleVariant(myVeh, var1, var1) -- Set what they wanted
        if (wasSet) then
            outputChatBox("Vehicle variant successfully set!", theUser, 0, 255, 0)
        else
            outputChatBox("Vehicle variant unsuccessfully set.", theUser, 255, 255, 0)
        end
    end
end
addCommandHandler("variante", setMyVehiclesVariant)


local cooldown={}


function createJobPickup ( x, y, z, id, jobs )
    local e = createPickup ( x, y, z, 1, 100, 50)
    setElementData ( e, "NGJobs:pickup.jobLock", jobs )
    addEventHandler ( "onPickupHit", e, function ( p )
        if ( getElementType ( p ) ~= "player" or isPedInVehicle ( p ) ) then return end
        local jobs = getElementData ( source, "NGJobs:pickup.jobLock" )
        local job = getElementData ( p, "Job" ) or ""
        local done = false
		local acc = getAccountName(getPlayerAccount(p))
        for i, v in ipairs ( jobs ) do
            if ( v == job ) then
                done = true
                break
            end
        end 
        if ( not done or isPedInVehicle ( p ) ) then
            if ( not isPedInVehicle ( p ) ) then
                exports['NGMessages']:sendClientMessage ( "No puedes usar este pickup.", p, 255, 255, 0 )
            end
            cancelEvent ( )
        end
		if ( (cooldown[acc]) and (getTickCount()-cooldown[acc])<600000 ) then
			local remaning = (600000-(getTickCount()-cooldown[acc]))/1000
			exports['NGMessages']:sendClientMessage ( "Sólo puedes usar este pickup cada 10 minutos. Te faltan "..remaning.." segundos.", p, 255, 255, 0 )
			cancelEvent()
		else
			cooldown[acc]=getTickCount()
		end
		
    end )
end
createJobPickup ( 1571.09, -1635.52, 13.55, 3, { "Police Officer", "Detective" } )


function kickPingHigh(reason)
	kickPlayer(source,"Consola",reason)
end
addEvent("NGmisc:kickServer",true)
addEventHandler("NGmisc:kickServer",root,kickPingHigh)