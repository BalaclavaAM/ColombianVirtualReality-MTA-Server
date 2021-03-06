function map()
	txd = engineLoadTXD ( "okaru.txd" )
		engineImportTXD ( txd, 2272 )
		engineImportTXD ( txd, 2271 )
		engineImportTXD ( txd, 2270 )
		engineImportTXD ( txd, 2269 )
		engineImportTXD ( txd, 2268 )
	col = engineLoadCOL ( "okaru.col" )
	col1 = engineLoadCOL ( "okaru1.col" )
	col2 = engineLoadCOL ( "okaru2.col" )
	col3 = engineLoadCOL ( "okaru3.col" )
	col4 = engineLoadCOL ( "okaru4.col" )
	dff = engineLoadDFF ( "okaru.dff", 0 )
	dff1 = engineLoadDFF ( "okaru1.dff", 0 )
	dff2 = engineLoadDFF ( "okaru2.dff", 0 )
	dff3 = engineLoadDFF ( "okaru3.dff", 0 )
	dff4 = engineLoadDFF ( "okaru4.dff", 0 )
	engineReplaceCOL ( col, 2272 )
	engineReplaceCOL ( col1, 2271 )
	engineReplaceCOL ( col2, 2270 )
	engineReplaceCOL ( col3, 2269 )
	engineReplaceCOL ( col4, 2268 )
	engineReplaceModel ( dff, 2272 )
	engineReplaceModel ( dff1, 2271 )
	engineReplaceModel ( dff2, 2270 )
	engineReplaceModel ( dff3, 2269 )
	engineReplaceModel ( dff4, 2268 )
	engineSetModelLODDistance(2272, 2000)
	engineSetModelLODDistance(2271, 2000)
	engineSetModelLODDistance(2270, 2000)
	engineSetModelLODDistance(2269, 2000)
	engineSetModelLODDistance(2268, 2000)
end

setTimer ( map, 1000, 1)
addCommandHandler("reloadmap",map)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(2272)
		engineRestoreCOL(2271)
		engineRestoreCOL(2270)
		engineRestoreCOL(2269)
		engineRestoreCOL(2268)
		engineRestoreModel(2272)
		engineRestoreModel(2271)
		engineRestoreModel(2270)
		engineRestoreModel(2269)
		engineRestoreModel(2268)
		destroyElement(dff)
		destroyElement(dff1)
		destroyElement(dff2)
		destroyElement(dff3)
		destroyElement(dff4)
		destroyElement(col)
		destroyElement(col1)
		destroyElement(col2)
		destroyElement(col3)
		destroyElement(col4)
		destroyElement(txd)
	end
)