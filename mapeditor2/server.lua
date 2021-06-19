




addEvent("normalworhggld",true) 

addEventHandler("normalworhggld",root, 
 
function()
      if ( getPlayerMoney (source) >= 0 ) then
        takePlayerMoney(source, 0)
			setElementInterior ( source, 0 )
			setElementDimension ( source, 0 )
			playSoundFrontEnd ( source, 101 )
		 local name = getPlayerName(source)
        outputChatBox("#ffff00[" ..name .. "]:#C0C0C0    #00ff00{ Normal world } ",  source, 255, 255, 0, true )
		exports.logsystem:outputLog("normalworldd", name.." teleported to normal world")
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
 
end 
 
) 
 
 
 
 

addEvent("rots2",true) 
 
addEventHandler("rots2",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+2 )
		rots2 = createObject ( 744, x-3, y, z-1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rots2 )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this rock will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)




addEvent("rotdfds",true) 
 
addEventHandler("rotdfds",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+2 )
		rotdfds = createObject ( 751, x-3, y, z-1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rotdfds )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this rock will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)






addEvent("gangstafdtue",true) 
 
addEventHandler("gangstafdtue",root, 
 
function()
      if ( getPlayerMoney (source) >= 0 ) then
        takePlayerMoney(source, 0)

		setElementPosition ( source, -2770, 291, 2178 )


		playSoundFrontEnd ( source, 101 )

      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)




addEvent("gangstaftue",true) 
 
addEventHandler("gangstaftue",root, 
 
function()
      if ( getPlayerMoney (source) >= 0 ) then
        takePlayerMoney(source, 0)

		setElementPosition ( source, -2770, 291, 2178 )


		playSoundFrontEnd ( source, 101 )
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("gangstatue",true) 
 
addEventHandler("gangstatue",root, 
 
function()
      if ( getPlayerMoney (source) >= 0 ) then
        takePlayerMoney(source, 0)

		setElementPosition ( source, -2770, 291, 2178 )


		playSoundFrontEnd ( source, 101 )
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("woodcbn",true) 
 
addEventHandler("woodcbn",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+2 )
		woodcbn = createObject ( 18267, x-1, y, z+0.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, woodcbn )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this cabin will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("cannonn",true) 
 
addEventHandler("cannonn",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		cannonn = createObject ( 3884, x+1.5, y, z-1.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, cannonn )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this canon will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("waterobj",true) 
 
addEventHandler("waterobj",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		waterobj = createObject ( 4206, x, y, z-0.6, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, waterobj )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this water will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("deadcoopp",true) 
 
addEventHandler("deadcoopp",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		deadcoopp = createObject ( 3092, x+1, y, z-0.1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, deadcoopp )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this dead cop will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("blueblockk",true) 
 
addEventHandler("blueblockk",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		blueblockk = createObject ( 1336, x+1.5, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, blueblockk )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this blue block will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("woodblock",true) 
 
addEventHandler("woodblock",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		woodblock = createObject ( 1224, x, y, z+1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, woodblock )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this wooden block will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("stairss1",true) 
 
addEventHandler("stairss1",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		stairss1 = createObject ( 10008, x, y, z+4, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, stairss1 )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this stairs will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("stairrss2",true) 
 
addEventHandler("stairrss2",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		stairrss2 = createObject ( 10009, x, y, z+4, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, stairrss2 )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this stairs will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("steppsd",true) 
 
addEventHandler("steppsd",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x+5, y, z+2 )
		steppsd = createObject ( 13644, x, y, z-0.7, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, steppsd )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this stair stepswill stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("coowws",true) 
 
addEventHandler("coowws",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+2.5 )
		coowws = createObject ( 16442, x, y, z+0.4, 0, 0, 45 )
		setTimer ( destroyElement, 1200000, 1, coowws )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this cow will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("coowwsd",true) 
 
addEventHandler("coowwsd",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+2.5 )
		coowwsd = createObject ( 16442, x, y, z+0.4, 0, 0, 120 )
		setTimer ( destroyElement, 1200000, 1, coowwsd )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this cow will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("giantstatue",true) 
 
addEventHandler("giantstatue",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x+15, y, z )
		giantstatue = createObject ( 2408, x, y, z-3, 0, 0, 120 )
		setTimer ( destroyElement, 1200000, 1, giantstatue)
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this statue will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("trafficcone",true) 
 
addEventHandler("trafficcone",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		trafficcone = createObject ( 1238, x, y, z-0.7, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, trafficcone )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this cone will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("bloemekesf",true) 
 
addEventHandler("bloemekesf",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		bloemekesf = createObject ( 2895, x, y, z-0.7, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, bloemekesf )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this flowers will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)



addEvent("walkingtest",true) 
 
addEventHandler("walkingtest",root, 
 
function()
      if ( getPlayerMoney (source) >= 1000 ) then
        takePlayerMoney(source, 1000)

		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+3 )

		rockkksddfdks = createObject ( 1632, x, y, z, 0, 0, 0 )

		setTimer ( destroyElement, 1200000, 1, rockkksddfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("stuntramp Successfully droped", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("walkingtest22",true) 
 
addEventHandler("walkingtest22",root, 
 
function()
      if ( getPlayerMoney (source) >= 1000 ) then
        takePlayerMoney(source, 1000)

		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+3 )

		rockkkdfdks = createObject ( 1632, x, y, z, 0, 0, 45 )

		setTimer ( destroyElement, 1200000, 1, rockkkdfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("stuntramp Successfully droped", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("walkingtest222",true) 
 
addEventHandler("walkingtest222",root, 
 
function()
      if ( getPlayerMoney (source) >= 1000 ) then
        takePlayerMoney(source, 1000)

		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+3 )

		rockkkdfdsdks = createObject ( 1632, x, y, z, 0, 0, 180 )

		setTimer ( destroyElement, 1200000, 1, rockkkdfdsdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("stuntramp Successfully droped", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("walkingtest2",true) 
 
addEventHandler("walkingtest2",root, 
 
function()
      if ( getPlayerMoney (source) >= 1000 ) then
        takePlayerMoney(source, 1000)

		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+3 )

		rockkkyudfdks = createObject ( 1632, x, y, z, 0, 0, 90 )

		setTimer ( destroyElement, 1200000, 1, rockkkyudfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("stuntramp Successfully droped", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("windmolen",true) 
 
addEventHandler("windmolen",root, 
 
function()
      if ( getPlayerMoney (source) >= 750 ) then
        takePlayerMoney(source, 750)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		rockkkdhgfdks = createObject ( 3425, x, y, z+4, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rockkkdhgfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This windmill will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("uitkijktore",true) 
 
addEventHandler("uitkijktore",root, 
 
function()
      if ( getPlayerMoney (source) >= 950 ) then
        takePlayerMoney(source, 950)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		rockkkddrdfdks = createObject ( 3279, x+3, y, z-2, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rockkkddrdfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This watchtower will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("brievebus",true) 
 
addEventHandler("brievebus",root, 
 
function()
      if ( getPlayerMoney (source) >= 40 ) then
        takePlayerMoney(source, 40)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		rockssddkkddrdfdks = createObject ( 3407, x, y, z-0.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rockssddkkddrdfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This mailbox will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("toadlightt",true) 
 
addEventHandler("toadlightt",root, 
 
function()
      if ( getPlayerMoney (source) >= 40 ) then
        takePlayerMoney(source, 40)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		rockss3dfdks = createObject ( 3534, x, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rockss3dfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This Toadstool light will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("struik",true) 
 
addEventHandler("struik",root, 
 
function()
      if ( getPlayerMoney (source) >= 10 ) then
        takePlayerMoney(source, 10)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		rockssddkkddrdfdks = createObject ( 800, x, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rockssddkkddrdfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This bush will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)



addEvent("boomkedsqs",true) 
 
addEventHandler("boomkedsqs",root, 
 
function()
      if ( getPlayerMoney (source) >= 10 ) then
        takePlayerMoney(source, 10)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		tree11 = createObject ( 737, x+1, y, z-1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, tree11 )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this tree will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("fencea",true) 
 
addEventHandler("fencea",root, 
 
function()
      if ( getPlayerMoney (source) >= 25 ) then
        takePlayerMoney(source, 0)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenceea = createObject ( 3461, x+1, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenceea )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this fire pole will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("fenceb",true) 
 
addEventHandler("fenceb",root, 
 
function()
      if ( getPlayerMoney (source) >= 25 ) then
        takePlayerMoney(source, 0)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenceeb = createObject ( 3524, x, y+1, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenceeb )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this skullfire will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("fencec",true) 
 
addEventHandler("fencec",root, 
 
function()
      if ( getPlayerMoney (source) >= 8 ) then
        takePlayerMoney(source, 8)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenceec = createObject ( 1331, x+1, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenceec )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this gargbage can will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("fenced",true) 
 
addEventHandler("fenced",root, 
 
function()
      if ( getPlayerMoney (source) >= 150 ) then
        takePlayerMoney(source, 150)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenceed = createObject ( 3515, x+2, y, z-2.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenceed )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this fountain will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("streelight",true) 
 
addEventHandler("streelight",root, 
 
function()
      if ( getPlayerMoney (source) >= 60 ) then
        takePlayerMoney(source, 60)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fencessded = createObject ( 1231, x+1, y, z+0.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fencessded )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this streetlight will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("boomkedsdsqqs",true) 
 
addEventHandler("boomkedsdsqqs",root, 
 
function()
      if ( getPlayerMoney (source) >= 15 ) then
        takePlayerMoney(source, 15)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenceezeed = createObject ( 726, x+1, y, z-1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenceezeed )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this tree will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("boomkedsfgqs",true) 
 
addEventHandler("boomkedsfgqs",root, 
 
function()
      if ( getPlayerMoney (source) >= 17 ) then
        takePlayerMoney(source, 17)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenddsceed = createObject ( 700, x+1, y, z-0.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenddsceed )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this tree will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("strsdfeelight",true) 
 
addEventHandler("strsdfeelight",root, 
 
function()
      if ( getPlayerMoney (source) >= 80 ) then
        takePlayerMoney(source, 80)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenceed = createObject ( 3441, x+1, y, z+1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenceed )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this pillar will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("gate1",true) 
 
addEventHandler("gate1",root, 
 
function()
      if ( getPlayerMoney (source) >= 20 ) then
        takePlayerMoney(source, 20)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fenceezedfded = createObject ( 985, x, y+1, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fenceezedfded )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this gate will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("gate2",true) 
 
addEventHandler("gate2",root, 
 
function()
      if ( getPlayerMoney (source) >= 20 ) then
        takePlayerMoney(source, 20)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fencddedfded = createObject ( 985, x+1, y, z, 0, 0, 90 )
		setTimer ( destroyElement, 1200000, 1, fencddedfded )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this gate will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("benchdss",true) 
 
addEventHandler("benchdss",root, 
 
function()
      if ( getPlayerMoney (source) >= 15 ) then
        takePlayerMoney(source, 15)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		feeaencedfded = createObject ( 1280, x, y+1, z-0.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, feeaencedfded )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this banch will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("lichtboven",true) 
 
addEventHandler("lichtboven",root, 
 
function()
      if ( getPlayerMoney (source) >= 75 ) then
        takePlayerMoney(source, 75)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		rockddssddkkddrdfdks = createObject ( 18102, x, y, z-1, 0, 0, 180 )
		setTimer ( destroyElement, 1200000, 1, rockddssddkkddrdfdks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This discolights will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("weedplntfg",true) 
 
addEventHandler("weedplntfg",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		weedplntfg = createObject ( 3409, x, y, z-1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, weedplntfg )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This weedplant will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)

addEvent("brokhouse",true) 
 
addEventHandler("brokhouse",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		brokhouse = createObject ( 1457, x, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, brokhouse )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This broken thing will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("othercabion",true) 
 
addEventHandler("othercabion",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z+2 )
		othercabion = createObject ( 18259, x, y, z-0.1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, othercabion )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This cabin will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("weidetree",true) 
 
addEventHandler("weidetree",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x+2, y, z+1 )
		weidetree = createObject ( 672, x, y, z-0.2, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, weidetree )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This tree will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("langgras",true) 
 
addEventHandler("langgras",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		langgras = createObject ( 826, x, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, langgras )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("This long grass will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)



addEvent("cactuds",true) 
 
addEventHandler("cactuds",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		feeaencedfded = createObject ( 653, x, y+1, z-0.5, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, feeaencedfded )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this cactus will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)



addEvent("struikieek",true) 
 
addEventHandler("struikieek",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		struikieek = createObject ( 825, x-1, y, z-0.1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, struikieek )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this bush will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("flwrbsh",true) 
 
addEventHandler("flwrbsh",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		flwrbsh = createObject ( 14469, x, y, z-0.1, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, flwrbsh )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this bush will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("flowersdjgf",true) 
 
addEventHandler("flowersdjgf",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		flowersdjgf = createObject ( 870, x-1, y, z-0.4, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, flowersdjgf )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("these flowers will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("flowerskgfkj",true) 
 
addEventHandler("flowerskgfkj",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		flowerskgfkj = createObject ( 869, x, y, z-0.4, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, flowerskgfkj )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("these flowers	 will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("fencefggh",true) 
 
addEventHandler("fencefggh",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fencefggh = createObject ( 3275, x, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fencefggh )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this fence will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("fencefdggh",true) 
 
addEventHandler("fencefdggh",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fencefdggh = createObject ( 3275, x, y, z, 0, 0, 90 )
		setTimer ( destroyElement, 1200000, 1, fencefdggh )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this fence will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("fencslkke",true) 
 
addEventHandler("fencslkke",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fencslkke = createObject ( 3276, x, y, z, 0, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, fencslkke )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this fence will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("fencslkked",true) 
 
addEventHandler("fencslkked",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		fencslkked = createObject ( 3276, x, y, z, 0, 0, 90 )
		setTimer ( destroyElement, 1200000, 1, fencslkked )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this fence will stay for 20 minutes", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("udfoijkf",true) 
 
addEventHandler("udfoijkf",root, 
 
function()
      if ( getPlayerMoney (source) >= 5 ) then
        takePlayerMoney(source, 5)
		x,y,z = getElementPosition( source )
		setElementPosition ( source, x, y, z )
		steppsd = createObject ( 16778, x, y, z+25, 180, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, steppsd )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("this ufo will stay for 20 minutes", source, 255, 255, 0, true)
		 outputChatBox("LOOK UP !", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("buyrockske", true)
addEventHandler("buyrockske", root,
function()
      if ( getPlayerMoney (source) >= 500 ) then
        takePlayerMoney(source, 500)
		x,y,z = getElementPosition( source )
		rockkkks = createObject ( 1305, x, y, z+2, 90, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, rockkkks )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("rock Successfully droped", source, 255, 255, 0, true)
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("giveknif", true)
addEventHandler("giveknif", getRootElement(), 
function()
  if getPlayerMoney(source) >= 0 then
    takePlayerMoney(source, 0 )
    local l_10_0 = getElementDimension(source)
    local l_10_1 = getElementInterior(source)
    local l_10_2, l_10_3, l_10_4 = getElementPosition(source)
    smokee = createObject(2780, l_10_2, l_10_3, l_10_4 - 1)
	setTimer ( destroyElement, 1200000, 1, smokee )
    setElementDimension(smokee, l_10_0)
    setElementInterior(smokee, l_10_1)
    outputChatBox("You bought Smoke by $0 !", source, 255, 255, 0)
    
     local name = getPlayerName(source)
 


        outputChatBox("#ffff00[" ..name .. "]:#C0C0C0 Has Bought #00ff00{ SMOKE }",  source, 255, 255, 0, true )           
    setTimer(function()
   
      destroyElement(smokee)
      outputChatBox("#FFFF1A Smoke Has been End", getRootElement(), 255, 0, 0, true)
      end, 50000, 1, true)
  else
    outputChatBox("You don't have $0 to buy Smoke !", source, 255, 0, 0)
  end
end
)
endsmoke = function(l_11_0)
  destroyElement(l_11_0)
end


ddEventHandler (
    'onResourceStart', resourceRoot,
    function ( )
        setElementData ( root, 'getClientServerName', getServerName ( ) )
    end
)



addEvent("buyHay", true)
addEventHandler("buyHay", root,
function()
      if ( getPlayerMoney (source) >= 600 ) then
        takePlayerMoney(source, 600)
		x,y,z = getElementPosition( source )
		hayyj = createObject ( 3374, x, y, z, 120, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, hayyj )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("Hay Successfully droped", source, 255, 255, 0, true)
		exports.logsystem:outputLog("hayy", name.." boucht hay")
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)


addEvent("buyBarrel", true)
addEventHandler("buyBarrel", root,
function()
      if ( getPlayerMoney (source) >= 1200 ) then
        takePlayerMoney(source, 1200 )
		x,y,z = getElementPosition( source )
		barrelllkjk = createObject ( 1225, x, y, z, 90, 0, 0 )
		setTimer ( destroyElement, 1200000, 1, barrelllkjk )
		playSoundFrontEnd ( source, 101 )
        outputChatBox("Bareel Successfully droped", source, 255, 255, 0, true)
		exports.logsystem:outputLog("barrel", name.." boucht a barrel")
      else
        outputChatBox("Not enough money.", source, 255, 0, 0, true)
    end
  end
)



