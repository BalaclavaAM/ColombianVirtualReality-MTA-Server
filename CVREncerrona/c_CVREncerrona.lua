function asesinoSOUND()
	playSound("archivos/ASESINO.mp3",false,false)
end
addEvent("playAsesino", true)
addEventHandler("playAsesino",localPlayer,asesinoSOUND)

function respawnSOUND()
    playSound("archivos/RESPAWN.mp3",false,false)
end
addEvent("playRespawn",true)
addEventHandler("playRespawn",localPlayer,respawnSOUND)


function replaceModel2()
    local aviso = engineLoadTXD ("archivos/break_s_fillers.txd")
    engineImportTXD (aviso,1443)
    local encerronatxd = engineLoadTXD("archivos/lockout.txd")
    local encerronadff = engineLoadDFF("archivos/lockout.dff")
    local encerronacol = engineLoadCOL("archivos/lockout.col")
    engineImportTXD(encerronatxd,14821)
    engineReplaceModel(encerronadff,14821)
    engineReplaceCOL(encerronacol,14821)

    local encerrona = createObject(14821,601.73, 2424.92, 317.92)
    setElementDimension(encerrona,40)

    local xboxtxd = engineLoadTXD("archivos/xbox.txd")
    local xboxdff = engineLoadDFF("archivos/xbox.dff")
    engineImportTXD (xboxtxd,2028)
    engineReplaceModel(xboxdff,2028)

    local avisogrande = engineLoadTXD("archivos/billbrd01_lan2.txd")
    engineImportTXD(avisogrande, 4732)
end
 addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), 
     function() 
         replaceModel2()
         setTimer (replaceModel2, 1000, 1) 
     end 
) 