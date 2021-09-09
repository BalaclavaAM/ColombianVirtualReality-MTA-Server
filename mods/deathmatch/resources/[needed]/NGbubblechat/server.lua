function outputMessage(element, text)
	assert(isElement(element), "outputMessage @ Bad argument: expected element at argument 1, got "..type(element).." "..tostring(element))
	for k,v in ipairs(getElementsByType("player")) do
		if not(exports['NGChat']:isIgnoredBy(element,v)) then
			triggerClientEvent( v,"onChatIncome", element, tostring(text))
		end
	end
end

function sendMessageToClient(message,messagetype)
	if not wasEventCancelled() then
		if messagetype == 0 or messagetype == 2 then
			for k,v in ipairs(getElementsByType("player")) do
				if not(exports['NGChat']:isIgnoredBy(v,source)) then
					triggerClientEvent(v,"onChatIncome", source, message, messagetype)
				end
			end
		end
	end
end
addEventHandler("onPlayerChat",getRootElement(),sendMessageToClient)