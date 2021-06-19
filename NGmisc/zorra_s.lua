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
  
  
  function giveVipCommand(p,_,acc,vip)
	  local accName = getAccountName ( getPlayerAccount ( p ) )
	  if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" ) ) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 4" ) ) then
		  local time = getRealTime()
		  local monthday = time.monthday
		  local month = time.month +2
		  local year = time.year +1900
  
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
				  outputChatBox("Le diste vip "..vip.." a "..acc.." por un mes.",p,255,255,0,true)
				  triggerEvent("NGAdmin->Modules->aManager->VIPManager->UpdateAccountVIP",p,acc,vip,monthday,month,year)	
			  else
				  outputChatBox("Cuenta no encontrada!",p,255,0,0)
			  end
		  else
			  outputChatBox("El comando es /darvip cuenta vip(b,p,o,d,e)",p,255,0,0)
		  end
	  end
  end
  addCommandHandler("darvip",giveVipCommand)
  