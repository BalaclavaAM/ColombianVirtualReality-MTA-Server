local votos1 = 0
local votos2 = 0
local votos3 = 0
local estado = 0

function CrearPanelEncuensta(player)

    if (exports['NGAdministration']:isPlayerStaff ( player )) and estado == 0 then --#se puede poner solo para x persona
        triggerClientEvent(player,"AbrirPanelEncuesta",player)
        votos1 = 0
        votos2 = 0
        votos3 = 0
        estado = 1
    else
        outputChatBox ("No tienes permiso o hay una encuesta en proceso.",player,255,0,0,true)
    end
end
addCommandHandler("encuesta",CrearPanelEncuensta)

function CrearPanelEncuensta(player,Op1,Op2,tamFuente2,Pregunta2)
    triggerClientEvent(root,"VentanaEncuesta",root,player,Op1,Op2,tamFuente2,Pregunta2)
    estado = 2
end
addEvent("EnviarOpcionesAServer", true ) 
addEventHandler("EnviarOpcionesAServer", root,CrearPanelEncuensta)

addEvent ( "onBoton1", true ) 
addEventHandler ( "onBoton1", root, function ( v ) 
    votos1 = votos1 + 1
end ) 

addEvent ( "onBoton2", true ) 
addEventHandler ( "onBoton2", root, function ( f ) 
    votos2 = votos2 + 1
end )

addEvent ( "onBoton3", true ) 
addEventHandler ( "onBoton3", root, function ( p) 
    votos3 = votos3 + 1 
end ) 

addEvent ( "Estadoen0", true ) 
addEventHandler ( "Estadoen0", root, function (estatus) 
    estado = estatus  
end ) 


function SumaVotos(playerSource,option)
    triggerClientEvent(root,"Terminarencuesta",root)
    if ( playerSource ) and estado == 2 then --#se puede poner solo para x persona
        outputChatBox( "#A000EA=====================",root,255 , 255, 255,true)
        outputChatBox( "        #26AD00Resultados Encuesta",root,255 , 255, 255,true)
        outputChatBox("     Opcion 1 Con:#DCEA00 "..votos1.." Votos",root,255 , 255, 255,true)
        outputChatBox("     Opcion 2 Con:#009AEA "..votos2.." Votos",root,255 , 255, 255,true)
        outputChatBox("     No Votaron:#EA2700 "..votos3.." Usuarios",root,255 , 255, 255,true)
        outputChatBox( "#A000EA=====================",root,255 , 255, 255,true)
    else 
        outputChatBox( "#A000EANo hay ninguna encuesta abierta o hay una en proceso.",playerSource,255 , 255, 255,true)
    end
    estado = 0
end
addCommandHandler( "votos", SumaVotos)
