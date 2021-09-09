local PlayButtonClickSound = true

addEvent ( "onClientPlayerLogin", true )
addEventHandler ( "onClientPlayerLogin", root, function ( )
	PlayButtonClickSound = exports.NGPhone:getSetting ( "usersetting_misc_playsoundonguiclick" );
end )

addEvent ( "onClientUserSettingChange", true )
addEventHandler ( "onClientUserSettingChange", root, function ( set, val )
	if ( set == "usersetting_misc_playsoundonguiclick" ) then
		PlayButtonClickSound = val
	end
end )

addEventHandler ( "onClientGUIClick", root, function ( )
	if ( getElementType ( source ) == "gui-button" and PlayButtonClickSound ) then
		local clickeo = playSound ( "files/click.mp3" )
		setSoundVolume( clickeo, 0.1)
	end
end )