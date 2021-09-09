shops = { -- fishermen locations on the map
--[[    {x = 2013.34, y = -1197.18, z = 20.02, rot = 101.04, int = 0, dim = 0},
    {x = 1983.81, y = -1227.41, z = 20.07, rot = 275.63, int = 0, dim = 0},    
    {x = 159.35, y = -1947.16, z = 3.77, rot = 300.01, int = 0, dim = 0},
    {x = 357.2, y = -1898.74, z = 1.31, rot = 85.29, int = 0, dim = 0},
    {x = 364.61, y = -1942.44, z = 7.84, rot = 93.62, int = 0, dim = 0},
    {x = 408.1, y = -2085.61, z = 7.84, rot = 181.14, int = 0, dim = 0, forceGreenzone = true}, -- santa marina guy. | forceGreenzone was used to create a greenzone around the fisherman in Forseti RPG. no longer used.
    {x = 820.66, y = -1852.08, z = 12.87, rot = 272.69, int = 0, dim = 0},
    {x = 850.41, y = -2065.77, z = 12.87, rot = 93.14, int = 0, dim = 0},
    {x = 971.01, y = -2088.71, z = 2.21, rot = 78.72, int = 0, dim = 0},
    {x = 69.69, y = -1517.05, z = 4.94, rot = 259.6, int = 0, dim = 0},
    {x = -229.38, y = -1721.43, z = 1.05, rot = 176.38, int = 0, dim = 0},
    {x = -231.78, y = -2154.48, z = 29.27, rot = 276.98, int = 0, dim = 0},
    {x = 5.1, y = -2489.85, z = 35.08, rot = 290.51, int = 0, dim = 0},
    {x = -599.79, y = -2806.87, z = 47.87, rot = 187.65, int = 0, dim = 0},
    {x = -1289.8, y = -2913.6, z = 54.22, rot = 202.09, int = 0, dim = 0},
    {x = -1498.07, y = -2233.4, z = 3.21, rot = 87.49, int = 0, dim = 0},
    {x = -1504.46, y = -2166.76, z = 2.01, rot = 165.77, int = 0, dim = 0},
    {x = -1408.73, y = -2036.3, z = 1.08, rot = 248.53, int = 0, dim = 0},
    {x = -1364.49, y = -2021.15, z = 1.13, rot = 292.75, int = 0, dim = 0},
    {x = -1886.99, y = -1399.49, z = 39.74, rot = 154.27, int = 0, dim = 0},
    {x = -1916.39, y = -1455.96, z = 13.4, rot = 12.38, int = 0, dim = 0},
    {x = -2523.73, y = -918.55, z = 8.86, rot = 49.6, int = 0, dim = 0},
    {x = -2952.37, y = -859.59, z = 1.62, rot = 147.52, int = 0, dim = 0},
    {x = -2941.3, y = -668.39, z = 1.87, rot = 84.36, int = 0, dim = 0},
    {x = -2937.98, y = -490.8, z = 1.46, rot = 97.45, int = 0, dim = 0},
    {x = -2914.7, y = -213.13, z = 2.17, rot = 90.45, int = 0, dim = 0},
    {x = -2912.6, y = 269.58, z = 2.07, rot = 94.96, int = 0, dim = 0},
    {x = -2974.69, y = 505.23, z = 2.43, rot = 182.03, int = 0, dim = 0},
    {x = -2949.59, y = 488.83, z = 2.43, rot = 264.35, int = 0, dim = 0},
    {x = -2902.74, y = 1241.19, z = 7.1, rot = 309.03, int = 0, dim = 0},
    {x = -2720.41, y = 1429.33, z = 7.25, rot = 268.9, int = 0, dim = 0},
    {x = -2437.55, y = 1399.11, z = 7.36, rot = 188.59, int = 0, dim = 0},
    {x = -2062.33, y = 1435.93, z = 7.1, rot = 180.03, int = 0, dim = 0},
    {x = -1614.06, y = 1390.97, z = 7.17, rot = 95.44, int = 0, dim = 0},
    {x = -1454.83, y = 1131.32, z = 7.19, rot = 12.87, int = 0, dim = 0},
    {x = -1461.54, y = 1086.09, z = 1.59, rot = 89.11, int = 0, dim = 0},
    {x = -818.71, y = 676.9, z = 10.08, rot = 167.87, int = 0, dim = 0},
    {x = -663.36, y = 880.86, z = 2, rot = 309.77, int = 0, dim = 0},
    {x = -445.1, y = 902.98, z = 4.3, rot = 96.83, int = 0, dim = 0},
    {x = -421.2, y = 1162.84, z = 1.77, rot = 278.17, int = 0, dim = 0},
    {x = -638.1, y = 1339.39, z = 1.81, rot = 296.44, int = 0, dim = 0},
    {x = -945.62, y = 1683.54, z = 16.22, rot = 189.55, int = 0, dim = 0},
    {x = -1438.16, y = 1671.21, z = 15.36, rot = 157.51, int = 0, dim = 0},
    {x = -1843.89, y = 2107.19, z = 2, rot = 104.72, int = 0, dim = 0},
    {x = -2002.74, y = 2204.31, z = 3.44, rot = 260.37, int = 0, dim = 0},
    {x = -2213.08, y = 2420.04, z = 2.49, rot = 47.21, int = 0, dim = 0},
    {x = -2223.69, y = 2389.8, z = 2.46, rot = 44.06, int = 0, dim = 0},
    {x = -2296.89, y = 2225.46, z = 4.98, rot = 358.27, int = 0, dim = 0},
    {x = -2705.92, y = 1925.88, z = 64.83, rot = 56.67, int = 0, dim = 0},
    {x = -2704.48, y = 1942.62, z = 64.02, rot = 116.46, int = 0, dim = 0},
    {x = -2831.24, y = -1997.33, z = 38.32, rot = 149.3, int = 0, dim = 0},
    {x = -2682.25, y = -2222.32, z = 2.05, rot = 36.75, int = 0, dim = 0},
    {x = -2782.04, y = -2559.61, z = 1.86, rot = 117.49, int = 0, dim = 0},
    {x = -2526.75, y = -2807.34, z = 13.87, rot = 30.66, int = 0, dim = 0},
    {x = -1939.81, y = -2804.74, z = 2.38, rot = 210.21, int = 0, dim = 0},
    {x = -784.42, y = 2134.03, z = 60.38, rot = 238.94, int = 0, dim = 0},
    {x = -480.64, y = 2187.86, z = 41.86, rot = 358.44, int = 0, dim = 0},
    {x = 156.45, y = 638.09, z = 1.87, rot = 156.19, int = 0, dim = 0},
    {x = 508.89, y = 623.44, z = 3.07, rot = 201.69, int = 0, dim = 0},
    {x = 1066.61, y = 665.59, z = 7.15, rot = 183.19, int = 0, dim = 0},
    {x = 1623.12, y = 576.16, z = 1.76, rot = 0.02, int = 0, dim = 0},
    {x = 2299.31, y = 523.17, z = 1.79, rot = 359.35, int = 0, dim = 0},
    {x = 2370.82, y = 534.45, z = 1.8, rot = 90.93, int = 0, dim = 0},
    {x = 2804.07, y = 279.92, z = 2.58, rot = 291.24, int = 0, dim = 0},
    {x = 2875.57, y = -240.19, z = 5, rot = 0.02, int = 0, dim = 0},
    {x = 2945.4, y = -676.39, z = 2.39, rot = 188.83, int = 0, dim = 0},
    {x = 2947.32, y = -764.84, z = 1.27, rot = 270, int = 0, dim = 0},
    {x = 2906.32, y = -1639.45, z = 11.05, rot = 72.86, int = 0, dim = 0},
    {x = 2918.4, y = -1906.3, z = 1.48, rot = 356.17, int = 0, dim = 0},
    {x = 2941.46, y = -2054.05, z = 3.55, rot = 89.13, int = 0, dim = 0},
    {x = 2717.97, y = -2316.43, z = 3.2, rot = 175.5, int = 0, dim = 0},
    {x = 2810.39, y = -2504.38, z = 13.63, rot = 89.3, int = 0, dim = 0},
    {x = 2722.8, y = -2577.14, z = 3.2, rot = 183.39, int = 0, dim = 0},
    {x = 1962.32, y = -2766.53, z = 2.07, rot = 180.47, int = 0, dim = 0},
    {x = 1199.96, y = -2471.87, z = 12.51, rot = 339.04, int = 0, dim = 0},
    {x = -753.88, y = 229.76, z = 1.82, rot = 32.72, int = 0, dim = 0},
    {x = -587.71, y = 295.28, z = 2.43, rot = 26.18, int = 0, dim = 0},
    {x = -224.55, y = 505.87, z = 2.55, rot = 168.73, int = 0, dim = 0},
    {x = -51.85, y = 209.09, z = 2.43, rot = 330, int = 0, dim = 0},
    {x = 296.65, y = 160.92, z = 2.47, rot = 22.56, int = 0, dim = 0},
    {x = 395.28, y = 228.34, z = 1.87, rot = 40.39, int = 0, dim = 0},
    {x = -213.64, y = -797.07, z = 2.76, rot = 336.08, int = 0, dim = 0},
    {x = -335.35, y = -452.88, z = 2.32, rot = 234.8, int = 0, dim = 0},
    {x = -773.23, y = -374.14, z = 4.69, rot = 274.73, int = 0, dim = 0},
    {x = -1664.65, y = -1696.84, z = 1.5, rot = 253.55, int = 0, dim = 0},        
    {x = -2171.07, y = -1128.14, z = 11.74, rot = 212.75, int = 0, dim = 0},
    {x = 1005, y = -97.06, z = 23.82, rot = 124.28, int = 0, dim = 0},
    {x = 1130.69, y = -77.96, z = 22.52, rot = 254.22, int = 0, dim = 0},]]
    {x = 2125.88, y = -89.79, z = 1.98, rot = 303.82, int = 0, dim = 0}, -- la de pescador 
    {x = 2015.95, y = -26.31, z = 2.62, rot = 171.44, int = 0, dim = 0}, -- la otra playa
--[[    {x = 2124.54, y = 201.39, z = 1.17, rot = 243.43, int = 0, dim = 0},
    {x = -1605.8, y = 170.48, z = 3.55, rot = 317.36, int = 0, dim = 0},
    {x = -1524.64, y = 164.9, z = 3.55, rot = 313.98, int = 0, dim = 0},
    {x = 258.02, y = 2938.15, z = 1.77, rot = 182.15, int = 0, dim = 0},
    {x = 564.02, y = -1958.85, z = 6.1, rot = 186.23, int = 0, dim = 0},
    {x = -1181.76, y = 2677.3, z = 41.93, rot = 13.77, int = 0, dim = 0},
]]
    -- inside ship base
    --{x = 2557.87, y = 1564.25, z = 10.82, rot = 94.22, int = 0, dim = 0},
};

local screenW, screenH = guiGetScreenSize();
local rodPrice = 50000;

local fishermanSkins = { 45 }

function showFishMarket()
    if marketShowing then
        hideFishMarket();
    else
        marketShowing = true;
        bindKey("X", "down", hideFishMarket);
        buyRodBtn = guiCreateButton(screenW * 0.4156, screenH * 0.2991, screenW * 0.0672, screenH * 0.0287, "Caña de pescar ($" .. rodPrice .. ")", false);
        sellFishBtn = guiCreateButton(screenW * 0.4880, screenH * 0.2991, screenW * 0.0672, screenH * 0.0287, "Vender tu pescao", false);

        addEventHandler("onClientGUIClick", buyRodBtn, 
            function()
                if getPedWeapon(localPlayer, 1) ~= 7 then
                    triggerServerEvent("fish:getRod", localPlayer, rodPrice);
                else
                    outputChatBox("Ya tienes una caña de pescar.", 55, 255, 55);
                end
            end
        );

        addEventHandler("onClientGUIClick", sellFishBtn, sellAllFish);

        showCursor(true);
        addEventHandler("onClientRender", root, renderFishMarket);
    end
end

function hideFishMarket()
    if marketShowing then
        marketShowing = false;
        buyRodBtn:destroy();
        sellFishBtn:destroy();
        unbindKey("X", "down", hideFishMarket);
        showCursor(false);
        removeEventHandler("onClientRender", root, renderFishMarket);
        closeConfirm(); 
    end
end

function renderFishMarket()
    dxDrawRectangle(screenW * 0.4104, screenH * 0.2898, screenW * 0.1500, screenH * 0.0472, tocolor(0, 0, 0, 165), false);
    dxDrawText("Cerrar: 'X'", (screenW * 0.4104)+3, (screenH * 0.3463)+3, (screenW * 0.5604)+3, (screenH * 0.3778)+3, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "top", false, false, false, false, false);
    dxDrawText("Cerrar: 'X'", screenW * 0.4104, screenH * 0.3463, screenW * 0.5604, screenH * 0.3778, tocolor(255, 55, 55, 255), 1.00, "pricedown", "center", "top", false, false, false, false, false);
end

function createShops ()
    for i, v in ipairs (shops) do
        local fisherman = createPed(fishermanSkins[ math.random(#fishermanSkins) ], v.x, v.y, v.z);
        createFishingBlip (v.x, v.y, "tropicalfish.png", 16);
        givePedWeapon(fisherman, 7, 1, true);
        fisherman:setRotation(0, 0, v.rot); fisherman.dimension = v.dim; fisherman.interior = v.int;
        local marker = createMarker(fisherman.matrix.position + fisherman.matrix.forward * 1 + fisherman.matrix.up * -1, "cylinder", 1, 255, 75, 175, 165);
        marker.dimension = v.dim; marker.interior = v.int;

        addEventHandler("onClientMarkerHit", marker,
            function(e, dim)
                if e and dim and e == localPlayer then
                    if not isPedInVehicle(localPlayer) then
                        showFishMarket ();
                    end
                end
            end
        );

        addEventHandler("onClientPedDamage", fisherman, cancelEvent);

        -- these are optional but nice.
        addEventHandler("onClientElementStreamIn", fisherman, 
            function()
                fisherman:setPosition(v.x, v.y, v.z+1);
                fisherman:setAnimation("pool", "pool_idle_stance");
            end
        );

        addEventHandler("onClientElementStreamOut", fisherman, 
        function()
            fisherman:setPosition(v.x, v.y, v.z+1);
            fisherman:setAnimation("pool", "pool_idle_stance");
        end
    );
    end
end

createShops();