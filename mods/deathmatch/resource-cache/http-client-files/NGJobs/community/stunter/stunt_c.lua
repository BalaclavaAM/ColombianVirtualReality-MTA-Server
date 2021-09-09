local StuntText = ""
local StuntTextStart = getTickCount ( )
local sx, sy = guiGetScreenSize ( )
local allowedTypes =  { ['quad'] = true, ['bmx'] = true, ['bike'] = true }


addEventHandler ( "onClientRender", root, function ( )
	if ( StuntText ~= "" ) then
		if ( getTickCount ( ) - StuntTextStart < 7000 ) then
			dxDrawText ( StuntText:gsub ( "#%x%x%x%x%x%x", "" ), 0, 0, sx, sy / 1.3, tocolor ( 0, 0, 0, 255 ), 1.5, "default-bold", "center", "bottom" )
			dxDrawText ( StuntText, 2, 2, sx, sy / 1.3, tocolor ( 255, 255, 255, 255 ), 1.5, "default-bold", "center", "bottom", false, false, false, true )
		else
			StuntText = ""
		end
	end
end )


addEventHandler( "onClientPlayerStuntFinish", getRootElement( ), function ( stunt, stuntTime, distance )
	money = nil
	if ( source ~= localPlayer ) then return end
	if ( getElementData ( localPlayer, "Job" ) ~= "Stunter" ) then return end
	local c = getPedOccupiedVehicle ( localPlayer )
	if c then
		local attachedElements = getAttachedElements ( c )
		local attachedTo = getElementAttachedTo( c )
		if c==false or attachedTo~=false then return end
		for ElementKey, ElementValue in ipairs ( attachedElements ) do
			if ( getElementType ( ElementValue ) == "vehicle" ) then return end
		end
	end 
	if ( not c ) then return end
	if ( not allowedTypes [ string.lower ( getVehicleType ( c ) ) ] ) then return end
	local seconds = math.floor ( stuntTime / 500 )
	if ( seconds >= 10 and stunt == "stoppie" and (getVehicleName ( c ) == "BMX" or getVehicleName ( c ) == "Mountain Bike" or getVehicleName ( c ) == "Bike")) then
		StuntText = "#FF0000Bug abuse detected!"
		StuntTextStart = getTickCount ( )
		return
	end
	
	if ( seconds >= 2 and distance == 0 ) then
		money = seconds * 30
		StuntText = "You did a "..tostring(stunt).." that lasted "..tostring(seconds).." seconds! #00ff00+ $"..money
	elseif ( seconds > 0 and distance > 0 ) then
		money = ( seconds * 30 ) + ( distance * 2 )
		StuntText = "You did a "..tostring(stunt).." that lasted "..tostring(seconds).." seconds and "..tostring(distance).." meters! #00ff00+ $"..money
	end
	
	if ( money ) then
		triggerServerEvent ( "NGJobs->GivePlayerMoney", localPlayer, localPlayer, money, false )
		--triggerServerEvent ( "NGJobs->SQL->UpdateColumn", localPlayer, localPlayer, "stunts", "AddOne" )
		StuntTextStart = getTickCount ( )
	end
end )
