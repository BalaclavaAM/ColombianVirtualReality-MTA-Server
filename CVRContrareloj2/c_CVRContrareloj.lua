local screenW, screenH = guiGetScreenSize()
local time=0
local starttime=0
local besttime=0
local besttimedesc="0"
local RaceInDuty=""
local penal=0
local car=""

function secondsToTimeDesc( seconds )
	if seconds then
		local results = {}
		local sec = ( seconds %60 )
		local min = math.floor ( ( seconds % 3600 ) /60 )
		local hou = math.floor ( ( seconds % 86400 ) /3600 )
		local day = math.floor ( seconds /86400 )
		
		if day > 0 then table.insert( results, day .. ( day == 1 and " dia" or " días" ) ) end
		if hou > 0 then table.insert( results, hou .. ( hou == 1 and " hora" or " horas" ) ) end
		if min > 0 then table.insert( results, min .. ( min == 1 and " minuto" or " minutos" ) ) end
		if sec > 0 then table.insert( results, sec .. ( sec == 1 and " segundo" or " segundos" ) ) end
		
		return string.reverse ( table.concat ( results, ", " ):reverse():gsub(" ,", " y ", 1 ) )
	end
	return ""
end

function secondsToTimeMinimal( seconds )
	if seconds then
		local results = {}
		local sec = ( seconds %60 )
		local min = math.floor ( ( seconds % 3600 ) /60 )
		local hou = math.floor ( ( seconds % 86400 ) /3600 )
		local day = math.floor ( seconds /86400 )
		
		if day > 0 then table.insert( results, day .. ( day == 1 and " d" or " ds" ) ) end
		if hou > 0 then table.insert( results, hou .. ( hou == 1 and " h" or " hs" ) ) end
		if min > 0 then table.insert( results, min .. ( min == 1 and " m" or " mins" ) ) end
		if sec > 0 then table.insert( results, sec .. ( sec == 1 and " s" or " sgs" ) ) end
		
		return string.reverse ( table.concat ( results, ", " ):reverse():gsub(" ,", " : ", 1 ) )
	end
	return ""
end

local screenW, screenH = guiGetScreenSize()
local CONTRARELOGSCVR = guiCreateWindow((screenW - 320) / 2, (screenH - 382) / 2, 320, 382, "Contrareloj CVR ", false)
guiWindowSetSizable(CONTRARELOGSCVR, false)
guiSetProperty(CONTRARELOGSCVR, "CaptionColour", "FF13F7D4")

local COMENZAR = guiCreateButton(0.12, 0.88, 0.34, 0.08, "EMPEZAR", true, CONTRARELOGSCVR)
guiSetProperty(COMENZAR, "NormalTextColour", "FF15FA04")
local SALIR = guiCreateButton(0.55, 0.88, 0.34, 0.08, "SALIR", true, CONTRARELOGSCVR)
guiSetProperty(SALIR, "NormalTextColour", "FFFC0E40")
local COLUMNAS = guiCreateGridList(0.03, 0.07, 0.94, 0.66, true, CONTRARELOGSCVR)
guiGridListAddColumn(COLUMNAS, "#", 0.3)
guiGridListAddColumn(COLUMNAS, "Usuario", 0.3)
guiGridListAddColumn(COLUMNAS, "Tiempo", 0.3)

local SCROLL = guiCreateScrollBar(0.94, 0.01, 0.06, 0.99, false, true, COLUMNAS)

local TUTIEMPO = guiCreateLabel(0.26, 0.75, 0.50, 0.08, "", true, CONTRARELOGSCVR)

guiSetVisible(CONTRARELOGSCVR, false)

function alimentarTabla(datos,mejortime)
    guiGridListClear ( COLUMNAS )
    for k,v in pairs(datos) do
        guiGridListAddRow(COLUMNAS,k,v['Username'],secondsToTimeMinimal(v['besttime']/1000))
    end
    guiSetText(TUTIEMPO,mejortime)
end
addEvent("AlimentarTabla",true)
addEventHandler("AlimentarTabla",root,alimentarTabla)

function triggerStart()
    closeMenuClient()
    triggerServerEvent("startMinigameServer",localPlayer,localPlayer,RaceInDuty)
    setWorldSpecialPropertyEnabled("aircars", false )
end

function choquesHandler()
    starttime=starttime-2000
    outputChatBox("#870000[#F18E8ECVRContrareloj#870000]#FFFFFFSe te han añadido dos segundos de penalización por chocarte",255,0,0,true) 
end

function createAntiChoques(veh)
    addEventHandler("onClientVehicleDamage",veh,choquesHandler)
    setWorldSpecialPropertyEnabled("aircars", false )
    setGameSpeed(1)
    car=veh
end
addEvent("activarAntiChoque",true)
addEventHandler("activarAntiChoque",root,createAntiChoques)

function openMenuClient(races)
	guiSetVisible(CONTRARELOGSCVR, true)
    showCursor(true)
    RaceInDuty=races
end
addEvent("openClientMenu",true)
addEventHandler("openClientMenu",root,openMenuClient)

function closeMenuClient()
    guiSetVisible(CONTRARELOGSCVR, false)
    showCursor(false)
end


addEventHandler ( "onClientGUIClick", COMENZAR, triggerStart, false )
addEventHandler ( "onClientGUIClick", SALIR, closeMenuClient, false )

function startRace(race)
    createCheckPoints(race)
    addEventHandler("onClientRender", root, createDisplay)
    starttime=getTickCount()
end

function createDisplay()
    time=getTickCount()-starttime
    local tiempodesc = secondsToTimeDesc(time/1000)
    dxDrawRectangle(screenW * 0.8067, screenH * 0.6927, screenW * 0.1786, screenH * 0.1393, tocolor(1, 0, 0, 191), false)
    dxDrawText("Tiempo actual", screenW * 0.8126, screenH * 0.7057, screenW * 0.9780, screenH * 0.7292, tocolor(36, 235, 15, 185), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawText(tiempodesc, screenW * 0.8126, screenH * 0.7357, screenW * 0.9780, screenH * 0.7591, tocolor(255, 255, 255, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawText("Mejor tiempo", screenW * 0.8126, screenH * 0.7656, screenW * 0.9780, screenH * 0.7891, tocolor(36, 235, 15, 185), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawText(besttimedesc, screenW * 0.8126, screenH * 0.7956, screenW * 0.9780, screenH * 0.8190, tocolor(254, 254, 254, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
end



local coords={}

coords['Bigear']={
    {-300.26, 1395.59, 71.87},
    {-366.26, 1464.06, 62.73},
    {-326.46, 1316.04, 52.24},
    {-440.12, 1635.85, 35.03},
    {-407.75, 1918.39, 57.37},
    {-445.74, 1757.81, 71.58},
    {-387.3, 2078.54, 60.57},
    {-529.56, 1999.83, 59.7},
    {-882.47, 1965.21, 59.7},
    {-881.21, 1796.44, 59.65},
    {-1207.81, 1799.63, 41.11}
    }

coords['Akina']={
    {-3370.81, 804.17, 318.94},
    {-3527.24, 786.07, 313.45},
    {-3359.91, 642.75, 305.79},
    {-3390.89, 542.41, 301.21},
    {-3412.37, 647.93, 295.68},
    {-3534.2, 703.9, 288.81},
    {-3556.32, 772.61, 285.92},
    {-3580.06, 702.67, 283.32},
    {-3564.16, 660.09, 280.92},
    {-3630.48, 524.93, 275.6},
    {-3485.76, 483.41, 268.44},
    {-3582.06, 458.5, 262.58},
    {-3476.46, 430.6, 259.23},
    {-3294.05, 187.18, 244.81},
    {-3256.99, 254.34, 240.74},
    {-3258.7, 316.74, 238.75},
    {-3327.75, 344.69, 236.73},
    {-3371.87, 409.68, 234.37},
    {-3418.42, 429.63, 233.22},
    {-3456.72, 522.29, 228.69},
    {-3557.28, 539.56, 222.55},
    {-3495.7, 574.05, 219.94},
    {-3292.06, 416.51, 210.46},
    {-3042.65, 365.64, 196.82},
    {-3100.39, 401.84, 177.63},
    {-3244.4, 444.43, 157.88},
    {-3338.3, 607.74, 136.64},
    {-3301.69, 563.39, 129.38},
    {-3321.94, 628.06, 121.41},
    {-3265.42, 579.56, 114.51},
    {-3266.85, 756.75, 100.1},
    {-3250.6, 694.3, 94.28},
    {-3169.71, 791.4, 82.52},
    {-3241.93, 922.87, 66.98},
    {-3035.96, 675.54, 41.88},
    {-3167.9, 581.11, 31.96},
    {-3116.32, 449.53, 18.08},
    {-2942.78, 478.91, 4.44}
    }
coords['Hotel']={
    {2037.45, 1778.63, 10.19},
    {2086.97, 1860.75, 10.2},
    {2054.59, 1918.55, 11.69},
    {2095.3, 1972.64, 10.21},
    {2025.04, 2002.53, 10.19},
    {1940.86, 1980.98, 7.11},
    {1859.52, 1993.5, 7.11},
    {1908.17, 2010.48, 13.3},
    {1861.66, 1999.52, 13.3},
    {1909.87, 1952.76, 13.3},
    {1860.84, 1944.66, 13.3},
    {1909.3, 1945.18, 7.11},
    {1860.83, 1878.64, 9.1},
    {1877.03, 1805.78, 12.26},
    {1928.82, 1805.72, 12.23},
    {1880.98, 1805.54, 18.45},
    {1928.38, 1806.53, 18.42},
    {1960.48, 1788.61, 18.45},
    {1915.03, 1774.25, 18.45},
    {1960.81, 1756.73, 18.45},
    {2009.28, 1739.63, 18.45},
    {1913.76, 1738.62, 18.42},
    {1964.95, 1747.53, 12.26},
    {2010.9, 1739.79, 12.26},
    {1963.06, 1731.13, 12.26},
    {1913.2, 1746.02, 12.23},
    {1952.57, 1764.66, 12.23}
    }
    
function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

local index = 1
local markers = {}
markers['Akina']={}
markers['Bigear']={}
markers['Hotel']={}


function endRace(race)
    index=1
    removeEventHandler("onClientRender", root, createDisplay)
    triggerServerEvent("serverWin",localPlayer,localPlayer,time,besttime,race)
end

function endForcedRace()
    removeEventHandler("onClientRender", root, createDisplay)
    for k,v in pairs(markers) do 
        for k2,v2 in pairs(v) do
            destroyElement(v2)
        end
    end
    markers={}
    markers['Akina']={}
    markers['Bigear']={}
    markers['Hotel']={}
    index=1
end
addEvent("ForceEnd",true)
addEventHandler("ForceEnd",root,endForcedRace)    

function markerHitHandler(hitPlayer,matchingDimension)
    if hitPlayer == localPlayer then
        local race=getElementData(source,"Race")
        removeEventHandler("onClientMarkerHit",markers[race][index],markerHitHandler)
        destroyElement(markers[race][index])
        markers[race][index]=nil
        if index==table.size(coords[race]) then
            endRace(race) 
        else
            index=index+1
            createCheckPoints(race)
        end        
    end
end

function getGreatestTime(greatestTime)
    besttime=tonumber(greatestTime)
    besttimedesc=secondsToTimeDesc(tonumber(greatestTime)/1000)
end
addEvent("sendGreatestTime",true)
addEventHandler("sendGreatestTime",root,getGreatestTime)   

function createCheckPoints(race)
    local x,y,z = coords[race][index][1],coords[race][index][2],coords[race][index][3]
    markers[race][index]=createMarker(x,y,z,"checkpoint",6,255,0,0,150)
    setElementData(markers[race][index],"Race",race,false)
    addEventHandler("onClientMarkerHit",markers[race][index],markerHitHandler)
end
addEvent("CreateClientCheckpoints",true)
addEventHandler("CreateClientCheckpoints",root,startRace)    