

GUIEditor = {
    button = {},
    window = {},
    memo = {}
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateStaticImage(500, 224, 400, 320, "community/taxi/fon.png", false)
		
		x = guiCreateStaticImage(5, 288, 142, 26, "community/taxi/otm.png", false, GUIEditor.window[1])
        x1 = guiCreateStaticImage(5, 288, 142, 26, "community/taxi/otm2.png", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateLabel(5, 288, 142, 26, "", false, GUIEditor.window[1])
		
		y = guiCreateStaticImage(253, 288, 142, 26, "community/taxi/sd.png", false, GUIEditor.window[1])
        y1 = guiCreateStaticImage(253, 288, 142, 26, "community/taxi/sd2.png", false, GUIEditor.window[1])
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
        GUIEditor.window[2] = guiCreateStaticImage(500, 224, 400, 320, "community/taxi/fon2.png", false)
		
		xx = guiCreateStaticImage(5, 288, 142, 26, "community/taxi/otm.png", false, GUIEditor.window[2])
        xx1 = guiCreateStaticImage(5, 288, 142, 26, "community/taxi/otm2.png", false, GUIEditor.window[2])
        GUIEditor.button[3] = guiCreateLabel(5, 288, 142, 26, "", false, GUIEditor.window[2])
		
		yy = guiCreateStaticImage(253, 288, 142, 26, "community/taxi/sd3.png", false, GUIEditor.window[2])
        yy1 = guiCreateStaticImage(253, 288, 142, 26, "community/taxi/sd4.png", false, GUIEditor.window[2])
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


----------------------
-- F5 Panel			--
----------------------
taxiGui = { }
function createTaxiInterface ( )
	if ( isElement ( taxiGui.window ) ) then 
		removeEventHandler ( "onClientGUIClick", taxiGui.close, createTaxiInterface );
		destroyElement ( taxiGui.window );
		taxiGui.window = false;
		showCursor ( false );
		return
	end 
	
	local job = getElementData ( localPlayer, "Job" ) or "";
	if ( job ~= "Taxista" ) then return false; end
	
	taxiGui.window = guiCreateWindow( ( sx / 2 - 471 / 2 ), ( sy / 2 - 330 / 2 ), 471, 330, "Taxista", false)
	guiWindowSetSizable(taxiGui.window, false)
	taxiGui.close = guiCreateButton(353, 295, 108, 25, "Cerrar", false, taxiGui.window)
	taxiGui.username = guiCreateLabel(10, 34, 437, 18, "Nombre: ".. tostring ( getElementData ( localPlayer, "AccountData:Username" ) ), false, taxiGui.window)
	taxiGui.job = guiCreateLabel(10, 62, 437, 18, "Trabajo: "..tostring ( getElementData ( localPlayer, "Job" ) ), false, taxiGui.window)
	taxiGui.completedCarreras = guiCreateLabel(10, 118, 437, 18, "Carreras: Cargando", false, taxiGui.window)
	taxiGui.jobRank = guiCreateLabel(10, 90, 437, 18, "Rango: "..tostring ( getElementData ( localPlayer, "Job Rank" ) ), false, taxiGui.window)
	taxiGui.nextRank  = guiCreateLabel(10, 146, 437, 18, "Nuevo Rango: cargando || cargando", false, taxiGui.window)
	taxiGui.jobDesc = guiCreateMemo(12, 187, 449, 98, jobDescriptions['taxista'], false, taxiGui.window)
	triggerServerEvent ( "NGJobs->Module->Job->taxi->OnClientRequestF5Data", localPlayer );
	showCursor ( true );
	addEventHandler ( "onClientGUIClick", taxiGui.close, createTaxiInterface );
end

addEvent ( "NGJobs->Module->Job->taxi->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->taxi->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( taxiGui.window ) ) then return false; end 
	
	guiSetText ( taxiGui.completedCarreras, "Carreras: "..tostring ( data.carreras ) );
	guiSetText ( taxiGui.nextRank, "Nuevo Rango: "..tostring ( data.nextRank ).. " | Requires "..tostring(data.requiredCarreras).." carreras mas.");
	
end );

bindKey ( "f5", "down", createTaxiInterface );