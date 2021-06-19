addEvent ( "client_ReturnPermissions", true )
addEvent ( "client_ReturnPrecio", true)
addEvent ( "client_ReturnPermissions", true )
addEvent ( "client_ReturnAvailableTeleports", true )
addEvent ( "client_ReturnSpecificTeleport", true )
teleRows = {}
precio = 0

function toggleTeleportManager()
	if guiGetVisible ( teleManager ) == true or guiGetVisible ( teleWizard ) == true then
		guiSetVisible ( teleManager, false )
		guiSetVisible ( teleWizard, false )
		showCursor ( false )
		guiGridListClear ( list )
		guiSetInputEnabled ( false )
	else
		guiSetVisible ( teleManager, true )
		showCursor ( true )
		processAvailableTeleports()
		getPrecios()
	end
end

function processAvailableTeleports()
	triggerServerEvent ( "client_CallAvailableTeleports", getLocalPlayer() )
end


function checkPermissions()
	triggerServerEvent ( "client_CheckPermissions", getLocalPlayer() )
end

function getPrecios ( )
    triggerServerEvent ( "getPrecios", getLocalPlayer() )
end

function returnPrecios ( precios )
	precio = tonumber(precios)
	outputChatBox ( "*Teletransportarte cuesta "..tostring(precio), 255, 0, 0 )
end

function client_ReturnPermissions ( isAdmin )
	if isAdmin == true then
		setElementData ( getLocalPlayer(), "allowedToCreateTele", true )
	elseif isAdmin == false then
		setElementData ( getLocalPlayer(), "allowedToCreateTele", false )
	end
end

function client_ReturnAvailableTeleports ( availableTele, tNodeType, teleNodeX, teleNodeY, teleNodeZ, teleNodeDesc, number )
	if availableTele == false then
		teleRows[1] = guiGridListAddRow ( list )
		guiGridListSetItemText ( list, teleRows[1], listDescColumn, "*No Available Teleports*", false, false )
		guiSetEnabled ( teleManagerUseTele, false )
		guiSetEnabled ( teleManagerDeleteTele, false )
	else
		teleRows[number] = guiGridListAddRow ( list )
		guiGridListSetItemText ( list, teleRows[number], listDescColumn, ""..teleNodeDesc.."", false, false )
		guiGridListSetItemText ( list, teleRows[number], listTypeColumn, tostring(tNodeType), false, false )
		guiSetEnabled ( teleManagerUseTele, true )
		guiSetEnabled ( teleManagerDeleteTele, true )
	end
end

function canTeleport(p)
	local rango = getElementData(localPlayer,"Job Rank")
	if (rango=="Keisuke Takahashi" or rango=="Han" or rango=="Ryosuke Takahashi" or rango=="Takumi Fujiwara") then
		return true
	else
		return false
	end
end

function client_ReturnSpecificTeleport ( x, y, z, rot, warpType, desc )
	if (getElementDimension(localPlayer)~=0 or getElementInterior(localPlayer)~=0) then
		return outputChatBox ( "*No puedes usar el tele en interiores", 255, 0, 0 )
	end
	if (getElementData(localPlayer,"VIP")=="Esmeralda" or getPlayerMoney(localPlayer)>=precio or canTeleport(localPlayer)) then
		if rot == nil or rot == false then 
			rot = 0 
		end
		if warpType == nil or warpType == false then 
			warpType = "foot only" 
		end
		if isPedInVehicle ( getLocalPlayer() ) == true then
			if getVehicleController ( getPedOccupiedVehicle ( getLocalPlayer() ) ) == getLocalPlayer() then
				if warpType == "both" or warpType == "vehicle only" then
					setTimer ( setVehicleFrozen, 1500, 1, getPedOccupiedVehicle ( getLocalPlayer() ), true )
					fadeCamera ( false, 1 )
					setTimer ( setElementPosition, 1500, 1, getPedOccupiedVehicle ( getLocalPlayer() ), x, y, z )
					setTimer ( setElementRotation, 1500, 1, getPedOccupiedVehicle ( getLocalPlayer() ), 0, 0, rot )
					setTimer ( setVehicleFrozen, 3000, 1, getPedOccupiedVehicle ( getLocalPlayer() ), false )
					setTimer ( fadeCamera, 200, 1, true, 1 )
					triggerServerEvent ( "Caldo", getLocalPlayer(),getPlayerName(getLocalPlayer()), desc )
					if not (getElementData(localPlayer,"VIP")=="Esmeralda") then
						if not (canTeleport(localPlayer)) then
							triggerServerEvent("quitarluquita", localPlayer, localPlayer)
						end
					end
				elseif warpType == "foot only" then
					outputChatBox ( "*Tienes que estar a pie para usar este warp", 255, 0, 0 )
				end
			end
		elseif isPedInVehicle ( getLocalPlayer() ) == false then
			if (getElementDimension(localPlayer)~=0 or getElementInterior(localPlayer)~=0) then 
				return outputChatBox ( "*No puedes usar el tele en interiores", 255, 0, 0 ) 
			end
			if warpType == "both" or warpType == "foot only" then
				fadeCamera ( false, 1 )
				setTimer ( setElementPosition, 2000, 1, getLocalPlayer(), x, y, z )
				triggerServerEvent ( "Caldo", getLocalPlayer(), getPlayerName(getLocalPlayer()), desc )
				setTimer ( setPedRotation, 2000, 1, getLocalPlayer(), tonumber(rot) )
				setTimer ( fadeCamera, 200, 1, true, 1 )
				if not (getElementData(localPlayer,"VIP")=="Esmeralda") then
					if not (canTeleport(localPlayer)) then
						triggerServerEvent("quitarluquita", localPlayer, localPlayer)
					end
				end
			elseif warpType == "vehicle only" then
				outputChatBox ( "*Tienes que estar en un vehiculo para usar este warp", 255, 0, 0 )
			end
		end
	else
		outputChatBox ( "*Teletransportarte cuesta "..tostring(precio).." para VIP Esmeralda y rangos altos de Drifter es GRATIS!", 255, 0, 0 )
		if getElementData(localPlayer,"Job")=="Drifter" then
			exports.NGMessages:sendClientMessage ( "Necesitas tener mínimo el rango Keisuke Takahashi para teletransportarte gratis.", 255, 0, 0 )
		end
	end
end

addCommandHandler ( "tele", toggleTeleportManager )
addEventHandler ( "client_ReturnPrecio", getRootElement(), returnPrecios )
addEventHandler ( "client_ReturnPermissions", getRootElement(), client_ReturnPermissions )
addEventHandler ( "client_ReturnAvailableTeleports", getRootElement(), client_ReturnAvailableTeleports )
addEventHandler ( "client_ReturnSpecificTeleport", getRootElement(), client_ReturnSpecificTeleport )