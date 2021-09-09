local track = {
    ['bigear']={
    {-309.21, 1394.59, 72.27},
    {-360.28, 1466.01, 63.79},
    {-323.62, 1317.04, 53.02},
    {-430.57, 1459.81, 34.49},
    {-455.85, 1570.67, 36.65},
    {-410.32, 1697.06, 39.69},
    {-375.07, 1803.07, 48.72},
    {-404.44, 1919.04, 57.94},
    {-445.16, 1760.75, 72.03},
    {-469.25, 1864.73, 81.98},
    {-471.9, 1943.35, 86.08},
    {-384.09, 2077.76, 60.89},
    {-455.63, 2028.39, 60.52},
    {-571.09, 2021.82, 60.38},
    {-695.69, 2063.77, 60.38},
    {-841.68, 2020.71, 60.38},
    {-883.43, 1969.07, 60.19},
    {-857.04, 1818.61, 60.19},
    {-945.08, 1806.26, 60.57},
    {-1013.42, 1856.63, 62.31},
    {-1203.87, 1822.82, 41.72},
    {-1112.05, 1807.67, 43.11},
    {-1035.72, 1851.67, 58.83},
    {-918.71, 1791.79, 60.17},
    {-856, 1821.49, 60.19},
    {-883.34, 1968.86, 60.19},
    {-788.28, 2047.22, 60.38},
    {-629.64, 2051.38, 60.38},
    {-502.68, 1985.58, 60.19},
    {-389.61, 2081.26, 61.15},
    {-477.3, 1936.25, 86.38},
    {-454.89, 1758.66, 72.14},
    {-409.34, 1918.3, 57.8},
    {-376.47, 1797.33, 48.28},
    {-410.6, 1691.77, 39.22},
    {-455.52, 1564.51, 36.79},
    {-441.4, 1459.55, 34.02},
    {-326.72, 1316.45, 52.69},
    {-374.5, 1461.54, 62.19},
    {-304.85, 1395.15, 72.32},
    {-302.49, 1511.09, 75.36}},

    ['tsan']={{2139.8, -2636.13, 982.33}, {2291.8, -2633.2, 967.65}, {2361.33, -2555.19, 960.65}, {2604.61, -2493.95, 946.61}, {2366.06, -2517.67, 930.46}, {2309.93, -2481.82, 927.98}, {2248, -2534.78, 924.69}, {2132, -2532.13, 921.07}, {2090.88, -2477.51, 920.76}, {2161.54, -2511.35, 907.0699999999999}, {2231.08, -2482.81, 898.76}, {2244.42, -2389.47, 889.19}, {2372.56, -2394.02, 877.03}, {2401.11, -2272.09, 865.46}, {2422.03, -2231.35, 861.8399999999999}, {2440.5, -2056.69, 849.8}, {2560.07, -1987.85, 846.77}, {2507.76, -1897.91, 842.3199999999999}, {2527.26, -1982.46, 836.3}, {2417.29, -2018.55, 828.81}, {2376.7, -2193.89, 819.6700000000001}, {2217.85, -2160.91, 806.5699999999999}, {2094.47, -2086.69, 799.9}, {1998.66, -2006.63, 789.46}, {2245.38, -2074.13, 765.89}, {2123.34, -2039.86, 757.46}, {2043.62, -1934.41, 750.3299999999999}, {2092.4, -1993.23, 742.9300000000001}, {2324.11, -1898.09, 729.0799999999999}, {2315.15, -1859.63, 726.31}, {2279.67, -1908.03, 722.87}, {2167.44, -1931.16, 713.25}, {2097.25, -1840.62, 704.85}, {2141.34, -1881.67, 701.4200000000001}, {2161.79, -1855.54, 698.88}, {2105.31, -1790.13, 693.45}, {2047.13, -1535.54, 674.63}, {2043.15, -1467.57, 668.98}, {2119.54, -1526.92, 662.62}, {2139.45, -1578.69, 659.9200000000001}, {2161.29, -1551.72, 658.13}, {2107.69, -1398.3, 645.7}, {2021.39, -1317.79, 636.37}, {1995.73, -1219.33, 628.26}, {1943.86, -1129.96, 622.45}, {2059.7, -1226.15, 611.58}, {1969.26, -1036.4, 601.74}, {2058.76, -1109.48, 596.23}, {2080.84, -914.32, 589.26}, {2109.12, -772.18, 583.09}, {2081.22, -642.1, 575.53}}
}
local Race = ""

addEvent('onClientPlayerStartRace',true)
addEvent('onRaceEnded',true)

addEvent ( "CreateClientCheckpoints", true )
addEventHandler ( "CreateClientCheckpoints", root, function ( f, d, race )
    local vehiclePlayer = getPedOccupiedVehicle(localPlayer)
    for i,v in pairs(getElementsByType("vehicle")) do
        if isElement(v) and isElement(vehiclePlayer) then
            setElementCollidableWith(v, vehiclePlayer, false)
        end
    end
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
        Race = race
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
		track8Race_LoadMarkerId ( 1 )
	else
		if ( isElement ( track8TrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
			destroyElement ( track8TrackMarker )
			destroyElement ( track8TrackBlip )
		end
	end
end )


function track8Race_LoadMarkerId ( i, isWin )
	if ( isElement ( track8TrackMarker ) ) then
        removeEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
        local vehiclePlayer = getPedOccupiedVehicle(localPlayer)
        for i,v in pairs(getElementsByType("vehicle")) do
            setElementCollidableWith(v, vehiclePlayer, false)
        end
		destroyElement ( track8TrackMarker )
		destroyElement ( track8TrackBlip )
	end
	local x, y, z = track[Race][i][1], track[Race][i][2], track[Race][i][3]
	if ( not isWin ) then
		track8TrackBlip = createBlip ( x, y, z, 0, 3, 255, 255, 0 )
		track8TrackMarker = createMarker ( x, y, z, "checkpoint", 9, 255, 255, 0, 120 )
	else
		track8TrackBlip = createBlip ( x, y, z, 0, 3, 0, 255, 0 )
		track8TrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
	end
	
	setElementDimension ( track8TrackMarker, RaceDimension )
	setElementDimension ( track8TrackBlip, RaceDimension )
	addEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
end

function Ontrack8RaceMarkerHit ( p )
    local vehiclePlayer = getPedOccupiedVehicle(localPlayer)
    for i,v in pairs(getElementsByType("vehicle")) do
        setElementCollidableWith(v, vehiclePlayer, false)
    end
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track[Race] ) then
			ThisPlayerWinsRace ( )
			return
		end
		track8Race_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track[Race] )
	end
end 

function ThisPlayerWinsRace  ( )
    local vehiclePlayer = getPedOccupiedVehicle(localPlayer)
    for i,v in pairs(getElementsByType("vehicle")) do
        setElementCollidableWith(v, vehiclePlayer, false)
    end
    triggerServerEvent ( "raceWin", localPlayer )
end
addEvent ( "forcedWin", true )
addEventHandler("forcedWin",root,ThisPlayerWinsRace)
addEventHandler('onClientPlayerStartRace',root,
    function()
        g_currentRace = true
    end
)

addEventHandler('onRaceEnded',root,
    function()
        g_currentRace = nil
    end
)

local screenX,screenY = guiGetScreenSize()
local guiX,guiY = screenX/1280,screenY/720


addEvent(getResourceName(getThisResource())..":sendTimerToClient",true)
addEventHandler(getResourceName(getThisResource())..":sendTimerToClient",root,
    function(remaining)
        local remaining = remaining/1000
        if remaining then
            c_Remaining = remaining
            c_raceTimer = setTimer(function()
                remaining = remaining-1
                c_Remaining = remaining
                if remaining <= 0 then
                    if isTimer(c_raceTimer) then
                        killTimer(c_raceTimer)
                    end
                end
            end,1000,0)
        end
    end
)

addEventHandler("onClientRender", root,
    function()
        if c_raceTimer and isTimer(c_raceTimer) then
            local remaining = c_Remaining
            if remaining then
                local newTime = math.ceil(remaining)
                dxDrawText("El touge comienza en..", guiX*494, guiY*332, guiX*786, guiY*390, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
                dxDrawText(remaining, guiX*494, guiY*389, guiX*786, guiY*419, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
            end
        end
    end
)
