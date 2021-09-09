Version = "v1.05"
imgPlayer={}
imgDealer={}

function createBJTable(lmin)
        local X = 0
        local Y = 0
        local w,z = guiGetScreenSize()
		if ( w > 640 ) and ( z > 480 ) then
		X = (w-640)/2
		Y = (z-480)/2
		end
		local Width = 640
        local Height = 480
        bjwindow = guiCreateWindow(X, Y, Width, Height, "Black Jack "..Version.."", false)
				
		Y = 0.9
        X = 0.01
        Width = 0.18
        Height = 0.1
        edtMo = guiCreateEdit(X, Y, Width, Height, ""..lmin.."", true, bjwindow)
        guiEditSetMaxLength(edtMo, 8)
		
		--Create Buttons
        Y = 0.9
		X = 0.20
        Width = 0.18
        Height = 0.1
        btnBetMo = guiCreateButton(X, Y, Width, Height, "Apostar", true, bjwindow)
		
		Y = 0.79
		X = 0.01
        Width = 0.18
        Height = 0.1
        btnCard = guiCreateButton(X, Y, Width, Height, "Sacar", true, bjwindow)
		
        X = 0.20
        btnDouble = guiCreateButton(X, Y, Width, Height, "Doblar", true, bjwindow)
		
		X = 0.39
        btnHold = guiCreateButton(X, Y, Width, Height, "Plantarse", true, bjwindow)
		
		X = 0.58
        btnSur = guiCreateButton(X, Y, Width, Height, "Rendirse", true, bjwindow)
		
		Y = 0.85
		X = 0.8
        btnExit = guiCreateButton(X, Y, Width, Height, "Salir", true, bjwindow)
		
		addEventHandler ( "onClientGUIClick", btnExit, pushBtn )
		addEventHandler ( "onClientGUIClick", btnHold, pushBtn )
		addEventHandler ( "onClientGUIClick", btnDouble, pushBtn )
		addEventHandler ( "onClientGUIClick", btnCard, pushBtn )
		addEventHandler ( "onClientGUIClick", btnBetMo, pushBtn )
		addEventHandler ( "onClientGUIClick", btnSur, pushBtn )
		X = 0.4
		Y = 0.08
		Width = 0.2
		Height = 0.09
		DealerP = guiCreateLabel ( X, Y, Width, Height, "Mano del Dealer: 0", true, bjwindow )
		Y = 0.7
		PlayerP = guiCreateLabel ( X, Y, Width, Height, "Tu mano: 0", true, bjwindow )
		
		--Dealer Cards
		local empty = "gfx/empty.png"
		Y = 0.14
		X = 0.01
		Width = 0.18
		Height = 0.27
		imgDealer[1] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgDealer[2] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgDealer[3] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgDealer[4] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgDealer[5] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		--Player Cards
		Y = 0.42
		X = 0.01
		imgPlayer[1] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgPlayer[2] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgPlayer[3] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgPlayer[4] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		X = X + Width + 0.01
		imgPlayer[5] = guiCreateStaticImage( X, Y, Width, Height, empty, true , bjwindow)
		
        guiSetVisible(bjwindow, false)
end

function startBJTable(lmin)
				outputChatBox("Bienvenido a Black Jack. Disfruta tu estadia.")
				--math.randomseed(rand)
				--Money = xen --getPlayerMoney(getLocalPlayer()) -- added in dp3
                createBJTable(lmin)
				--toggleAllControls( false, true, false )

                if (bjwindow ~= nil) then
                         guiSetVisible(bjwindow, true)
						 guiWindowSetSizable(bjwindow, false)
                end

                showCursor(true)
                guiSetInputEnabled(true)
end
addEvent( "startBJ", true )
addEventHandler("startBJ", getLocalPlayer(), startBJTable)

function pushBtn(button)
local btn = ""
if (source == btnBetMo) then
	btn = "btnBetMo"
elseif (source == btnCard) then
	btn = "btnCard"
elseif (source == btnSur) then
	btn = "btnSur"
elseif (source == btnDouble) then
	btn = "btnDouble"
elseif (source == btnHold) then
	btn = "btnHold"
elseif (source == btnExit) then
	btn = "btnExit"
end
	local bet = tonumber(guiGetText(edtMo))
	triggerServerEvent("BTNBJ", getLocalPlayer(),btn,button,bet)
end

function endBJ()
	showCursor(false)
    guiSetInputEnabled(false)
	toggleAllControls( true, true, false )
	guiSetVisible(bjwindow, false)
end
addEvent( "BJend", true )
addEventHandler("BJend", getLocalPlayer(), endBJ)


function imgCh(x,y,z)
if x == 1 then
	guiStaticImageLoadImage(imgPlayer[y],"gfx/"..z..".png")
elseif x == 2 then
	guiStaticImageLoadImage(imgDealer[y],"gfx/"..z..".png")
end
end
addEvent( "imgChBJ", true )
addEventHandler("imgChBJ", getLocalPlayer(), imgCh)

function txtCh(x,y)
if x == 1 then
	guiSetText(PlayerP,"Tu mano: "..y)
elseif x == 2 then
	guiSetText(DealerP,"Mano del dealer: "..y)
end
end
addEvent( "txtChBJ", true )
addEventHandler("txtChBJ", getLocalPlayer(), txtCh)


function stopMinigunDamage ( attacker, weapon, bodypart )
	if ( getElementInterior(source) == 1 and getElementDimension(source)~=90 ) then --if the weapon used was the minigun
		cancelEvent() --cancel the event
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopMinigunDamage )