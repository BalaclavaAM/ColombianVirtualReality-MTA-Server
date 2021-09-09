function akina()
	txd = engineLoadTXD ( "ebisuw.txd" )
		engineImportTXD ( txd, 1942 )
		engineImportTXD ( txd, 1943 )
		engineImportTXD ( txd, 1944 )
engineImportTXD ( txd, 1945)
		

	col = engineLoadCOL ( "ebisu_w.col" )
	col1 = engineLoadCOL ( "ebisu_w2.col" )
	col2 = engineLoadCOL ( "ebisu_w3.col" )
     col3 = engineLoadCOL ( "ebisu_w4.col" )


	dff = engineLoadDFF ( "ebisuw1.dff", 0 )
	dff1 = engineLoadDFF ( "ebisuw2.dff", 0 )
	dff2 = engineLoadDFF ( "ebisuw3.dff", 0 )
dff3 = engineLoadDFF ( "ebisuw4.dff", 0 )

	
     engineReplaceCOL ( col, 1942  )
	engineReplaceCOL ( col1, 1943 )
	engineReplaceCOL ( col2, 1944 )
	engineReplaceCOL ( col3, 1945)
	

	engineReplaceModel ( dff, 1942 )
	engineReplaceModel ( dff1, 1943 )
	engineReplaceModel ( dff2, 1944 )
	engineReplaceModel ( dff3, 1945 )
	

	engineSetModelLODDistance(1942 , 2000)
	engineSetModelLODDistance(1943, 2000)
	engineSetModelLODDistance(1944, 2000)
engineSetModelLODDistance(1945, 2000)
	

end


setTimer ( akina, 1000, 1)
addCommandHandler("reloadmap",akina)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(1942)
		engineRestoreCOL(1943)
		engineRestoreCOL(1944)
engineRestoreCOL(1945)
		
	
	
		engineRestoreModel(1942)
		engineRestoreModel(1943)
		engineRestoreModel(1944)
	      engineRestoreModel(1945)

		
		destroyElement(dff)
		destroyElement(dff1)
		destroyElement(dff2)
destroyElement(dff3)
		
	
		destroyElement(col)
		destroyElement(col1)
		destroyElement(col2)
destroyElement(col3)

		
		destroyElement(txd)
	end
)