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

function buyCandy()
    local money = getPlayerMoney( source )
    if money > 150 then
        takePlayerMoney( source, 150 )
        setPedAnimation( source,"VENDING","VEND_Use")
        animTimers[source] = setTimer(animationC,3000,1,source)
    else
    exports['NGMessages']:sendClientMessage ( "No tienes dinero suficiente.",source,200,0,0)
    end
end
addEvent( "buyCandy",true)
addEventHandler( "buyCandy",root,buyCandy )

function animationC(thePlayer)
    setPedAnimation(thePlayer,"VENDING","VEND_Eat1_P")
	setElementHealth ( thePlayer, getElementHealth(thePlayer) + 10 )
    animTimers[thePlayer] = setTimer(removeAnimation,3000,1,thePlayer)
end

function removeAnimation(thePlayer)
    if (isElement( thePlayer )) then
        animTimers[thePlayer] = nil;
        setPedAnimation(thePlayer,false)
    end
end