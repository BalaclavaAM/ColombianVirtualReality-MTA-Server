sW, sH = guiGetScreenSize()
rX, rY = 1366, 768 -- Resolucao cujo a funcao foi criada - DO NOT EDIT OR THE DX WILL FUCK UP
dRX, dRY = 1600, 900
infofont = 0.9
speedfontsize = 1.1
marchfontsize =1.0
speedfontdx = dxCreateFont( "font.ttf", 50,false,"cleartype")
state = true

if sW >= 1024 and sH >= 768 then
	infofont = 0.9
	speedfontsize = 1.1
	marchfontsize = 1.0
	else
	infofont = 0.7
	speedfontsize = 0.9
	marchfontsize = 0.8
end

-- Gerar RPM


function rpmcount()
	if isPedInVehicle(localPlayer) then
		local vh = getPedOccupiedVehicle(localPlayer)
		local speed = getVehicleSpeed(vh) or 0
		local speed = math.floor(speed)	
		if checking == 'down' and speed > 10 then
			local vh = getPedOccupiedVehicle(localPlayer)
			if vh then
				
				local engine = getVehicleEngineState(vh)
				if engine == false then rpm = 0 setElementData(vh,'fakeRPM',rpm) return end
				local marchat = tostring(getMarcha(vh))
				if mudou == true then					
					local rpm = getElementData(vh,'fakeRPM') or 0
					local rpm = rpm + (tonumber(getVehicleCurrentGear(vh))*300)
					mudou = false
					setElementData(vh,'fakeRPM',rpm)
					if rpm > 11000 then
						rpm = 11000
					end
					setElementData(vh,'fakeRPM',rpm)					
					return
				end	
				local rpm = getElementData(vh,'fakeRPM') or 0
				local hand = getVehicleHandling(vh)	
				local velomaxima = hand["maxVelocity"]
				if rpm < 11000 then
					rpm = rpm + 200
					if rpm > 11000 then
						rpm = 11000
					end
					setElementData(vh,'fakeRPM',rpm)
				end
			end
		else
			local vh = getPedOccupiedVehicle(localPlayer)
			if vh then
				local engine = getVehicleEngineState(vh)
				if engine == false then rpm = 0 setElementData(vh,'fakeRPM',rpm) return end
				local marchat = tostring(getMarcha(vh))
				if speed == 0 or marchat == 'R' then
					rpm = math.random(1000,1500)
					setElementData(vh,'fakeRPM',rpm)
				end
				if speed > 0 or marchat ~= "R" or marchat ~= "N" then
					local rpm = getElementData(vh,'fakeRPM') or 0
					if rpm ~= rpmsave then
						rpmsave = rpm
						if rpm >= 1600 then
							rpm = rpm - 300
						end
						if rpm < 1000 then
							rpm = 1000
						end
					else
						rpm = math.random(1000,1500)	
					end
					setElementData(vh,'fakeRPM',rpm)
				end
			end		
		end
	end	
end


function getVehicleRPM(vh)
	if vh then
		return tonumber(getElementData(vh,'fakeRPM'))
	else
		return 0
	end
end

function playerPressedKey(button, press)
    if (button) then
		checking = press
    end
end

-- Pegar velocidade atual
------------------------>>

function getVehicleSpeed(vehicle)
	if not localPlayer.vehicle then
		return 0
	end
	return localPlayer.vehicle.velocity:getLength() * 180
end

-- Pegar marcha atual
------------------------>>

function getMarcha(vh)
	local speed = getVehicleSpeed(vh) or 0
	local marcha = getVehicleCurrentGear(vh) or 0	 
	if tonumber(marcha) == 1 and tonumber(speed) == 0 then
		marchat = 'N'
	end
	if tonumber(marcha) >= 1 and tonumber(speed) > 0 then
		marchat = tostring(marcha)
	end
	if tonumber(marcha) == 0 and tonumber(speed) == 0 then
		marchat = 'N'
	end
	if tonumber(marcha) == 0 and tonumber(speed) > 0 then
		marchat = 'R'
	end
	return tostring(marchat)
end




SAFEZONE_Y = 0

function aToR( X, Y, sX, sY, rtype)
	local rCX, rCY = rX, rY
	if not rtype then
		rCX = rX
		rCY = rY
	else
		rCX = dRX
		rCY = dRY
	end
	local xd = X/rCX or X
	local yd = Y/rCY or Y
	local xsd = sX/rCX or sX
	local ysd = sY/rCY or sY
	return xd*sW, yd*sH, xsd*sW, ysd*sH
end

function dxDrawEmptyRec (startX, startY, endX, endY, color, width, postGUI)
	dxDrawLine (startX, startY, startX+endX, startY, color, width, postGUI)
	dxDrawLine (startX, startY, startX, startY+endY, color, width, postGUI)
	dxDrawLine (startX, startY+endY, startX+endX, startY+endY,  color, width, postGUI)
	dxDrawLine (startX+endX, startY, startX+endX, startY+endY, color, width, postGUI)
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
  end


function hideorno(fun)
state = fun
end
addEvent("hide:VELOCIMETRO",true)
addEventHandler("hide:VELOCIMETRO", root, hideorno)

function drawing()
	if tostring(state) == "true" then
		local vh = getPedOccupiedVehicle(localPlayer)
		if vh then
		local health = math.floor(getElementHealth(vh))
		local fuel = getElementData(vh,"fuel") or 100
		local fuel = math.floor(tonumber(fuel))



		local realname = getVehicleName(vh)
		local marcha = exports['bengines']:getVehicleGear(vh) or ""
		local rpm = round(tonumber(exports['bengines']:getVehicleRPM(vh))) or 0
		local speed = getVehicleSpeed(vh)
		local vehicleType=getElementData(vh, "vehicle:type")
		local handling = getVehicleHandling(vh)
		local fueltank=getVehicleHandling(vh)['mass']
		fuel=round((fuel*100)/fueltank)
		--#####Info do veiculo
			ivX, ivY, ivSX, ivSY = aToR( 1243, 930+SAFEZONE_Y+380, 1350, 15)
			dxDrawText(tostring(rpm).." RPM", ivX, ivY, ivSX, ivSY, tocolor(255, 255, 255, 255), infofont, "clear", "right", "center", false, false, false, true, true) 		
			ivX, ivY, ivSX, ivSY = aToR( 1000, 930+SAFEZONE_Y+500, 1200, 15)
			dxDrawText("000000001 Km", ivX, ivY, ivSX, ivSY, tocolor(255, 255, 255, 255), infofont+0.2, "default-bold", "right", "center", false, false, false, true, true) 		

			ivX, ivY, ivSX, ivSY = aToR( 1115, 870+SAFEZONE_Y+380, 1350, 15) --Speed
			dxDrawText(math.floor(speed).." "..marcha, ivX, ivY, ivSX, ivSY, tocolor(255, 255, 255, 255), speedfontsize, speedfontdx, "right", "center", false, false, false, true, true) 
		
			ivX, ivY, ivSX, ivSY = aToR( 1115, 930+SAFEZONE_Y+380, 1150, 15) --Name
			dxDrawText(realname, ivX, ivY, ivSX, ivSY, tocolor(255, 255, 255, 255), infofont, "clear", "left", "center", false, false, false, true, true) 
		

			if getElementModel(vh) ~= 509 and getElementModel(vh) ~= 510 and getElementModel(vh) ~= 481 then
				fuelvX, fuelvY, fuelvSX, fuelvSY = aToR( 1240, 481+SAFEZONE_Y+190, ((fuel/100)*110), 15) --fuel math
				dxDrawRectangle( fuelvX, fuelvY, fuelvSX, fuelvSY, tocolor(60, 60, 60, 255), false)
				ivX, ivY, ivSX, ivSY = aToR( 1240, 481+SAFEZONE_Y+190, 110, 15) --iv	
				dxDrawEmptyRec (ivX, ivY, ivSX, ivSY, tocolor(0, 0, 0, 255), 1,false)	
				ivX, ivY, ivSX, ivSY = aToR( 1243, 963+SAFEZONE_Y+380, 1150, 15)
				dxDrawText("Gasolina: "..tostring(fuel), ivX, ivY, ivSX, ivSY, tocolor(255, 255, 255, 255), infofont, "clear", "left", "center", false, false, false, true, true) 		
			end
	
		
			
			danovX, danovY, danovSX, danovSY = aToR( 1112, 481+SAFEZONE_Y+190, ((health/1000)*110), 15) --damage math
			dxDrawRectangle( danovX, danovY, danovSX, danovSY, tocolor(damageR, damageG, damageB, 255), false)
			ivX, ivY, ivSX, ivSY = aToR( 1112, 481+SAFEZONE_Y+190, 110, 15) 	
			dxDrawEmptyRec (ivX, ivY, ivSX, ivSY, tocolor(0, 0, 0, 255), 1,false)
			
			ivX, ivY, ivSX, ivSY = aToR( 1115, 963+SAFEZONE_Y+380, 1150, 15)
			dxDrawText("Daño: "..math.floor(health/10), ivX, ivY, ivSX, ivSY, tocolor(255, 255, 255, 255), infofont, "clear", "left", "center", false, false, false, true, true) 
		--#####Retangulo Grande Horizontal Brancos
			rb1X, rb1Y, rb1SX, rb1SY = aToR( 1111, 519+SAFEZONE_Y+190, 182, 4) --rb
			dxDrawRectangle(rb1X, rb1Y, rb1SX, rb1SY,tocolor(255,255,255,80),false)

			rb1X, rb1Y, rb1SX, rb1SY = aToR( 1111, 519+SAFEZONE_Y+190, (tonumber(rpm)*4.1/182), 4) --rb
			dxDrawRectangle(rb1X, rb1Y, rb1SX, rb1SY,tocolor(255,255,255,255),false)
	--(rpm*3/182)
			rb1X, rb1Y, rb1SX, rb1SY = aToR( 1075+(tonumber(rpm)*4.1/182), 491+190+SAFEZONE_Y,65 , 60) --rb	
			--[[rpm brilho]]dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/br.png", 0, 0, 0, tocolor(255,255,255,255))
			--[[rpm brilho]]dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/br.png", 0, 0, 0, tocolor(255,255,255,255))		
		--#####Efeitos Retangulos Brancos

		if rpm > 295.295*1 then --[[01]]  alphafx1=255 else alphafx1 = 50 end
		if rpm > 295.295*2 then	--[[03]]  alphafx2=255 else alphafx2 = 50 end
		if rpm > 295.295*3  then	--[[04]]  alphafx3=255 else alphafx3 = 50 end
		if rpm > 295.295*4  then	--[[05]]  alphafx4=255 else alphafx4 = 50 end
		if rpm > 295.295*5  then	--[[06]] alphafx5=255 else alphafx5 = 50 end
		if rpm > 295.295*6  then	--[[07]]  alphafx6=255 else alphafx6 = 50 end
		if rpm > 295.295*7  then	--[[08]]  alphafx7=255 else alphafx7 = 50 end
		if rpm > 295.295*8  then	--[[09]]  alphafx8=255 else alphafx8 = 50 end
		if rpm > 295.295*9  then	--[[10]]  alphafx9=255 else alphafx9 = 50 end
		if rpm > 295.295*10  then	--[[11]]  alphafx10=255 else alphafx10 = 50 end
		if rpm > 295.295*11  then	--[[12]]  alphafx11=255 else alphafx11 = 50 end
		if rpm > 295.295*12  then	--[[13]]  alphafx12=255 else alphafx12 = 50 end
		if rpm > 295.295*13  then	--[[14]]  alphafx13=255 else alphafx13 = 50 end
		if rpm > 295.295*14  then	--[[15]] alphafx14=255 else alphafx14 = 50 end
		if rpm > 295.295*15  then	--[[16]]  alphafx15=255 else alphafx15 = 50 end
		if rpm > 295.295*16  then	--[[17]]  alphafx16=255 else alphafx16 = 50 end
		if rpm > 295.295*17  then	--[[18]]  alphafx17=255 else alphafx17 = 50 end
		if rpm > 295.295*18  then	--[[19]]  alphafx18=255 else alphafx18 = 50 end
		if rpm > 295.295*19  then	--[[20]]  alphafx19=255 else alphafx19 = 50 end
		if rpm > 295.295*20  then	--[[21]]  alphafx20=255 else alphafx20 = 50 end
		if rpm > 295.295*21 then	--[[22]]  alphafx21=255 else alphafx21 = 50 end
		if rpm > 295.295*22 then	--[[22]]  alphafx22=255 else alphafx22 = 50 end	
		if rpm > 295.295*23 then	--[[22]]  alphafx23=255 else alphafx23 = 50 end	
		if rpm > 295.295*24	then	--[[22]]  alphafx24=255 else alphafx24 = 50 end	
		if rpm > 295.295*25 then	--[[22]]  alphafx25=255 else alphafx25 = 50 end	
		if rpm > 295.295*26 then	--[[22]]  alphafx26=255 else alphafx26 = 50 end	
		if rpm > 295.295*27 then	--[[22]]  alphafx27=255 else alphafx27 = 50 end		
		
		--#####Retangulos Brancos
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*33), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx1))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*32), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx2))
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*31), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx3))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*30), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx4))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*29), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx5))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*28), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx6))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*27), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx7))
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*26), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx8))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*25), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx9))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*24), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx10))		
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*23), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx11))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*22), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx12))
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*21), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx13))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*20), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx14))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*19), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx15))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*18), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx16))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*17), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx17))
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*16), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx18))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*15), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx19))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*14), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx20))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*13), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx21))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*12), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx22))
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*11), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx23))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*10), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx24))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*9), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx25))	
		
		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*8), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx26))

		rb1X, rb1Y, rb1SX, rb1SY = aToR( 1337.5-(7*7), 500.5+SAFEZONE_Y+190, 15, 22) --rb
		dxDrawImage ( rb1X, rb1Y, rb1SX, rb1SY,"fx/p.png", -1+180, 0, 0, tocolor(255,255,255,alphafx27))
		
		--27 qds brancos
		
		--#####Retangulos Vermelhos
		rv1X, rv1Y, rv1SX, rv1SY = aToR( 1335-(7*6), 500+SAFEZONE_Y+190, 17, 27) --rv
		dxDrawImage ( rv1X, rv1Y, rv1SX, rv1SY,"fx/g.png", 0, 0, 0, tocolor(tracoR, tracoG, tracoB,255))	
		
		rv1X, rv1Y, rv1SX, rv1SY = aToR( 1335-(7*5), 500+SAFEZONE_Y+190, 17, 27) --rv
		dxDrawImage ( rv1X, rv1Y, rv1SX, rv1SY,"fx/g.png", 0, 0, 0, tocolor(tracoR, tracoG, tracoB,255))
		
		rv1X, rv1Y, rv1SX, rv1SY= aToR( 1335-(7*4), 500+SAFEZONE_Y+190, 17, 27) --rv
		dxDrawImage ( rv1X, rv1Y, rv1SX, rv1SY,"fx/g.png", 0, 0, 0, tocolor(tracoR, tracoG, tracoB,255))
		
		rv1X, rv1Y, rv1SX, rv1SY = aToR( 1335-(7*3), 500+SAFEZONE_Y+190, 17, 27) --rv
		dxDrawImage ( rv1X, rv1Y, rv1SX, rv1SY,"fx/g.png", 0, 0, 0, tocolor(tracoR, tracoG, tracoB,255))
		
		rv1X, rv1Y, rv1SX, rv1SY = aToR( 1335-(7*2), 500+SAFEZONE_Y+190, 17, 27) --rv
		dxDrawImage ( rv1X, rv1Y, rv1SX, rv1SY,"fx/g.png", 0, 0, 0, tocolor(tracoR, tracoG, tracoB,255))
		
		rv1X, rv1Y, rv1SX, rv1SY = aToR( 1335-(7*1), 500+SAFEZONE_Y+190, 17, 27) --rv
		dxDrawImage ( rv1X, rv1Y, rv1SX, rv1SY,"fx/g.png", 0, 0, 0, tocolor(tracoR, tracoG, tracoB,255))
		
		rv1X, rv1Y, rv1SX, rv1SY = aToR( 1335, 500+SAFEZONE_Y+190, 17, 27) --rv
		dxDrawImage ( rv1X, rv1Y, rv1SX, rv1SY,"fx/g.png", 0, 0, 0, tocolor(tracoR, tracoG, tracoB,255))
		--#####	
		
		end
	end	
end
addEventHandler("onClientRender", root,drawing)


