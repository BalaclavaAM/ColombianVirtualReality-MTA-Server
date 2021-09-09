----------------------
-- F5 Panel	Militar
----------------------
miliGui = { }
function createMilitarInterface ( )
	if ( isElement ( miliGui.window ) ) then 
		removeEventHandler ( "onClientGUIClick", miliGui.close, createMilitarInterface );
		destroyElement ( miliGui.window );
		miliGui.window = false;
		showCursor ( false );
		return
	end 
	
	local job = getElementData ( localPlayer, "Job" ) or "";
	if ( job ~= "Militar" ) then return false; end
	
	miliGui.window = guiCreateWindow( ( sx / 2 - 471 / 2 ), ( sy / 2 - 330 / 2 ), 471, 330, "Militar", false)
	guiWindowSetSizable(miliGui.window, false)
	miliGui.close = guiCreateButton(353, 295, 108, 25, "Cerrar", false, miliGui.window)
	miliGui.username = guiCreateLabel(10, 34, 437, 18, "Nombre: ".. tostring ( getElementData ( localPlayer, "AccountData:Username" ) ), false, miliGui.window)
	miliGui.job = guiCreateLabel(10, 62, 437, 18, "Trabajo: "..tostring ( getElementData ( localPlayer, "Job" ) ), false, miliGui.window)
	miliGui.completedBajas = guiCreateLabel(10, 118, 437, 18, "Falsos positivos: Cargando", false, miliGui.window)
	miliGui.jobRank = guiCreateLabel(10, 90, 437, 18, "Rango: "..tostring ( getElementData ( localPlayer, "Job Rank" ) ), false, miliGui.window)
	miliGui.nextRank  = guiCreateLabel(10, 146, 437, 18, "Nuevo Rango: cargando || cargando", false, miliGui.window)
	miliGui.jobDesc = guiCreateMemo(12, 187, 449, 98, jobDescriptions['militar'], false, miliGui.window)
	triggerServerEvent ( "NGJobs->Module->Job->militar->OnClientRequestF5Data", localPlayer );
	showCursor ( true );
	addEventHandler ( "onClientGUIClick", miliGui.close, createMilitarInterface );
end

addEvent ( "NGJobs->Module->Job->militar->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->militar->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( miliGui.window ) ) then return false; end 
	
	guiSetText ( miliGui.completedBajas, "Bajas: "..tostring ( data.bajas ) );
	guiSetText ( miliGui.nextRank, "Nuevo Rango: "..tostring ( data.nextRank ).. " | Requires "..tostring(data.requiredBajas).." falsos positivos mas.");
	
end );

bindKey ( "f5", "down", createMilitarInterface );