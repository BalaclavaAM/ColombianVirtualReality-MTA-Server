addEventHandler("onPlayerCommand", root, 
function(command) 
    if command == "logout" then 
		cancelEvent() 
    end 
end) 