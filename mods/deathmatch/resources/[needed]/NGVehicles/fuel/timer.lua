local fuelPrice = math.random ( 5, 34 )
exports.NGMessages:sendClientMessage ( "La gasolina ahora está a $"..tostring(fuelPrice*60).." pesares (COP) por galón!", root, 255, 255, 0 )
--setTimer ( triggerClientEvent, 500, 1, root, "NGVehicles:Fuel:OnFuelPriceChange", root, fuelPrice )

addEvent ( "NGVehicles:Fuel:OnClientRequestFuelPrice", true )
addEventHandler ( "NGVehicles:Fuel:OnClientRequestFuelPrice", root, function ( )
	triggerClientEvent ( source, "NGVehicles:Fuel:OnFuelPriceChange", source, fuelPrice )
end )

setTimer ( function ( )
	local _fuelPrice = math.random ( 5, 34 )
	while ( fuelPrice == _fulePrice ) do
		_fuelPrice = math.random ( 5, 34 )
	end
	fuelPrice = _fuelPrice
	exports.NGMessages:sendClientMessage ( "La gasolina ahora está a $"..tostring(fuelPrice*60).." pesares (COP) por galón!", root, 255, 255, 0 )
	triggerClientEvent ( root, "NGVehicles:Fuel:OnFuelPriceChange", root, fuelPrice )
end, 700000, 0 )

local warnings = {
	[20]=true,
	[15]=true,
	[10]=true,
	[7]=true,
	[5]=true,
	[2]=true,
}


setTimer ( function ( ) 
	for i, v in ipairs ( getElementsByType ( 'vehicle' ) ) do 
		local vehicleType=getElementData(v, "vehicle:type")
		local handling = getVehicleHandling(v)
		local fueltank=getVehicleHandling(v)['mass']
		local fuel = getElementData ( v, "fuel" )

		if not fuel then
			setElementData ( v, "fuel", fueltank )
			fuel = fueltank
		end
		local speed = getVehicleSpeed ( v, "kph" )
		if ( fuel >= 1 and speed > 0 and getVehicleOccupant ( v ) ) then
			setElementData ( v, "fuel", (fuel -  handling['mass']*0.01 ))
			local fuel = (fuel - handling['mass']*0.01)
			if ( warnings[fuel] ) then
				exports['NGMessages']:sendClientMessage ( "Peligro. Te estás quedando sin gasolina, está a "..tostring((fuel*100)/fueltank).."%", getVehicleOccupant ( v ), 255, 0, 0 )
			end
		end
		fuel = getElementData(v,"fuel")
		if ( (fuel <= 0 and getVehicleEngineState ( v )) or not(isCarFunctioning(v)) ) then
			setVehicleEngineState ( v, false )
			exports['NGMessages']:sendClientMessage ( "Este vehículo no tiene gasolina o le faltan partes!", 255, 0, 0 )
		elseif ( fuel > 0 and not getVehicleEngineState ( v ) and isCarFunctioning(v) ) then
			setVehicleEngineState ( v, true )
		end
	end
end, 25000, 0 )


function getVehicleSpeed ( tp, md )
	local md = md or "kph"
	local sx, sy, sz = getElementVelocity ( tp )
	local speed = math.ceil( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 )
	local speed1 = math.ceil( ( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 ) / 1.61 )
	if ( md == "kph" ) then
		return speed;
	else
		return speed1;
	end
end


addEvent ( "NGFuel:takeMoney", true )
addEventHandler ( "NGFuel:takeMoney", root, function ( p )
	takePlayerMoney ( source, p )
end )