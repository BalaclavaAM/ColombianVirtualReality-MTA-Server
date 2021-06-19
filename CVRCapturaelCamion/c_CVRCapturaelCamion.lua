addEvent('onMinigameEnded',true)



addEvent('godTruck',true)
addEvent('disableGodTruck',true)
addEvent('onMinigameEnded',true)

addEventHandler('godTruck',root,
    function()
        setVehicleDamageProof ( getPedOccupiedVehicle ( getLocalPlayer() ), true )
		fixVehicle( getPedOccupiedVehicle( getLocalPlayer() ) )
    end
)

addEventHandler('disableGodTruck',root,
    function()
        setVehicleDamageProof ( getPedOccupiedVehicle ( getLocalPlayer() ), false )
		fixVehicle( getPedOccupiedVehicle( getLocalPlayer() ) )
    end
)

local myTeam={}

function stopTeamDamage ( attacker, weapon, bodypart )
    if attacker and isElement(attacker) and getElementType(attacker)=="player" and myTeam[attacker] then
	    cancelEvent()
    end
end

function addPlayerToTable(player)
    myTeam[player]=true
end
addEvent("CVRCapturaCamion:addPlayerTable",true)
addEventHandler("CVRCapturaCamion:addPlayerTable",root,addPlayerToTable)

function removePlayerToTable(player)
    myTeam[player]=nil
end
addEvent("CVRCapturaCamion:removePlayerTable",true)
addEventHandler("CVRCapturaCamion:removePlayerTable",root,removePlayerToTable)

function disableProtection(player)
    removeEventHandler ( "onClientPlayerDamage", localPlayer, stopTeamDamage )
    myTeam={}
end
addEvent("CVRCapturaCamion:disableProtection",true)
addEventHandler("CVRCapturaCamion:disableProtection",root,disableProtection)

function enableProtection()
    addEventHandler ( "onClientPlayerDamage", localPlayer, stopTeamDamage )
end
addEvent("CVRCapturaCamion:enableProtection",true)
addEventHandler("CVRCapturaCamion:enableProtection",root,enableProtection)


function crearPanel()
    sx, sy = guiGetScreenSize ( )
    rSX, rSY = sx / 1280, sx / 1024
    CapturaWindow = guiCreateWindow( ( sx / 2 - (rSX*500) / 2 ), (sy-(rSY*230))-rSY*15, rSX*500, rSY*230, "CVR Presenta: Captura el Camión", false)
    CapturaDescription = guiCreateMemo((rSX*10), (rSY*23), (rSX*480), (rSY*150), "En este minijuego la meta es traer el camión del otro equipo a tu base, con tres rondas ganadas, tu equipo gana el juego. Este juego tiene un costo de 25.000 (normalmente) y al final, la puja será dividida entre los participantes del juego. \nReglas:\n-No puedes asesinar a las personas de tu propio equipo. \n-No puedes trollear llevando tu propio camión a la base enemiga.\n\nComandos:\n/salircamion: Salir del camión.", false, CapturaWindow)
    CapturaAccept = guiCreateButton((rSX*10), ((rSY*230)-(rSY*25))-rSY*10, (rSX*150), (rSY*25), "Aceptar", false, CapturaWindow)
    CapturaDeny = guiCreateButton((rSX*170), ((rSY*230)-(rSY*25))-rSY*10, (rSX*150), (rSY*25), "Rechazar", false, CapturaWindow)
    guiWindowSetSizable(CapturaWindow, false)
    guiWindowSetMovable ( CapturaWindow, false )
    guiSetFont(CapturaDeny, "default-bold-small")
    guiSetFont(CapturaAccept, "default-bold-small")
    guiMemoSetReadOnly ( CapturaDescription, true )
end

function createP()
    if isElement(CapturaWindow) then
        removeEventHandler("onClientGUIClick",root,clickingevents_capturamenu)
        destroyElement(CapturaWindow)
        showCursor ( false )
    else
        addEventHandler("onClientGUIClick",root,clickingevents_capturamenu)
        crearPanel()
        showCursor( true )
    end
end
addEvent("CVRCapturaCamion:askPlayer",true)
addEventHandler("CVRCapturaCamion:askPlayer",root,createP)

function clickingevents_capturamenu ( )
	if ( source == CapturaDeny ) then
        createP()
	elseif ( source == CapturaAccept ) then
		triggerServerEvent ( "CVRCapturaCamion:EnterPlayer", localPlayer, localPlayer )
		createP()
	end
end