playerConMaletin = "nadie"
mark = {
	{1912.7153320313,-1353.298828125,14.034099578857},
    {965.12274169922,-1254.515625,16.978940963745},
	{767.3583984375,-1089.9201660156,24.0859375},
	{1119.6906738281,-1667.3558349609,13.632842063904},
	{1594.3298339844,-1555.9375,13.586387634277},
	{2550.1772460938,-1209.9743652344,54.543243408203},
	{2440.9250488281,-1900.4132080078,13.546875},
	{2801.7236328125,-2033.1927490234,13.5546875},
	{2478.498046875,-1962.2583007813,16.7578125},
	{2238.3420410156,-2155.6213378906,13.553833007813},
	{737.03, -1383.52, 24.69},
	{2214.16, -1179.73, 28.8}, 
	{1874.55, -1954.63, 19.07},
	{738.73, -1430.82, 13.52},
}

bag = {
	{1578.2777099609,-1345.7055664063,16.484375},
    {1302.3748779297,-1463.0034179688,10.046875},
	{839.49645996094,-1373.4074707031,22.532068252563},
	{913.87054443359,-1239.5350341797,17.019510269165},
	{1343.0270996094,-1665.2170410156,13.581394195557},
	{2755.1091308594,-1431.0084228516,30.453125},
	{2504.1252441406,-1688.5943603516,13.556813240051},
	{2448.0864257813,-2119.3666992188,13.546875},
	{2676.2385253906,-1791.9935302734,11.84375},
	{2754.1650390625,-2099.2358398438,12.10768699646},
	{328.67, -1514.58, 36.04}, 
	{2765, -1177.87, 69.41},
	{2414.67, -2469.8, 13.62},
	{835.68, -2066.47, 12.87},
}


function createBag()
	local mt = math.random(#bag)
	ob = createObject(1210,bag[mt][1],bag[mt][2],bag[mt][3])
	setElementCollisionsEnabled(ob,false)
	time = setTimer(roo,100,0,ob)
	mar = createMarker(bag[mt][1],bag[mt][2],bag[mt][3],"corona",0.5,255,0,0,120)
	bl = createBlipAttachedTo(mar,17)
	setElementData(mar,"num",mt)
	outputChatBox("                    #0069c7|MALETIN DE DROGAS|                  ",root,0,255,0,true)
	outputChatBox("* #0069c7Un maletin de droga ha aparecido, llevalo a su destino ",root,0,255,0,true)
	outputChatBox("                 #0069c7 y gana $#ff640040.000 #0069c7(#ffffff Icono #ff0000Malteada#0069c7)    ",root,0,255,0,true)
end
addEventHandler("onResourceStart",resourceRoot,createBag)

addEventHandler("onMarkerHit",root,
	function (player)
		if ( source == mar ) then
			if getElementData(player,"Job") =="Criminal" then
				if getElementType(player) == "player" and isPedInVehicle(player) == false then
					local x,y,z = getElementPosition(player)
					local data = getElementData(mar,"num")
					local data = tonumber(data)
					playerConMaletin = getPlayerAccount(player)
					destroyElement(mar)
					destroyElement(ob)
					destroyElement(bl)
					killTimer(time)
					setElementData(player,"bag",true)
					atBag = createObject(1210,x,y,z)
					setElementData(atBag,"num",data)
					exports.bone_attach:attachElementToBone(atBag,player,12,0,0.05,0.27,0,180,0)
					bli = createBlipAttachedTo(player,17)
					outputChatBox("* #ffffff[ #ff0000" .. getPlayerName(player) .. "#ffffff ]#0069c7 Ha cogido el maletin",root,0,255,0,true)
					markerEntregaMaletin = createMarker(mark[data][1],mark[data][2],mark[data][3],"cylinder",1.5,255,255,0,255,player)
					marBli = createBlipAttachedTo(markerEntregaMaletin,12,2,255,0,0,255,0,99999.0,player)
				end
			else
				outputChatBox("Tienes que ser criminal para coger el maletin!",player,255,0,0)
			end
		end
	end
)

function roo(ele)
	local x,y,z = getElementRotation(ele)
	setElementRotation(ele,x,y,z + 5)
end

addEventHandler("onPlayerWasted",root,
	function ()
		if getElementData(source,"bag") and getElementData(source,"bag") == true then
			local data = getElementData(atBag,"num")
			local data = tonumber(data)
			local x,y,z = getElementPosition(source)
			setElementData(source,"bag",false)
			destroyElement(atBag)
			destroyElement(markerEntregaMaletin)
			destroyElement(bli)
			destroyElement(marBli)
			ob = createObject(1210,x,y,z)
			setElementCollisionsEnabled(ob,false)
			time = setTimer(roo,100,0,ob)
			mar = createMarker(x,y,z,"corona",0.5,255,0,0,120)
			setElementData(mar,"num",data)
			bl = createBlipAttachedTo(mar,17)
		end
	end
)

addEventHandler("onPlayerVehicleEnter",root,
	function ()
		if getElementData(source,"bag") and getElementData(source,"bag") == true then
			local data = getElementData(atBag,"num")
			local data = tonumber(data)
			local x,y,z = getElementPosition(source)
			setElementData(source,"bag",false)
			destroyElement(atBag)
			destroyElement(markerEntregaMaletin)
			destroyElement(bli)
			destroyElement(marBli)
			ob = createObject(1210,x,y,z)
			setElementCollisionsEnabled(ob,false)
			time = setTimer(roo,100,0,ob)
			mar = createMarker(x,y,z,"corona",0.5,255,0,0,120)
			setElementData(mar,"num",data)
			bl = createBlipAttachedTo(mar,17)
		end
	end
)

addEventHandler("onMarkerHit",root,
	function (player)
		if ( source == markerEntregaMaletin ) and playerConMaletin == getPlayerAccount(player) then
			if getElementType(player) == "player" then
				playerConMaletin = "Nadie"
				setElementData(player,"bag",false)
				destroyElement(markerEntregaMaletin)
				destroyElement(marBli)
				destroyElement(bli)
				destroyElement(atBag)
				outputChatBox("* #ffffff[ #ff0000" .. getPlayerName(player) .. " #ffffff] #0069c7Ha ganado #00ff00$40.000 #0069c7al entregar el maletin de droga",root,255,0,0,true)
				givePlayerMoney(player,40000)
				triggerClientEvent(player,"onShowMoney",player)
				setTimer(createBag,900000,1)
			end
		end
	end
)

addEventHandler("onVehicleStartEnter",root,
	function (player)
		if getElementData(player,"bag") and getElementData(player,"bag") == true then
			cancelEvent()
			outputChatBox("* #0069c7No puedes ingresar a un vehiculo mientras tienes el maletin",player,255,0,0,true)
		end
	end
)

addEventHandler("onPlayerQuit",root,
	function ()
		if getElementData(source,"bag") and getElementData(source,"bag") == true then
			local data = getElementData(atBag,"num")
			local data = tonumber(data)
			local x,y,z = getElementPosition(source)
			setElementData(source,"bag",false)
			destroyElement(atBag)
			destroyElement(markerEntregaMaletin)
			destroyElement(bli)
			destroyElement(marBli)
			ob = createObject(1210,x,y,z)
			setElementCollisionsEnabled(ob,false)
			time = setTimer(roo,100,0,ob)
			mar = createMarker(x,y,z,"corona",0.5,255,0,0,120)
			setElementData(mar,"num",data)
			bl = createBlipAttachedTo(mar,17)
		end
	end
)
