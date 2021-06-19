bots = {}

function consoleCreateMarker ( playerSource, commandName )
	-- If a player triggered it (rather than the admin) then
	if ( playerSource ) then
		-- Get that player's position
		local x, y, z = getElementPosition ( playerSource )
		-- Create a size 2, red checkpoint marker at their position
		--createMarker ( x, y, z, "checkpoint", 2, 255, 0, 0, 255 )
		-- Output it in his chat box
		outputChatBox ( "You got a red marker", playerSource )
		bots[playerSource] = exports [ "slothBot" ]:spawnBot ( x,  y, z, 90,  math.random ( 300, 303 ), 0, 0, false, 31, "following", playerSource )
		setElementData(bots[playerSource],"leader",playerSource)
		exports [ "slothBot" ]:setBotAttackEnabled( bots[playerSource],false)
		exports["slothBot"]:setBotWeapon( bots[playerSource], 1)
		outputChatBox(exports["slothBot"]:getBotMode(bots[playerSource]))
	end 
end
-- Attach the 'consoleCreateMarker' function to the "createmarker" command
addCommandHandler ( "createmarker", consoleCreateMarker )

function disableBot()
	exports [ "slothBot" ]:setBotAttackEnabled( source,false)
	outputChatBox("true1")
end
addEventHandler("onBotSpawned", getRootElement(), disableBot)