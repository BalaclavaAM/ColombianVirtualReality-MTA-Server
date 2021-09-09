local screenW, screenH = guiGetScreenSize()
local screenX, screenY = 1600 , 900
local WX = screenW/screenX
local resolucion = 2.8*WX
local anuncioCompleto = false
local anunciador = false
local anunciadorDJ = false
local anuncioDJ = false

function render (persona,mensaje)
    anunciador = persona
    anuncioCompleto = mensaje
    addEventHandler ( "onClientRender", root, anuncioCVRCliente)
    setTimer (
        function ( )
            removeEventHandler("onClientRender",root,anuncioCVRCliente)
            anuncioCompleto = false
            anunciador = false
        end
        ,10000, 1
    )
end
addEvent( "AnucioToCliente", true )
addEventHandler( "AnucioToCliente", root, render)

function anuncioCVRCliente()

    dxDrawText(anunciador..": "..anuncioCompleto, (screenW * 0.1556) - 1, (screenH * 0.3244) - 1, (screenW * 0.8444) - 1, (screenH * 0.6756) - 1, tocolor(0, 0, 0, 255), (resolucion), "default", "center", "center", true, true, true, false, false)
    dxDrawText(anunciador..": "..anuncioCompleto, (screenW * 0.1556) + 1, (screenH * 0.3244) - 1, (screenW * 0.8444) + 1, (screenH * 0.6756) - 1, tocolor(0, 0, 0, 255), (resolucion), "default", "center", "center", true, true, true, false, false)
    dxDrawText(anunciador..": "..anuncioCompleto, (screenW * 0.1556) - 1, (screenH * 0.3244) + 1, (screenW * 0.8444) - 1, (screenH * 0.6756) + 1, tocolor(0, 0, 0, 255), (resolucion), "default", "center", "center", true, true, true, false, false)
    dxDrawText(anunciador..": "..anuncioCompleto, (screenW * 0.1556) + 1, (screenH * 0.3244) + 1, (screenW * 0.8444) + 1, (screenH * 0.6756) + 1, tocolor(0, 0, 0, 255), (resolucion), "default", "center", "center", true, true, true, false, false)
    dxDrawText(anunciador..": "..anuncioCompleto, screenW * 0.1556, screenH * 0.3244, screenW * 0.8444, screenH * 0.6756, tocolor(254, 9, 61, 255), (resolucion), "default", "center", "center", true, true, true, false, false)

end
------------------------------------------------------------------------------


function renderDJ (elDJ,suPubli)
    anunciadorDJ = elDJ
    anuncioDJ = suPubli
    addEventHandler ( "onClientRender", root, publiDJ)
    timerDJs =setTimer (
        function ( )
            removeEventHandler("onClientRender",root,publiDJ)
            mensajeDJ = 0
            anunciadorDJ = false
            anuncioDJ = false
        end
        ,120000, 1
    )
end
addEvent( "AnucioToClienteDJ", true )
addEventHandler( "AnucioToClienteDJ", getLocalPlayer(  ), renderDJ)

function publiDJ()

    dxDrawText("DJ "..anunciadorDJ.." "..anuncioDJ, (screenW * 0.2162) - 1, (screenH * 0.7300) - 1, (screenW * 0.3837) - 1, (screenH * 0.8978) - 1, tocolor(0, 0, 0, 255), (1.50*WX), "default", "center", "center", true, true, true, false, false)
    dxDrawText("DJ "..anunciadorDJ.." "..anuncioDJ, (screenW * 0.2162) + 1, (screenH * 0.7300) - 1, (screenW * 0.3837) + 1, (screenH * 0.8978) - 1, tocolor(0, 0, 0, 255), (1.50*WX), "default", "center", "center", true, true, true, false, false)
    dxDrawText("DJ "..anunciadorDJ.." "..anuncioDJ, (screenW * 0.2162) - 1, (screenH * 0.7300) + 1, (screenW * 0.3837) - 1, (screenH * 0.8978) + 1, tocolor(0, 0, 0, 255), (1.50*WX), "default", "center", "center", true, true, true, false, false)
    dxDrawText("DJ "..anunciadorDJ.." "..anuncioDJ, (screenW * 0.2162) + 1, (screenH * 0.7300) + 1, (screenW * 0.3837) + 1, (screenH * 0.8978) + 1, tocolor(0, 0, 0, 255), (1.50*WX), "default", "center", "center", true, true, true, false, false)
    dxDrawText("DJ "..anunciadorDJ.." "..anuncioDJ, screenW * 0.2162, screenH * 0.7300, screenW * 0.3837, screenH * 0.8978, tocolor(255, 0, 0, 255), (1.50*WX), "default", "center", "center", true, true, true, false, false)

end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


function delAnuncio()
    killTimer( timerDJs )
    removeEventHandler("onClientRender",root,publiDJ)
    mensajeDJ = 0
    anunciadorDJ = false
    anuncioDJ = false
end
addEvent( "delAnucioToClienteDJ", true )
addEventHandler( "delAnucioToClienteDJ", getLocalPlayer(  ), delAnuncio)