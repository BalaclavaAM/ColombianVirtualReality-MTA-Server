local pickup = createPickup ( 1629.49, -1508.8, 13.59, 2, 26, 30000, 0 )  
function darHabilidadRecortada(playerWhoUsed)
    if getElementData(playerWhoUsed,"Job Rank") == "Pablo Escobar" then
        setPedStat( playerWhoUsed, 73, 1000)
        outputChatBox("Acabas de obtener habilidad máxima en la recortada!.",playerWhoUsed,255,0,0,false)
    else
        outputChatBox("Tienes que ser rango Pablo Escobar para usar este pickup y obtener habilidad. Anímate!!.",playerWhoUsed,255,0,0,false)
        cancelEvent()
    end
end


addEventHandler( "onPickupUse", pickup, darHabilidadRecortada )
