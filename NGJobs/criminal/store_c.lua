
--exports.ngwarpmanager:makeWarp ( { pos = { 1315.36, -897.68, 40.58 }, toPos = { -31.36129, -89.49852, 1003.546882 }, cInt = 0, cDim = 0, tInt = 18, tDim = 0 } )
--exports.ngwarpmanager:makeWarp ( { pos = { -31.03502, -92.00517, 1004.54688 }, toPos = { 1315.36, -897.68, 39.58 }, cInt = 18, cDim = 0, tInt = 0, tDim = 0 } )


function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

function targetingActivated ( target )
	if ( target ) and getPedWeaponSlot ( source ) ~= 0 then
		if  isPedAiming ( source ) then
			if getElementType(target) == "ped" then
				if getElementData(source,"Job") == "Criminal" then
					if getElementData(target,"theft") == 1 then
						setElementData(target,"theft", 0)
						triggerServerEvent("startStoreTheft", source, target)
						exports['NGMessages']:sendClientMessage ("Has comenzado a robar la tienda, espera 2 minutos a que el empleado te entregue el dinero.",source,255,0,0)
						outputChatBox("#FFFF00Empleado:#FFFFFFAaa parce no me haga nada, ya le doy todo relajelo.",0,0,0,true)
					elseif getElementData(target,"theft") == 0 then
						exports['NGMessages']:sendClientMessage ("Esta tienda ya esta siendo o fue robada, vuelve mas tarde.",source,255,0,0)
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), targetingActivated )

function cancelPedDamage ( attacker )
	if attacker and getElementData(source,"canYouRobThisPed") then
		cancelEvent() -- cancel any damage done to peds
	end
end
addEventHandler ( "onClientPedDamage", resourceRoot, cancelPedDamage )