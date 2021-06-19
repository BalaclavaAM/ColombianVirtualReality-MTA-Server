local gates =
{
	{
		model = 985, -- Gate object ID so you can change type of gate
		originalPosition = Vector3(1019.18, -370.51, 73.68), -- Example gate is located at SF Well stacked pizza & Co, near sea
		originalRotation = Vector3(0,0,170),
		newPosition = Vector3(1022.84, -371.03, 73.6), -- Edit depending on the opening width you want to cover with the gate, this defines how far it will move to the side (creating the gate's opening effect)
		open = false,
		movingInterval = 3000, --Move time in milliseconds
		colInfo = {createColSphere,{-1698.5302734375, 1392.7216796875, 7.1786022186279,7.5}},
	},
	-- If you need to add more gates, you can simply copy the above chunk and duplicate it within the 'local gates' table.
}

local colshapes = {}

local function toggleGate(element)

	if element.type ~= "player" then return end
	if element.dimension ~= source.dimension then return end
	if element.interior ~= source.interior then return end
	
	local gate = gates[colshapes[source]]
	
	gate.open = eventName=="onColShapeHit"
	
	if gate.open then
		gate.object:move(gate.movingInterval,gate.newPosition,0,0,0)
	else
		gate.object:move(gate.movingInterval,gate.originalPosition,0,0,0)
	end

end

local function initScript()

	for gateIndex,gate in ipairs(gates) do
		gate.object = Object(gate.model,gate.originalPosition,gate.originalRotation)
		local func,args = unpack(gate.colInfo)
		gate.colshape = func(unpack(args))
		colshapes[gate.colshape] = gateIndex
		addEventHandler("onColShapeHit",gate.colshape,toggleGate)
		addEventHandler("onColShapeLeave",gate.colshape,toggleGate)
	end

end

addEventHandler("onResourceStart",resourceRoot,initScript)