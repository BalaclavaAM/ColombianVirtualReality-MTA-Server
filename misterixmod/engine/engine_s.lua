--ENGINE SERVER SIDE

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

function createMystery( name, x, y, z, extraHealth, areaSize, reward )
    if not name then
        return false
    end
    if not x then
        return false
    end
    if not y then
        return false
    end
    if not z then
        return false
    end
	local model
    if name == "Bigfoot" then
	    model = 122  
    elseif name == "CaveDemon" then
	    model = 220
    elseif name == "Jason" then
	    model = 112  
    elseif name == "Leatherface" then
	    model = 118  
    elseif name == "Lizard" then
	    model = 209  
    elseif name == "Nemesis" then
	    model = 103  
    elseif name == "Pigsy" then
	    model = 131
    elseif name == "Samara" then
	    model = 101
    elseif name == "Yeti" then
	    model = 102
	elseif name == "SerialKiller" then
        model = 33	
    elseif name == "Other" then
        model = math.random(0,200)	
	end
	local extraHealth = extraHealth or 100
	local areaSize = areaSize or 100
	local reward = reward or 0
	if areaSize > 300 then
	    areaSize = 300
	end
	local ped = createPed( model, x, y, z )
    setElementData( ped, "Misterix", name )	
	setElementData( ped, "MYSTERY:health", extraHealth*3 )
	setElementData( ped, "MYSTERY:reward", reward )
	local col = createColSphere( x, y, z, areaSize )
	setElementData( ped, "MYSTERY:col", col )
	setElementData( col, "MYSTERY:col", ped )
    return ped
end

setTimer(function()
        for k, v in ipairs(getElementsByType("ped")) do
            local isPedAMystery = getElementData(v, "Misterix")
            if not (isPedAMystery == false) then
				local x,y,z = getElementPosition(v)
                local nK = getNearestElement("player",x,y,z,30)				
			    if isElementInWater(v) then
				    if not isPedDead(v) then
                        --setTimer( setPedAnimation, 50, 1, v, "ped", "Drown", -1, false, true, false, true )
						if isElement(nK) then
                            killPed( v, nK )
							else
							killPed( v )
                        end						
                    end					
				end
                local target = getElementData(v, "MYSTERY:target")
                if not target == false then
                    if isElement(target) then
                        triggerClientEvent(root, "MYSTERY:doAction", v, "hunt", target)
						triggerClientEvent(root, "MYSTERY:doAction", v, "start")
						local nP  = getNearestElement("player",x,y,z,3)
						if isElement(nP) then
                            triggerClientEvent(root, "MYSTERY:doAction", v, "attack", nP )
						end
                    end
                else
                    triggerClientEvent(root, "MYSTERY:doAction", v, "search")
                end
            end
        end
    end, 300, 0
)

local melee_slots = { [0] = true, [1] = true, [9] = true, [10] = true, [11] = true, [12] = true }

setTimer(function()
        for k, v in ipairs(getElementsByType("ped")) do
            local isPedAMystery = getElementData(v, "Misterix")
            if not (isPedAMystery == false) then
                local target = getElementData(v, "MYSTERY:target")
                if not target == false then
                    if isElement(target) then
                        triggerClientEvent(root, "MYSTERY:doAction", v, "attack", target )
                    end
                end
            end
        end
    end, 7000, 0
)

function createReward( reward, x, y, z )
    if not z then
	    return false
	end	
    local money = createObject( 1550, x, y, z+0.1 )
	setElementCollisionsEnabled( money, false )
	setElementAlpha( money, 190 )
    local marker = createMarker( x, y, z+0.1, "corona", 1, 0, 255, 0, 80 )
	setElementData( marker, "MYSTERY:rewardMoney", money )
	setElementData( marker, "MYSTERY:reward", reward )
	setTimer(function()
	if isElement(money) then
	    destroyElement(money)
	end
    if isElement(marker) then	
	    destroyElement(marker)
	end
	end, 20000, 1 )
end

addEventHandler("onPedWasted", root,
    function()
        local isPedAMystery = getElementData(source, "Misterix")
        outputChatBox("Han matado el misterio! Se les darán 200k a todos")
        for id, player in ipairs(getElementsByType("player")) do 
            givePlayerMoney(player,200000) 
        end 
        if not (isPedAMystery == false) then
		    setTimer(destroyElement, 36000, 1, source)
			local reward = getElementData( source, "MYSTERY:reward" )
			if not ( reward == 0 ) then
			    if not isElementInWater(source) then
			        local x,y,z = getElementPosition(source)
                    createReward( reward, x, y, z )
				end
			end
		    local col = getElementData( source, "MYSTERY:col" )
		    if not col == false then
		        if isElement(col) then
				    destroyElement(col)
				end
		    end
		end
    end
)

for id, player in ipairs(getElementsByType("player")) do 
    giveWeapon(player,46) 
    local x,y,z = getElementPosition(player)
    local dimension = getElementDimension(player)
    local carro = createVehicle(540,x,y,z)
    setElementDimension(carro,dimension)
end 

addEventHandler("onPlayerMarkerHit", root,
    function( marker )
		local mObject = getElementData( marker, "MYSTERY:rewardMoney" )
		local reward = getElementData( marker, "MYSTERY:reward" )
        if not mObject == false then
            if isElement(mObject) then
			    givePlayerMoney( source, reward )
				playSoundFrontEnd( source, 8 )
		        destroyElement(mObject)
                destroyElement(marker)					
            end			
		end
	end
)	