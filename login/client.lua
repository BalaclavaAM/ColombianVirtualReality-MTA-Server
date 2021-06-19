
local screenWidth, screenHeight = guiGetScreenSize()

local page = "http://mta/html/index.html"
local initBrowser = guiCreateBrowser(0, 0, screenWidth, screenHeight, true, false, false)
local theBrowser = guiGetBrowser(initBrowser)

addEventHandler("onClientBrowserCreated", theBrowser, 
	function()
		loadBrowserURL(source, page)
		showCursor(true)		
	end
)

addEvent("onClientPlayerLogin", true)
addEventHandler("onClientPlayerLogin", root,
	function()
		destroyElement(initBrowser)
		showCursor(false)
	end
)

function cmsg(login, password, email, command)
	if (command == "register") then
	triggerServerEvent("Login:onClientAttemptRegistration", localPlayer, login, password, email)
	end
end
addEvent("cmsg", true)
addEventHandler("cmsg", root, cmsg)

function ssj(login, password, comand)
	if (comand == "log") then
		triggerServerEvent("Login:onClientAttemptLogin", localPlayer, login, password)
	end
end
addEvent("ssj", true)
addEventHandler("ssj", root, ssj)


function cm(cod)
	if (cod == "gu") then
		destroyElement(initBrowser)
	    showCursor(false)
	end
end
addEvent("cm", true)
addEventHandler("cm", root, cm)
