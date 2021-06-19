local evento = false
local warptoevent = false
local carrazosevento = {}
local participantesevento = {}
local entradosevento = {}
local ejob = false
local ecar = false
local dmntion = 0
local psword = false
local x,y,z = 0,0,0
local frozen = false
local playerlimit = false
local passive = false

function canCreateEvent(plr)
	local acc = getPlayerAccount(plr)
	local accName = getAccountName(acc)
	local retorno = false
	if isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 4" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 3" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 2" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "GangLeader" )) then
		retorno = true
	end
	return retorno
end


function abrirVentana(thePlayer)
	local cuenta = getPlayerAccount(thePlayer)
	local accName = getAccountName(cuenta)
    if not isGuestAccount(cuenta) and isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 4" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 3" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 2" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "GangLeader" )) then
		triggerClientEvent(thePlayer, "onServerAbrirVentana2", thePlayer)
    end
end
addCommandHandler("crearevento", abrirVentana)

function makeItToServer2(thePlayer,job,vehiculo,dimension,frzn,password,players,desc)
	crearEvento(thePlayer,job,vehiculo,dimension,frzn,password,players,desc)
end

addEvent("makeItToServer2", true)
addEventHandler("makeItToServer2", root, makeItToServer2)

function crearEvento( p,job,vehiculo,dimension,frzn,password,players,desc,mp )
	local accName = getAccountName ( getPlayerAccount ( p ) )
	if evento then exports['NGMessages']:sendClientMessage ( "Hay un evento activo! Espera que el otro lider de clan/admin lo termine", p, 255, 255, 0 ) return end
	if canCreateEvent(p) then
		if (vehiculo and dimension and password) then
			evento = true
			if job then
				ejob=true
			end
			x,y,z = getElementPosition(p)
			if password ~= "" then
				psword=password
			end
			if vehiculo~="" then
                ecar = vehiculo
			end
			if frzn then
                frozen = true
			end
			local tienecontrasena=""
			if psword then
				tienecontrasena=" con contraseña "
            end
            if players~="" then
                playerlimit=tonumber(players)
			end
			if dimension~="" then
				dmntion=tonumber(dimension)
			end
            for k, player in ipairs(getElementsByType("player")) do
                participantesevento[player]=true
			end
			local limitejugadores =""
			if playerlimit then
				limitejugadores=(" con límite de jugadores de "..players)
			end
			if mp then
				passive=true
			end
            warptoevent=true
			outputChatBox ("***************************************************************************", getRootElement(), 255, 0, 0, true) 
			outputChatBox ("#F8A2FA"..getPlayerName(p).." #FFFFFFha creado un evento"..tienecontrasena..limitejugadores..", warpeate con #00FFF7/entrarevento#FFFFFF.", getRootElement(), 255, 0, 0, true) 
			outputChatBox ("#FFAA3EDescripción del evento:#FFFFFF "..desc, getRootElement(), 255, 0, 0, true) 
			outputChatBox ("***************************************************************************", getRootElement(), 255, 0, 0, true) 
			outputChatBox ("Hola admin, recuerda que puedes usar /sacarevento, /desactivarwarp, /comenzarevento (si los congelaste), y /terminarevento", p, 255, 0, 0, true) 
		else
			exports['NGMessages']:sendClientMessage ( "Syntax: /crearevento [quitartrabajo(1/0)] [vehiculo(idcarro o /0)] [dimensión (0 para mundo normal)] [congelarlos(1/0)][contraseña o 0 (si no tiene)] [descripción]", p, 255, 255, 0 )
		end
	end
end
  
function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

addCommandHandler ("entrarevento", 
function ( thePlayer,_,password ) 
	if (not warptoevent) then return end
    if not evento then return end
	if (not participantesevento[thePlayer]) then 
		return 
	end 
	if (getElementDimension(thePlayer)~=0) then return end
	if (getElementInterior(thePlayer)~=0) then return end
	if psword then
		if (password~=psword) then
			exports['NGMessages']:sendClientMessage ( "La contraseña del evento es incorrecta", thePlayer, 255, 255, 0 )
			return
		end
	end
	if playerlimit then
		if table.size(entradosevento)>playerlimit then 
			return exports['NGMessages']:sendClientMessage ( "El límite de jugadores ya se completó", thePlayer, 255, 255, 0 )
		end
	end
	if frozen and not(canCreateEvent(thePlayer)) then
		setElementFrozen(thePlayer,true)
	end
	local delay = math.random(0,10)
	setElementPosition(thePlayer,x+delay,y,z)
	setElementDimension(thePlayer,dmntion)
	setElementHealth ( thePlayer, 100 )
	setPedArmor( thePlayer, 100 )
	participantesevento[thePlayer]=nil
	entradosevento[thePlayer]=true
	setElementData(thePlayer,"isPassive",true)
	if ejob then
        local j = getElementData ( thePlayer, "Job" )
		local r = getElementData ( thePlayer, "Job Rank" )
        setElementData ( thePlayer, "Job", "UnEmployed" )
        exports['NGPlayerFunctions']:setTeam ( thePlayer, "Unemployed" )
        setElementData ( thePlayer, "Job Rank", "None" )
		if ( isPedInVehicle ( thePlayer ) ) then removePedFromVehicle ( thePlayer ) end
		local skin = tonumber ( getElementData ( thePlayer, "NGUser.UnemployedSkin" ) )
		if ( not skin ) then
			setElementData ( thePlayer, "NGUser.UnemployedSkin", 28 )
			skin = 28
		end
	end
	if ecar then
		outputChatBox("*********************************************************************",thePlayer,255,0,0,true)
		outputChatBox("#FFFFFFEste evento está configurado con vehículos, usa #00FFE4/vehiculoevento", thePlayer, 255, 0, 0, true)
	end
    outputChatBox ("#FFFFFFEl jugador #00FFE4"..getPlayerName(thePlayer).." #FFFFFFse ha unido al evento. Únete tú también! #02665B/entrarevento", getRootElement(), 255, 0, 0, true) 
end )


addCommandHandler ( "terminarevento", 
function ( thePlayer,_,p2 )
	local accName = getAccountName ( getPlayerAccount ( thePlayer ) )
	if evento and canCreateEvent(thePlayer) then 
	local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
	if not toJ then 
		return 
	end
	evento=false
	for k,v in pairs(carrazosevento) do
		executeCommandHandler("kill",k)
		destroyElement(v)
	end
	for k,v in pairs(entradosevento) do
		if isElement(k) and getElementType(k) == "player" then
			setElementFrozen(k,false)
			setElementDimension(k,0)
			setElementData(thePlayer,"isPassive",false)
		end
	end
	evento = false
	warptoevent = false
	carrazosevento = {}
	participantesevento = {}
	entradosevento = {}
	ejob = false
	ecar = false
	dmntion = 0
	psword = false
	x,y,z = 0,0,0
	outputChatBox ("#FFFFFFEl jugador #FFAA3E"..getPlayerName(toJ).." #FFFFFFha ganado el evento organizado por #FFAA3E"..getPlayerName(thePlayer).." #FFFFFF!", getRootElement(), 255, 0, 0, true) 
end
end )

addCommandHandler ( "comenzarevento", 
function ( thePlayer ) 
	local accName = getAccountName ( getPlayerAccount ( thePlayer ) )
	if evento and isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 5" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 4" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 3" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "Level 2" )) or isObjectInACLGroup("user."..accName, aclGetGroup ( "GangLeader" )) then
		for k,v in pairs(entradosevento) do
			if isElement(k) then
				setElementFrozen(k,false)
				if not passive then
					setElementData(k,"isPassive",false)
				end
			end
		end
		outputChatBox ("#FFFFFFEl evento organizado por #FFAA3E"..getPlayerName(thePlayer).." ha comenzado#FFFFFF!", getRootElement(), 255, 0, 0, true) 
		participantesevento=nil
	end
end )

addCommandHandler ( "sacarevento", 
function ( thePlayer,_,p2 ) 
	local accName = getAccountName ( getPlayerAccount ( thePlayer ) )
	if evento and canCreateEvent(thePlayer) then 
		local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
		if not toJ then 
			return 
		end
		entradosevento[toJ]=nil
		if carrazosevento[p2] then
			destroyElement(carrazosevento[p2])
		end
		setElementDimension(toJ,0)
		outputChatBox ("#FFFFFFEl jugador #02665B"..getPlayerName(thePlayer).." #FFFFFFha expulsado a #02665B"..getPlayerName(toJ).." #FFFFFFdel evento.", getRootElement(), 255, 0, 0, true) 
	end
end )

addCommandHandler ( "vehiculoevento", 
function ( thePlayer ) 
	if (not carrazosevento[thePlayer] and entradosevento[thePlayer]) or canCreateEvent(thePlayer) then
		if not ecar then 
			return 
		end
		if not getElementDimension(thePlayer) == dmntion then 
			return 
		end
		local x1,y1,z1 = getElementPosition(thePlayer)
		carrazosevento[thePlayer]=createVehicle(tonumber(ecar),x1,y1,z1)
		setElementDimension(carrazosevento[thePlayer],getElementDimension(thePlayer))
		warpPedIntoVehicle(thePlayer,carrazosevento[thePlayer])
	end
end )

function traerEvento(p,_,p2)
	if canCreateEvent(p) then
		local thePlayer = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
		if thePlayer then
			if evento then
				local delay = math.random(0,10)
				setElementPosition(thePlayer,x+delay,y,z)
				setElementDimension(thePlayer,dmntion)
				setElementHealth ( thePlayer, 100 )
				setPedArmor( thePlayer, 100 )
			else
				outputChatBox("No hay un evento activo",p,255,0,0)
			end
		else
			outputChatBox("Parcero ese jugador no existe",p,255,0,0)
		end
	else
		outputChatBox("Tú no puedes crear eventos por lo tanto no puedes traer gente al evento",p,255,0,0)
	end
end
addCommandHandler("traerevento",traerEvento)