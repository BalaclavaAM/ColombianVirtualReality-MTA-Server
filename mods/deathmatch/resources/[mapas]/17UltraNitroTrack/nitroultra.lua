function map()
	txd = engineLoadTXD ( "nitroultra.txd" )
		engineImportTXD ( txd, 1515 )
		engineImportTXD ( txd, 1830 )
	col = engineLoadCOL ( "nitroultra1.col" )
	col1 = engineLoadCOL ( "nitroultra2.col" )
	dff = engineLoadDFF ( "nitroultra1.dff", 0 )
	dff1 = engineLoadDFF ( "nitroultra2.dff", 0 )
	engineReplaceCOL ( col, 1515 )
	engineReplaceCOL ( col1, 1830 )
	engineReplaceModel ( dff, 1515 )
	engineReplaceModel ( dff1, 1830 )
	engineSetModelLODDistance(1515, 2000)
	engineSetModelLODDistance(1830, 2000)

end

function chat()
		outputChatBox('TougeEbisuSoutch', player, 0, 255, 0)
end

setTimer ( map, 1000, 1)
addCommandHandler("reloadmap",map)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(1515)
		engineRestoreCOL(1830)
		engineRestoreModel(1515)
		engineRestoreModel(1830)
		destroyElement(dff)
		destroyElement(dff1)
		destroyElement(col)
		destroyElement(col1)
		destroyElement(txd)
	end
)