events[8] = { 
	name 						= 'Super Gt Race',	-- The event name
	maxSlots 					= 21,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
	    { 74.559 ,-1541 ,5 ,260.996},
	    { 74 ,-1544,5 ,260.996 },
	    { 75 ,-1538 ,5 ,258.997 },
	    { 75.559 ,-1535 ,5 ,259 },
	    { 79.799 ,-1545 ,5.239 ,260.991 },
	    { 80.289 ,-1541.9 ,5.3 ,260 },
	    { 80.889 ,-1539.009 ,5.199 ,258.889 },
	    { 81.458 ,-1536 ,5.099 ,259 },
	    { 85.5 ,-1545.9 ,5.599 ,260.985 },
	    { 86 ,-1542.9 ,5.5 ,259.996 }, 
        { 86.699 ,-1539.9 ,5.4 ,258.887 },
	    { 87.199 ,-1536.9 ,5.4 ,258.997 },
        { 76.199 ,-1532.199 ,4.9 ,259 },
	    { 76.8 ,-1529 ,5 ,258.997 },
   	    { 77.599 ,-1525.8 ,4.8 ,258.997 },
	    { 81.8 ,-1533 ,5.199 ,258.997 },
	    { 82.599 ,-1530 ,5.199 ,258.997 },
	    { 83.4 ,-1526.8 ,5 ,258.997 },
	    { 87.699 ,-1534 ,5.4 ,258.997 },
	    { 88.5 ,-1530.9 ,5.4 ,258.997 },
	    { 89 ,-1527.9 ,5.3 ,258.997 },
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 506,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,				-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	nitro                       = true, 
	autor                       = 'Orgalor',
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->SuperGtStreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[8] = _G['tempFunction']
tempFunction = nil

addEvent ( "NGEvents:Modules->SuperGtRace:ThisPlayerWinsRace", true )
addEventHandler ( "NGEvents:Modules->SuperGtRace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "NGEvents:Modules->SuperGtStreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )