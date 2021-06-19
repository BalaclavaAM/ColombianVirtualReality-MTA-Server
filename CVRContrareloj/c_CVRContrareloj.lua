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
guiGridListAddColumn(COLUMNAS, "#", 0.1)
guiGridListAddColumn(COLUMNAS, "Usuario", 0.3)
guiGridListAddColumn(COLUMNAS, "Tiempo", 0.3)
guiGridListAddColumn(COLUMNAS, "Club", 0.3)

local TUTIEMPO = guiCreateLabel(0.26, 0.75, 0.50, 0.08, "", true, CONTRARELOGSCVR)
local clubbest = guiCreateLabel(0.26, 0.79, 1, 0.08, "Club dominante: ", true, CONTRARELOGSCVR)


guiSetVisible(CONTRARELOGSCVR, false)

function alimentarTabla(datos,mejortime,club)
    guiGridListClear ( COLUMNAS )
    for k,v in pairs(datos) do
        guiGridListAddRow(COLUMNAS,k,v['Username'],secondsToTimeMinimal(v['besttime']/1000),v['club'])
    end
    guiSetText(clubbest,"Club dominante: "..club)
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
    destroyMarkers()
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

coords['SFRun']={
    {-2019.41, 320.83, 34.53},
    {-1947.37, 346.25, 32.77},
    {-1870.95, 407.48, 16.54},
    {-1816.31, 482.22, 24.1},
    {-1893.03, 605.8, 34.53},
    {-1727, 613.18, 24.26},
    {-1611.19, 663.32, 6.7},
    {-1559.24, 661.08, 6.56},
    {-1560.2, 843.76, 6.55},
    {-1678.1, 845.3, 24.25},
    {-1793.87, 844.71, 24.25},
    {-1796.95, 923.77, 24.26},
    {-2001.25, 924.62, 44.81}
}

coords['HotelSpiral']={
    {2325.06, 1946.4, 28.64},
    {2290.98, 1950, 26.3},
    {2324.47, 1944.71, 22.95},
    {2291.03, 1950.29, 20.82},
    {2324.4, 1944.42, 17.43},
    {2289.6, 1950.35, 15.35},
    {2324.77, 1946.18, 12.19},
    {2290.78, 1947.8, 9.87},
    {2225.21, 1984.17, 9.87},
    {2315.33, 1995.32, 5.06},
    {2319.08, 1906.45, 9.38}
}

coords['Parking']={
    {2323.51, 1413.62, 42.82},
    {2294.14, 1511.49, 42.82},
    {2307.94, 1395.22, 36.42},
    {2307.29, 1511.46, 30.02},
    {2306.89, 1395.93, 23.63},
    {2307.69, 1512.72, 17.22},
    {2306.73, 1401.3, 10.82},
    {2312.33, 1500.94, 10.82}
}

coords['Parking2']={
    {2387.59, 2489.63, 10.82},
    {2434.21, 2447.57, 10.82},
    {2409.41, 2465.07, 10.82},
    {2425.98, 2494.18, 10.82},
    {2419.48, 2477.94, 10.82},
    {2418.27, 2504.87, 10.81},
    {2499.82, 2519.93, 10.82},
    {2430.94, 2541.6, 10.82},
    {2463.46, 2555.17, 10.82},
    {2517.01, 2526.78, 10.82},
    {2517.67, 2479.55, 10.82},
    {2455.4, 2480.15, 21.88},
    {2511.82, 2494.32, 21.88},
    {2509.77, 2522.21, 21.88},
    {2508.02, 2497.81, 21.88},
    {2497.16, 2539.79, 21.88},
    {2427.24, 2537.24, 21.88},
    {2426.29, 2561.32, 21.88},
    {2458.01, 2539.76, 21.88},
    {2491.45, 2517.91, 21.88},
    {2457.47, 2486.72, 21.88},
    {2518.71, 2478.02, 10.82},
    {2521.55, 2522.27, 10.82},
    {2478.28, 2548.99, 10.82},
    {2428.82, 2547.78, 10.82},
    {2459.38, 2534.92, 10.82},
    {2497.98, 2524.58, 10.82},
    {2458.7, 2513.28, 10.78},
    {2406.36, 2513.29, 10.69},
    {2387.28, 2538.41, 10.67}
}

coords['tsan']={{2139.8, -2636.13, 982.33}, {2291.8, -2633.2, 967.65}, {2361.33, -2555.19, 960.65}, {2604.61, -2493.95, 946.61}, {2366.06, -2517.67, 930.46}, {2309.93, -2481.82, 927.98}, {2248, -2534.78, 924.69}, {2132, -2532.13, 921.07}, {2090.88, -2477.51, 920.76}, {2161.54, -2511.35, 907.0699999999999}, {2231.08, -2482.81, 898.76}, {2244.42, -2389.47, 889.19}, {2372.56, -2394.02, 877.03}, {2401.11, -2272.09, 865.46}, {2422.03, -2231.35, 861.8399999999999}, {2440.5, -2056.69, 849.8}, {2560.07, -1987.85, 846.77}, {2507.76, -1897.91, 842.3199999999999}, {2527.26, -1982.46, 836.3}, {2417.29, -2018.55, 828.81}, {2376.7, -2193.89, 819.6700000000001}, {2217.85, -2160.91, 806.5699999999999}, {2094.47, -2086.69, 799.9}, {1998.66, -2006.63, 789.46}, {2245.38, -2074.13, 765.89}, {2123.34, -2039.86, 757.46}, {2043.62, -1934.41, 750.3299999999999}, {2092.4, -1993.23, 742.9300000000001}, {2324.11, -1898.09, 729.0799999999999}, {2315.15, -1859.63, 726.31}, {2279.67, -1908.03, 722.87}, {2167.44, -1931.16, 713.25}, {2097.25, -1840.62, 704.85}, {2141.34, -1881.67, 701.4200000000001}, {2161.79, -1855.54, 698.88}, {2105.31, -1790.13, 693.45}, {2047.13, -1535.54, 674.63}, {2043.15, -1467.57, 668.98}, {2119.54, -1526.92, 662.62}, {2139.45, -1578.69, 659.9200000000001}, {2161.29, -1551.72, 658.13}, {2107.69, -1398.3, 645.7}, {2021.39, -1317.79, 636.37}, {1995.73, -1219.33, 628.26}, {1943.86, -1129.96, 622.45}, {2059.7, -1226.15, 611.58}, {1969.26, -1036.4, 601.74}, {2058.76, -1109.48, 596.23}, {2080.84, -914.32, 589.26}, {2109.12, -772.18, 583.09}, {2081.22, -642.1, 575.53}}
    
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
markers['SFRun']={}
markers['HotelSpiral']={}
markers['Parking']={}
markers['Parking2']={}
markers['tsan']={}


function endRace(race)
    index=1
    removeEventHandler("onClientRender", root, createDisplay)
    triggerServerEvent("serverWin",localPlayer,localPlayer,time,besttime,race)
end

function destroyMarkers()
    for k,v in pairs(markers) do
        for k2,v2 in pairs(v) do
            markers[k][k2]=nil
            destroyElement(v2)
        end
    end
    index = 1
end

function endForcedRace()
    removeEventHandler("onClientRender", root, createDisplay)
    destroyMarkers()
    markers={}
    markers['Akina']={}
    markers['Bigear']={}
    markers['Hotel']={}
    markers['SFRun']={}
    markers['HotelSpiral']={}
    markers['Parking']={}
    markers['tsan']={}
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