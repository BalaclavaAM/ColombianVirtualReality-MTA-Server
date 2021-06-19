local track = {
    {2042.46, 1785.62, 10.19},
    {2055.4, 1918.98, 11.68},
    {2097.61, 1971.54, 10.25},
    {2044.08, 2002.06, 10.19},
    {1949.09, 1991.85, 7.11},
    {1859.94, 2001.62, 7.11},
    {1906.57, 2008.68, 13.3},
    {1860.5, 2013.38, 13.3},
    {1909.04, 1952.98, 13.3},
    {1860.26, 1944.99, 13.3},
    {1909.27, 1944.68, 7.11},
    {1859.64, 1928.19, 7.15},
    {1870.33, 1800.05, 12.19},
    {1928.4, 1805.52, 12.23},
    {1877.66, 1805.1, 18.45},
    {1960.03, 1788.59, 18.45},
    {1914.07, 1773.74, 18.45},
    {2009.55, 1739.09, 18.45},
    {1913.79, 1737.81, 18.42},
    {2008.26, 1740.6, 12.26},
    {1911.7, 1746.95, 12.23},
    {1999.55, 1768.15, 10.19}
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
	else
		track8TrackBlip = createBlip ( x, y, z, 0, 3, 0, 255, 0 )
		track8TrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
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
