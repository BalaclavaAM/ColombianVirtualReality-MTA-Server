

GUIEditor = {
    button = {},
    window = {},
    memo = {}
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateStaticImage(500, 224, 400, 320, "fon.png", false)
		
		x = guiCreateStaticImage(5, 288, 142, 26, "otm.png", false, GUIEditor.window[1])
        x1 = guiCreateStaticImage(5, 288, 142, 26, "otm2.png", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateLabel(5, 288, 142, 26, "", false, GUIEditor.window[1])
		
		y = guiCreateStaticImage(253, 288, 142, 26, "sd.png", false, GUIEditor.window[1])
        y1 = guiCreateStaticImage(253, 288, 142, 26, "sd2.png", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateLabel(253, 288, 142, 26, "", false, GUIEditor.window[1])
		
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
   end
)

addEventHandler( "onClientMouseLeave", root, 
function()
	if source == GUIEditor.button[2] then
		guiSetVisible(y,true)
		guiSetVisible(y1,false)
	end
end)

addEventHandler( "onClientMouseEnter", root, 
function()
	if source == GUIEditor.button[2] then
		guiSetVisible(y,false)
		guiSetVisible(y1,true)
	end
end)

addEventHandler( "onClientMouseLeave", root, 
function()
	if source == GUIEditor.button[1] then
		guiSetVisible(x,true)
		guiSetVisible(x1,false)
	end
end)

addEventHandler( "onClientMouseEnter", root, 
function()
	if source == GUIEditor.button[1] then
		guiSetVisible(x,false)
		guiSetVisible(x1,true)
	end
end)



--dxDraw3DText("Работа таксиста",-2021.86,-44.18,35.35-1+1.5) -- Пишет в Мире3D над маркером

function showMenu(player)
    if not guiGetVisible(GUIEditor.window[1]) then
        guiSetVisible(GUIEditor.window[1], true)
        showCursor(true)
		guiSetVisible(y,true)
		guiSetVisible(y1,false)
		guiSetVisible(x,true)
		guiSetVisible(x1,false)
    else
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
    end
end
addEvent("StartWinTaxi", true)
addEventHandler("StartWinTaxi", getRootElement(), showMenu)

function onGuiClickPanel (button, state, absoluteX, absoluteY)
    if source == GUIEditor.button[2] then
        if not getElementData(localPlayer, "JobTaxi") then
            triggerServerEvent("StartJobTaxi", getRootElement(), localPlayer, true)
		    guiSetVisible(GUIEditor.window[1], false)
            showCursor(false)
        else
            triggerServerEvent("StartJobTaxi", getRootElement(), localPlayer, false)
		    guiSetVisible(GUIEditor.window[1], false)
            showCursor(false)
        end
    elseif source == GUIEditor.button[1] then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
	end
end
addEventHandler ("onClientGUIClick", getRootElement(), onGuiClickPanel)


--Уволится

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[2] = guiCreateStaticImage(500, 224, 400, 320, "fon2.png", false)
		
		xx = guiCreateStaticImage(5, 288, 142, 26, "otm.png", false, GUIEditor.window[2])
        xx1 = guiCreateStaticImage(5, 288, 142, 26, "otm2.png", false, GUIEditor.window[2])
        GUIEditor.button[3] = guiCreateLabel(5, 288, 142, 26, "", false, GUIEditor.window[2])
		
		yy = guiCreateStaticImage(253, 288, 142, 26, "sd3.png", false, GUIEditor.window[2])
        yy1 = guiCreateStaticImage(253, 288, 142, 26, "sd4.png", false, GUIEditor.window[2])
        GUIEditor.button[4] = guiCreateLabel(253, 288, 142, 26, "", false, GUIEditor.window[2])
		
        guiSetVisible(GUIEditor.window[2], false)
        showCursor(false)
   end
)

addEventHandler( "onClientMouseLeave", root, 
function()
	if source == GUIEditor.button[4] then
		guiSetVisible(yy,true)
		guiSetVisible(yy1,false)
	end
end)

addEventHandler( "onClientMouseEnter", root, 
function()
	if source == GUIEditor.button[4] then
		guiSetVisible(yy,false)
		guiSetVisible(yy1,true)
	end
end)

addEventHandler( "onClientMouseLeave", root, 
function()
	if source == GUIEditor.button[3] then
		guiSetVisible(xx,true)
		guiSetVisible(xx1,false)
	end
end)

addEventHandler( "onClientMouseEnter", root, 
function()
	if source == GUIEditor.button[3] then
		guiSetVisible(xx,false)
		guiSetVisible(xx1,true)
	end
end)


function showMenu2(player)
    if not guiGetVisible(GUIEditor.window[2]) then
        guiSetVisible(GUIEditor.window[2], true)
        showCursor(true)
		guiSetVisible(yy,true)
		guiSetVisible(yy1,false)
		guiSetVisible(xx,true)
		guiSetVisible(xx1,false)
    else
        guiSetVisible(GUIEditor.window[2], false)
        showCursor(false)
    end
end
addEvent("StartWinTaxi2", true)
addEventHandler("StartWinTaxi2", getRootElement(), showMenu2)

function onGuiClickPanel2 (button, state, absoluteX, absoluteY)
    if source == GUIEditor.button[4] then
        if not getElementData(localPlayer, "JobTaxi") then
            triggerServerEvent("StartJobTaxi", getRootElement(), localPlayer, true)
		    guiSetVisible(GUIEditor.window[2], false)
            showCursor(false)
        else
            triggerServerEvent("StartJobTaxi", getRootElement(), localPlayer, false)
		    guiSetVisible(GUIEditor.window[2], false)
            showCursor(false)
        end
    elseif source == GUIEditor.button[3] then
        guiSetVisible(GUIEditor.window[2], false)
        showCursor(false)
	end
end
addEventHandler ("onClientGUIClick", getRootElement(), onGuiClickPanel2)


