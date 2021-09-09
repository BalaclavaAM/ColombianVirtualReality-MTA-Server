events[12] = { 
	name 						= 'Bandito Race',	-- The event name
	maxSlots 					= 12,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
		{-719.89, 2366.08, 126.78, 154.284},
		{-722.90, 2367.63, 126.78, 154.284},
		{-720.74, 2371.70, 127.00, 154.284},
		{-717.92, 2370.25, 126.99, 154.284},
		{-718.61, 2375.87, 127.21, 154.284},
		{-715.9, 2374.62, 127.21, 154.284},
		{-716.63, 2379.88, 127.48, 154.284},
		{-714.11, 2378.58, 127.46, 154.284},
		{-714.62, 2383.99, 127.8, 154.284},
		{-712.14, 2382.72, 127.77, 154.284},
		{-710.16, 2386.78, 128.13, 154.284},
		{-712.61, 2388.03, 128.15, 154.284},
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 568,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,			-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	nitro                       = true,
	autor                       = "Sebls",
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->BanditoDesertRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[12] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->BanditoRace:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->BanditoRace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->BanditoDesertRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )