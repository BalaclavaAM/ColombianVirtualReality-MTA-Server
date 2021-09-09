local carsVinil={}
function setCarColorVinil(vehicle, vinilo, r,g,b, ...)
	carsVinil[vehicle]=selected
	setVehiclePaintjob(vehicle,1)
	setVehicleColor(vehicle, r,g,b, ...)
	for k,v in ipairs(getElementsByType("player")) do
		triggerClientEvent(v,"CVRVinilos:aplicarViniloStreamed",v,vehicle)
	end
end
addEvent("setCarColorVinil", true)
addEventHandler("setCarColorVinil", root, setCarColorVinil)