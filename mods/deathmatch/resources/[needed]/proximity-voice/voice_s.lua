--+----------------------------------------------------------------------------------------------------------------------------------------
--|   Script by K "Addlibs" Stasiak, downloaded from MTA community.
--|
--|   Licensed under Creative Commons Attribution 4.0 International Public License
--|   https://creativecommons.org/licenses/by/4.0/
--|
--|   You are free to copy and redistribute the script, to remix, transform, and build upon the script for any purpose, even commercially.
--|   You must give appropriate credit, provide a link to the license, and indicate if changes were made.
--|   You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
--+----------------------------------------------------------------------------------------------------------------------------------------

addEventHandler("onPlayerJoin", root,
    function () -- client has just joined and the proximity voice resource isn't yet running on the client (thus they'd be able to hear everything without limitations on distance)
        setPlayerVoiceIgnoreFrom(source, root)
        setPlayerVoiceBroadcastTo(source, nil)
    end
)
if isVoiceEnabled() then
    -- adding handler for voice start event
    addEventHandler( 'onPlayerVoiceStart', root,
        function()
            -- if player is muted in chat
            -- do not broadcast his voice to other players
            if isPlayerMuted(source) then cancelEvent() end
        end
    )
end

addEvent("proximity-voice::broadcastUpdate", true)
addEventHandler("proximity-voice::broadcastUpdate", root,
    function (broadcastList) -- client has streamed in or out another player and the broadcast list has changed
        if client and source == client then else return end
        setPlayerVoiceIgnoreFrom(source, nil)
        local newlist={}
        for k,v in ipairs(broadcastList) do
            if not(exports['NGChat']:isIgnoredBy(source,v)) then
                table.insert(newlist,v)
            end
        end
		if isPlayerMuted(source)== false then 
			setPlayerVoiceBroadcastTo(source, newlist)
		end
    end
)
