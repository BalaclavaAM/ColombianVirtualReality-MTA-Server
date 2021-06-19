function replaceModel()
txd_pl = engineLoadTXD ( "pl.txd" )
engineImportTXD ( txd_pl, 1866 )

col_pl = engineLoadCOL ( "pl.col" )
engineReplaceCOL ( col_pl, 1866 )

dff_pl = engineLoadDFF ( "pl.dff", 0 )
engineReplaceModel ( dff_pl, 1866 )

engineSetModelLODDistance(1866, 500)


end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
addCommandHandler ("recarregar", replaceModel )