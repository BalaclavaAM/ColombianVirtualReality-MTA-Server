
function PCedula(Jugador)
    local stringlogin = getAccountName( getPlayerAccount( Jugador ) )
    local stringnick = getPlayerName( Jugador )
    local stringvip = getElementData ( Jugador, "VIP" )
    triggerClientEvent ( client, "dibujarCedula", client, stringlogin,stringnick,stringvip )
end
addEvent( "HMenu::PCedula", true )
addEventHandler( "HMenu::PCedula", resourceRoot, PCedula )

function ComandoServer (Comando )
    executeCommandHandler( Comando,client)
end
addEvent( "HMenu::ComandoServer", true )
addEventHandler( "HMenu::ComandoServer", resourceRoot, ComandoServer )