function isPlayerStaff ( p )
	if ( p and getElementType ( p ) == 'player' ) then
		if ( isPlayerInACL( p, "Level 0") or isPlayerInACL ( p, "Level 1" ) or isPlayerInACL ( p, "Level 2" ) or isPlayerInACL ( p, "Level 3" ) or isPlayerInACL ( p, "Level 4" ) or isPlayerInACL ( p, "Level 5" ) or isPlayerInACL ( p, "Admin" ) or isPlayerInACL ( p, "Console" ) ) then
			return true
		end
		return false
	end
end

function getPlayerStaffLevel ( p, var )
	if ( isPlayerStaff ( p ) ) then
		local str = nil
		local num = -1
		for i=0,5 do
			if ( isPlayerInACL ( p, 'Level '..tostring ( i ) ) ) then
				num = i
				str = 'Level '..tostring ( i )
				break 
			end
		end
		if ( var == 'string' ) then
			return str
		elseif ( var == 'int' ) then
			return num
		else
			return str, num
		end
		
	end
	return 0,0
end

function getAllStaff ( )
	local staff = { 
		['Level 0'] = { },
		['Level 1'] = { },
		['Level 2'] = { },
		['Level 3'] = { },
		['Level 4'] = { },
		['Level 5'] = { },
	}
	
	for i=0,5 do
		for k, v in ipairs ( aclGroupListObjects ( aclGetGroup ( "Level "..tostring ( i ) ) ) ) do
			if ( string.find ( tostring ( v ), 'user.' ) ) then
				local name = tostring ( v:gsub ( "user.", "" ) )
				staff['Level '..tostring ( i )][#staff['Level '..tostring ( i )]+1] = name
			end
		end
	end

	return staff
end
local prefix = "#454545[#ffe605C#1105ffV#ff0516R#454545]#FFFFFF"
function printStaff(p)
	if not(isGuestAccount(getPlayerAccount(p))) then
		local players=getElementsByType("player")
		outputChatBox(prefix.."Los siguientes staff están online: ",p,255,0,0,true)
		for k,v in ipairs(players) do
			if isPlayerStaff(v) and not(getElementData(v,"disguise")) then
				outputChatBox(prefix..getPlayerStaffLevel(v).." :"..getPlayerName(v),p,255,0,0,true)
			end
		end
	end
end
addCommandHandler("admins",printStaff)

function printStaffV2(p)
	if not(isGuestAccount(getPlayerAccount(p))) then
		local players=getElementsByType("player")
		outputChatBox(prefix.."Los siguientes staff están online: ",p,255,0,0,true)
		for k,v in ipairs(players) do
			if isPlayerStaff(v) then
				outputChatBox(prefix..getPlayerStaffLevel(v).." :"..getPlayerName(v),p,255,0,0,true)
			end
		end
	end
end
addCommandHandler("adminsv2",printStaffV2)

function isPlayerInACL ( player, acl )
	local account = getPlayerAccount ( player )
	if ( isGuestAccount ( account ) ) then
		return false
	end
	if ( aclGetGroup ( acl ) ) then
		return isObjectInACLGroup ( "user."..getAccountName ( account ), aclGetGroup ( acl ) )
	end 
	
	return false;
end

function getOnlineStaff ( )
	local online = { }
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		if ( isPlayerStaff ( v ) ) then
			table.insert ( online, v )
		end
	end
	return online
end


-- NG 1.1.4 --
-- Set element data to make getting staff on client side --
function setNewPlayerStaffData ( p )
	if ( isPlayerStaff ( p ) ) then 
		setElementData ( p, "staffLevel", getPlayerStaffLevel ( p, 'int' ) )
	else 
		setElementData ( p, 'staffLevel', -1 );
	end 
end

addEventHandler ( "onPlayerLogin", root, function ( )
	setNewPlayerStaffData ( source )
end );

addEventHandler ( "onResourceStart", resourceRoot, function ( )
	for _, p in pairs ( getElementsByType ( "player" ) ) do 
		setNewPlayerStaffData ( p );
	end 
end );

function unsetLevels(player)
	for i=0,5 do
		aclGroupRemoveObject ( aclGetGroup("Level "..i), "user."..getAccountName(getPlayerAccount(player)) )
	end
end

function setLevel(player,level)
	local cuenta = getPlayerAccount(player)
	if not(isGuestAccount(cuenta)) then
		unsetLevels(player)
		aclGroupAddObject(aclGetGroup("Level "..level),"user."..getAccountName(getPlayerAccount(player)))
	end
end


function promote(p,_,p2)
	local jugador2 = getPlayerFromName(p2) or exports['NGPlayerFunctions']:getPlayerFromNamePart (p2)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) then
		if jugador2 then
			if isPlayerStaff(jugador2) then
				local level=getPlayerStaffLevel(jugador2,"int")
				if level==0 then
					setLevel(jugador2,1)
				elseif level==1 then
					setLevel(jugador2,2)
				elseif level==2 then
					setLevel(jugador2,3)
				elseif level==3 then
					setLevel(jugador2,4)
				end
				outputChatBox("Has promovido a "..getPlayerName(jugador2).." a Level "..getPlayerStaffLevel(jugador2,"int"),p,255,0,0)
				outputChatBox("Has sido promovido por "..getPlayerName(p).." a Level "..getPlayerStaffLevel(jugador2,"int"),jugador2,255,0,0)
				outputChatBox(prefix.." el administrador #5A5959"..getPlayerName(p).."#FFFFFF ha promovido a #5A5959"..getPlayerName(jugador2).."#FFFFFF a nivel #5A5959"..getPlayerStaffLevel(jugador2,"int").."#FFFFFF. ¡Felicidades!.",root,255,0,0,true)
			else
				setLevel(jugador2,0)
				outputChatBox("Has promovido a "..getPlayerName(jugador2).." a Level "..getPlayerStaffLevel(jugador2,"int"),p,255,0,0)
				outputChatBox("Has sido promovido por "..getPlayerName(p).." a Level "..getPlayerStaffLevel(jugador2,"int"),jugador2,255,0,0)
				outputChatBox(prefix.." el administrador #5A5959"..getPlayerName(p).."#FFFFFF ha promovido a #5A5959"..getPlayerName(jugador2).."#FFFFFF a nivel #5A5959"..getPlayerStaffLevel(jugador2,"int").."#FFFFFF. ¡Felicidades!.",root,255,0,0,true)
			end
		else
			outputChatBox("Amigo, el jugador "..p2.." no está conectado o no existe",p,255,0,0)
		end
	else
		outputChatBox("Tienes que ser lvl 5 o Líder Admin para usar este comando",p,255,0,0)
	end
end
addCommandHandler("promote",promote)

function demote(p,_,p2)
	local jugador2 = getPlayerFromName(p2) or exports['NGPlayerFunctions']:getPlayerFromNamePart (p2)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) then
		if jugador2 then
			if isPlayerStaff(jugador2) then
				local level=getPlayerStaffLevel(jugador2,"int")
				if level==0 then
					unsetLevels(jugador2)
					outputChatBox("Has demoteado a "..getPlayerName(jugador2).." a jugador.",p,255,0,0)
					outputChatBox(prefix.." el administrador #5A5959"..getPlayerName(p).."#FFFFFF ha demoteado a #5A5959"..getPlayerName(jugador2).."#FFFFFF a jugador#FFFFFF.",root,255,0,0,true)
				elseif level==1 then
					setLevel(jugador2,0)
					outputChatBox("Has demoteado a "..getPlayerName(jugador2).." a Level 0.",p,255,0,0)
					outputChatBox(prefix.." el administrador #5A5959"..getPlayerName(p).."#FFFFFF ha demoteado a #5A5959"..getPlayerName(jugador2).."#FFFFFF a nivel #5A5959"..getPlayerStaffLevel(jugador2,"int").."#FFFFFF.",root,255,0,0,true)
				elseif level==2 then
					setLevel(jugador2,1)
					outputChatBox("Has demoteado a "..getPlayerName(jugador2).." a Level 1.",p,255,0,0)
					outputChatBox(prefix.." el administrador #5A5959"..getPlayerName(p).."#FFFFFF ha demoteado a #5A5959"..getPlayerName(jugador2).."#FFFFFF a nivel #5A5959"..getPlayerStaffLevel(jugador2,"int").."#FFFFFF.",root,255,0,0,true)
				elseif level==3 then
					setLevel(jugador2,2)
					outputChatBox("Has demoteado a "..getPlayerName(jugador2).." a Level 2.",p,255,0,0)
					outputChatBox(prefix.." el administrador #5A5959"..getPlayerName(p).."#FFFFFF ha demoteado a #5A5959"..getPlayerName(jugador2).."#FFFFFF a nivel #5A5959"..getPlayerStaffLevel(jugador2,"int").."#FFFFFF.",root,255,0,0,true)
				elseif level==4 then
					setLevel(jugador2,3)
					outputChatBox("Has demoteado a "..getPlayerName(jugador2).." a Level 3.",p,255,0,0)
					outputChatBox(prefix.." el administrador #5A5959"..getPlayerName(p).."#FFFFFF ha demoteado a #5A5959"..getPlayerName(jugador2).."#FFFFFF a nivel #5A5959"..getPlayerStaffLevel(jugador2,"int").."#FFFFFF.",root,255,0,0,true)
				end
				outputChatBox("Has sido demoteado por "..getPlayerName(p).." a Level "..getPlayerStaffLevel(jugador2,"int"),jugador2,255,0,0)
			else
				outputChatBox("Amigo, el jugador "..p2.." no es staff",p,255,0,0)
			end
		else
			outputChatBox("Amigo, el jugador "..p2.." no está conectado o no existe",p,255,0,0)
		end
	else
		outputChatBox("Tienes que ser lvl 5 o Líder Admin para usar este comando",p,255,0,0)
	end
end
addCommandHandler("demote",demote)

function unsetLevels2(cuenta)
	e=false
	for i=0,4 do
		e=aclGroupRemoveObject ( aclGetGroup("Level "..i), "user."..cuenta)
	end
	return e
end

function removeADM(p,_,xd)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) then
		if xd then
			local e= unsetLevels2(xd)
			if e then
				outputChatBox(prefix.."Se le quitaron los niveles de admin a "..xd,p,255,0,0,true)
			else
				outputChatBox(prefix.."No fue posible quitarle los niveles de admin a "..xd,p,255,0,0,true)
			end
		else
			outputChatBox("Sintaxis: /quitaradm cuenta level",p,255,0,0,true)
		end
	end
end
addCommandHandler("quitaradm",removeADM)

function darADM(p,_,xd,level)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) then
		if level and xd then
			local e= unsetLevels2(xd)
			if e then
				outputChatBox(prefix.."Se le quitaron los niveles de admin a "..xd,p,255,0,0,true)
			else
				outputChatBox(prefix.."No fue posible quitarle los niveles de admin a "..xd,p,255,0,0,true)
			end
			if tonumber(level)>4 then
				return
			end
			local a=aclGroupAddObject(aclGetGroup("Level "..level),"user."..xd)
			if a then
				outputChatBox(prefix.."Le diste "..level.." a "..xd,p,255,0,0,true)
			end
		else
			outputChatBox(prefix.."Sintaxis: /darlevel (cuenta) (level)",p,255,0,0,true)
		end
	end
end
addCommandHandler("darlevel",darADM)


function verAdminList(p,_,xd)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) then
		local staff=getAllStaff()
		for level,v in pairs(staff) do
			for k,admin in ipairs(v) do
				if xd==nil then
					outputChatBox(prefix..level..": "..admin,p,255,0,0,true)
				else
					local nivel="Level "..xd
					if level==nivel then
						outputChatBox(prefix..level..": "..admin,p,255,0,0,true)
					end
				end
			end
		end
	else
		outputChatBox("Tienes que ser lvl 5 o Líder Admin para usar este comando",p,255,0,0)
	end
end
addCommandHandler("veradmins",verAdminList)

local alloweddj={"Jimenez","V-neko_Kawaii"}
local allowedprod={"RicardoJorge"}

function isAllowedDJ(cuenta)
	e = false
	for k,v in ipairs(alloweddj) do
		if cuenta==v then
			e= true
		end
	end
	return e
end

function isAllowedProd(cuenta)
	e = false
	for k,v in ipairs(allowedprod) do
		if cuenta==v then
			e= true
		end
	end
	return e
end

function darDJ(p,_,p2)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) or isAllowedDJ(getAccountName(getPlayerAccount(p))) then
		if p2 then
			local e = aclGroupAddObject(aclGetGroup("DJ"),"user."..p2)
			if e then
				outputChatBox(prefix.."Le diste DJ a "..p2,p,255,0,0,true)
			else
				outputChatBox(prefix.."No fue posible darle DJ a ese jugador. Revisa que no tenga ya DJ.",p,255,0,0,true)
			end
		else
			outputChatBox(prefix.."Sintaxis: /dardj (cuenta)",255,0,0,true)
		end
	end
end
addCommandHandler("dardj",darDJ)

function darProd(p,_,p2)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) or isAllowedProd(getAccountName(getPlayerAccount(p))) then
		if p2 then
			local e = aclGroupAddObject(aclGetGroup("Productores"),"user."..p2)
			if e then
				outputChatBox(prefix.."Le diste Productor a "..p2,p,255,0,0,true)
			else
				outputChatBox(prefix.."No fue posible darle Productor a ese jugador. Revisa que no tenga ya Productor.",p,255,0,0,true)
			end
		else
			outputChatBox(prefix.."Sintaxis: /darprod (cuenta)",255,0,0,true)
		end
	end
end
addCommandHandler("darprod",darProd)

function quitarProd(p,_,p2)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) or isAllowedProd(getAccountName(getPlayerAccount(p))) then
		if p2 then
			local e = aclGroupRemoveObject(aclGetGroup("Productores"),"user."..p2)
			if e then
				outputChatBox(prefix.."Le removiste el Productor a "..p2,p,255,0,0,true)
			else
				outputChatBox(prefix.."No fue posible remover el Productor a ese jugador. Revisa que no lo hayas removido ya.",p,255,0,0,true)
			end
		else
			outputChatBox(prefix.."Sintaxis: /quitarprod (cuenta)",255,0,0,true)
		end
	end
end
addCommandHandler("quitarprod",quitarProd)

function quitarDJ(p,_,p2)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) or isAllowedDJ(getAccountName(getPlayerAccount(p))) then
		if p2 then
			local e = aclGroupRemoveObject(aclGetGroup("DJ"),"user."..p2)
			if e then
				outputChatBox(prefix.."Le removiste el DJ a "..p2,p,255,0,0,true)
			else
				outputChatBox(prefix.."No fue posible remover el DJ a ese jugador. Revisa que no lo hayas removido ya.",p,255,0,0,true)
			end
		else
			outputChatBox(prefix.."Sintaxis: /quitardj (cuenta)",255,0,0,true)
		end
	end
end
addCommandHandler("quitardj",quitarDJ)

function listaDJ(p)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) or isAllowedDJ(getAccountName(getPlayerAccount(p))) then
		for k, v in ipairs ( aclGroupListObjects ( aclGetGroup ( "DJ" ) ) ) do
			if ( string.find ( tostring ( v ), 'user.' ) ) then
				local name = tostring ( v:gsub ( "user.", "" ) )
				outputChatBox(prefix.."Cuenta de DJ: "..name,p,255,0,0,true)
			end
		end
	end
end
addCommandHandler("listadj",listaDJ)

function listaProd(p)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) or isAllowedProd(getAccountName(getPlayerAccount(p))) then
		for k, v in ipairs ( aclGroupListObjects ( aclGetGroup ( "Productores" ) ) ) do
			if ( string.find ( tostring ( v ), 'user.' ) ) then
				local name = tostring ( v:gsub ( "user.", "" ) )
				outputChatBox(prefix.."Cuenta de Productor: "..name,p,255,0,0,true)
			end
		end
	end
end
addCommandHandler("listaprod",listaProd)

function helpLider(p)
	if getPlayerStaffLevel(p,"int")==5 or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(p)),aclGetGroup("LiderADM")) then
		outputChatBox(prefix.."Comandos Líder ADM:",p,255,255,0,true)
		outputChatBox("/promote (jugador): Promueves a alguien de lvl (desde jugador hasta lvl 4)",p,255,255,0,true)
		outputChatBox("/demote (jugador): Bajas a alguien de lvl (desde lvl 4 hasta jugador)",p,255,255,0,true)
		outputChatBox("/veradmins (nivel-opcional): Ves la lista de admins completa o por niveles",p,255,255,0,true)
		outputChatBox("/darlevel (login) (level): Le das un nivel a alguien",p,255,255,0,true)
		outputChatBox("/quitaradm (login): Le quitas el admin a alguien",p,255,255,0,true)
		outputChatBox("/dardj (login): Le das el dj a alguien",p,255,255,0,true)
		outputChatBox("/darprod (login): Le das el productor a alguien",p,255,255,0,true)
		outputChatBox("/quitardj (login): Le quitas el dj a alguien",p,255,255,0,true)
		outputChatBox("/quitarprod (login): Le quitas el productor a alguien",p,255,255,0,true)
		outputChatBox("/listaprod: Ves a todos los productores",p,255,255,0,true)
		outputChatBox("/listadj: Ves a todos los DJ",p,255,255,0,true)
	end
end
addCommandHandler("helplider",helpLider)

