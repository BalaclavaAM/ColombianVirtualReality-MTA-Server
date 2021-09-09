function map()
	txd = engineLoadTXD ( "drift.txd" )
		engineImportTXD ( txd, 2267 )
		engineImportTXD ( txd, 2266 )
	col = engineLoadCOL ( "drift1.col" )
	col1 = engineLoadCOL ( "drift2.col" )
	dff = engineLoadDFF ( "drift1.dff", 0 )
	dff1 = engineLoadDFF ( "drift2.dff", 0 )
	engineReplaceCOL ( col, 2267 )
	engineReplaceCOL ( col1, 2266 )
	engineReplaceModel ( dff, 2267 )
	engineReplaceModel ( dff1, 2266 )
	engineSetModelLODDistance(2267, 20000)
	engineSetModelLODDistance(2266, 20000)
end


setTimer ( map, 1000, 1)
addCommandHandler("reloadmap",map)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(2267)
		engineRestoreCOL(2266)
		engineRestoreModel(2267)
		engineRestoreModel(2266)
		destroyElement(dff)
		destroyElement(dff1)
		destroyElement(col)
		destroyElement(col1)
		destroyElement(txd)
	end
)