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


--A LOT of locations (If not all external ones then just add some OR comment and tell me.)
local vendingMachineLocations = {
--ALL the EXTERNAL vending machine locations from MTA wiki (This will show you how to properly add your locations to the table)

--SF petrol station soda
	{	-2420.18, 985.945, 44.2969	},
	{	-2420.22, 984.578, 44.2969	},
--ext_sprunk
	{ 1789.21, -1369.27, 15.1641	},
	{ 1729.79, -1943.05, 12.9453	},
	{ 2060.12, -1897.64, 12.9297	},
	{ 1928.73, -1772.45, 12.9453	},
	{ 2325.98, -1645.13, 14.2109	},
	{ 2352.18, -1357.16, 23.7734	},
	{ 1154.73, -1460.89, 15.1562	},
	{ -1350.12, 492.289, 10.5859	},
	{ -2118.97, -423.648, 34.7266	},
	{ -2118.62, -422.414, 34.7266	},
	{ -2097.27, -398.336, 34.7266	},
	{ -2092.09, -490.055, 34.7266	},
	{ -2063.27, -490.055, 34.7266	},
	{ -2005.65, -490.055, 34.7266	},
	{ -2034.46, -490.055, 34.7266	},
	{ -2068.56, -398.336, 34.7266	},
	{ -2039.85, -398.336, 34.7266	},
	{ -2011.14, -398.336, 34.7266	},
	{ -1980.79, 142.664, 27.0703	},
	{ 2319.99, 2532.85, 10.2188	},
	{ 1520.15, 1055.27, 10	},
	{ -862.828, 1536.61, 21.9844	},
	{ -14.7031, 1175.36, 18.9531	},
	{ -253.742, 2597.95, 62.2422	},
	{ 201.016, -107.617, 0.898438 },
	{ 1277.771, 372.57, 19.5547	},
}

local vendingMachineMarker = {}

function vendingMachineHit(hitElement, matchingDimension)
    if (hitElement == localPlayer) and (getElementType( hitElement ) == "player") and (matchingDimension) then 
        bindKey("H","down",buyDrink) --What key should it be to buy it?
        exports.NGMessages:sendClientMessage ( "Presiona H para comprar una bebida por 50$",238,155,23 ) --What is the message when they hit the marker?
		exports.NGMessages:sendClientMessage ( "La bebida te curara 5 puntos de vida",238,155,23 ) --How much health will it restore?
    end
end

function vendingMachineLeave(hitElement, matchingDimension)
if (hitElement == localPlayer) and (getElementType( hitElement ) == "player") and (matchingDimension) then 
       unbindKey("H","down",buyDrink ) --Now unbind it when they leave the marker!
    end
end

function buyDrink()
    local isPlayerNearMachine = false;
    for markerId,markerElement in ipairs (vendingMachineMarker) do
        if (isElementWithinColShape( localPlayer, markerElement )) and not (isPlayerNearMachine) then
            isPlayerNearMachine = true;
        end
    end

    if (isPlayerNearMachine) then
        unbindKey("H","down",buyDrink ) --Unbind it
        triggerServerEvent( "buyDrink",localPlayer ) --Trigger the server side event!
    end
end

function createVendingMachine()
    for i=1,#vendingMachineLocations do 
        local x,y,z = vendingMachineLocations[i][1],vendingMachineLocations[i][2],vendingMachineLocations[i][3]
        vendingMachineMarker[i] = createColTube( x,y,z,1,2 ) --create the col shape
        addEventHandler( "onClientColShapeHit",vendingMachineMarker[i], vendingMachineHit )
        addEventHandler( "onClientColShapeLeave",vendingMachineMarker[i], vendingMachineLeave )
    end
end


createVendingMachine()