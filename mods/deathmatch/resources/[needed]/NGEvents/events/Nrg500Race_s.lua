events[9] = { 
	name 						= 'NGR500RaceSf',	-- The event name
	maxSlots 					= 20,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
	    {-2685.239 ,1219 ,55.09 ,111.994 },
	    {-2685.899 ,1221.099 ,55.09 ,111.994 },
	    {-2686.5 ,1223 ,55.09 ,111.994 },
	    {-2687 ,1225 ,55.09 ,111.994 },
	    {-2681.599,1220.5 ,55.09 ,111.994 },
	    {-2682.399 ,1222.599 ,55.099 ,111.994 },
	    {-2683.099 ,1224.2 ,55.099 ,111.994 },
	    {-2683.899 ,1226.199 ,55.099 ,111.989 },
	    {-2681 ,1218.8 ,55.099 ,111.994 },
	    {-2677.8 ,1219.8 ,55.099 ,111.989 },
	    {-2684.1 ,1228.4 ,55.099 ,111.994 },
	    {-2680.899 ,1229.5 ,55.099 ,111.989 },
	    {-2680.199 ,1227.699 ,55.099 ,111.994 },
	    {-2679.6 ,1225.5 ,55.099 ,111.989 },
	    {-2679.1 ,1223.599 ,55.099 ,111.994 },
	    {-2678.399 ,1221.699 ,55.099 ,111.989 },
	    {-2677.1 ,1228.599 ,55.099 ,111.994 },
	    {-2676.5 ,1226.699 ,55.099 ,111.989 },
	    {-2675.899 ,1224.8 ,55.099 ,111.994 },
	    {-2675.3 ,1222.9 ,55.099 ,111.989 },
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 522,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,				-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,		-- When set to true, only person can spawn at each warp
    autor                       = 'Orgalor', 
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->Nrg500StreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[9] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->Nrg500Race:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->Nrg500Race:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->Nrg500StreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )