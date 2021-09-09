function AddPlayerMoney(thePlayer, count, victory)
	if(count < 0) then 
		if(getPlayerMoney(thePlayer)+count < 0) then
			local c = count+getPlayerMoney(thePlayer)
			outputChatBox("Necesitas para apostar $"..c-c-c, thePlayer)
			cancelEvent()
			return false
		end
	end
	
	givePlayerMoney(thePlayer, count)
	if(victory) then
		outputChatBox("Ganaste $"..count, thePlayer)
	end
	return true
end
addEvent("AddPlayerMoney", true)
addEventHandler("AddPlayerMoney", root, AddPlayerMoney)