-- #s_WeaponIDs = {[weapon ID]=ammo} // EXAMPLE
-- #s_MaxRounds = 5 // EXAMPLE

s_WeaponIDs = {[31]=1000,[28]=1000}
s_MaxRounds = 5



-- EDIT EVERYTHING ABOVE THIS IF YOU WANT
-- DONT EDIT ANYTHING ELSE BELOW UNLESS YOU KNOW WHAT YOU ARE DOING

s_raceSpawns = {
    ['bigear']={
        {-298.98, 1514.31, 74.9, 180, 0},
        {-305.72, 1514.11, 74.88, 180, 0}},
    ['tsan']={
        {2143.0944824219, -2870.0454101562, 1003.6375732422, 0, 0}, 
        {2147.5046386719, -2869.802734375, 1003.6416015625, 0, 0}}
    }


function getRaceSpawns(race)
    return s_raceSpawns[race]
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