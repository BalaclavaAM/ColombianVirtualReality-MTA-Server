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


local animTimers = {}

function buyDrink()
    local money = getPlayerMoney( source ) --Get the money
    if money > 50 then --If he has more than $5
        takePlayerMoney( source, 50 ) --Take his money
        setPedAnimation( source,"VENDING","VEND_Use") --And set his animation
        animTimers[source] = setTimer(animation2,3000,1,source) --And also make sure to set it on a timer!
    else
    exports['NGMessages']:sendClientMessage ( "No tienes dinero suficiente.",source,200,0,0) --If he has less than $5 then tell him
    end
end
addEvent( "buyDrink",true) --Add event to buy drink
addEventHandler( "buyDrink",root,buyDrink )

function animation2(thePlayer)
    setPedAnimation(thePlayer,"VENDING","VEND_Drink2_P") --This is the second Animation
	setElementHealth ( thePlayer, getElementHealth(thePlayer) + 5 ) --This will give him health, change the "+10" to change health given
    animTimers[thePlayer] = setTimer(removeAnimation,3000,1,thePlayer) --now remove the animation
end

function removeAnimation(thePlayer) --This removes the animation and lets the player move
    if (isElement( thePlayer )) then
        animTimers[thePlayer] = nil;
        setPedAnimation(thePlayer,false)
    end
end