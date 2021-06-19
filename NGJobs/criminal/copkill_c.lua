----------------------
-- F5 Panel			--
----------------------
CrimenGui = { }
function createCrimenInterface ( )
	if ( isElement ( CrimenGui.window ) ) then 
		removeEventHandler ( "onClientGUIClick", CrimenGui.close, createCrimenInterface );
		destroyElement ( CrimenGui.window );
		CrimenGui.window = false;
		showCursor ( false );
		return
	end 
	
	local job = getElementData ( localPlayer, "Job" ) or "";
	if ( job ~= "Criminal" ) then return false; end
	
	CrimenGui.window = guiCreateWindow( ( sx / 2 - 471 / 2 ), ( sy / 2 - 330 / 2 ), 471, 330, "Criminal", false)
	guiWindowSetSizable(CrimenGui.window, false)
	CrimenGui.close = guiCreateButton(353, 295, 108, 25, "Cerrar", false, CrimenGui.window)
	CrimenGui.username = guiCreateLabel(10, 34, 437, 18, "Nombre: ".. tostring ( getElementData ( localPlayer, "AccountData:Username" ) ), false, CrimenGui.window)
	CrimenGui.job = guiCreateLabel(10, 62, 437, 18, "Trabajo: "..tostring ( getElementData ( localPlayer, "Job" ) ), false, CrimenGui.window)
	CrimenGui.completedAsesinatos = guiCreateLabel(10, 118, 437, 18, "Asesinatos: Cargando", false, CrimenGui.window)
	CrimenGui.jobRank = guiCreateLabel(10, 90, 437, 18, "Rango: "..tostring ( getElementData ( localPlayer, "Job Rank" ) ), false, CrimenGui.window)
	CrimenGui.nextRank  = guiCreateLabel(10, 146, 437, 18, "Nuevo Rango: cargando || cargando", false, CrimenGui.window)
	CrimenGui.jobDesc = guiCreateMemo(12, 187, 449, 98, jobDescriptions['criminal'], false, CrimenGui.window)
	triggerServerEvent ( "NGJobs->Module->Job->criminal->OnClientRequestF5Data", localPlayer );
	showCursor ( true );
	addEventHandler ( "onClientGUIClick", CrimenGui.close, createCrimenInterface );
end

addEvent ( "NGJobs->Module->Job->criminal->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->criminal->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( CrimenGui.window ) ) then return false; end 
	
	guiSetText ( CrimenGui.completedAsesinatos, "Asesinatos: "..tostring ( data.asesinatos ) );
	guiSetText ( CrimenGui.nextRank, "Nuevo Rango: "..tostring ( data.nextRank ).. " | Requires "..tostring(data.requiredAsesinatos).." asesinatos mas.");
	
end );

bindKey ( "f5", "down", createCrimenInterface );