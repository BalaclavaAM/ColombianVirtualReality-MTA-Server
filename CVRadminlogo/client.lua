local admins={}

local cooldown=false

function getStaff()
    if not (cooldown) or getTickCount()-cooldown>30000 then
        for k, player in ipairs(getElementsByType("player")) do
            if getElementData(player,"staffLevel") ~= -1 and getElementData(player,"staffLevel") ~= false then
                admins[player]=player
                cooldown=getTickCount()
            end
        end
    end
end

imgW = 250
imgH = 125




function adminLogo()
    getStaff()
    for i,player in pairs(admins) do
        if player and isElement(player) and not (getElementData(player,"disguise")) then
            local cX, cY, cZ = getCameraMatrix()
            local hX, hY, hZ = getPedBonePosition(player, 8)
            hZ = hZ + 0.3
            local pX,pY,pZ = getPedBonePosition(localPlayer, 8)
            pZ = pZ + 0.5
            if getScreenFromWorldPosition(hX, hY, hZ) and isLineOfSightClear(cX,cY,cZ, pX,pY,pZ) then
                local sX, sY, sD = getScreenFromWorldPosition(hX, hY, hZ)
                local relative = (50 - sD) / 50
                if relative > 0 then
                    local iW = (imgW * relative)/2
                    local iH = (imgH * relative)/2

                    local iX = sX - (iW / 2)
                    local iY = sY - (iH / 2)

                    dxDrawImage(iX, iY, iW, iH, "admin.png")
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, adminLogo)