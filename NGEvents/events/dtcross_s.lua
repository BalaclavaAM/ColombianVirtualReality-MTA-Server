events[6] = { 
	name 						= 'DT cross',	-- The event name
	maxSlots 					= 19,				-- The max players for the event
	minSlots 					= 1,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
			{-1378.94, -668.58, 1056, 90},
			{-1378.94, -666.58, 1056, 90},
			{-1378.94, -664.58, 1056, 90},
			{-1378.94, -662.58, 1056, 90},
			{-1374.94, -668.58, 1056, 90},
			{-1374.94, -666.58, 1056, 90},
			{-1374.94, -664.58, 1056, 90},
			{-1374.94, -662.58, 1056, 90},
			{-1370.94, -666.58, 1056, 90},
			{-1370.94, -666.58, 1056, 90},
			{-1370.94, -664.58, 1056, 90},
			{-1370.94, -662.58, 1056, 90},
			{-1366.94, -664.58, 1056, 90},
			{-1366.94, -666.58, 1056, 90},
			{-1366.94, -664.58, 1056, 90},
			{-1366.94, -662.58, 1056, 90},
			{-1362.94, -662.58, 1056, 90},
			{-1362.94, -666.58, 1056, 90},
			{-1362.94, -664.58, 1056, 90},
			{-1362.94, -662.58, 1056, 90},
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 468,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,				-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	interior					= 4,
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->dtStreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[6] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->dtRace:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->dtRace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->dtStreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )