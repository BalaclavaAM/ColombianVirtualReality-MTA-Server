-- FILE: 	mapEditorScriptingExtension_c.lua
-- PURPOSE:	Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps
-- VERSION:	RemoveWorldObjects (v1) AutoLOD (v1) BreakableObjects (v1)

function requestLODsClient()
	triggerServerEvent("requestLODsClient", resourceRoot)
end
addEventHandler("onClientResourceStart", resourceRoot, requestLODsClient)

function setLODsClient(lodTbl)
	for i, model in ipairs(lodTbl) do
		engineSetModelLODDistance(model, 300)
	end
end
addEvent("setLODsClient", true)
addEventHandler("setLODsClient", resourceRoot, setLODsClient)

function applyBreakableState()
	for k, obj in pairs(getElementsByType("object", resourceRoot)) do
		local breakable = getElementData(obj, "breakable")
		if breakable then
			setObjectBreakable(obj, breakable == "true")
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, applyBreakableState)

exports.ngwarpmanager:makeWarp ( { pos = { 2715.55127, -2455.04370, 14.27099+1 }, toPos = { 2780.4, -2462.17, -16.72+1 }, cInt = 0, cDim = 0, tInt = 0, tDim = 0 } )
exports.ngwarpmanager:makeWarp ( { pos = { 2780.4, -2462.17, -16.72+1 }, toPos = { 2715.55127, -2455.04370, 14.27099+1 }, cInt = 0, cDim = 0, tInt = 0, tDim = 0 } )

exports.ngwarpmanager:makeWarp ( { pos = { 2752.86, -2468.71, -22.64+1 }, toPos = { 1968.47, 1012.13, 10.91+1 }, cInt = 0, cDim = 0, tInt = 0, tDim = 0 } )
exports.ngwarpmanager:makeWarp ( { pos = { 1968.47, 1012.13, 10.91+1 }, toPos = { 2752.86, -2468.71, -22.64 +1 }, cInt = 0, cDim = 0, tInt = 0, tDim = 0 } )
