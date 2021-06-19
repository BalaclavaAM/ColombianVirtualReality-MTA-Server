function manageColShape(hitElement,isDimension)
    if isElement(hitElement) then
        if getElementType(hitElement)=="player" then
            if not(exports['NGAdministration']:isPlayerStaff(hitElement)) then
                
                setElementPosition(hitElement,702.16+math.random(0,4),-1276.32+math.random(0,4),13.65,true)
            
            end
        else
            destroyElement(hitElement)
        end
	end
end

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


function createColShapes()
    local momazos=createColCuboid(718.01129, -1300.0067, 13.645313, 11.25, 49, 10)
    addEventHandler("onColShapeHit",momazos,manageColShape)
end
addEventHandler("onResourceStart",resourceRoot,createColShapes)


local limos={}
function createSuperLimo(p)
    if isPlayerInACL ( p, 'Level 5' ) then
        local x,y,z = getElementPosition(p)
        if limos[p] and isElement(limos[p]) then
            destroyElement(limos[p])
        end
        limo[p]=createVehicle(409,x,y,z)        
    end
end