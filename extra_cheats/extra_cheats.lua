---------------------
----by DireXus----
---------------------

--- Variabled to Toggle cheats ---
local car_fly = false
local hover_car = false
local extrabunny = false
local extrajump = false
local vehicle_godmode = false
local godmode = false


---- Flying Cars----
function toggle_carfly ( player )
	if car_fly == false then
		setWorldSpecialPropertyEnabled("aircars", true )
		exports.NGMessages:sendClientMessage ("Car-Fly enabled", player, 0, 255, 0 )
		car_fly = true
	elseif car_fly == true then
		setWorldSpecialPropertyEnabled("aircars", false )
		exports.NGMessages:sendClientMessage ("Car-Fly disabled", player, 255, 0, 0 )
		car_fly = false
	end
end

------ Hovercars ------
function toggle_hovercar ( player )
	if hover_car == false then
		setWorldSpecialPropertyEnabled("hovercars", true )
		exports.NGMessages:sendClientMessage ("Car-Swim enabled", player, 0, 255, 0 )
		hover_car = true
	elseif hover_car == true then
		setWorldSpecialPropertyEnabled("hovercars", false )
		exports.NGMessages:sendClientMessage ("Car-Swim", player, 255, 0, 0 )
		hover_car = false
	end
end
addCommandHandler("swim", toggle_hovercar )

---- High BMX Jump -----
function toggle_bunny ( player )
	if extrabunny == false then
		setWorldSpecialPropertyEnabled("extrabunny", true )
		exports.NGMessages:sendClientMessage ("Bunny enabled", player, 0, 255, 0 )
		extrabunny = true
	elseif extrabunny == true then
		setWorldSpecialPropertyEnabled("extrabunny", false )
		exports.NGMessages:sendClientMessage ("Bunny disabled", player, 255, 0, 0 )
		extrabunny = false
	end
end
addCommandHandler("bunny", toggle_bunny )

----- Higher Jump ----
function toggle_superjump ( player )
	if extrajump == false then
		setWorldSpecialPropertyEnabled("extrajump", true )
		exports.NGMessages:sendClientMessage ("Extrajump enabled", player, 0, 255, 0 )
		extrajump = true
	elseif extrajump == true then
		setWorldSpecialPropertyEnabled("extrajump", false )
		exports.NGMessages:sendClientMessage ("Extrajump disabled", player, 255, 0, 0 )
		extrajump = false
	end
end
addCommandHandler("jump", toggle_superjump )

----- Vehicle Godmode -----
function toggle_veh_godmode ( player )
	if vehicle_godmode == false then
		setVehicleDamageProof ( getPedOccupiedVehicle ( getLocalPlayer() ), true )
		fixVehicle( getPedOccupiedVehicle( getLocalPlayer() ) )
		exports.NGMessages:sendClientMessage ("Vehicle Godmode enabled", player, 0, 255, 0 )
		vehicle_godmode = true
	elseif vehicle_godmode == true then
		setVehicleDamageProof ( getPedOccupiedVehicle ( getLocalPlayer() ), false )
		exports.NGMessages:sendClientMessage ("Vehicle Godmode disabled", player, 255, 0, 0 )
		vehicle_godmode  = false
	end
end
function toggle_taxi_godmode ( player )
	if vehicle_godmode == false and getElementModel( getPedOccupiedVehicle(getLocalPlayer()))==420 then
		setVehicleDamageProof ( getPedOccupiedVehicle ( getLocalPlayer() ), true )
		fixVehicle( getPedOccupiedVehicle( getLocalPlayer() ) )
		exports.NGMessages:sendClientMessage ("Vehicle Godmode enabled", player, 0, 255, 0 )
		vehicle_godmode = true
	elseif vehicle_godmode == true then
		setVehicleDamageProof ( getPedOccupiedVehicle ( getLocalPlayer() ), false )
		exports.NGMessages:sendClientMessage ("Vehicle Godmode disabled", player, 255, 0, 0 )
		vehicle_godmode  = false
	end
end
addCommandHandler("vgod", toggle_veh_godmode )
addCommandHandler("taxidios", toggle_taxi_godmode )

---- Player Godmode -----
addEventHandler("onClientPlayerDamage", getLocalPlayer(),
function()
	if godmode == true then
		cancelEvent()
	end
end
)

function toggle_godmode ( player )
	if godmode == false then
		godmode = true
		exports.NGMessages:sendClientMessage ("Godmode Enabled", player, 0, 150, 0 )
	elseif godmode == true then
		godmode = false
		exports.NGMessages:sendClientMessage ("Godmode Disabled", player, 255, 0, 0 )
	end
end
addCommandHandler("god", toggle_godmode )