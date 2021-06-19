function setDrugAmmount(drugType,qnty)
	if getElementData(client,drugType) >= qnty then
		setElementData(client, drugType, getElementData(client,drugType)-qnty)
		setAccountData(getPlayerAccount(client),drugType,getElementData(client,drugType))
		outputChatBox("#ff0000Vicioso:#f7f9f9La buena pa, que viva el vicio, abrase que llegan los tombos.",client,0,0,0,true)
		triggerClientEvent(client,"onDealSucessfull",client,client)
	else
		outputChatBox("#ff0000Vicioso:#f7f9f9Largo de aqui, no tenes nada.",client,0,0,0,true)
	end
end
addEvent( "setDrugAmmount", true ) 
addEventHandler("setDrugAmmount", root , setDrugAmmount)