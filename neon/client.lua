local sx, sy = guiGetScreenSize()
localPlayer = getLocalPlayer()
local visible = false
local key = "F5"

local neonname = {
[1] = "Red Neon",
[2] = "Blue Neon",
[3] = "Green Neon",
[4] = "Yellow Neon",
[5] = "Pink Neon",
[6] = "White Neon",
[7] = "Reset"
}

local idModel = {
[1] = 14399,
[2] = 14400,
[3] = 14401,
[4] = 14402,
[5] = 14403,
[6] = 14404
}



function openGui()
local xBtn = 75
local yBtn = 30
local wBtn = 150
local hBtn = 21
local space = 28
     window = guiCreateWindow(sx/2-150,sy/2-115,300,260,"Neon panel",false)
     Btn1 = guiCreateButton(xBtn,yBtn,wBtn,hBtn,neonname[1],false, window)
     Btn2 = guiCreateButton(xBtn,yBtn+space,wBtn,hBtn,neonname[2],false, window)
     Btn3 = guiCreateButton(xBtn,yBtn+2*space,wBtn,hBtn,neonname[3],false, window)
     Btn4 = guiCreateButton(xBtn,yBtn+3*space,wBtn,hBtn,neonname[4],false, window)
     Btn5 = guiCreateButton(xBtn,yBtn+4*space,wBtn,hBtn,neonname[5],false, window)
     Btn6 = guiCreateButton(xBtn,yBtn+5*space,wBtn,hBtn,neonname[6],false, window)
     Btn7 = guiCreateButton(xBtn,yBtn+6*space,wBtn,hBtn,neonname[7],false, window)
     info = guiCreateLabel(200, 230, 300, 30,"By [SV]Kostya", false, window) 
     guiLabelSetColor (info, 0,0,255)
guiSetVisible(window, visible)
end


function start_cl_resource()
	openGui()
          if ( guiGetVisible(window) == true ) then
             showCursor(true)
          end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),start_cl_resource)

function hideGui()
  if (guiGetVisible(window) == false) then 
           guiSetVisible(window, true)
           showCursor(true)
   else
           guiSetVisible(window, false)
           showCursor(false)

  end
end
bindKey(key, "down", hideGui)

function onGuiClickPanel (button, state, absoluteX, absoluteY)
  if (source == Btn1) then
       setElementData( localPlayer, "neon", idModel[1] )
       outputChatBox("#00ff00Now your neon color is #ff0000Red", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
  elseif (source == Btn2) then
       setElementData( localPlayer, "neon", idModel[2] )
       outputChatBox("#00ff00Now your neon color is #0000ffBlue", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
  elseif (source == Btn3) then
       setElementData( localPlayer, "neon", idModel[3] )
       outputChatBox("#00ff00Now your neon color is Green", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
  elseif (source == Btn4) then
       setElementData( localPlayer, "neon", idModel[4] )
       outputChatBox("#00ff00Now your neon color is #ffcc00Yellow", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
  elseif (source == Btn5) then
       setElementData( localPlayer, "neon", idModel[5] )
       outputChatBox("#00ff00Now your neon color is #f754e1Pink", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
  elseif (source == Btn6) then
       setElementData( localPlayer, "neon", idModel[6] )
       outputChatBox("#00ff00Now your neon color is #ffffffWhite", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
  elseif (source == Btn7) then
       setElementData( localPlayer, "neon", 0 )
       outputChatBox("#00ff00Your neon successfully reseted", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
  end
end
addEventHandler ("onClientGUIClick", getRootElement(), onGuiClickPanel)

function replaceTXD() 
txd = engineLoadTXD ( "models/MatTextures.txd" )
engineImportTXD ( txd, idModel[1] )
engineImportTXD ( txd, idModel[2] )
engineImportTXD ( txd, idModel[3] )
engineImportTXD ( txd, idModel[4] )
engineImportTXD ( txd, idModel[5] )
engineImportTXD ( txd, idModel[6] )

col = engineLoadCOL("models/RedNeonTube1.col")
engineReplaceCOL(col, idModel[1])
col = engineLoadCOL("models/BlueNeonTube1.col")
engineReplaceCOL(col, idModel[2])
col = engineLoadCOL("models/GreenNeonTube1.col")
engineReplaceCOL(col, idModel[3])
col = engineLoadCOL("models/YellowNeonTube1.col")
engineReplaceCOL(col, idModel[4])
col = engineLoadCOL("models/PinkNeonTube1.col")
engineReplaceCOL(col, idModel[5])
col = engineLoadCOL("models/WhiteNeonTube1.col")
engineReplaceCOL(col, idModel[6])

dff = engineLoadDFF ( "models/RedNeonTube1.dff", idModel[1] )
engineReplaceModel ( dff, idModel[1] ) 
dff = engineLoadDFF ( "models/BlueNeonTube1.dff", idModel[2] )
engineReplaceModel ( dff, idModel[2] ) 
dff = engineLoadDFF ( "models/GreenNeonTube1.dff", idModel[3] )
engineReplaceModel ( dff, idModel[3] ) 
dff = engineLoadDFF ( "models/YellowNeonTube1.dff", idModel[4] )
engineReplaceModel ( dff, idModel[4] ) 
dff = engineLoadDFF ( "models/PinkNeonTube1.dff", idModel[5] )
engineReplaceModel ( dff, idModel[5] ) 
dff = engineLoadDFF ( "models/WhiteNeonTube1.dff", idModel[6] )
engineReplaceModel ( dff, idModel[6] ) 
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceTXD)