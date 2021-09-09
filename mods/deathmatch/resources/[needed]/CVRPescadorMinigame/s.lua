-------- Modify functions below to suit your needs and/or database ------
-------- Aşağıdaki fonksiyonları kendi veri tabanınıza göre uyarlayın ---
function setPlayerData(player, key, val)
    local acc = player.account;
    if acc then
        return acc:setData(key, val)
    end
end

function getPlayerData(player, key)
    local acc = player.account;
    if acc then
        return acc:getData(key);
    end
    return false;
end

function getMoney(player)
    return getPlayerMoney(player);
end

function takeMoney(player, amount)
    return takePlayerMoney(player, amount);
end

function giveMoney(player, amount)
    return givePlayerMoney(player, amount);
end

function isPlayerLoggedIn(player)
    return player.account;
end
----------------------------------------
----------------------------------------


addEvent("fish:syncAnim", true);
addEventHandler("fish:syncAnim", root,
    function(...)
        client:setAnimation(unpack(arg));
    end
);

function comma_value( n )
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end



local function round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end



addEvent("fish:updateInventory", true); 
function updateInventory (player, newInv)
end
addEventHandler("fish:updateInventory", root, function(i) updateInventory(client, i) end);

addEvent("fish:onPlayerCatchFish", true);
addEventHandler("fish:onPlayerCatchFish", root,
    function(fishname, weight, exp)
        local currentFish = getPlayerData(client, "fish_inventory");
        if  not currentFish then
            local inventory = {
            };
            for i, v in ipairs (fish) do
            inventory[v.name] = {};
            end
            currentFish = toJSON(inventory);
            ----
        end
        if currentFish then currentFish = fromJSON(currentFish) end
        if currentFish then

            currentFish[fishname].inhand = (currentFish[fishname].inhand or 0)+1;
            currentFish[fishname].total = (currentFish[fishname].total or 0)+1;
            currentFish[fishname].totalweight = (currentFish[fishname].totalweight or 0) + weight;
            setPlayerData(client, "fish_inventory", toJSON(currentFish));

            -- special announcements for rare fish.
            if fishname == "Pearl" then
                outputChatBox( client.name .. " atrapaste una Perla!", root, 255, 65, 165 );
            end
            if fishname == "Rainbow Jellyfish" then
                outputChatBox( client.name .. " has caught a Pescao Arcoíris!", root, 255, 65, 165 );
            end

            -- sync player's inv.
            syncInventory(client);

            --exp
            --triggerEvent("exp:gain", client, exp or 0) -- used in Forseti RPG.
        end
        
    end
)


addEvent("fish:requestedSync", true);
function syncInventory (player, FORCED_INV)
    -- send your fish inventory to client, so we can render it.
    if isPlayerLoggedIn(player) then
        local savedInv = FORCED_INV or getPlayerData(player, "fish_inventory");
        if savedInv then
            if fromJSON(savedInv) then

                local inv = fromJSON(savedInv);

                for i,v in ipairs (fish) do
                    if not inv[v.name] then
                        inv[v.name] = {};
                    end
                end
                setPlayerData(player, "fish_inventory", toJSON(inv));

                triggerClientEvent(player, "fish:onServerSendInventory", player, inv);
            end
        end
    end
end
addEventHandler("fish:requestedSync", root, function() syncInventory(client) end);

addEventHandler("onPlayerLogin", root,
    function()
        syncInventory(source);
    end
);

addEventHandler("onPlayerLogout", root,
    function()
        syncInventory(source, toJSON({}));
    end
);



addEvent("fish:sellInventory", true);
addEventHandler("fish:sellInventory", root,
    function()

        -- sell player's current inventory of fish. if we removed a previous fish type, it will stay in player's inventory.
        -- but it will not be eligable for selling unless it gets added back in fishlist.lua with the same ["name"] key.

        local currentFish = getPlayerData(client, "fish_inventory") or "[[]]";
        if currentFish then currentFish = fromJSON(currentFish) end

        if currentFish then
            local totalfish = 0;
            local totalweight = 0;
            local totalprice = 0;

            -- do the math.
            for i,v in pairs (fish) do
                if currentFish[v.name] then
                    local inhand = currentFish[v.name].inhand or 0;
                    local weight = currentFish[v.name].totalweight or 0;

                    totalfish = totalfish + inhand;
                    totalweight = totalweight + weight;
                    totalprice = totalprice + (weight * v.price);

                    -- remove "in hand" part from our inv.
                    currentFish[v.name].inhand = 0;
                    currentFish[v.name].totalweight = 0;
                else
                end
            end

            -- give him the money and update his inventory.
            giveMoney(client, totalprice, "Fishing");
            setPlayerData(client, "fish_inventory", toJSON(currentFish));
            syncInventory(client);
            -----------

            local currentTotalGain = getPlayerData(client, "fishing_income") or 0;
            setPlayerData(client, "fishing_income", currentTotalGain + totalprice);

            local str = string.format("Vendiste %s libras(s) de %s pescao!\n+$%s", round(totalweight), totalfish, comma_value(round(totalprice)));
            triggerClientEvent(client, "pop", client, str, "green", .1 );
        end
    end
)



-- get a fishing rod.
addEvent("fish:getRod", true);
addEventHandler("fish:getRod", root,
    function(price)
        local curMoney = getMoney(client);
        if curMoney >= price then
            takeMoney(client, price);
            giveWeapon(client, 7, 1, true);
            triggerClientEvent(client, "pop", client, "Compraste una caña de pescar.\nEncuentra un lugar y empieza a pescar!", "green", .2);
        else
            triggerClientEvent(client, "pop", client, "No tienes suficiente dinero.", "orange");
        end
    end
);