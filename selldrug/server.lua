function serverStartSellingDrugs() 
    local x, y, z = getElementPosition ( client) 
	local marker =  createMarker ( x, y, z-1, "cylinder", 1.5, 255, 255, 0, 170 ) 
	setElementData(marker, "owner", client)
	attachElements( client, marker)
	setPedAnimation(client, "dealer", "dealer_idle",-1,true,false,true)
end  
addEvent( "startSellingDrugs", true ) 
addEventHandler("startSellingDrugs", root , serverStartSellingDrugs) 

function serverStopSellingDrugs()
	local attached = getElementAttachedTo ( client )
    if ( attached ) then
		destroyElement(attached)
		setPedAnimation(client)
    end
end
addEvent( "stopSellingDrugs", true ) 
addEventHandler("stopSellingDrugs", root , serverStopSellingDrugs) 

function buyerMarkerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler
    if getElementData(source, "owner") ~= nil and  getElementData(source,"owner") ~= false then
		if getPlayerName(hitElement) ~= getPlayerName( getElementData(source, "owner")) then
			triggerClientEvent ( hitElement, "onServerMarkerHit", hitElement, getElementData(source,"owner") )
		end
	end
    
end
addEventHandler( "onMarkerHit", resourceRoot, buyerMarkerHit )

function serverBuyDrugs()
	local sellerPointer = getElementData(client, "seller")
	if tonumber(getElementData(sellerPointer, "bQty")) >= tonumber(getElementData(client,"baretaBuyQty")) then
		setElementData(sellerPointer,"bQty", tonumber(getElementData(sellerPointer,"bQty"))-tonumber(getElementData(client,"baretaBuyQty")))
		setElementData(client,"Weed",tonumber(getElementData(client,"Weed"))+tonumber(getElementData(client,"baretaBuyQty")))
		setElementData(sellerPointer, "Weed",tonumber(getElementData(sellerPointer,"Weed"))-tonumber(getElementData(client,"baretaBuyQty")))
		givePlayerMoney(sellerPointer, tonumber(getElementData(sellerPointer,"bPrice"))*tonumber(getElementData(client,"baretaBuyQty")))
		setPlayerMoney(client, getPlayerMoney(client) - tonumber(getElementData(sellerPointer,"bPrice"))*tonumber(getElementData(client,"baretaBuyQty")))
		setAccountData(getPlayerAccount(client),"Weed",tonumber(getElementData(client,"Weed")))
		setAccountData(getPlayerAccount(sellerPointer),"Weed",tonumber(getElementData(sellerPointer,"Weed")))

	else
		return outputChatBox("El usuario no posee tal cantidad de bareta",client)
	end
	
	if tonumber(getElementData(sellerPointer, "popperQty")) >= tonumber(getElementData(client,"popperBuyQty")) then
		setElementData(sellerPointer,"popperQty", tonumber(getElementData(sellerPointer,"popperQty"))-tonumber(getElementData(client,"popperBuyQty")))
		setElementData(client,"God",tonumber(getElementData(client,"God"))+tonumber(getElementData(client,"popperBuyQty")))
		setElementData(sellerPointer, "God",tonumber(getElementData(sellerPointer,"God"))-tonumber(getElementData(client,"popperBuyQty")))
		givePlayerMoney(sellerPointer, tonumber(getElementData(sellerPointer,"popperPrice"))*tonumber(getElementData(client,"popperBuyQty")))
		setPlayerMoney(client, getPlayerMoney(client) - tonumber(getElementData(sellerPointer,"popperPrice"))*tonumber(getElementData(client,"popperBuyQty")))
		setAccountData(getPlayerAccount(client),"God",tonumber(getElementData(client,"God")))
		setAccountData(getPlayerAccount(sellerPointer),"God",tonumber(getElementData(sellerPointer,"God")))

	else
		return outputChatBox("El usuario no posee tal cantidad de popper",client)
	end
	
	if tonumber(getElementData(sellerPointer, "pericaQty")) >= tonumber(getElementData(client,"pericaBuyQty")) then
		setElementData(sellerPointer,"pericaQty", tonumber(getElementData(sellerPointer,"pericaQty"))-tonumber(getElementData(client,"pericaBuyQty")))
		setElementData(client,"Speed",tonumber(getElementData(client,"Speed"))+tonumber(getElementData(client,"pericaBuyQty")))
		setElementData(sellerPointer, "Speed",tonumber(getElementData(sellerPointer,"Speed"))-tonumber(getElementData(client,"pericaBuyQty")))
		givePlayerMoney(sellerPointer, tonumber(getElementData(sellerPointer,"pericaPrice"))*tonumber(getElementData(client,"pericaBuyQty")))
		setPlayerMoney(client, getPlayerMoney(client) - tonumber(getElementData(sellerPointer,"pericaPrice"))*tonumber(getElementData(client,"pericaBuyQty")))
		setAccountData(getPlayerAccount(client),"Speed",tonumber(getElementData(client,"Speed")))
		setAccountData(getPlayerAccount(sellerPointer),"Speed",tonumber(getElementData(sellerPointer,"Speed")))

	else
		return outputChatBox("El usuario no posee tal cantidad de perica",client)
	end
	
	if tonumber(getElementData(sellerPointer, "lsdQty")) >= tonumber(getElementData(client,"lsdBuyQty")) then
		setElementData(sellerPointer,"lsdQty", tonumber(getElementData(sellerPointer,"lsdQty"))-tonumber(getElementData(client,"lsdBuyQty")))
		setElementData(client,"Lsd",tonumber(getElementData(client,"Lsd"))+tonumber(getElementData(client,"lsdBuyQty")))
		setElementData(sellerPointer, "Lsd",tonumber(getElementData(sellerPointer,"Lsd"))-tonumber(getElementData(client,"lsdBuyQty")))
		givePlayerMoney(sellerPointer, tonumber(getElementData(sellerPointer,"lsdPrice"))*tonumber(getElementData(client,"lsdBuyQty")))
		setPlayerMoney(client, getPlayerMoney(client) - tonumber(getElementData(sellerPointer,"lsdPrice"))*tonumber(getElementData(client,"lsdBuyQty")))
		setAccountData(getPlayerAccount(client),"Lsd",tonumber(getElementData(client,"Lsd")))
		setAccountData(getPlayerAccount(sellerPointer),"Lsd",tonumber(getElementData(sellerPointer,"Lsd")))

	else
		return outputChatBox("El usuario no posee tal cantidad de LSD",client)
	end
	
	if tonumber(getElementData(sellerPointer, "bazukoQty")) >= tonumber(getElementData(client,"bazukoBuyQty")) then
		setElementData(sellerPointer,"bazukoQty", tonumber(getElementData(sellerPointer,"bazukoQty"))-tonumber(getElementData(client,"bazukoBuyQty")))
		setElementData(client,"Steroids",tonumber(getElementData(client,"Steroids"))+tonumber(getElementData(client,"bazukoBuyQty")))
		setElementData(sellerPointer, "Steroids",tonumber(getElementData(sellerPointer,"Steroids"))-tonumber(getElementData(client,"bazukoBuyQty")))
		givePlayerMoney(sellerPointer, tonumber(getElementData(sellerPointer,"bazukoPrice"))*tonumber(getElementData(client,"bazukoBuyQty")))
		setPlayerMoney(client, getPlayerMoney(client) - tonumber(getElementData(sellerPointer,"bazukoPrice"))*tonumber(getElementData(client,"bazukoBuyQty")))
		setAccountData(getPlayerAccount(client),"Steroids",tonumber(getElementData(client,"Steroids")))
		setAccountData(getPlayerAccount(sellerPointer),"Steroids",tonumber(getElementData(sellerPointer,"Steroids")))

	else
		return outputChatBox("El usuario no posee tal cantidad de bazuko",client)
	end
	
	if tonumber(getElementData(sellerPointer, "heroinaQty")) >= tonumber(getElementData(client,"heroinaBuyQty")) then
		setElementData(sellerPointer,"heroinaQty", tonumber(getElementData(sellerPointer,"heroinaQty"))-tonumber(getElementData(client,"heroinaBuyQty")))
		setElementData(client,"Heroin",tonumber(getElementData(client,"Heroin"))+tonumber(getElementData(client,"heroinaBuyQty")))
		setElementData(sellerPointer, "Heroin",tonumber(getElementData(sellerPointer,"Heroin"))-tonumber(getElementData(client,"heroinaBuyQty")))
		givePlayerMoney(sellerPointer, tonumber(getElementData(sellerPointer,"heroinaPrice"))*tonumber(getElementData(client,"heroinaBuyQty")))
		setPlayerMoney(client, getPlayerMoney(client) - tonumber(getElementData(sellerPointer,"heroinaPrice"))*tonumber(getElementData(client,"heroinaBuyQty")))
		setAccountData(getPlayerAccount(client),"Heroin",tonumber(getElementData(client,"Heroin")))
		setAccountData(getPlayerAccount(sellerPointer),"Heroin",tonumber(getElementData(sellerPointer,"Heroin")))

	else
		return outputChatBox("El usuario no posee tal cantidad de Heroina",client)
	end
end
addEvent( "sBuyDrugs", true ) 
addEventHandler("sBuyDrugs", root , serverBuyDrugs) 