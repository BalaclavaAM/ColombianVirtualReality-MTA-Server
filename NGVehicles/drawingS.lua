function showVeloServer(player, state) 
    triggerClientEvent(player, "hide:VELOCIMETRO", player, state) 
end 
addEvent("hide:VELOCIMETRO", true)
addEventHandler("hide:VELOCIMETRO", getRootElement(), showVeloServer)





addEventHandler("onResourceStart", resourceRoot,
function(res)
	setTimer(function()
	if (getResourceName(res) == (getResourceName(getThisResource()))) then
		triggerClientEvent(root, "hide:VELOCIMETRO", root, true) 
	end
	end,2000,1)
end)