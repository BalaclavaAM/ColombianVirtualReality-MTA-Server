local marker = createMarker ( 2528.49, -1312.78, 34, "cylinder", 1.5, 255, 255, 0, 170 )
addEventHandler("onClientMarkerHit", marker, 
	function(hitPlayer, matchingDimension)
		if hitPlayer == localPlayer then
			if getTeamName(getPlayerTeam(hitPlayer)) == "Criminals" then
				deliverPanel = guiCreateWindow(507, 394, 490, 184, "Jibarear", false)
				guiWindowSetSizable(deliverPanel, false)
				guiSetProperty(deliverPanel, "CaptionColour", "FFFB2602")

				memo = guiCreateMemo(16, 38, 451, 61, "Revenderas drogas por todo LS, apareceran en el mapa compradores (icono C rosa) que te pediran una cantidad variable de droga a un precio establecido. La policia te buscara mas por cada negocio que logres concretar", false, deliverPanel)
				guiMemoSetReadOnly(memo, true)
				acceptDeliverBtn = guiCreateButton(10, 115, 187, 48, "De una", false, deliverPanel)
				guiSetProperty(acceptDeliverBtn, "NormalTextColour", "FF01FD13")
				cancelDeliverBtn = guiCreateButton(299, 115, 181, 48, "Cancelar", false, deliverPanel)
				guiSetProperty(cancelDeliverBtn, "NormalTextColour", "FFFF0000")    
				guiSetVisible(deliverPanel,true)
				showCursor(true)
				addEventHandler ( "onClientGUIClick", cancelDeliverBtn, 
					function()
						guiSetVisible(deliverPanel, false)
						showCursor(false)
					end
				, false )
				addEventHandler("onClientGUIClick", acceptDeliverBtn, 
					function ()
						guiSetVisible(deliverPanel,false)
						showCursor(false)
						outputChatBox("Distribuye drogas a los compradores (icono C rosa en el mapa).",255,0,128)
						startDistribution(localPlayer)
					end
				, false)
			else
				outputChatBox("Debes ser criminal para acceder a esta funcionalidad",255,0,0)
			end
		end
	end
)
--Data, name, price
local drugType = {
	{"Weed" ,"Bareta", 400},
	{"God", "Popper", 600},
	{"Speed", "Perica", 700},
	{"Lsd", "Lsd",700},
	{"Steroids", "Bazuko", 400},
	{"Heroin", "Heroina", 1000},
}
local customers = {
	{2477.81, -1320.57, 27.97},
	{2162.99, -1595.34, 14.35},
	{2247.36, -1433.28, 24.77},
	{2113.05, -1342.3, 23.98},
	{1971.27, -1176.75, 20.02},
	{1292.18, -1081.09, 25.88},
	{2165.9, -1506, 23.93},
	{2290.38, -1528.32, 26.88},
	{2374.76, -1554.39, 24},
	{2520.32, -1481.81, 24},
	{2632.96, -1478.12, 16.33},
	{2578.91, -2171.57, -0.22},
	{2704.29, -2319.34, 3},
	{2550.34, -2342.67, 13.63},
	{2224.31, -2281.85, 14.76},
	{2234.8, -2120.13, 7.64},
	{2051.46, -1903.56, 13.55},
	{1901.24, -1990.2, 13.55},
	{1874.45, -1955.49, 20.07},
	{1880.75, -1872.22, 13.53},
	{1991.58, -1828.07, 13.55},
	{1667.59, -1703.36, 15.61},
	{1359.43, -1673.76, 8.61},
	{1341.97, -1773.73, 13.49},
	{1392.84, -1895.24, 13.49},
	{1074.19, -2038.53, 53.14},
	{1112.79, -2047.01, 74.43},
	{1570.49, -1896.12, 13.56},
	{1570.18, -1477.22, 13.55},
	{1768.99, -1371.24, 15.76},
	{1904.67, -1319.24, 14.19},
	{2044.24, -1034.22, 25.95},
	{2266, -1027.34, 59.29},
	{2061.54, -1007.48, 47.98},
	{1306.33, -873.96, 39.58},
	{1264.81, -868.23, 42.88},
	{1208.65, -1101.76, 25.21},
	{1112.79, -1186.01, 18.34},
	{1093.06, -1312.38, 13.67},
	{831.8, -1453.27, 13.63},
	{722.98, -1483.73, 1.97},
	{674.36, -1866.93, 5.46},
	{386.37, -1881.9, 2.47},
	{367.26, -2080.47, 7.84},
	{385.23, -1754.06, 9.47},
	{405.28, -1535.47, 32.27},
	{339.7, -1345.93, 14.51},
	{412.8, -1303.25, 14.97},
	{731.22, -1281.91, 13.57},
	{815.09, -1096.82, 25.79},
	{939, -1086.67, 24.3},
	{1033.01, -1091.01, 23.83},
	{1071.7, -873.16, 43.39},
	{963.11, -917.99, 45.77},
	{1234.41, -1266.66, 14.5},

}

function startDeal(p)
	if p == localPlayer then
		local rotX1, rotY1, rotZ1 = getElementRotation(p)
		setElementRotation(buyer,rotX1,rotY1,180+rotZ1)
		
		if getTeamName(getPlayerTeam(p)) == "Criminals" or getTeamName(getPlayerTeam(p)) =="Staff" then
			dealWindow = guiCreateWindow(550, 416, 547, 120, "Negociacion en proceso...", false)
			guiWindowSetSizable(dealWindow, false)

			dealLabel = guiCreateLabel(65, 29, 419, 16, "Vicioso: Estoy buscando "..drugQty.." de "..name.." por "..price.." cada unidad.", false, dealWindow)
			guiSetFont(dealLabel, "clear-normal")
			acceptDeal = guiCreateButton(111, 77, 143, 33, "Hacer trato", false, dealWindow)
			guiSetProperty(acceptDeal, "NormalTextColour", "FF67F806")
			closeDeal = guiCreateButton(264, 75, 143, 35, "Cancelar", false, dealWindow)
			guiSetProperty(closeDeal, "NormalTextColour", "FFFD0000")
			guiSetVisible(dealWindow, true)
			showCursor(true)
			addEventHandler ( "onClientGUIClick", closeDeal, 
				function()
					guiSetVisible(dealWindow, false)
					showCursor(false)
				end
			, false )
			addEventHandler("onClientGUIClick", acceptDeal, 
				function ()
					triggerServerEvent("setDrugAmmount", p, drugT, drugQty)
				end
			, false)
			
		end
		
	end
end
function dealFinish(p)
	guiSetVisible(dealWindow, false)
	setPedAnimation(p, "dealer", "dealer_deal",-1,false,false,true)
	setPedAnimation(buyer, "dealer", "drugs_buy",-1,false,false,true)
	setTimer(function() setPedAnimation(p) end,3000,1)
	setTimer(function() setPedAnimation(buyer,"dealer","dealer_idle") end, 3000,1)
	triggerServerEvent ( "NGJobs->GivePlayerMoney", p, p, price*drugQty*1+math.random(1,3)/3, false )
	showCursor(false)
	destroyElement(col)
	local wl = tonumber ( getElementData ( p, "WantedPoints" ) )
	setElementData ( p, "WantedPoints", wl + math.random(200,350) )  
	setTimer(
		function()
			destroyElement(buyer)
			destroyElement(blip)
			buyer = nil
			blip = nil
			col = nil
			startDistribution(p)
		end
	,15000,1)

end
addEvent( "onDealSucessfull", true )
addEventHandler( "onDealSucessfull", localPlayer, dealFinish )

function startDistribution(p)
	if p == localPlayer then
		if not isElement(buyer) then
			local x, y, z = unpack ( customers [ math.random ( #customers ) ] )
			drugT, name, price = unpack( drugType[math.random(#drugType)] )
			drugQty = math.random(1,5)
			buyer = createPed(math.random(0,312),x,y,z,rotZ)
			blip = createBlipAttachedTo(buyer,12)
			col = createColSphere(x,y,z,1)
			attachElements(col,buyer)
			addEventHandler("onClientColShapeHit", col, startDeal)
		end
	end
end

function cancelPedDamage ( attacker )
	if isElement(buyer) and source == buyer then
		cancelEvent() -- cancel any damage done to peds
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), cancelPedDamage )
 
--[[
addEventHandler( "onClientResourceStart", resourceRoot,
    function ( startedRes )
	p = localPlayer
	if getTeamName(getPlayerTeam(p)) == "Criminals" or getTeamName(getPlayerTeam(p)) =="Staff" then
        startDistribution(p)
	end
    end
)]]
