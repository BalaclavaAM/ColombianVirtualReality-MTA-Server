addEventHandler ("onClientResourceStart", getResourceRootElement(getThisResource()),
	function()
		txd = engineLoadTXD ("texturas/lod2_sfe.txd")
		engineImportTXD (txd, 9936)
		
		txd2 = engineLoadTXD ("texturas/pointysfe.txd")
		engineImportTXD (txd2, 9900)
		
		txd3 = engineLoadTXD ("texturas/nitelites.txd")
		engineImportTXD (txd3, 9933)

		dff = engineLoadDFF ("texturas/landshit_09_sfe.dff", 9900)
		dff1 = engineLoadDFF ("texturas/loda02.dff", 9936)
		dff2 = engineLoadDFF ("texturas/nitelites_sfe01.dff", 9933)

		col = engineLoadCOL("texturas/landshit_09_sfe.col")
		col2 = engineLoadCOL("texturas/loda02.col")

		engineReplaceModel (dff, 9900)
		engineReplaceModel (dff1, 9936)
		engineReplaceModel (dff2, 9933)

		engineReplaceCOL(col,9900)
		engineReplaceCOL(col2,9936)
	end
);

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()

		engineRestoreModel(9900)
		engineRestoreModel(9936)
		engineRestoreModel(9933)

		destroyElement(dff)
		destroyElement(dff1)
		destroyElement(dff2)


		destroyElement(txd)
		destroyElement(txd2)
		destroyElement(txd3)
	end
);