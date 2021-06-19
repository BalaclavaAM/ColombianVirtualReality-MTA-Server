function nikko()
	txd = engineLoadTXD ( "tougeteam.txd" )
		engineImportTXD ( txd, 2281 )
	col = engineLoadCOL ( "tougeteam.col" )
	dff = engineLoadDFF ( "tougeteam.dff", 0 )
	engineReplaceCOL ( col, 2281 )
	engineReplaceModel ( dff, 2281 )
	engineSetModelLODDistance(2281, 2000)

end

setTimer ( nikko, 1000, 1)
addCommandHandler("reloadmap",nikko)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(2281)
		engineRestoreModel(2281)
		destroyElement(dff)
		destroyElement(col)
		destroyElement(txd)
	end
)