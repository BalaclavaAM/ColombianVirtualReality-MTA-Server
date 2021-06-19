
local cvrBrowser = guiCreateWindow(346, 143, 826, 621, "CVR Chrome", false)
guiWindowSetSizable(cvrBrowser, false)

local urlEdit = guiCreateEdit(140, 21, 549, 25, "", false, cvrBrowser)
local backBtn = guiCreateButton(10, 21, 41, 25, "<<", false, cvrBrowser)
local forwardBtn = guiCreateButton(51, 21, 41, 25, ">>", false, cvrBrowser)
local reloadBtn = guiCreateButton(99, 21, 41, 25, "⟳", false, cvrBrowser)
local navigateBtn = guiCreateButton(702, 22, 86, 24, "Navegar", false, cvrBrowser)  
local browser = guiCreateBrowser( 3, 48, 817, 563, false, false, false, cvrBrowser )
local theBrowser = guiGetBrowser( browser ) 
guiSetVisible(cvrBrowser,false)

 function resourceBlocked(url,domain,reason)
	outputChatBox("blocked"..url.." "..domain.." "..reason.."")
    if reason == 0 then
        requestBrowserDomains({url})
    end
end
addEventHandler("onClientBrowserResourceBlocked",theBrowser,resourceBlocked)

addEventHandler( "onClientBrowserCreated", theBrowser, 
	function( )
		-- After the browser has been initialized, we can load www.youtube.com
		loadBrowserURL( theBrowser, "https://www.youtube.com/" )
		guiSetText(urlEdit,getBrowserURL(theBrowser))
	end
)

 function resourceBlocked2(targeturl, isBlocked)
	if isBlocked == true then
		requestBrowserDomains({targeturl})
	end
end
addEventHandler("onClientBrowserNavigate",theBrowser,resourceBlocked2)

-- This part handles the GUI navigation buttons for the browser.
addEventHandler( "onClientGUIClick", resourceRoot, function ( )
    if source == backBtn then
        navigateBrowserBack(theBrowser)
		guiSetText(urlEdit,getBrowserURL(theBrowser))
    elseif source == forwardBtn then
        navigateBrowserForward(theBrowser)
		guiSetText(urlEdit,getBrowserURL(theBrowser))
    elseif source == reloadBtn then
        reloadBrowserPage(theBrowser)
		guiSetText(urlEdit,getBrowserURL(theBrowser))
	elseif source == navigateBtn then
		local url = tostring(guiGetText(urlEdit))
		if isBrowserDomainBlocked(url) then
			requestBrowserDomains({url})
			loadBrowserURL(url)
		end
		local getUrlHttp = string.sub(url,1,8)
		if getUrlHttp =="https://" then
			loadBrowserURL(theBrowser,url)
		else
			loadBrowserURL(theBrowser, "https://"..url.."")
			
		end
    end
end )


function showGui()
	if guiGetVisible(cvrBrowser) == true then
		guiSetVisible(cvrBrowser, false)
		showCursor(false)
	else
		guiSetVisible(cvrBrowser,true)
		showCursor(true)
	end
end
 bindKey ( "F4", "down", showGui )
 
