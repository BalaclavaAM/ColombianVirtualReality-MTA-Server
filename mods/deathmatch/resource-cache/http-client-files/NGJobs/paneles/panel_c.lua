----------------------
--F5 Panel Busetero --
----------------------
PanelTrabajosGui = { }
function createPanelTrabajosInterface ( )
	if ( isElement ( PanelTrabajosGui.window ) ) then 
		removeEventHandler ( "onClientGUIClick", PanelTrabajosGui.close, createPanelTrabajosInterface );
		destroyElement ( PanelTrabajosGui.window );
		PanelTrabajosGui.window = false;
		showCursor ( false );
		return
	end 
	
	local job = getElementData ( localPlayer, "Job" ) or "";
	if ( job ~= "Busetero" ) and ( job ~= "Camionero" ) and ( job ~= "Stunter" ) and ( job ~= "Taxista" ) and ( job ~= "Mechanic" ) and ( job ~= "Basurero" ) and ( job ~= "Medic" ) and ( job ~= "Criminal" ) and ( job ~= "Drifter" ) and ( job ~= "Militar" ) then return false; end

	PanelTrabajosGui.window = guiCreateWindow( ( sx / 2 - 471 / 2 ), ( sy / 2 - 330 / 2 ), 471, 330, "Estadisticas de trabajo", false)
	guiWindowSetSizable(PanelTrabajosGui.window, false)
	PanelTrabajosGui.close = guiCreateButton(353, 295, 108, 25, "Cerrar", false, PanelTrabajosGui.window)
	PanelTrabajosGui.username = guiCreateLabel(10, 34, 437, 18, "Nick: ".. tostring ( getElementData ( localPlayer, "AccountData:Username" ) ), false, PanelTrabajosGui.window)
	PanelTrabajosGui.job = guiCreateLabel(10, 62, 437, 18, "Trabajo: "..tostring ( getElementData ( localPlayer, "Job" ) ), false, PanelTrabajosGui.window)
	PanelTrabajosGui.jobRankPanelTrabajos= guiCreateLabel(10, 90, 437, 18, "Rango de Trabajo: "..tostring ( getElementData ( localPlayer, "Job Rank" ) ), false, PanelTrabajosGui.window)
	PanelTrabajosGui.completedVueltas = guiCreateLabel(10, 118, 437, 18, "Vueltas: Loading...", false, PanelTrabajosGui.window)
	PanelTrabajosGui.nextRankTrabajo = guiCreateLabel(10, 146, 437, 18, "Siguiente rango: Loading || Loading", false, PanelTrabajosGui.window)

	addEventHandler ( "onClientGUIClick", PanelTrabajosGui.close, createPanelTrabajosInterface );
	showCursor ( true );
	if ( job == "Busetero" ) then 

		PanelTrabajosGui.jobDesc = guiCreateMemo(12, 187, 449, 98, jobDescriptions['Busetero'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Busetero->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Camionero" ) then

		PanelTrabajosGui.jobDesc = guiCreateMemo(12, 187, 449, 98, jobDescriptions['Camionero'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Camionero->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Stunter" ) then

		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['stunter'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->stunter->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Taxista" ) then

		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['Taxista'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Taxista->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Mechanic" ) then

		PanelTrabajosGui.completedVueltas2 = guiCreateLabel(120, 118, 437, 18, "Decomisos: Loading...", false, PanelTrabajosGui.window)
		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['mechanic'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->mechanic->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Basurero" ) then

		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['Basurero'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Basurero->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Medic" ) then

		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['medic'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Medic->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Criminal" ) then

		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['criminal'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Criminal->OnClientRequestF5Data", localPlayer );
	
	elseif ( job == "Drifter" ) then

		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['Drifter'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Drifter->OnClientRequestF5Data", localPlayer );

	elseif ( job == "Militar" ) then

		PanelTrabajosGui.jobDesc= guiCreateMemo(12, 187, 449, 98, jobDescriptions['militar'], false, PanelTrabajosGui.window)
		triggerServerEvent ( "NGJobs->Module->Job->Militar->OnClientRequestF5Data", localPlayer );
	end
end
----addEventHandlers--------------
addEvent ( "NGJobs->Module->Job->Busetero->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Busetero->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Rutas: "..tostring ( data.ruticas ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankBusetero).. " | Requires "..tostring(data.requiredRutas).." rutas");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->Camionero->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Camionero->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Entregas: "..tostring ( data.entreguitas ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankCamionero).. " | Requires "..tostring(data.requiredEntregas).." entregas");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->stunter->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->stunter->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Repartos: "..tostring ( data.stuntscitos ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankstunter).. " | Requires "..tostring(data.requiredStunts).." Repartos");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->Taxista->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Taxista->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Carreras: "..tostring ( data.carreritas ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankTaxista).. " | Requires "..tostring(data.requiredCarreras).." carreras");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->mechanic->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->mechanic->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Reparaciones: "..tostring ( data.reparacioncitas ) );
	guiSetText ( PanelTrabajosGui.completedVueltas2, "Decomisos: "..tostring ( data.decomisitos ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankmechanic).. " | Requires "..tostring(data.requiredReparaciones).." reparaciones");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->Basurero->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Basurero->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Repartos: "..tostring ( data.reparticos ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankBasurero).. " | Requires "..tostring(data.requiredRepartos).." repartos");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->Medic->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Medic->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Curados: "..tostring ( data.curaditos ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankMedic).. " | Requires "..tostring(data.requiredCurados).." curados");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->Criminal->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Criminal->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Kills: "..tostring ( data.killcitas ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankCriminal).. " | Requires "..tostring(data.requiredKills).." kills");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->Drifter->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Drifter->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Acciones: "..tostring ( data.accioncitas ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankDrifter).. " | Requires "..tostring(data.requiredAcciones).." acciones");
end );
---------------------------------
addEvent ( "NGJobs->Module->Job->Militar->onServerSendClientJobInfo", true );
addEventHandler ( "NGJobs->Module->Job->Militar->onServerSendClientJobInfo", root, function ( data )
	if ( not isElement ( PanelTrabajosGui.window ) ) then return false; end 
	guiSetText ( PanelTrabajosGui.completedVueltas, "Falsos Positivos: "..tostring ( data.falsosposi ) );
	guiSetText ( PanelTrabajosGui.nextRankTrabajo, "Siguiente rango: "..tostring ( data.nextRankMilitar).. " | Requires "..tostring(data.requiredFalsosPositivos).." falsos positivos");
end );
---------------------------------

bindKey ( "f5", "down", createPanelTrabajosInterface );