events[10] = { 
	name 						= 'InfernusRace',	-- The event name
	maxSlots 					= 18,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
	    {-2695.899 ,1294.8 ,55.2 ,0 },
	    {-2692.399 ,1295 ,55.2 ,0 },
	    {-2688.3 ,1294.9 ,55.2 ,0 },
	    {-2685.299 ,1294.9 ,55.2 ,0 },
	    {-2695.899 ,1288.099 ,55.2 ,0 },
	    {-2692.5 ,1288.199 ,55.2 ,0 },
	    {-2688.3 ,1288.099 ,55.2 ,0 },
	    {-2685.3 ,1288.099 ,55.2 ,0 },
	    {-2694.699 ,1282 ,55.2 ,0 },
	    {-2686.5 ,1281.8 ,55.2 ,0 },
	    {-2685.5 ,1301.3 ,55.2 ,0 },
	    {-2688.6 ,1301.1 ,55.2 ,0 },
	    {-2692.5 ,1301.4 ,55.2 ,0 },
	    {-2695.899 ,1301.4 ,55.2 ,0 },
	    {-2685.399 ,1307.699 ,55.2 ,0 },
	    {-2688.699 ,1307.699 ,55.2 ,0 },
	    {-2692.399 ,1307.9 ,55.2 ,0 },
	    {-2695.899 ,1308 ,55.2 ,0 },
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 411,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,				-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	nitro                       = true,
	autor                       = 'Orgalor', 
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->InfernusStreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[10] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->InfernusRace:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->InfernusRace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->InfernusStreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )