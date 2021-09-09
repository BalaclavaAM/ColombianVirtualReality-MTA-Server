------------------------------------
-- 		 Taran Preet Rayat		  --
------------------------------------
--         2016 - Unknown	  	  -- 
------------------------------------
--	  Edited: 2017 - Britain	  -- 	    
------------------------------------
--   Edited by kieran (kieranb)   -- 	    
------------------------------------
-- 	 This script was originally	  --
-- 	    sourced from Youtube.     --
------------------------------------
------------------------------------
--  VendingMachines v1.0 for MTA  --
------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
--  NOTE:	I have simply edited this script adding locations and the ability to get health, all credit goes to the YouTube link  --
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
--								  Link to YouTube video: https://www.youtube.com/watch?v=Rnqhco1d3os							  --
------------------------------------------------------------------------------------------------------------------------------------


local vendingMachineCandyLocations = {
--ext_candy
	{ 1634.11, -2237.53, 12.8906},
	{ 2480.86, -1959.27, 12.9609},
	{ 2139.52, -1161.48, 23.3594},
	{ 2153.23, -1016.15, 62.2344},
	{ -1350.12, 493.859, 10.5859},	
	{ -2229.19, 286.414, 34.7031},
	{ 1659.46, 1722.86, 10.2188	},
	{ 2647.7, 1129.66, 10.2188	},
	{ 1398.84, 2222.61,	10.4219	},
	{ -1455.12, 2591.66, 55.2344},
	{ -76.0312, 1227.99, 19.125	},
	{ -253.742, 2599.76, 62.2422},
	{ 662.43, -552.164, 15.7109	},
}

local vendingMachineCandyMarker = {}
local vendingMachineCandyMarker = {}

function vendingMachineCandyHit(hitElement, matchingDimension)
    if (hitElement == localPlayer) and (getElementType( hitElement ) == "player") and (matchingDimension) then 
        bindKey("H","down",buyCandy)
        exports.NGMessages:sendClientMessage ( "Presiona H para comprar un dulce por 150$",238,155,23 )
		exports.NGMessages:sendClientMessage ( "Te curara 10 puntos de vida",238,155,23 )
    end
end

function vendingMachineCandyLeave(hitElement, matchingDimension)
if (hitElement == localPlayer) and (getElementType( hitElement ) == "player") and (matchingDimension) then 
       unbindKey("H","down",buyCandy )
    end
end

function buyCandy()
    local isPlayerNearCandyMachine = false;
    for markerId,markerElement in ipairs (vendingMachineCandyMarker) do
        if (isElementWithinColShape( localPlayer, markerElement )) and not (isPlayerNearCandyMachine) then
            isPlayerNearCandyMachine = true;
        end
    end

    if (isPlayerNearCandyMachine) then
        unbindKey("H","down",buyCandy )
        triggerServerEvent( "buyCandy",localPlayer )
    end
end

function createVendingCandyMachine()
    for i=1,#vendingMachineCandyLocations do 
        local x,y,z = vendingMachineCandyLocations[i][1],vendingMachineCandyLocations[i][2],vendingMachineCandyLocations[i][3]
        vendingMachineCandyMarker[i] = createColTube( x,y,z,1,2 )
        addEventHandler( "onClientColShapeHit",vendingMachineCandyMarker[i], vendingMachineCandyHit )
        addEventHandler( "onClientColShapeLeave",vendingMachineCandyMarker[i], vendingMachineCandyLeave )
    end
end


createVendingCandyMachine()



--[[interior vendings
--dunno
{	316.875, -140.352, 998.586	},
--Sprunk
{	2225.2, -1153.42	1025.91	},
{	2155.91, 1606.77	1000.05	},
{	2576.7, -1284.43	1061.09	},
{	2222.2, 1606.77	1000.05	},
{	-19.0391, -57.8359, 1003.63	},
{	-16.1172, -91.6406, 1003.63	},
{	-32.4453, -186.695, 1003.63	},
{	-35.7266, -140.227, 1003.63	},
{	495.969, -24.3203, 1000.73	},
{	501.828, -1.42969, 1000.73	},
{	373.828, -178.141, 1000.73	},
--candyVendor
{	330.68, 178.5, 1020.07	},
{	331.922, 178.5, 1020.07	},
{	350.906, 206.086, 1008.48	},
{	361.562, 158.617, 1008.48	},
{	371.594, 178.453, 1020.07	},
{	374.891, 188.977, 1008.48	},
{	2155.84, 1607.88, 1000.06	},
{	2202.45, 1617.01, 1000.06	},
{	2209.24, 1621.21, 1000.06	},
{	2222.37, 1602.64, 1000.06	},
{	-36.1484, -57.875, 1003.63	},
{	-17.5469, -91.7109, 1003.63	},
{	-16.5312, -140.297, 1003.63	},
{	-33.875, -186.766, 1003.63	},
{	500.562, -1.36719, 1000.73	},
{	379.039, -178.883, 1000.73	},]]