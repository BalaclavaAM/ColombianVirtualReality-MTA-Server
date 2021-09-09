function comma_value( n )
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function sellAllFish ()
    local a, b = getInventoryTotal(); -- total price, total weight

    if a > 0 then
        local y = function()
            triggerServerEvent("fish:sellInventory", localPlayer, inventory, a, b);
            resetInventory ();
        end

        local n = function()

        end

        confirm( "Quieres vender " .. b .. " libra(s) de pescao?\n\nRecompensa: $".. comma_value(a), y, n );
    else
        outputChatBox("No tienes pescaos. Presiona '-' pa abrir tu inventario de pescaos.", 255, 155, 0);
    end
end