local track = {
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
    {-302.49, 1511.09, 75.36}
}

addEvent('onClientPlayerStartRace',true)
addEvent('onRaceEnded',true)

addEvent ( "CreateClientCheckpoints", true )
addEventHandler ( "CreateClientCheckpoints", root, function ( f, d )
    local vehiclePlayer = getPedOccupiedVehicle(localPlayer)
    for i,v in pairs(getElementsByType("vehicle")) do
        setElementCollidableWith(v, vehiclePlayer, false)
    end
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
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
	local x, y, z = track[i][1], track[i][2], track[i][3]
	if ( not isWin ) then
		track8TrackBlip = createBlip ( x, y, z, 0, 3, 255, 255, 0 )
		track8TrackMarker = createMarker ( x, y, z, "checkpoint", 9, 255, 255, 0, 120 )
        setElementDimension(track8TrackMarker,20)
	else
		track8TrackBlip = createBlip ( x, y, z, 0, 3, 0, 255, 0 )
		track8TrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
        setElementDimension(track8TrackMarker,20)
	end
	
	setElementDimension ( track8TrackMarker, RaceDimension )
	setElementDimension ( track8TrackBlip, RaceDimension )
	setElementInterior(track8TrackMarker,7)
	setElementInterior(track8TrackBlip,7)
	addEventHandler ( "onClientMarkerHit", track8TrackMarker, Ontrack8RaceMarkerHit )
end

function Ontrack8RaceMarkerHit ( p )
    local vehiclePlayer = getPedOccupiedVehicle(localPlayer)
    for i,v in pairs(getElementsByType("vehicle")) do
        setElementCollidableWith(v, vehiclePlayer, false)
    end
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		track8Race_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
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
