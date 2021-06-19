 policeLbl = guiCreateLabel(1249, 733, 262, 50, "", false)
 guiSetFont(policeLbl, "sa-header")
 guiLabelSetColor(policeLbl, 10, 32, 244)  
 
crimLabel = guiCreateLabel(0.78, 0.88, 0.20, 0.07, "", true)
guiSetFont(crimLabel, "sa-header")
guiLabelSetColor(crimLabel, 255, 0, 0) 

function clearHeist()
	guiSetText(crimLabel,"")
	guiSetText(policeLbl,"")
end
addEvent ("clearHeist",true)
addEventHandler ("clearHeist",getRootElement(), clearHeist)

function loadClientHeist(totalcrims, totalpolice)
	fadeCamera( false, 0.5, 0, 0, 0 )
	setTimer(function() fadeCamera( true, 1.2, 0, 0, 0 ) end, 1000,1)
	guiSetText(crimLabel,""..totalcrims.." Criminales")
	guiSetText(policeLbl,""..totalpolice.." Policias")
	alarm = playSound3D("alarm.ogg", 358.54, 173.76, 1008.39)
	setElementDimension(alarm, 233)
	setElementInterior(alarm, 3)

end
addEvent ("loadClientHeist",true)
addEventHandler ("loadClientHeist",getRootElement(), loadClientHeist)

function updateCounterCrim(totalcrims)
	if totalcrims == -1 then if isElement(crimLabel) then guiSetText(crimLabel,"") end return end
	if isElement(crimLabel) then
		guiSetText(crimLabel,""..totalcrims.." Criminales")
	end
end
addEvent ("updateCounterCrim",true)
addEventHandler ("updateCounterCrim",getRootElement(), updateCounterCrim)

function updateCounterPolice(totalpolice)
	if totalpolice == -1 then if isElement(totalpolice) then guiSetText(policeLbl,"") end return end
	if isElement(policeLbl) then
		guiSetText(policeLbl,""..totalpolice.." Policias")
	end
end
addEvent ("updateCounterPolice",true)
addEventHandler ("updateCounterPolice",getRootElement(), updateCounterPolice)


text = ""

addEvent("onShowMoney",true)
addEventHandler("onShowMoney",root,
	function ()
		setText("Has robado el banco de Los Santos!")
		setTimer(setText,5000,1,"")
		playSound("sound.ogg")
	end
)

function setText(tt)
	text = tt
end

addEventHandler("onClientRender",root,
	function ()
		local x,y = guiGetScreenSize()
		dxDrawText(text,0,0,x,y,tocolor(255,255,255,120),2,"pricedown","center","center",false,false,false)
	end
)
