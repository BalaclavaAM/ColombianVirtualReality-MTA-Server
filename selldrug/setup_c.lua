GUIEditor = {
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        sellDrugsWin = guiCreateWindow(527, 250, 339, 322, "Vender Drogas", false)
        guiWindowSetSizable(sellDrugsWin, false)

        wLabel = guiCreateLabel(27, 54, 63, 17, "Bareta:", false, sellDrugsWin)
        GUIEditor.label[1] = guiCreateLabel(92, 26, 74, 18, "Cantidad", false, sellDrugsWin)
        GUIEditor.label[2] = guiCreateLabel(198, 26, 80, 16, "Precio/unidad", false, sellDrugsWin)
        bQty = guiCreateEdit(90, 54, 72, 17, "0", false, sellDrugsWin)
        bPrice = guiCreateEdit(196, 54, 72, 17, "0", false, sellDrugsWin)
        GUIEditor.label[3] = guiCreateLabel(27, 86, 63, 17, "Popper:", false, sellDrugsWin)
        popperQty = guiCreateEdit(90, 86, 72, 17, "0", false, sellDrugsWin)
        popperPrice = guiCreateEdit(196, 86, 72, 17, "0", false, sellDrugsWin)
        GUIEditor.label[4] = guiCreateLabel(27, 118, 63, 17, "Perica:", false, sellDrugsWin)
        pericaQty = guiCreateEdit(90, 118, 72, 17, "0", false, sellDrugsWin)
        pericaPrice = guiCreateEdit(196, 118, 72, 17, "0", false, sellDrugsWin)
        GUIEditor.label[5] = guiCreateLabel(27, 149, 63, 17, "LSD:", false, sellDrugsWin)
        lsdQty = guiCreateEdit(90, 149, 72, 17, "0", false, sellDrugsWin)
        lsdPrice = guiCreateEdit(196, 149, 72, 17, "0", false, sellDrugsWin)
        GUIEditor.label[6] = guiCreateLabel(27, 181, 63, 17, "Bazuko:", false, sellDrugsWin)
        GUIEditor.label[7] = guiCreateLabel(27, 213, 63, 17, "Heroina:", false, sellDrugsWin)
        bazukoQty = guiCreateEdit(90, 181, 72, 17, "0", false, sellDrugsWin)
        heroinaQty = guiCreateEdit(90, 213, 72, 17, "0", false, sellDrugsWin)
        heroinaPrice = guiCreateEdit(196, 213, 72, 17, "0", false, sellDrugsWin)
        bazukoPrice = guiCreateEdit(196, 181, 72, 17, "0", false, sellDrugsWin)
        sellBtn = guiCreateButton(39, 264, 123, 32, "Vender", false, sellDrugsWin)
        cancelBtn = guiCreateButton(196, 264, 123, 32, "Cerrar", false, sellDrugsWin)    
		guiSetVisible(sellDrugsWin, false)
		addEventHandler ( "onClientGUIClick", cancelBtn, closeWindow, false )
		addEventHandler ( "onClientGUIClick", sellBtn, startSell, false )
    end
)
function startSell()
	dbaretaPrice = tonumber(guiGetText(bPrice))
	dpopperPrice = tonumber(guiGetText(popperPrice))
	dpericaPrice = tonumber(guiGetText(pericaPrice))
	dlsdPrice = tonumber(guiGetText(lsdPrice))
	dbazukoPrice = tonumber(guiGetText(bazukoPrice))
	dheroinaPrice = tonumber(guiGetText(heroinaPrice))
	
	dbaretaQty = tonumber(guiGetText(bQty))
	dpopperQty = tonumber(guiGetText(popperQty))
	dpericaQty = tonumber(guiGetText(pericaQty))
	dlsdQty = tonumber(guiGetText(lsdQty))
	dbazukoQty = tonumber(guiGetText(bazukoQty))
	dheroinaQty = tonumber(guiGetText(heroinaQty))

	if type(dbaretaPrice) =="number" and type(dpopperPrice) =="number" and type(dpericaPrice) =="number" and type(dlsdPrice) =="number" and type(dbazukoPrice) =="number" and 
		type(dheroinaPrice) =="number" and type(dbaretaQty) =="number" and type(dpopperQty) =="number" and type(dpericaQty) =="number" and type(dlsdQty) =="number" and 
		type(dbazukoQty) =="number" and type(dheroinaQty) =="number" then
		
		if dbaretaPrice < 0 or dpopperPrice < 0 or dpericaPrice < 0 or dlsdPrice < 0 or dbazukoPrice < 0 or dheroinaPrice < 0 or
		dbaretaQty < 0  or dpopperQty < 0 or dpericaQty < 0 or dlsdQty < 0 or dbazukoQty < 0 or dheroinaQty < 0 then
			return outputChatBox("Ingrese solo numeros positivos")
		else
			if getElementData(getLocalPlayer(),"Weed") >= dbaretaQty and getElementData(getLocalPlayer(),"God") >= dpopperQty and 
				getElementData(getLocalPlayer(),"Speed") >= dpericaQty and getElementData(getLocalPlayer(),"Lsd") >= dlsdQty and 
				getElementData(getLocalPlayer(),"Steroids") >= dbazukoQty and getElementData(getLocalPlayer(),"Heroin") >= dheroinaQty then
				
				setElementData(getLocalPlayer(), "bPrice",dbaretaPrice)
				setElementData(getLocalPlayer(), "popperPrice",dpopperPrice)
				setElementData(getLocalPlayer(), "pericaPrice",dpericaPrice)
				setElementData(getLocalPlayer(), "lsdPrice",dlsdPrice)
				setElementData(getLocalPlayer(), "bazukoPrice",dbazukoPrice)
				setElementData(getLocalPlayer(), "heroinaPrice",dheroinaPrice)
				
				setElementData(getLocalPlayer(), "bQty",dbaretaQty)
				setElementData(getLocalPlayer(), "popperQty",dpopperQty)
				setElementData(getLocalPlayer(), "pericaQty",dpericaQty)
				setElementData(getLocalPlayer(), "lsdQty",dlsdQty)
				setElementData(getLocalPlayer(), "bazukoQty",dbazukoQty)
				setElementData(getLocalPlayer(), "heroinaQty",dheroinaQty)
				
				setElementData(getLocalPlayer(),"sellingDrugs", true)
				guiSetVisible(sellDrugsWin,false) 
				triggerServerEvent("startSellingDrugs",getLocalPlayer())
			else
				return outputChatBox("No posees alguna cantidad de droga, revisa")
			end
		end
	else
		return outputChatBox("Ingrese solo numeros")
	end

end

function stopSell()
	showCursor(false)
	setElementData(getLocalPlayer(),"sellingDrugs", false)
	triggerServerEvent("stopSellingDrugs",getLocalPlayer())
end
addCommandHandler("pararventa", stopSell ) 

function venderDroga( localPlayer ) 
	if guiGetVisible(sellDrugsWin) == false then
		guiSetVisible ( sellDrugsWin, true) 
		showCursor ( true ) 
	end
end 
addCommandHandler("venderdroga", venderDroga ) 

function closeWindow(localPlayer)
	guiSetVisible(sellDrugsWin, false)
	showCursor(false)
end