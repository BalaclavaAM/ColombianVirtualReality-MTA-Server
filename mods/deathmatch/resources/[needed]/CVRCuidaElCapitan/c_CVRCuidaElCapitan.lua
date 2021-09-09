function canceldanho(attacker)
    if getElementData(localPlayer,"isinCapitan") then
        if attacker then
            if getPlayerTeam(localPlayer) == getPlayerTeam(attacker) then
                cancelEvent()
            end
        end
    end
end
addEventHandler("onClientPlayerDamage",root,canceldanho)