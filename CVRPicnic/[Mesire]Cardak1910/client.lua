
-- SparroW MTA :https://sparrow-mta.blogspot.com

-- Discord :  https://discord.gg/DzgEcvy

-- ID 1910


addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('base.txd',true)
engineImportTXD(txd, 1910)
local dff = engineLoadDFF('base.dff', 0)
engineReplaceModel(dff, 1910)
local col = engineLoadCOL('base.col')
engineReplaceCOL(col, 1910)
engineSetModelLODDistance(1910, 301)
end)

-- SparroW MTA :https://sparrow-mta.blogspot.com

-- Discord :  https://discord.gg/DzgEcvy