
function serverTeleport(city,money)
	if city == 1 then
		setElementPosition(client, 1731.02, -2241.2, 13.54)
	elseif city == 2 then
		setElementPosition(client, -1413.71, -299.69, 14.59)
	elseif city == 3 then
		setElementPosition(client, 1706.7, 1414.86, 10.64)
	end
	takePlayerMoney(client,money)
end
addEvent( "serverTeleport", true ) 
addEventHandler("serverTeleport", root , serverTeleport)