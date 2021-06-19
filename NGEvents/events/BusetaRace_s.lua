events[13] = { 
	name 						= 'Busetas Race',	-- The event name
	maxSlots 					= 14,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
		{1323.65, -1393, 13.01, 90},
		{1323.64, -1395.79, 13.01, 90},
		{1323.62, -1398.57, 13.01, 90},
		{1323.64, -1401.69, 13.01, 90},
		{1323.63, -1404.41, 13.01, 90},
		{1323.78, -1407.36, 13.01, 90},
		{1323.75, -1410.17, 13.01, 90},
		{1329.71, -1393.07, 13.06, 90},
		{1329.72, -1395.74, 13.04, 90},
		{1329.79, -1398.63, 13.04, 90},
		{1329.81, -1401.61, 13.04, 90},
		{1329.94, -1404.37, 13.04, 90},
		{1330.02, -1407.31, 13.03, 90},
		{1330.02, -1410.2, 13.01, 90},

	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 405,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,			-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	nitro                       = true,
	autor                       = "Sebls",
	
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->BusetaStreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[13] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->BusetaRace:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->BusetaRace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->BusetaStreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )