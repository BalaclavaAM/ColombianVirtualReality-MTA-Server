events[5] = { 
	name 						= 'A muerte en el hueco',-- The event name
	maxSlots 					= 20,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
		{-1364.22, 932.06, 1036.01, 0},
		{-1351.04, 932.46, 1036.04, 0},
		{-1316.41, 945.39, 1036.17, 0},
		{-1342.78, 1054.55, 1038.04, 180},
		{-1368.87, 1059.3, 1038.16, 180},
		{-1382.25, 1059.47, 1038.19, 180},
		{-1395.99, 1060.26, 1038.22, 180},
		{-1417.49, 1060.53, 1038.26, 180},
		{-1442.04, 1057.77, 1038.26, 180},
		{-1470.59, 1050.69, 1038.19, 180},
		{-1494.89, 1036.51, 1037.99, 190},
		{-1513.69, 1017.95, 1037.72, 245},
		{-1518.24, 998.8, 1037.41, 245},
		{-1515.5, 980.08, 1037.1, 245},
		{-1506.66, 967.8, 1036.88, 245},
		{-1494.14, 955.72, 1036.65, 245},
		{-1487.15, 949.79, 1036.54, 0},
		{-1447.89, 995.25, 1023.89, 260},
		{-1346.7, 992.34, 1023.71, 180},
		{-1396.35, 981.09, 1023.57, 0},
	},
	
	disableWeapons 				= false,			-- Force no weapons
	useGodmode 					= false,			-- Set players in godmode for the whole event
	warpVehicle 				= 504,			-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,			-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= false,			-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true,				-- When set to true, only person can spawn at each warp
	interior					= 15,
}


local thisEventFunctionsBloodBowl = { }
function Startbloodbowl ( ) 
	--[[for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		giveWeapon ( v, 4, 1, false )
		giveWeapon ( v, 22, 1, true )
		exports.NGMessages:sendClientMessage ( "Use your ammo wisely! You will get a bullet for every kill", v, 255, 255, 255 )
	end]]
	addEventHandler ( "onPlayerWasted", root, thisEventFunctionsBloodBowl.OnPlayerWasted )
	--addEventHandler ( "onPlayerDamage", root, thisEventFunctionsBloodBowl.OnPlayerDamage )
	addEventHandler ( "NGEvents:onEventEnded", root, thisEventFunctionsBloodBowl.OnEventEnded )
end

function thisEventFunctionsBloodBowl.OnPlayerDamage ( s, w )
	if ( s and isElement ( s ) and w and w == 22 and not isPedDead ( source ) and isPlayerInEvent ( source ) and isPlayerInEvent ( s ) ) then
		--killPed ( source );
	end
end

function thisEventFunctionsBloodBowl.OnPlayerWasted ( _, killer )
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

function thisEventFunctionsBloodBowl.OnEventEnded ( x )
	if not x then return end 
	if ( x.name == events[4].name ) then
		removeEventHandler ( "onPlayerWasted", root, thisEventFunctionsBloodBowl.OnPlayerWasted )
		removeEventHandler ( "onPlayerDamage", root, thisEventFunctionsBloodBowl.OnPlayerDamage )
		removeEventHandler ( "NGEvents:onEventEnded", root, thisEventFunctionsBloodBowl.OnEventEnded )
	end
end




eventStartFunctions[5] = _G['Startbloodbowl']
Startbloodbowl = nil