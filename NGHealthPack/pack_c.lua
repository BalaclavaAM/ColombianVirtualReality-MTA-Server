local gui = { }
local sx, sy = guiGetScreenSize ( )

function openBuyWindow ( )
	if ( isElement ( gui.window ) ) then
		destroyBuyWindow ( )
	end 
	gui.window = guiCreateWindow((sx/2-359/2), (sy/2-193/2), 359, 193, "Kit médico", false)
	guiWindowSetSizable(gui.window, false)
	gui.Image = guiCreateStaticImage(10, 28, 100, 112, "pack.png", false, gui.window)
	gui.Label = guiCreateLabel(128, 28, 215, 85, "Puedes comprar un Kit médico por $500, te regenerará 10% de salud.", false, gui.window)
	guiLabelSetHorizontalAlign ( gui.Label, "left", true )
	gui.Buy = guiCreateButton(249, 138, 94, 36, "Comprar 1", false, gui.window)
	gui.Close = guiCreateButton(149, 138, 94, 36, "Cerrar", false, gui.window)
	gui.comprar = guiCreateButton(249, 98, 94, 36, "Comprar", false, gui.window)
	gui.cantidad = guiCreateEdit(149, 98, 94, 36, "", false, gui.window)
	guiEditSetMaxLength ( gui.cantidad, 10 )
	guiSetProperty(gui.cantidad, "ValidationString", "^[0-9]*$")

	showCursor ( true )

	addEventHandler ( "onClientGUIClick", gui.Close, destroyBuyWindow )
	addEventHandler ( "onClientGUIClick", gui.Buy, onClientBuyHealthPack )
	addEventHandler ( "onClientGUIClick", gui.comprar, onClientComprarHealthPack )
end

function destroyBuyWindow ()
	removeEventHandler ( "onClientGUIClick", gui.Close, destroyBuyWindow )
	removeEventHandler ( "onClientGUIClick", gui.Buy, onClientBuyHealthPack )
	removeEventHandler ( "onClientGUIClick", gui.comprar, onClientComprarHealthPack )
	destroyElement ( gui.window )
	showCursor ( false )
	gui = { }
end 

function onClientBuyHealthPack ( )
	triggerServerEvent ( "NGHealthPacks->Modules->Packs->onPlayerBuypack", localPlayer )
end
function onClientComprarHealthPack (cantidad)
	cantidad = tonumber(guiGetText( gui.cantidad ))
	triggerServerEvent ( "NGHealthPacks->Modules->Packs->onPlayerComprarpack", localPlayer,cantidad )
end

function useHealthPack ( )
	if ( localPlayer.health > 90 ) then return false end

	triggerServerEvent ( "NGHealthPacks->Modules->Packs->UseHealthPack", localPlayer, localPlayer )
	return true
end 



local packs = { }
function createHealthPackPickup ( x, y, z, int, dim )
	if not int then int = 0 end
	if not dim then dim = 0 end
	local i = 0

	while ( packs [ i ] ) do
		i = i + 1
	end

	packs [ i ] = createPickup ( x, y, z, 0, 0, 0 )
	packs[i].interior = int
	packs[i].dimension = dim 
	addEventHandler ( "onClientPickupHit", packs[i], function ( p )
		if ( p == localPlayer and p.interior == source.interior and p.dimension == source.dimension and not isPedInVehicle ( localPlayer ) ) then
			openBuyWindow ( )
		end 
	end )
end 


createHealthPackPickup ( 1603.42, 1818.13, 10.82 )
createHealthPackPickup ( 2538.63, 1971.21, 10.82 ) --7EVEN LV (AUC)
createHealthPackPickup ( 1367.78, 396.36, 19.7 ) --HP Pescadores
createHealthPackPickup ( -321.54, 1056.34, 19.74 ) --HP Area51 FortCarson
createHealthPackPickup ( -1505.13, 2519.84, 55.9 ) --HP el quebrados
createHealthPackPickup ( -2639.56, 634.39, 14.45 ) --Hospital SF
createHealthPackPickup ( -2204.79, -2290.08, 30.63 ) --Hospital chiliad
createHealthPackPickup ( 1183.29, -1315.31, 13.58 ) --HP Central
createHealthPackPickup ( 2041.37, -1426.31, 17.16 ) --HP Groove