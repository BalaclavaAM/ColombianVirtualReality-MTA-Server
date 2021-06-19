--SparroW MTA : https://sparrow-mta.blogspot.com/
--Facebook : https://www.facebook.com/sparrowgta/
--İnstagram : https://www.instagram.com/sparrowmta/
--Discord : https://discord.gg/DzgEcvy

addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('object.txd',true)
engineImportTXD(txd, 903)
local dff = engineLoadDFF('object.dff', 0)
engineReplaceModel(dff, 903)
local col = engineLoadCOL('object.col')
engineReplaceCOL(col, 903)
engineSetModelLODDistance(903, 413)
end)