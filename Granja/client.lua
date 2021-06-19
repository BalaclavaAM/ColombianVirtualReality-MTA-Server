-- Türkçe Çeviri SparroW --
-- Site : https://sparrow-mta.blogspot.com
-- Discord : https://discord.gg/89V5vN8
-- SparroW İyi Oyunlardiler.
local dxMarker = createMarker(markerT[1],markerT[2],markerT[3]-0.1, "cylinder", 1, 255, 255, 255, 0)
local ped = createPed(skinTractor,markerT[1],markerT[2],markerT[3])
setElementRotation(ped, 0, 0, 90)

addEventHandler( "onClientRender", root, function ()
       local x, y, z = getElementPosition(dxMarker)
       local Mx, My, Mz = getCameraMatrix()
        if (getDistanceBetweenPoints3D(x, y, z, Mx, My, Mz) <= 20) then
           local WorldPositionX, WorldPositionY = getScreenFromWorldPosition(x, y, z +1, 0.07)
            if (WorldPositionX and WorldPositionY) then
			    dxDrawText("Granjero", WorldPositionX - 1, WorldPositionY + 1, WorldPositionX - 1, WorldPositionY + 1, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
			    dxDrawText("Granjero", WorldPositionX - 1, WorldPositionY + 1, WorldPositionX - 1, WorldPositionY + 1, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
            end
      end
end 
)
---------------------------------------------

local markerState = 1
function getMarkerCurrentState ()
    return markerState
end

function updateMarkerCurrentState ()
    markerState = markerState + 1
end

function restoreMarkerCurrentState ()
    markerState = 1
end

function isMarchEnd ()
	if getMarkerCurrentState () >= #tractorMarks then
	    return true
	else
	    return false
	end
end

local markerT = createMarker(markerT[1],markerT[2],markerT[3]-1, "cylinder", 1, 255, 255, 255, 0)
local blip = createBlipAttachedTo(markerT, 25)
setBlipVisibleDistance(blip, 400)

function centerWindow ( center_window )
	local sx, sy = guiGetScreenSize ( )
	local windowW, windowH = guiGetSize ( center_window, false )
	local x, y = ( sx - windowW ) / 2, ( sy - windowH ) / 2
	guiSetPosition ( center_window, x, y, false )
end

local sw,sh = guiGetScreenSize()
local window={}
local label={}
local button={}

wndTra = guiCreateWindow(0,0,400,120,"Profesión de granjero",false)
centerWindow(wndTra)
guiSetVisible(wndTra,false)

labeTra = guiCreateLabel(5,25,390,50," Hola, quiero que conduzcas este campo \nen tractor, ¿puedes?.",false,wndTra)
guiSetFont(labeTra, "default-bold-small")
guiLabelSetHorizontalAlign(labeTra, "center", false)

buttonTra1 = guiCreateButton(10,70,180,35,"...",false,wndTra)
guiSetFont(buttonTra1,"default-bold-small")
guiSetProperty(buttonTra1, "NormalTextColour", "FF00FF00")

buttonTra2 = guiCreateButton(210,70,180,35,"Nokas.",false,wndTra)
guiSetFont(buttonTra2,"default-bold-small")
guiSetProperty(buttonTra2, "NormalTextColour", "FFFF0000")

function createMarkerTractor(player)
    if player == getLocalPlayer() then
        m = tractorMarks[ getMarkerCurrentState () ]
		updateMarkerCurrentState ()
        local marker = createMarker(m[1],m[2],m[3]-1, "corona", 2, 0, 255, 0, 80)
        setElementData(marker,"tractor_mark",true)
        setElementData(player,"tractor_mark",marker)
        local blip = createBlip(m[1],m[2],m[3],41,3)
        setElementData(player,"tractor_blip",blip)
        local obj = createObject(804,m[1],m[2],m[3])
        setObjectScale(obj, 1.0)
        setElementCollisionsEnabled (obj, false)
        setElementData(player,"tractor_obj",obj)
    end
end

function deleteMarkerTractor(player)
    if player == getLocalPlayer() then
        local marker = getElementData(player,"tractor_mark")
        local blip = getElementData(player,"tractor_blip")
        local obj = getElementData(player,"tractor_obj")
        if marker then if isElement(marker) then destroyElement(marker) end end
        if blip then if isElement(blip) then destroyElement(blip) end end
        if obj then if isElement(obj) then destroyElement(obj) end end
    end
end
addEvent("deleteMarkerTractor", true)
addEventHandler("deleteMarkerTractor", getRootElement(), deleteMarkerTractor)

function startClick()
    local player = getLocalPlayer()
    if (source == buttonTra1) then
        guiSetVisible(wndTra,false)
        showCursor(false)
        local state = getElementData(player,"tractor_works")
        if not state then
            triggerServerEvent("start_Tractor",player,player)
            setElementData(player,"tractor_works",0)
            createMarkerTractor(player)
            outputChatBox("#1E90FF[INFORMACIÓN] #FFFFFFHas comenzado, gatea.",255,255,255,true)
            
            setElementData(player,"Консультант_скин_до",getElementModel(player))
            setElementModel(player,158)
            setElementData(player,"tractor_plus",0)
            setElementData(player,"Заработано_Сейчас_Кон",moneyTra)
        else
            triggerServerEvent("stop_Tractor",player,player)
            local hodok = tonumber(state)
            local profit = getElementData(player,"Заработано_Всего_Кон")
            if not profit then profit = 0 end
            
            setElementData(player,"Заработано_Всего_Кон",nil)
            setElementData(player,"Заработано_Сейчас_Кон",nil)
            triggerServerEvent("giveMoneyTractor",player,player,profit)
            setElementData(player,"tractor_works",nil)
            
            setElementModel(player,getElementData(player,"Консультант_скин_до"))
            deleteMarkerTractor(player)
        end
    elseif (source == buttonTra2) then
        guiSetVisible(wndTra,false)
        showCursor(false)
    end
end
addEventHandler("onClientGUIClick", getRootElement(), startClick)

function onClientMarkerHit(player, mdim)
    if player == getLocalPlayer() then
        if mdim then
            local veh = getPedOccupiedVehicle(player)
            local state = getElementData(player,"tractor_works")
            if getElementData(source,"tractor_mark") then
                if veh then
                    setElementData(player,"tractor_plus",tonumber(getElementData(player,"tractor_plus")) + 1)
                    if getElementData(player,"tractor_plus") >= #tractorMarks then
                        restoreMarkerCurrentState ()
                        local pacienty = tonumber(getElementData(player,"tractor_plus"))
                        if pacienty > 0 then
                            setElementData(player,"tractor_works",tonumber(state) + pacienty)
                            setElementData(player,"tractor_plus",0)
                            if not getElementData(player,"Заработано_Всего_Кон") then
                                setElementData(player,"Заработано_Всего_Кон",0)
                            end
                            if not getElementData(player,"Заработано_Сейчас_Кон") then setElementData(player,"Заработано_Сейчас_Кон",0) end
                            setElementData(player,"Заработано_Всего_Кон",getElementData(player,"Заработано_Всего_Кон") + getElementData(player,"Заработано_Сейчас_Кон"))
                            deleteMarkerTractor(player)
                            outputChatBox("#1E90FF[INFORMACIÓN] #FFFFFFGanancias : #00FF00"..getElementData(player,"Заработано_Всего_Кон").." #FFFFFFdinero.",255,255,255,true)
                            outputChatBox("#1E90FF[INFORMACIÓN] #FFFFFFRecibiste tu salario.",255,255,255,true)
                        end
                    else
                        deleteMarkerTractor(player)
                        createMarkerTractor(player)
                    end
                end
            end
        end
    end
end
addEventHandler("onClientMarkerHit", getRootElement(), onClientMarkerHit)

addEventHandler ( "onClientMarkerHit", getRootElement(), function(ply)
	if ply ~= localPlayer then return end
	if source == markerT then
        local state = getElementData(ply,"tractor_works")
        local veh = getPedOccupiedVehicle(ply)
        if not veh then
            guiSetVisible(wndTra,true)
            showCursor(true)
            if not state then
                guiSetText(buttonTra1,"Dejar de LABURAR.")
            else
                guiSetText(buttonTra1,"A LABURAR.")
            end
        end
	end
end)