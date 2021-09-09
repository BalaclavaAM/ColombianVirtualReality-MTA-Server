events[7] = { 
	name 						= 'Guerra de DTs',-- The event name
	maxSlots 					= 19,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
	{-1351.6, 1559.15, 1052.53,0},
	{-1351.18, 1651.15, 1052.53,0},
	{-1494.62, 1653.26, 1052.53,0},
	{-1495.29, 1560.02, 1052.53,0},
	{-1483.64, 1568.29, 1052.53,0},
	{-1420.73, 1564.97, 1052.59,0},
	{-1472.12, 1626.26, 1052.58,0},
	{-1461.07, 1586.27, 1052.8,0},
	{-1442.09, 1562.39, 1052.59,0},
	{-1417.38, 1585.34, 1052.58,0},
	{-1418.69, 1615.72, 1052.59,0},
	{-1418.25, 1641.55, 1052.59,0},
	{-1370.87, 1626.21, 1052.58,0},
	{-1357.57, 1612.21, 1052.59,0},
	{-1409.03, 1585.02, 1052.58,0},
	{-1359.33, 1589.48, 1052.58,0},
	{-1377.89, 1563.05, 1052.58,0},
	{-1446.6, 1626.12, 1052.58,0},
	{-1456.47, 1643.41, 1052.58,0},
	{-1429.54, 1652.27, 1052.58,0},
	{-1463.45, 1609.76, 1052.58,0},
	},
	
	disableWeapons 				= false,			-- Force no weapons
	useGodmode 					= false,			-- Set players in godmode for the whole event
	warpVehicle 				= 468,			-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,			-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= false,			-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	interior					= 14,
}


local thisEventFunctionsDtWar = { }
function Startbloodbowl ( ) 
	--[[for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		giveWeapon ( v, 4, 1, false )
		giveWeapon ( v, 22, 1, true )
		exports.NGMessages:sendClientMessage ( "Use your ammo wisely! You will get a bullet for every kill", v, 255, 255, 255 )
	end]]
	addEventHandler ( "onPlayerWasted", root, thisEventFunctionsDtWar.OnPlayerWasted )
	--addEventHandler ( "onPlayerDamage", root, thisEventFunctionsDtWar.OnPlayerDamage )
	addEventHandler ( "NGEvents:onEventEnded", root, thisEventFunctionsDtWar.OnEventEnded )
end

function thisEventFunctionsDtWar.OnPlayerDamage ( s, w )
	if ( s and isElement ( s ) and w and w == 22 and not isPedDead ( source ) and isPlayerInEvent ( source ) and isPlayerInEvent ( s ) ) then
		--killPed ( source );
	end
end

function thisEventFunctionsDtWar.OnPlayerWasted ( _, killer )
	--killPed ( source )

	
	local plrs = EventCore.GetPlayersInEvent ( )
	local winner = nil
	if ( table.len ( plrs ) == 0 ) then
		winner = source
	elseif ( table.len ( plrs ) == 1 ) then
		for i, v in pairs ( plrs ) do
			winner = v
		end
	end
	if winner then
		EventCore.WinPlayerEvent ( winner )
	end
	
end

function thisEventFunctionsDtWar.OnEventEnded ( x )
	if not x then return end 
	if ( x.name == events[4].name ) then
		removeEventHandler ( "onPlayerWasted", root, thisEventFunctionsDtWar.OnPlayerWasted )
		removeEventHandler ( "onPlayerDamage", root, thisEventFunctionsDtWar.OnPlayerDamage )
		removeEventHandler ( "NGEvents:onEventEnded", root, thisEventFunctionsDtWar.OnEventEnded )
	end
end




eventStartFunctions[7] = _G['Startbloodbowl']
Startbloodbowl = nil