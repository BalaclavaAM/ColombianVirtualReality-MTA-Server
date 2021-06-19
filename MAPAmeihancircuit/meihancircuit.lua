function meihancircuit()
	txd = engineLoadTXD ( "meihancircuit.txd" )
		engineImportTXD ( txd, 2282 )
	col = engineLoadCOL ( "meihancircuit.col" )
	dff = engineLoadDFF ( "meihancircuit.dff", 0 )
	engineReplaceCOL ( col, 2282 )
	engineReplaceModel ( dff, 2282 )
	engineSetModelLODDistance(2282, 2000)

end

setTimer ( meihancircuit, 1000, 1)
addCommandHandler("reloadmap",meihancircuit)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(2282)
		engineRestoreModel(2282)
		destroyElement(dff)
		destroyElement(col)
		destroyElement(txd)
	end
)