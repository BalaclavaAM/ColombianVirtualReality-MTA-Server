-- #s_WeaponIDs = {[weapon ID]=ammo} // EXAMPLE
-- #s_MaxRounds = 5 // EXAMPLE

s_WeaponIDs = {[31]=1000,[28]=1000}
s_MaxRounds = 5



-- EDIT EVERYTHING ABOVE THIS IF YOU WANT
-- DONT EDIT ANYTHING ELSE BELOW UNLESS YOU KNOW WHAT YOU ARE DOING

s_raceSpawns = {
    -- x, y, z, rotation, interior
    {1995.13, 1763.59, 10.19, 90, 0}, -- spawn 1
    {1993.27, 1769.31, 10.19, 90, 0}, -- spawn 2
}


function getRaceSpawns()
    return s_raceSpawns
end

function getFreeDuelDimension()
    count = 1
    for i,v in pairs(getElementsByType('player')) do
        if getElementInterior(v) == 3 then
            if getElementDimension(v) == count then
                count = count+1
            end
        end
    end
    return count
end

function getDuelWeapons()
    return s_WeaponIDs or {}
end

function getMaxDuelRounds()
    local max = tonumber(s_MaxRounds) or 5
    return max
end