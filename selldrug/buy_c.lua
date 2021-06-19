
GUIEditor = {
    label = {},
    memo = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
	buyWin = guiCreateWindow(567, 316, 248, 314, "Comprar Drogas", false)
	guiWindowSetSizable(buyWin, false)
	baretaLabel = guiCreateLabel(24, 36, 63, 15, "Bareta (0)$", false, buyWin)
	popperLabel = guiCreateLabel(24, 65, 77, 16, "Popper (0)$", false, buyWin)
	pericaLabel = guiCreateLabel(24, 95, 63, 15, "Perica (0)$", false, buyWin)
	lsdLabel = guiCreateLabel(24, 126, 63, 15, "Lsd (0)$", false, buyWin)
	bazukoLabel = guiCreateLabel(24, 159, 69, 15, "Bazuko (0)$", false, buyWin)
	heroinaLabel = guiCreateLabel(24, 191, 75, 15, "Heroina (0)$", false, buyWin)
	baretaEdit = guiCreateEdit(166, 33, 52, 19, "0", false, buyWin)
	popperEdit = guiCreateEdit(166, 62, 52, 19, "0", false, buyWin)
	pericaEdit = guiCreateEdit(166, 91, 52, 19, "0", false, buyWin)
	lsdEdit = guiCreateEdit(166, 127, 52, 19, "0", false, buyWin)
	bazukoEdit = guiCreateEdit(166, 162, 52, 19, "0", false, buyWin)
	heroinaEdit = guiCreateEdit(166, 191, 52, 19, "0", false, buyWin)
	buyBtn = guiCreateButton(27, 246, 82, 27, "Comprar", false, buyWin)
	closeBuyBtn = guiCreateButton(146, 246, 82, 27, "Cerrar", false, buyWin)
	--totalLabel = guiCreateLabel(59, 216, 99, 15, "Total: 0 $", false, buyWin)  
	addEventHandler ( "onClientGUIClick", closeBuyBtn, closeBuyWindow, false )
	addEventHandler ( "onClientGUIClick", buyBtn, buyDrugs, false )
	
	local sellerBPrice = tonumber(getElementData(seller,"bPrice"))
	local sellerPopperPrice = tonumber(getElementData(seller,"popperPrice"))
	local sellerPericaPrice = tonumber(getElementData(seller,"pericaPrice"))
	local sellerLsdPrice = tonumber(getElementData(seller,"lsdPrice"))
	local sellerBazukoPrice = tonumber(getElementData(seller,"bazukoPrice"))
	local sellerHeroinaPrice = tonumber(getElementData(seller,"heroinaPrice"))
    end
)

function buyDrugs()
baretaEdit = tonumber(guiGetText(baretaEdit)) 
popperEdit = tonumber(guiGetText(popperEdit))  
pericaEdit = tonumber(guiGetText(pericaEdit))
lsdEdit = tonumber(guiGetText(lsdEdit)) 
bazukoEdit = tonumber(guiGetText(bazukoEdit))
heroinaEdit = tonumber(guiGetText(heroinaEdit))

	if type(baretaEdit) =="number" and type(baretaEdit) =="number" and type(baretaEdit) =="number" and type(baretaEdit) =="number" and type(baretaEdit) =="number" and 
		type(baretaEdit) =="number" then
		if baretaEdit < 0 or popperEdit < 0 or pericaEdit < 0 or lsdEdit < 0 or bazukoEdit < 0 or heroinaEdit < 0 then
			return outputChatbox("Ingrese solo numeros positivos")
		else
			setElementData(getLocalPlayer(),"baretaBuyQty", baretaEdit)
			setElementData(getLocalPlayer(),"popperBuyQty", popperEdit)
			setElementData(getLocalPlayer(),"pericaBuyQty", pericaEdit)
			setElementData(getLocalPlayer(),"lsdBuyQty", lsdEdit)
			setElementData(getLocalPlayer(),"bazukoBuyQty", bazukoEdit)
			setElementData(getLocalPlayer(),"heroinaBuyQty", heroinaEdit)
			guiSetVisible(buyWin,false)
			showCursor(false)
			triggerServerEvent("sBuyDrugs",getLocalPlayer())
			
		end
	else
		return outputChatBox("Ingrese solo numeros")
	end

end

function closeBuyWindow()
	if guiGetVisible(buyWin) then
		guiSetVisible(buyWin,false)
		showCursor(false)
	end
end

function clientOpenBuyWin(seller)

	buyWin = guiCreateWindow(567, 316, 226, 289, "Comprar Drogas", false)
	guiWindowSetSizable(buyWin, false)
	baretaLabel = guiCreateLabel(24, 36, 63, 15, "Bareta (0)$", false, buyWin)
	popperLabel = guiCreateLabel(24, 65, 77, 16, "Popper (0)$", false, buyWin)
	pericaLabel = guiCreateLabel(24, 95, 63, 15, "Perica (0)$", false, buyWin)
	lsdLabel = guiCreateLabel(24, 126, 63, 15, "Lsd (0)$", false, buyWin)
	bazukoLabel = guiCreateLabel(24, 159, 69, 15, "Bazuko (0)$", false, buyWin)
	heroinaLabel = guiCreateLabel(24, 191, 75, 15, "Heroina (0)$", false, buyWin)
	baretaEdit = guiCreateEdit(120, 36, 52, 19, "0", false, buyWin)
	popperEdit = guiCreateEdit(120, 62, 52, 19, "0", false, buyWin)
	pericaEdit = guiCreateEdit(120, 91, 52, 19, "0", false, buyWin)
	lsdEdit = guiCreateEdit(120, 122, 52, 19, "0", false, buyWin)
	bazukoEdit = guiCreateEdit(120, 155, 52, 19, "0", false, buyWin)
	heroinaEdit = guiCreateEdit(120, 187, 52, 19, "0", false, buyWin)
	buyBtn = guiCreateButton(21, 246, 82, 27, "Comprar", false, buyWin)
	closeBuyBtn = guiCreateButton(120, 246, 82, 27, "Cerrar", false, buyWin)
	totalLabel = guiCreateLabel(59, 216, 99, 15, "Total: 0 $", false, buyWin)  
	addEventHandler ( "onClientGUIClick", closeBuyBtn, closeBuyWindow, false )
	addEventHandler ( "onClientGUIClick", buyBtn, buyDrugs, false )
	
	local sellerBPrice = tonumber(getElementData(seller,"bPrice"))
	local sellerPopperPrice = tonumber(getElementData(seller,"popperPrice"))
	local sellerPericaPrice = tonumber(getElementData(seller,"pericaPrice"))
	local sellerLsdPrice = tonumber(getElementData(seller,"lsdPrice"))
	local sellerBazukoPrice = tonumber(getElementData(seller,"bazukoPrice"))
	local sellerHeroinaPrice = tonumber(getElementData(seller,"heroinaPrice"))
	guiSetVisible(buyWin, true)
	showCursor(true)
	guiSetText(baretaLabel, "Bareta ("..tostring(sellerBPrice)..")$")
	guiSetText(popperLabel, "Popper ("..tostring(sellerPopperPrice)..")$")
	guiSetText(pericaLabel, "Perica ("..tostring(sellerPericaPrice)..")$")
	guiSetText(lsdLabel, "Lsd ("..tostring(sellerLsdPrice)..")$")
	guiSetText(bazukoLabel, "Bazuko ("..tostring(sellerBazukoPrice)..")$")
	guiSetText(heroinaLabel, "Heroina ("..tostring(sellerHeroinaPrice)..")$")
	setElementData(localPlayer,"seller",seller)
end
addEvent( "onServerMarkerHit", true )
addEventHandler( "onServerMarkerHit", localPlayer, clientOpenBuyWin )

