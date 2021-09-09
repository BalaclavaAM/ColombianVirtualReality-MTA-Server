events[2] = { 
	name 						= 'Nascar Rumble',	-- The event name
	maxSlots 					= 15,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
	{-1397 ,-193.5 ,1051.4 ,356},
	{-1400.8 ,-193.10001 ,1051.4 ,355.995 },
	{-1393.2 ,-193.60001 ,1051.4 ,355.995 },
	{-1394.1 ,-203.8 ,1051.3 ,355.995 },
	{-1398 ,-203.60001 ,1051.3 ,355.995 },
	{-1401.8 ,-203.89999 ,1051.3 ,355.995 },
	{-1402.4 ,-212 ,1051.2 ,355.995 },
	{-1398.3 ,-212.5 ,1051.2 ,355.995 },
	{-1394.2 ,-212.3 ,1051.2 ,355.995 },
	{-1403 ,-220.7 ,1051.1 ,355.995 },
	{-1399.3 ,-220.60001 ,1051.1 ,355.995 },
	{-1395.1 ,-221.10001 ,1051.1 ,355.995 },
	{-1403.3 ,-228.39999 ,1051 ,355.995 },
	{-1399.9 ,-228.8 ,1051 ,355.995 },
	{-1396.2 ,-229.10001 ,1051 ,355.995 },
	{-1403.9 ,-236.60001 ,1051 ,355.995 },
	{-1400.7 ,-236.5 ,1051 ,355.995 },
	{-1396.7 ,-236.60001 ,1051 ,355.995 },
	{-1405.3 ,-245 ,1051 ,355.995 },
	{-1401.4 ,-245.2 ,1051 ,355.995 },
	{-1397.5 ,-245.8 ,1051 ,355.995 },
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 502,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,				-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	interior					= 7,
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->track8StreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[2] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->track8Race:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->track8Race:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->track8StreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )