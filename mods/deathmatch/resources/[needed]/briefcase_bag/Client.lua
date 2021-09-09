--outputChatBox("* #0069c7BriefCase Bag By #ff0000|Mr|#000ff0-Talal07-|",255,255,255,true)
text = ""

addEvent("onShowMoney",true)
addEventHandler("onShowMoney",root,
	function ()
		setText("+$40.000 Pa' la gasofa")
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

