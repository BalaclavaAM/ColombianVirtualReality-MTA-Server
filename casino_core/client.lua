function ToolTip(message)
	outputChatBox(message,255, 255,255, true)
end
addEvent("ToolTip", true)
addEventHandler("ToolTip", root, ToolTip)