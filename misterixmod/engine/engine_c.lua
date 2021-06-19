--ENGINE CLIENT SIDE

function getNearestElement( element, x, y, z, maxRangeDetection )
if not element then return false end if not x then return false end if not y then return false end if not z then return false end
local maxRangeDetection = maxRangeDetection or 20
local count = 0
for k,v in ipairs(getElementsByType(element)) do
local ex,ey,ez = getElementPosition(v)
local distance = getDistanceBetweenPoints3D(ex,ey,ez,x,y,z)
if distance < maxRangeDetection then
if not ( count == 1 ) then
count = count+1
return v
end
end
end
end

function isPedAMystery(ped,mysteryName) -- Detect if ped is a mystery
    if isElement(ped) then
	    local data = getElementData( ped, "Misterix" )
	    if not mysteryName then
		    if data == false then
		        return false
			else
                return true			
			end
		end
        if not data == false then
	        if data == mysteryName then
			    return true
		    else
			    return false
			end
	    end
	end
end

addEventHandler("onClientPedDamage", root,
    function(attacker,wp,bodypart,loss)
        if isPedAMystery(source) then
			triggerEvent( "MYSTERY:doAction", source, "hunt", attacker )
            local health = getElementData( source, "MYSTERY:health" )
            if health > 1 then
                cancelEvent()
				local mloss = 8
				if bodypart == 9 then
				    mloss = 4
				end
                setElementData( source, "MYSTERY:health", health-loss/mloss )
				--outputChatBox("Extra Health : "..health-loss/mloss, 255, 0, 0 )
            else
                setElementData( source, "MYSTERY:health", 0 )
            end
			if ( wp == 34 ) then
			    setPedAnimation( source, "ped", "Hit_front", -1, false, true, true, false )
			end
        end
    end
)

local melee_slots = { [0] = true, [1] = true, [9] = true, [10] = true, [11] = true, [12] = true }
local fire_slots = { [2] = true, [3] = true, [4] = true, [5] = true }

addEvent("MYSTERY:doAction", true)
addEventHandler("MYSTERY:doAction", root,
    function(action,target)
	    if not action then
            return false
        end
		if action == "start" then
            setPedControlState( source, "forwards", true )
			setPedVoice(source, "PED_TYPE_DISABLED")
        elseif action == "stop" then
           	setPedControlState( source, "forwards", false )	
	    elseif action == "search" then
		    local x, y, z = getElementPosition(source)
			for k,col in ipairs(getElementsByType("colshape")) do
                local colData = getElementData( col, "MYSTERY:col" )
				if not colData == false then
                    local nP = getNearestElement("player", x, y, z, 50)
                    if isElement(nP) then
					    if isElementWithinColShape(nP, col) then
                            setElementData(source, "MYSTERY:target", nP)
						end	
                    end
			    end	
		    end	
		elseif action == "hunt" then
		    if not isPedDead(source) then
        	    if not target then
			       return false
			    end
                local x, y, z = getElementPosition(source)
                if isElement(target) then
				    for k,col in ipairs(getElementsByType("colshape")) do
                        local colData = getElementData( col, "MYSTERY:col" )
				        if not colData == false then
						    if isElementWithinColShape(target, col) then 
                                local tx, ty, tz = getElementPosition(target)
                                local xx, xy, xz = getElementPosition(source)
								if isPedDucked(target) then
								setPedAimTarget( source, tx, ty, tz-0.5 )								
								else
								setPedAimTarget( source, tx, ty, tz )
								end
                                local r = getPedRotation(source)
                                xx = xx - math.sin(math.rad(r)) * 2
                                xy = xy + math.cos(math.rad(r)) * 2
                                if (isLineOfSightClear(x, y, z, xx, xy, xz, true, true, false, true, false, true)) then
                                    local rx = math.atan2(ty - y, tx - x) * 180 / math.pi
                                    setPedRotation(source, rx + 270)
                                else
                                    setPedRotation(source, r + 90)
								end	
							end
                        end							
                    end
                end			
            end 
	    elseif action == "attack" then
		    if isElement(source) then
			    if not isPedDead(source) then
			        local tx,ty,tz = getElementPosition(target)
			        setPedAimTarget( source, tx, ty, tz )
                    if melee_slots[getPedWeaponSlot(source)] then
				        setPedControlState( source, "forwards", false )
				        setPedControlState( source, "fire", true )
				        setTimer( setPedControlState, 300, 1, source, "fire", false )
				    elseif fire_slots[getPedWeaponSlot(source)] then  
                        setPedControlState( source, "fire", true )
				        setTimer( setPedControlState, 4000, 1, source, "fire", false ) 	
				    elseif getPedWeaponSlot(source) == 8 then
				        local x,y,z = getElementPosition(source)
						--[[
                        if getPedWeapon(source) == 16 then
                            createProjectile( target, 16, x, y, z, -500 )
						    setPedControlState( source, "fire", true )
				            setTimer( setPedControlState, 6000, 1, source, "fire", false ) 							
                        end	
						]]
                    elseif getPedWeaponSlot(source) == 7 then
				        if getPedWeapon(source) == 36 then
                            local x,y,z = getElementPosition(source)
							local distance = getDistanceBetweenPoints3D( tx, ty, tz, x, y, z )
							if distance > 5 then
						        setPedControlState( source, "forwards", false )
						        setPedControlState( source, "aim_weapon", true )							
						        setPedControlState( source, "zoom_in", true )
						        setPedControlState( source, "fire", true )					
						        setTimer( setPedControlState, 300, 1, source, "forwards", true )
						        setTimer( setPedControlState, 300, 1, source, "fire", false )
						        setTimer( setPedControlState, 300, 1, source, "zoom_in", false )		
						        setTimer( setPedControlState, 300, 1, source, "aim_weapon", false )							
                                --setPedAnimation( source, "rocket", "rocketfire", -1, false, false, true, false )					
						        local mx,my,mz = getPedWeaponMuzzlePosition(source)
                                if mx then							
                                    local r = getPedRotation ( source )
                                    mx = mx - math.sin ( math.rad ( r ) ) * 1.5
                                    my = my + math.cos ( math.rad ( r ) ) * 1.5				
                                    setTimer( createProjectile, 100, 1, target, 20, mx, my, mz, 400, target )
							    end
							end
					    elseif getPedWeapon(source) == 35 then
					        local x,y,z = getElementPosition(source)
							local distance = getDistanceBetweenPoints3D( tx, ty, tz, x, y, z )
							if distance > 5 then
						        setPedControlState( source, "forwards", false )
						        setPedControlState( source, "aim_weapon", true )							
						        setPedControlState( source, "zoom_in", true )
						        setPedControlState( source, "fire", true )					
						        setTimer( setPedControlState, 300, 1, source, "forwards", true )
						        setTimer( setPedControlState, 300, 1, source, "fire", false )
						        setTimer( setPedControlState, 300, 1, source, "zoom_in", false )		
						        setTimer( setPedControlState, 300, 1, source, "aim_weapon", false )						
                                local r = getPedRotation ( source )
						        local mo = createObject( 345, x, y, z+0.5, 0, 0, r )
						        local dist = math.floor(getDistanceBetweenPoints3D( x, y, z, tx, ty, tz )+8)
                                x = x - math.sin ( math.rad ( r ) ) * dist
                                y = y + math.cos ( math.rad ( r ) ) * dist	
                                moveObject( mo, 2000, x, y, tz )
                                setTimer( destroyElement, 2000, 1, mo )						
                                setTimer( createExplosion, 2000, 1, x, y, tz, 2 )
							end
						elseif getPedWeapon(source) == 37 then
						    local x,y,z = getElementPosition(source)
						    local nP = getNearestElement("player",x,y,z,15)
							if isElement(nP) then
							    setPedControlState( source, "aim_weapon", true )
								setTimer( setPedControlState, 7000, 1, source, "aim_weapon", false )
                                setPedControlState( source, "fire", true )
				                setTimer( setPedControlState, 7000, 1, source, "fire", false )
                            end	
                        elseif getPedWeapon(source) == 38 then
							setPedControlState( source, "aim_weapon", true )
							setTimer( setPedControlState, 4000, 1, source, "aim_weapon", false )						
                            setPedControlState( source, "fire", true )
				            setTimer( setPedControlState, 4000, 1, source, "fire", false )						
                        end		
                    elseif getPedWeaponSlot(source) == 6 then
                        if getPedWeapon(source) == 33 then
                            setPedControlState( source, "fire", true )
				            setTimer( setPedControlState, 5000, 1, source, "fire", false ) 
                        elseif getPedWeapon(source) == 34 then
						    setPedControlState( source, "aim_weapon", true )							
						    setPedControlState( source, "zoom_in", true )
						    setPedControlState( source, "fire", true )							
				            setTimer( setPedControlState, 5000, 1, source, "fire", false ) 		
				            setTimer( setPedControlState, 5000, 1, source, "aim_weapon", false ) 	
				            setTimer( setPedControlState, 5000, 1, source, "zoom_in", false ) 	
                        end							
                    end					
				end
			end
        end
	end	
)

addEventHandler("onClientPedWasted", root,
    function()
        local blipCreated = getElementData( source, "MYSTERY:blip" )
		if not blipCreated == false then
            if isElement(blipCreated) then
                destroyElement(blipCreated)
            end				
	    end
    end
)	

addEventHandler("onClientColShapeHit", root,
    function(player)
	    local data = getElementData( source, "MYSTERY:col" )
        if not data == false then
            if ( getElementType(player) == "player" ) and ( player == getLocalPlayer() ) then
			    local x,y,z = getElementPosition(data)
                if x then
				    local blipCreated = getElementData( data, "MYSTERY:blip" )
					if blipCreated == false then
				        local blip = createBlip( x, y, z, 0, 2, 255, 0, 0, 255 )
					    attachElements( blip, data )
					    setElementData( data, "MYSTERY:blip", blip )
					end
                end				
			end
        end		
	end
)	

addEventHandler("onClientColShapeLeave", root,
    function(ped)
	    local data = getElementData( source, "MYSTERY:col" )
		if not data == false then
	        if getElementType(ped) == "ped" then
                if isPedAMystery(ped) then 
			        if data == ped then
			            setElementData( ped, "MYSTERY:target", false )
					    local r = getPedRotation(ped)
                        setPedControlState( ped, "forwards", false )
                        setTimer( setPedControlState, 70, 1, ped, "forwards", true )						
				        setTimer( setPedRotation, 2400, 1, ped, r+180 )
					    setTimer(setPedAnimation, 50, 1, ped, "ped", "fucku", -1, false, false, true, false )
					    setTimer( triggerEvent, 9000, 1, "MYSTERY:doAction", ped, "stop" )
					end
			    end
			end	
		    if ( getElementType(ped) == "player" ) and ( ped == getLocalPlayer() ) then
			    local blipCreated = getElementData( data, "MYSTERY:blip" )
				if not blipCreated == false then
				    if isElement(blipCreated) then
						destroyElement(blipCreated)
						setElementData( data, "MYSTERY:blip", false )
					end
				end  			
			end
		end	
    end
)

addEventHandler("onClientPlayerStealthKill", localPlayer,
    function(target)
        if isPedAMystery(target) then
		    cancelEvent()
		end
    end
)