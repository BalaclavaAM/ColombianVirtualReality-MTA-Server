local mensajePantalla = 0 
local mensajeDJ = 0 
local tiempoDJ = {}
local limitadorTiempo = 1200000

function CVRMensajePantalla(player,_,...)
    if mensajePantalla ~= 0 then return end
    local accountname = getAccountName ( getPlayerAccount ( player ) )
    if ((accountname=="MagicMora") or (accountname=="AshTheLynx.") or (accountname=="BalaclavaAM")  or (accountname=="cazaputas42") or (accountname == "DokiC4C0RR0") or (accountname=="karamelo") or (accountname == "ReizerB")  or (accountname == "RicardoJorge") or (accountname == "Jimenez") or (accountname == "MataTombos23") or (accountname == "V-neko_Kawaii") or (accountname == "iMegu") or (accountname == "FRANCINE98") or (accountname == "Paisita09") and mensajePantalla == 0 ) then 
        local anuncioCompleto = table.concat( {...}," " )
        local anunciador = getPlayerName(player)
        mensajePantalla = 1
        triggerClientEvent(root,"AnucioToCliente",root,anunciador,anuncioCompleto)
        setTimer (
            function ( )
                mensajePantalla = 0
            end
            ,10000, 1
        )
    end

end
addCommandHandler("anunciodj",CVRMensajePantalla)

function CVRMensajePublicidad(player,_,...)
    local anunciadorDJ =getPlayerName(player)
    local anuncioDJ = table.concat( {...}," " )
    local accName = getAccountName(getPlayerAccount(player))
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "DJ" ) ) then
        if mensajeDJ ~= 0 then return end
        if not tiempoDJ[player] or getTickCount() - tiempoDJ[player] >= limitadorTiempo then
            mensajeDJ = 1
            tiempoDJ[player] = getTickCount()
            triggerClientEvent(root,"AnucioToClienteDJ",root,anunciadorDJ,anuncioDJ)
            timerDJ = setTimer (
                function ( )
                    mensajeDJ = 0
                end
                ,120000, 1
            )
        else 
            local tiempoRestante = math.round((limitadorTiempo - (getTickCount() - tiempoDJ[player]))/(60000))
            outputChatBox("#00ff00Debes esperar #ff0000"..tiempoRestante.." #00ff00min antes de volver a hacer publicidad de ti.",player,255,0,0,true)
        end
    end
end
addCommandHandler("publidj",CVRMensajePublicidad)

function delMesajeDJ(player,_)
    if (exports['NGAdministration']:isPlayerStaff ( player )) then
        if mensajeDJ == 1 then
            mensajeDJ = 0
            triggerClientEvent(root,"delAnucioToClienteDJ",root)
            killTimer(timerDJ)
            outputChatBox("#00ff00Anuncio eliminado",player,255,0,0,true)
        else 
            outputChatBox("#00ff00No hay mensaje activo para borrar",player,255,0,0,true)
        end
    end
end
addCommandHandler("deldj",delMesajeDJ)
