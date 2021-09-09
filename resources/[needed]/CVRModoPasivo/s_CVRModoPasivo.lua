local ticks = {}

function setPassiveMode(player)
    if (not getElementData(player,"isPassive")) and (not ticks[player] or  getTickCount() - ticks[player]>=300000) and (getElementData(player,"Job")=="UnEmployed") and (getElementData(player,"WantedPoints")==0) and not (exports.CVRhitman:hasReward(player)) then
        setElementData(player,"isPassive",true)
        ticks[player]=getTickCount()
        exports.ngmessages:sendClientMessage ( "Estás en modo pasivo!",player, 255, 255, 0 )
    elseif getElementData(player,"isPassive") then
        setElementData(player,"isPassive",nil)
        ticks[player]=getTickCount()
        exports.ngmessages:sendClientMessage ( "Te quitaste el modo pasivo!",player, 255, 255, 0 )
    else
        exports.ngmessages:sendClientMessage ( "Error, revisa que no tengas trabajo ni estrellas y que no hayas activado o desactivado el modo pasivo en los últimos 5 minutos",player, 255, 0, 0 )
    end
end

function makeItToServer4(thePlayer)
	setPassiveMode(thePlayer)
end

addEvent("makeItToServer4", true)
addEventHandler("makeItToServer4", root, makeItToServer4)
addCommandHandler("modopasivo",setPassiveMode)

