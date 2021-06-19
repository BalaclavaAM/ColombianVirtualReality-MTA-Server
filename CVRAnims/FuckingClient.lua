--------------------------------------------------------------------------------------------------------------------------------------------------------------
local screenH, screenW = guiGetScreenSize()
local x, y = (screenH/1024), (screenW/768)
local fount = dxCreateFont("font.ttf", 15)
MainMenu = false
DanceMenu = false
GangMenu = false
DjMenu = false
PervertMenu = false
StripMenu = false
RiotMenu = false
MiscMenu = false
local colLV = createColRectangle(866,480,2300,2800)
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--233 (I NEED THIS NUMBER, DONT TOUCH IT) *-* @Element
function part1()		
        dxDrawImage(x*842, y*339, x*125, y*117, ":AUR_Animations/logo.png", 0, 0, 0, tocolor(241, 0, 130, 255), false)
        dxDrawRectangle(x*804, y*484, x*206, y*270, tocolor(51,0,51, 122), false)
        dxDrawRectangle(x*804, y*456, x*206, y*28, tocolor(0, 0, 0, 122), false)
        dxDrawText("AUR Animations System", x*824, y*685, x*1010, y*253, tocolor(90,0,90, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("1 - Dance Animations", x*824, y*727, x*1010, y*291, tocolor(255, 255, 255, 255), x*00.55, fount, "left", "center", false, false, false, false, false)
        dxDrawText("2 - Gang Animations", x*824, y*755, x*1010, y*319, tocolor(255, 255, 255, 255), x*00.55, fount, "left", "center", false, false, false, false, false)
        dxDrawText("3 - DJ Animations", x*824, y*783, x*1010, y*347, tocolor(255, 255, 255, 255), x*00.55, fount, "left", "center", false, false, false, false, false)
        dxDrawText("4 - Pervert Animations", x*824, y*811	, x*1010, y*375, tocolor(255, 255, 255, 255), x*00.55, fount, "left", "center", false, false, false, false, false)
        dxDrawText("5 - Strip Animations", x*824, y*839, x*1010, y*403, tocolor(255, 255, 255, 255), x*00.55, fount, "left", "center", false, false, false, false, false)
        dxDrawText("6 - Riot Animations", x*824, y*868, x*1010, y*431, tocolor(255, 255, 255, 255), x*00.55, fount, "left", "center", false, false, false, false, false)
        dxDrawText("7 - Custom Animations", x*824, y*895, x*1010, y*459, tocolor(255, 255, 255, 255), x*00.55, fount, "left", "center", false, false, false, false, false)
        dxDrawText("/stopanim or shift to stop animation", x*804, y*939, x*1010, y*503, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
end

function part2()
        dxDrawRectangle(x*593, y*456, x*206, y*299, tocolor(51,0,51, 122), false)
        dxDrawText("Dance Animations", x*593, y*685, x*790, y*247, tocolor(255,0,0, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_1 : Dance 1", x*593, y*727, x*790, y*300, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_2 : Dance 2", x*593, y*755, x*790, y*333, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_3 : Dance 3", x*593, y*783, x*790, y*366, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_4 : Dance 4", x*593, y*811, x*790, y*399, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_5 : Dance 5", x*593, y*839, x*790, y*432, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_5 : Dance 6", x*593, y*867, x*790, y*465, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_5 : Dance 7", x*593, y*895, x*790, y*498, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
		end

function Dance1 (button, _)
    if DanceMenu then
        if button == "num_1" then
               triggerServerEvent ("Dance1", getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, Dance1)
function Dance2 (button, _)
    if DanceMenu then
      if button == "num_2" then
               triggerServerEvent ("Dance2", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Dance2)
function Dance3 (button, _)
    if DanceMenu then
      if button == "num_3" then
               triggerServerEvent ("Dance3", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Dance3)
function Dance4 (button, _)
    if DanceMenu then
              if button == "num_4" then
               triggerServerEvent ("Dance4", getLocalPlayer())

    end
end
end
addEventHandler("onClientKey", root, Dance4)
function Dance5 (button, _)
    if DanceMenu then
              if button == "num_5" then
               triggerServerEvent ("Dance5", getLocalPlayer())

    end
end
end
addEventHandler("onClientKey", root, Dance5)

function part3()
        dxDrawRectangle(x*593, y*456, x*206, y*299, tocolor(51,0,51, 122), false)
        dxDrawText("Gang Animations", x*593, y*685, x*790, y*247, tocolor(255, 0, 0, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_1 : Gang Deal", x*593, y*727, x*790, y*300, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_2 : Gang Idle", x*593, y*755, x*790, y*333, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_3 : Gang Shake", x*593, y*783, x*790, y*366, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_4 : Gang Refuse", x*593, y*811, x*790, y*399, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_5 : Gang Sign 1", x*593, y*839, x*790, y*432, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_6 : Gang Sign 2", x*593, y*867, x*790, y*465, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_7 : Gang Sign 3", x*593, y*895, x*790, y*498, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
end
function Gang1 (button, _)
    if GangMenu then
        if button == "num_1" then
               triggerServerEvent ("Gang1", getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, Gang1)
function Gang2 (button, _)
    if GangMenu then
        if button == "num_2" then
               triggerServerEvent ("Gang2", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Gang2)
function Gang3 (button, _)
    if GangMenu then
        if button == "num_3" then
               triggerServerEvent ("Gang3", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Gang3)
function Gang4 (button, _)
    if GangMenu then
        if button == "num_4" then
               triggerServerEvent ("Gang4", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Gang4)
function Gang5 (button, _)
    if GangMenu then
        if button == "num_5" then
               triggerServerEvent ("Gang5", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Gang5)
function Gang6 (button, _)
    if GangMenu then
        if button == "num_6" then
               triggerServerEvent ("Gang6", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Gang6)
function Gang7 (button, _)
    if GangMenu then
        if button == "num_7" then
               triggerServerEvent ("Gang7", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, Gang7)
function part4()
        dxDrawRectangle(x*593, y*456, x*206, y*299, tocolor(51,0,51, 122), false)
        dxDrawText("DJ Animations", x*593, y*685, x*790, y*247, tocolor(255, 0, 0, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_1 : DJ 1 ", x*593, y*727, x*790, y*300, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_2 : DJ 2", x*593, y*755, x*790, y*333, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_3 : DJ 3", x*593, y*783, x*790, y*366, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_4 : DJ 4", x*593, y*811, x*790, y*399, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_5 : DJ 5", x*593, y*839, x*790, y*432, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_6 : DJ 6", x*593, y*867, x*790, y*465, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_7 : DJ 7", x*593, y*895, x*790, y*498, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
end

function dj1 (button, _)
    if DjMenu then
        if button == "num_1" then
               triggerServerEvent ("dj1", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, dj1)

function dj2 (button, _)
    if DjMenu then
       if button == "num_2" then
               triggerServerEvent ("dj2", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, dj2)

function dj3 (button, _)
    if DjMenu then
        if button == "num_3" then
               triggerServerEvent ("dj3", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, dj3)

function dj4 (button, _)
    if DjMenu then
        if button == "num_4" then
               triggerServerEvent ("dj4", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, dj4)

function dj5 (button, _)
    if DjMenu then
        if button == "num_5" then
               triggerServerEvent ("dj5", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, dj5)

function dj6 (button, _)
    if DjMenu then
        if button == "num_6" then
               triggerServerEvent ("dj6", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, dj6)

function dj7 (button, _)
    if DjMenu then
        if button == "num_7" then
               triggerServerEvent ("dj7", getLocalPlayer())
            end
        end
    end
addEventHandler("onClientKey", root, dj7)


function part5()
        dxDrawRectangle(x*593, y*456, x*206, y*299, tocolor(51,0,51, 122), false)
        dxDrawText("Pervert Animations", x*593, y*685, x*790, y*247, tocolor(255, 0, 0, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_1 : +18 ", x*593, y*727, x*790, y*300, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_2 : +18", x*593, y*755, x*790, y*333, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_3 : +18", x*593, y*783, x*790, y*366, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
end

function sex1 (button, _)
    if PervertMenu then
        if button == "num_1" then
               triggerServerEvent ("sex1", getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, sex1)
function sex2 (button, _)
    if PervertMenu then
        if button == "num_2" then
               triggerServerEvent ("sex2", getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, sex2)

function sex3 (button, _)
    if PervertMenu then
        if button == "num_3" then
               triggerServerEvent ("sex3", getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, sex3)
function part6()
        dxDrawRectangle(x*593, y*456, x*206, y*299, tocolor(51,0,51, 122), false)
		dxDrawText("Stripping Animations", x*593, y*685, x*790, y*247, tocolor(255, 0, 0, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_1 : Strip: 1 ", x*593, y*727, x*790, y*300, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_2 : Strip: 2", x*593, y*755, x*790, y*333, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_3 : Strip: 3", x*593, y*783, x*790, y*366, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_4 : Strip: 4", x*593, y*811, x*790, y*399, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)

end
function strip1 (button, _)
    if StripMenu then
        if button == "num_1" then
               triggerServerEvent ("strip1", getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, strip1)
function strip2 (_,state)
    if StripMenu then
        if button == "num_2" then
               triggerServerEvent ("strip2", getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, strip2)
function strip3 (_,state)
    if StripMenu then
        if state == "down" then
            if isCursorOnElement (x*593, y*333, x*197, y*33) then
               triggerServerEvent ("strip3", getLocalPlayer())
            end
        end
    end
end
addEventHandler ("onClientClick", root, strip3)
function strip4 (_,state)
    if StripMenu then
        if state == "down" then
            if isCursorOnElement (x*593, y*366, x*197, y*33) then
               triggerServerEvent ("strip4", getLocalPlayer())
            end
        end
    end
end
addEventHandler ("onClientClick", root, strip4)

function part7()
        dxDrawRectangle(x*593, y*456, x*206, y*299, tocolor(51,0,51, 122), false)
        dxDrawText("Riot Animations", x*593, y*685, x*790, y*247, tocolor(255, 0, 0, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_1 : Riot Punches ", x*593, y*727, x*790, y*300, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_2 : Riot Shout", x*593, y*755, x*790, y*333, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_3 : Riot Chant", x*593, y*783, x*790, y*366, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
        dxDrawText("Num_4 : Riot Challenge", x*593, y*811, x*790, y*399, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
end

function part8()
        dxDrawRectangle(x*593, y*456, x*206, y*299, tocolor(51,0,51, 122), false)
        dxDrawText("Soon... ", x*593, y*727, x*790, y*300, tocolor(255, 255, 255, 255), x*00.55, fount, "center", "center", false, false, false, false, false)
end


function painelClickPartes(button, press)
     local player = getLocalPlayer()
     if not getPedOccupiedVehicle ( player ) then
	if MainMenu == true and DanceMenu == false then
		if button == "1" then	
            MainMenu = true
            DanceMenu = true
            GangMenu = false
            DjMenu = false
            PervertMenu = false
            StripMenu = false
            RiotMenu = false
            MiscMenu = false
			playSound( "gfx/button.mp3")
			addEventHandler ("onClientRender", root, part2)
			removeEventHandler ("onClientRender", root, part3)
			removeEventHandler ("onClientRender", root, part4)
			removeEventHandler ("onClientRender", root, part5)
			removeEventHandler ("onClientRender", root, part6)
			removeEventHandler ("onClientRender", root, part8)
			removeEventHandler ("onClientRender", root, part7)			
			end
		end
	end
	if MainMenu == true and GangMenu == false then
			if button == "2" then
            tick32 = getTickCount()		
            MainMenu = true
            DanceMenu = false
            GangMenu = true
            DjMenu = false
            PervertMenu = false
            StripMenu = false
            RiotMenu = false
            MiscMenu = false
			playSound( "gfx/button.mp3")

			addEventHandler ("onClientRender", root, part3)
			removeEventHandler ("onClientRender", root, part2)
			removeEventHandler ("onClientRender", root, part4)
			removeEventHandler ("onClientRender", root, part5)
			removeEventHandler ("onClientRender", root, part6)
			removeEventHandler ("onClientRender", root, part8)
			removeEventHandler ("onClientRender", root, part7)			
		end
	end		
	if MainMenu == true and DjMenu == false then
		if button == "3" then
             tick32 = getTickCount()		
            MainMenu = true
            DanceMenu = false
            GangMenu = false
            DjMenu = true
            PervertMenu = false
            StripMenu = false
            RiotMenu = false
            MiscMenu = false
			playSound( "gfx/button.mp3")

			addEventHandler ("onClientRender", root, part4)
			removeEventHandler ("onClientRender", root, part2)
			removeEventHandler ("onClientRender", root, part3)
			removeEventHandler ("onClientRender", root, part5)
			removeEventHandler ("onClientRender", root, part6)
			removeEventHandler ("onClientRender", root, part8)
			removeEventHandler ("onClientRender", root, part7)	
		end
	end	
	if MainMenu == true and PervertMenu == false then
		if button == "4" then	
            tick32 = getTickCount()		
            MainMenu = true
            DanceMenu = false
            GangMenu = false
            DjMenu = false
            PervertMenu = true
            StripMenu = false
            RiotMenu = false
            MiscMenu = false
			playSound( "gfx/button.mp3")
			addEventHandler ("onClientRender", root, part5)
			removeEventHandler ("onClientRender", root, part2)
			removeEventHandler ("onClientRender", root, part3)
			removeEventHandler ("onClientRender", root, part4)
			removeEventHandler ("onClientRender", root, part6)
			removeEventHandler ("onClientRender", root, part8)
			removeEventHandler ("onClientRender", root, part7)			
	    end
	end
    if MainMenu == true and StripMenu == false then
		if button == "5" then
            tick32 = getTickCount()		
            MainMenu = true
            DanceMenu = false
            GangMenu = false
            DjMenu = false
            PervertMenu = false
            StripMenu = true
            RiotMenu = false
            MiscMenu = false
			playSound( "gfx/button.mp3")			
			addEventHandler ("onClientRender", root, part6)
			removeEventHandler ("onClientRender", root, part2)
			removeEventHandler ("onClientRender", root, part3)
			removeEventHandler ("onClientRender", root, part4)
			removeEventHandler ("onClientRender", root, part5)
		    removeEventHandler ("onClientRender", root, part8)
			removeEventHandler ("onClientRender", root, part7)
	     end
	end
	if MainMenu == true and RiotMenu == false then
		if button == "6" then
            tick32 = getTickCount()		
            MainMenu = true
            DanceMenu = false
            GangMenu = false
            DjMenu = false
            PervertMenu = false
            StripMenu = false
            RiotMenu = true
            MiscMenu = false
			playSound( "gfx/button.mp3")			
			addEventHandler ("onClientRender", root, part7)
			removeEventHandler ("onClientRender", root, part2)
			removeEventHandler ("onClientRender", root, part3)
			removeEventHandler ("onClientRender", root, part4)
			removeEventHandler ("onClientRender", root, part5)
			removeEventHandler ("onClientRender", root, part6)
			removeEventHandler ("onClientRender", root, part8)
        end
	end
	if MainMenu == true and MiscMenu == false  then
		if button == "7" then
            tick32 = getTickCount()		
            MainMenu = true
            DanceMenu = false
            GangMenu = false
            DjMenu = false
            PervertMenu = false
            StripMenu = false
            RiotMenu = false
            MiscMenu = true
			playSound( "gfx/button.mp3")			
			addEventHandler ("onClientRender", root, part8)
			removeEventHandler ("onClientRender", root, part2)
			removeEventHandler ("onClientRender", root, part3)
			removeEventHandler ("onClientRender", root, part4)
			removeEventHandler ("onClientRender", root, part5)
			removeEventHandler ("onClientRender", root, part6)
			removeEventHandler ("onClientRender", root, part7)
		end
	end		
end
addEventHandler("onClientKey", getRootElement(), painelClickPartes)

function anim()
local player = getLocalPlayer()
if getPedOccupiedVehicle ( player ) then
outputChatBox ("You can't use animations when u're inside a vehicle.")
else
local detection = isElementWithinColShape ( player, colLV )
if not detection then
if MainMenu == false then
if not fontScale then fontScale = screenW/40 end
    addEventHandler ("onClientRender", root, part1)
    MainMenu = true 
	 tick30 = getTickCount()
	 tick31 = getTickCount()
	 toggleControl ( "aim_weapon", false) 
	 toggleControl ( "fire", false) 
	 toggleControl ( "sprint", false) 
	 toggleControl ( "jump", false) 
	 toggleControl ( "crouch", false) 
	 toggleControl ( "forwards", false) 
	 toggleControl ( "backwards", false) 
	 toggleControl ( "left", false) 
	 toggleControl ( "right", false) 
else
    removeEventHandler ("onClientRender", root, part1)
    removeEventHandler ("onClientRender", root, part2)
    removeEventHandler ("onClientRender", root, part3)
    removeEventHandler ("onClientRender", root, part4)
    removeEventHandler ("onClientRender", root, part5)
    removeEventHandler ("onClientRender", root, part6)
	removeEventHandler ("onClientRender", root, part7)
	removeEventHandler ("onClientRender", root, part8)
    MainMenu = false
    DanceMenu = false
    GangMenu = false
    DjMenu = false
    PervertMenu = false
    StripMenu = false
    RiotMenu = false
    MiscMenu = false
	 toggleControl ( "aim_weapon", true) 
	 toggleControl ( "fire", true) 
	 toggleControl ( "sprint", true) 
	 toggleControl ( "jump", true) 
	 toggleControl ( "crouch", true) 
	 toggleControl ( "forwards", true) 
	 toggleControl ( "backwards", true) 
	 toggleControl ( "left", true) 
	 toggleControl ( "right", true) 
	 end
	 end
    end
end
bindKey("k", "down", anim)

local x,y = guiGetScreenSize()

