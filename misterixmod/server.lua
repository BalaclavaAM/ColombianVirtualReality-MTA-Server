
addEventHandler("onResourceStart", resourceRoot,
    function()
	    outputChatBox( "#DF7401[ #610B0BMTA Misterix Mod v."..getResourceInfo(getThisResource(), "version").." #DF7401]", root, 255, 255, 255, true )
		outputDebugString( "MTA Misterix Mod v."..getResourceInfo(getThisResource(), "version").." loaded ! ", 3 )
	end
)

--MYSTERIES
--Bigfoot
local bigfoot_randomPos = {

    { -861.95166015625, -2224.3134765625, 26.649639129639 },
	{ -894.73913574219, -2391.9155273438, 53.387577056885 },
	{ -677.58563232422, -2504.6865234375, 40.588394165039 },	

}

function spawn_bigfoot()
    local x, y, z = unpack( bigfoot_randomPos[math.random(#bigfoot_randomPos)])
    local ped = createMystery( "Bigfoot", x, y, z, 600, 80, 5000 )
    setPedWalkingStyle(ped,120)	
end
setTimer( spawn_bigfoot, 100, 1 )
--Cave demons
function spawn_cavedemon()
    local ped = createMystery( "CaveDemon", -410.49240112305, 1332.5187988281, 12.946291923523, 270, 140, 500 )
	setElementData( ped, "MYSTERY:leader", true )
    local ped2 = createMystery( "CaveDemon", -405.90005493164, 1326.0241699219, 12.628323554993, 200, 140, 300  )
    local ped3 = createMystery( "CaveDemon", -411.15444946289, 1341.3620605469, 13.20466709137, 200, 140, 300 )	
end
setTimer( spawn_cavedemon, 100, 1 )
--Jason
function spawn_jason()
    local ped = createMystery( "Jason", -1632.0134277344, -2238.1726074219, 31.4765625, 700, 90, 5000 )
    giveWeapon( ped, 4 )
    setPedWeaponSlot( ped, 1 )
    setPedWalkingStyle(ped,118)	
end
setTimer( spawn_jason, 100, 1 )
--Leatherface
function spawn_leatherface()
    local ped = createMystery( "Leatherface", -548.12554931641, -195.9296875, 78.40625, 650, 90, 4000 )
    giveWeapon( ped, 9 )
    setPedWeaponSlot( ped, 1 )
    setPedWalkingStyle(ped,118) 	
end
setTimer( spawn_leatherface, 100, 1 )
--Ninja Lizard
function spawn_lizard()
    local ped = createMystery( "Lizard", 1088.115234375, 1073.9729003906, 10.838157653809, 500, 90, 4000 )
    setPedWalkingStyle(ped,118)	
end
setTimer( spawn_lizard, 100, 1 )
--Nemesis
function spawn_nemesis()
    local ped = createMystery( "Nemesis", -1936.9736328125, 643.62561035156, 46.5625, 300, 70, 2000 )
    giveWeapon( ped, 36, 9999 )
    setPedWeaponSlot( ped, 7 )	
end
setTimer( spawn_nemesis, 100, 1 )
--Fisher Lagoon monster
local nessie = createObject( 1851, 2060.5107421875, -124.28504180908, -20, 0, 0, 90 )
local nessieCol = createColCuboid( 2057.1157226563, -119.79872894287, -5, 7, 25, 10 )
setElementData( nessie, "MYSTERY:nessieMovement", "up" )

function nessie_movement()
    if ( getElementData( nessie, "MYSTERY:nessieMovement" ) == "up" ) then
        moveObject( nessie, 1000, 2060.5107421875, -124.28504180908, -25, 0, 10 )
		setElementData( nessie, "MYSTERY:nessieMovement", "down" )
    elseif ( getElementData( nessie, "MYSTERY:nessieMovement" ) == "down" ) then
	    moveObject( nessie, 1000, 2060.5107421875, -124.28504180908, -20, 0, -10 )
		setElementData( nessie, "MYSTERY:nessieMovement", "up" )
    end
end
setTimer( nessie_movement, 1000, 0 )

addEventHandler("onColShapeHit", nessieCol,
    function(hitElement)
	    if getElementType(hitElement) == "player" then
		    killPed( hitElement )
	    end
	end
)	
--Pigsy
function spawn_pigsy()
    local ped = createMystery( "Pigsy", -2235.7905273438, -1124.2531738281, 15.671875, 900, 50, 7000 )
    giveWeapon( ped, 9 )
    setPedWeaponSlot( ped, 1 )
    setPedWalkingStyle(ped,120)	
end
setTimer( spawn_pigsy, 100, 1 )
--Samara
function spawn_samara()
    local ped = createMystery( "Samara", 1271.7211914063, 295.42276000977, 20.656307220459, 800, 50, 7000 )
    setPedWalkingStyle(ped,120)	
end
setTimer( spawn_samara, 100, 1 )
--Serial Killer
function spawn_serialkiller()
    local ped = createMystery( "SerialKiller", -208.30061340332, 2713.0944824219, 62.979370117188, 150, 90, 1500 )
	setPedWeaponSlot( ped, 4 )	
	giveWeapon( ped, 28, 9999 )
	setPedStat( ped, 75, 1000 )
    setPedWalkingStyle(ped,120)	
end
setTimer( spawn_serialkiller, 100, 1 )
--Yeti
function spawn_yeti()
    local ped = createMystery( "Yeti", -2376.6791992188, -1832.1256103516, 442.29888916016, 600, 50, 3500 )
    setPedWalkingStyle(ped,120)	
end
setTimer( spawn_yeti, 100, 1 )

--RESPAWN

addEventHandler("onPedWasted", root,
    function()
        if ( getElementData( source, "Misterix" ) == "Bigfoot" ) then
		    setTimer( spawn_bigfoot, 600000, 1 )
		elseif ( getElementData( source, "Misterix" ) == "CaveDemon" ) then
		    if ( getElementData(source,"MYSTERY:leader") == true ) then
		        setTimer( spawn_cavedemon, 600000, 1 )
            end			
		elseif ( getElementData( source, "Misterix" ) == "Jason" ) then
		    setTimer( spawn_jason, 600000, 1 )
		elseif ( getElementData( source, "Misterix" ) == "Leatherface" ) then
		    setTimer( spawn_leatherface, 600000, 1 )
		elseif ( getElementData( source, "Misterix" ) == "Lizard" ) then
		    setTimer( spawn_lizar, 600000, 1 )
		elseif ( getElementData( source, "Misterix" ) == "Nemesis" ) then
		    setTimer( spawn_nemesis, 600000, 1 )	
		elseif ( getElementData( source, "Misterix" ) == "Pigsy" ) then
		    setTimer( spawn_pigsy, 600000, 1 )	
		elseif ( getElementData( source, "Misterix" ) == "Samara" ) then
		    setTimer( spawn_samara, 600000, 1 )
		elseif ( getElementData( source, "Misterix" ) == "Yeti" ) then
		    setTimer( spawn_yeti, 600000, 1 )
        elseif ( getElementData( source, "Misterix" ) == "SerialKiller" ) then
            setTimer( spawn_serialkiller, 600000, 1 )		
	    end
    end
)