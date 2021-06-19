

mapas={
    ["Oficina"]={{{299.1181640625, 174.505859375, 1007.171875, 87.548645019531, 3},{239.1328125, 141.9453125, 1003.0234375, 0.77731323242188, 3}}},
    --["Caligula"]={{{2265.4538574219,1619.7229003906,1090.4453125, 265.46618652344, 1},{2266.552734375,1675.8331298828,1090.4453125,270, 1}}},
    ["Comisaria"]={{{219.54, 69.31, 1005.04, 270, 6},{264.21780395508,82.160087585449,1001.0390625,270, 6}}}

}

s_WeaponIDs = {[31]=1000,[28]=1000,[24]=1000,[26]=1000}
s_MaxRounds = 3



-- EDIT EVERYTHING ABOVE THIS IF YOU WANT
-- DONT EDIT ANYTHING ELSE BELOW UNLESS YOU KNOW WHAT YOU ARE DOING

s_duelSpawns = {
    -- x, y, z, rotation, interior
    {299.1181640625, 174.505859375, 1007.171875, 87.548645019531, 3}, -- spawn 1
    {239.1328125, 141.9453125, 1003.0234375, 0.77731323242188, 3}, -- spawn 2
}

function getmapas()
  return mapas
end

function getDuelSpawns(mapa)
    return mapas[mapa][1]
end

function checkDim(dim)
    for i,v in ipairs(getElementsByType("player")) do
        if getElementDimension(v) == dim then
            return false
        end
    end
    return true
end

function getFreeDuelDimension()
    dimension = 1
    noencontrada=true
    while noencontrada do
        if checkDim(dimension) then
            noencontrada=false
        else
            dimension=dimension+1
        end
    end
    return dimension
end

function getDuelWeapons()
    return s_WeaponIDs or {}
end

function getMaxDuelRounds()
    local max = tonumber(s_MaxRounds) or 3
    return max
end