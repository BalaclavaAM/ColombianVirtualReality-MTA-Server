FISHING_KEY = "x"; -- which key we want to use for fishing | balık tutmak için kullanılacak tuş
FISHING_KEY_2 = "mouse1"; -- second key for fishing (left mouse button) | 2. alternatif (sol mouse tık)
INVENTORY_KEY = "-"; -- which key we want to use for our inventory | envanteri açmak için kullanılacak tuş
minigame_enabled = true; -- require a minigame for catching fish. this can be turned off. | balık tutmak için minigame oynamamızı sağlar. false yaparak kapatabilirsiniz.
BACKGROUND_COLOR = tocolor(0, 188, 255, 165); -- inventory color | envanter rengi

minWait, maxWait = 10, 20; -- how much you need to wait before fish bites. | balık oltaya gelmeden önceki bekleme süresi
if minigame_enabled then
    minWait, maxWait = 9, 16; -- if minigame is enabled, lower the wait | minigame aktif ise bekleme süresi azalır.
end



-------------------------------------------- FISH DATA -------------------------------------------------------------------------

-- note: changing ["name"] will mess up the save data. if you want to change the fish name, just add or change ["display_name"].
-- in our save data, ["name"] is the important key.
fish = {
    { -- example format
        name = "Pez Normal",--1
        icon = "freshwaterfish.png", -- img/... is added automatically
        --display_name = "Fresh Water Fish", -- example
        price = 2500,-- price value of every pound.
        weight = 0.9, -- we use a value between 0.6 and 1.2 to get a good weight value. the value between .6 and 1.2 also affects price.
        weight_gap = {.6, 1.1}, -- this is the default value if this variable is not in the table, but we can change it.
        depth = 0, -- scrapped feature- used to spawn fish at a certain depth in the sea.
        common = 940, -- how common is our fish? higher this is, more we'll get of this fish. 1 is minimum.
        exp = 8; -- how much exp you gain for catching this one | disabled in this script. it was used for Forseti RPG.
    },

    {
        name = "Pescao Amazónico",--2
        icon = "tropicalfish.png",
        price = 2700,
        weight = 0.9,
        weight_gap = {.6, 1.2},
        depth = 0, 
        common = 80,
        exp = 12;
    },

    {
        name = "Pescao Popper",--3
        icon = "popperfish.png",
        price = 2900,
        weight = 0.9,
        weight_gap = {.6, 1.2},
        depth = 0, 
        common = 50,
        exp = 12;
    },

    { 
    name = "Pescao Pierrot",--4
        icon = "pierrot.png",
        price = 3000,
        weight = 0.9,
        weight_gap = {.6, 1.3},
        depth = 0, 
        common = 40,
        exp = 17;
    },

    { 
        name = "Medusa",--5
        icon = "jellyfish.png", 
        price = 3200,
        weight = 0.9,
        weight_gap = {.6, 1.2}, 
        common = 30,
        exp = 8;
    },
    
    {
        name = "Langosta",--6
        icon = "wobster.png",
        price = 3500,
        weight = 0.9,
        weight_gap = {.6, 1.2},
        depth = 0, 
        common = 25,
        exp = 22;
    },

    {
        name = "Cangrejo",--7
        icon = "crab.png", 
        price = 4000,
        weight = 0.9, 
        weight_gap = {.6, 1.2}, 
        depth = 0, 
        common = 20,
        exp = 15;
    },

    { 
        name = "Angüila",--8
        icon = "mudfish.png",
        price = 4200,
        weight = 0.9, 
        weight_gap = {.6, 1.3},
        depth = 0, 
        common = 20,
        exp = 18;
    },

    {
        name = "Pez Gato",--9
        icon = "catfish.png", 
        price = 4500,
        weight = 0.9, 
        weight_gap = {.6, 1.2}, 
        depth = 0, 
        common = 15,
        exp = 35;
    },

    {
        name = "Pterois",--10
        icon = "lionfish.png",
        price = 5000,
        weight = 0.8,
        weight_gap = {.6, 1},
        depth = 0, 
        common = 10,
        exp = 20;
    },

    {
        name = "Pescao Inflable",--11
        icon = "bloomfish.png", 
        price = 10000,
        weight = 0.8, 
        weight_gap = {0.6, 1}, 
        depth = 0, 
        common = 6,
        exp = 40;
    },

    {
        name = "Pescao Arcoíris",--12
        icon = "rainbowjelly.png", 
        price = 20000,
        weight = 0.8, 
        weight_gap = {.6, 1}, 
        depth = 0, 
        common = 3,
        exp = 100;
    },
    
    {
        name = "Perla",--13
        icon = "mussel.png", 
        price = 1000000,
        weight = 0.8, 
        weight_gap = {.6, 1}, 
        depth = 0, 
        common = 1,
        exp = 250;
    },

    
}

-- just for testing. give us an output so we can see the price ratios for fish.
if localPlayer then
    local usable = true;
    if not usable then return end;

    addCommandHandler("fishrates",
        function()
            if getElementData(localPlayer,"Job")~="Fisherman" then return outputChatBox("Tienes que ser pescador para usar este comando.") end
            -- gives you some fish data to help re-balance it.
            local used = {}; -- removes duplicates
            
            local a = 0; -- total count
            local fishies = {}; -- this is what we need.
            for i, f in ipairs (fish) do a = a + 1 end; -- define how many fish there are in total

            for i, f in ipairs (fish) do
                if not used[f.name] then
                    -- make an entry for this one.
                    local cur = {
                        ["Adı"] = (f.display_name or f.name);
                        ["Minimum Ağırlık"] = (f.weight * f.weight_gap[1]);
                        ["Maximum Ağırlık"] = (f.weight * f.weight_gap[2]);
                        ["Minimum Değer"] = (f.weight * f.weight_gap[1]) * f.price;
                        ["Maximum Değer"] = (f.weight * f.weight_gap[2]) * f.price;
                        ["Çıkma Oranı"] = (f.common .. "/" .. a);
                        --percent = (a*(f.common/a));
                    };
                    used[f.name] = true;
                    table.insert( fishies, cur );
                end
            end
            outputChatBox("Los costos de venta fueron copiados al portapapeles.", 0, 255, 0);
            setClipboard( tostring(inspect(fishies)) );
        end
    )
end