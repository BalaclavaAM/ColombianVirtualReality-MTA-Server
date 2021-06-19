local sound = nil
addEvent("EmpezarTerremoto", true)
addEventHandler("EmpezarTerremoto", root, function()
	setWindVelocity(70, 70, 10);setHeatHaze ( 50, 20, 0, 500, 200, 100, 50, 20, true );setCameraShakeLevel(255);
	sound = Sound("sounds/s.mp3", true);
end);

addEvent("StopTerremoto", true)
addEventHandler("StopTerremoto", root, function()
	resetWindVelocity(); resetHeatHaze();setCameraShakeLevel(0);
	if isElement( sound ) then
		sound:stop();
	end
end);