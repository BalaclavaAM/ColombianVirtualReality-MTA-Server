function importTextures2()
	txd = engineLoadTXD ( "files/spoilers.txd" )
	engineImportTXD ( txd, 1147 )
	engineImportTXD ( txd, 1146 )
	dff = engineLoadDFF ( "files/spoiler_1.dff" )
	dff1 = engineLoadDFF ( "files/spoiler_2.dff" )
	engineReplaceModel ( dff, 1147 )
	engineReplaceModel ( dff1, 1146 )
	engineSetModelLODDistance(1147, 2000)
	engineSetModelLODDistance(1146, 2000)
end

setTimer ( importTextures2, 1000, 1)
addCommandHandler("spoilers",importTextures2)
addCommandHandler("alerones",importTextures2)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreModel(1147)
		engineRestoreModel(1146)
		destroyElement(dff)
		destroyElement(dff1)
	end
)