function map()
	txd = engineLoadTXD ( "tougeteam.txd" )
		engineImportTXD ( txd, 2273 )
	col = engineLoadCOL ( "tougeteam.col" )
	dff = engineLoadDFF ( "tougeteam.dff", 0 )
	engineReplaceCOL ( col, 2273 )
	engineReplaceModel ( dff, 2273 )
	engineSetModelLODDistance(2273, 2000)

end

setTimer ( map, 1000, 1)
addCommandHandler("reloadmap",map)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(2273)
		engineRestoreModel(2273)
		destroyElement(dff)
		destroyElement(col)
		destroyElement(txd)
	end
)