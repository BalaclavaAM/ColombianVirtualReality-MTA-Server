events[11] = { 
	name 						= 'Monster Race',	-- The event name
	maxSlots 					= 12,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
		{1278.37, -2053.57, 59.94, 267.706},
		{1278.25, -2058.16, 59.92, 267.706},
		{1272.1, -2053.36, 60.13, 267.706},
		{1271.87, -2058.05, 60.09, 267.706},
		{1265.55, -2053.02, 60.27, 267.706},
		{1265.33, -2057.6, 60.3, 267.706},
		{1259.23, -2052.59, 60.44, 267.706},
		{1259.13, -2057.52, 60.47, 267.706},
		{1252.91, -2052.49, 60.65, 267.706},
		{1252.7, -2057.51, 60.62, 267.706},
		{1246.1, -2052.4, 60.82, 267.706},
		{1245.84, -2057.1, 60.8, 267.706},
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 556,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,				-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	nitro                       = true,
	autor                       = "Sebls",
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->MonsterStreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[11] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->MonsterRace:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->MonsterRace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->MonsterStreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )