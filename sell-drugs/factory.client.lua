
GUIEditor = {
    label = {}
}
local baretaTime = 30000
local popperTime = 40000
local pericaTime = 60000
local lsdTime = 40000
local bazukoTime = 40000
local heroinaTime = 40000
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        factoryGui = guiCreateWindow(584, 235, 207, 254, "Fabrica de drogas", false)
        guiWindowSetSizable(factoryGui, false)

        GUIEditor.label[1] = guiCreateLabel(24, 36, 67, 15, "Bareta", false, factoryGui)
        guiLabelSetColor(GUIEditor.label[1], 248, 182, 5)
        GUIEditor.label[2] = guiCreateLabel(24, 61, 67, 15, "Popper", false, factoryGui)
        guiLabelSetColor(GUIEditor.label[2], 73, 247, 5)
        GUIEditor.label[3] = guiCreateLabel(24, 86, 67, 15, "Perica", false, factoryGui)
        guiLabelSetColor(GUIEditor.label[3], 241, 7, 244)
        GUIEditor.label[4] = guiCreateLabel(24, 111, 67, 15, "Lsd", false, factoryGui)
        guiLabelSetColor(GUIEditor.label[4], 27, 223, 202)
        GUIEditor.label[5] = guiCreateLabel(24, 136, 67, 15, "Bazuko", false, factoryGui)
        guiLabelSetColor(GUIEditor.label[5], 86, 172, 77)
        GUIEditor.label[6] = guiCreateLabel(24, 161, 67, 15, "Heroina", false, factoryGui)
        guiLabelSetColor(GUIEditor.label[6], 248, 0, 41)
        baretaRadio = guiCreateRadioButton(91, 36, 15, 15, "", false, factoryGui)
        popperRadio = guiCreateRadioButton(91, 61, 15, 15, "", false, factoryGui)
        pericaRadio = guiCreateRadioButton(91, 86, 15, 15, "", false, factoryGui)
        lsdRadio = guiCreateRadioButton(91, 111, 15, 15, "", false, factoryGui)
        bazukoRadio = guiCreateRadioButton(91, 136, 15, 15, "", false, factoryGui)
        heroinaRadio = guiCreateRadioButton(91, 161, 15, 15, "", false, factoryGui)
        guiRadioButtonSetSelected(heroinaRadio, true)
        closeFactoryBtn = guiCreateButton(12, 200, 89, 37, "Cerrar", false, factoryGui)
        makeDrugsBtn = guiCreateButton(112, 200, 82, 37, "Crear", false, factoryGui)
		guiSetVisible(factoryGui,false)
		
		--Progress window
		drugGuiProgress = guiCreateWindow(564, 428, 254, 102, "Creando drogas...", false)
        guiWindowSetSizable(drugGuiProgress, false)

        drugProgressBar = guiCreateProgressBar(29, 51, 190, 28, false, drugGuiProgress)
        GUIEditor.label[1] = guiCreateLabel(97, 34, 112, 17, "Progreso:", false, drugGuiProgress) 
		guiSetVisible(drugGuiProgress,false)
		
		addEventHandler ( "onClientGUIClick", closeFactoryBtn, closeFactoryWindow, false )
		addEventHandler ( "onClientGUIClick", makeDrugsBtn, startMakingDrugs, false )
    end
)
--God mode
function godmodeHandler ()
  cancelEvent ()
end

addEvent ("enableGodMode",true)
addEventHandler ("enableGodMode",getRootElement(),
function()
  if (source == getLocalPlayer()) then
    addEventHandler ("onClientPlayerDamage",getRootElement(),godmodeHandler)
  end
end)

addEvent ("disableGodMode",true)
addEventHandler ("disableGodMode",getRootElement(),
function()
  if (source == getLocalPlayer()) then
    removeEventHandler ("onClientPlayerDamage",getRootElement(),godmodeHandler)
  end
end)

function startMakingDrugs()
	triggerServerEvent("sSetAnim",getLocalPlayer()) 
	guiSetVisible(drugGuiProgress, true)
	guiSetVisible(factoryGui,false)
	showCursor(true)
	guiProgressBarSetProgress(drugProgressBar,0)
	local wl = tonumber ( getElementData ( localPlayer, "WantedPoints" ) )
	setElementData ( localPlayer, "WantedPoints", wl + math.random(50,100) )  
	if guiRadioButtonGetSelected(baretaRadio) then
		local baretaCount = 0
		local bTimer = setTimer(function()
			baretaCount = baretaCount +1
			if baretaCount*1000 == baretaTime then
				guiProgressBarSetProgress(drugProgressBar,0)
				guiSetVisible(drugGuiProgress,false)
				guiSetVisible(factoryGui,true)
				triggerServerEvent("sSetDrugs",getLocalPlayer(),"Weed") 
			else
				guiProgressBarSetProgress( drugProgressBar, ((baretaCount*1000)/baretaTime)*100)
			end
		end
		,1000, baretaTime/1000)
	elseif guiRadioButtonGetSelected(popperRadio) then
		local popperCount = 0
		local popperTimer = setTimer(function()
			popperCount = popperCount +1
			if popperCount*1000 == popperTime then
				guiProgressBarSetProgress(drugProgressBar,0)
				guiSetVisible(drugGuiProgress,false)
				guiSetVisible(factoryGui,true)
				triggerServerEvent("sSetDrugs",getLocalPlayer(),"God") 
			else
				guiProgressBarSetProgress( drugProgressBar, ((popperCount*1000)/popperTime)*100)
			end
		end
		,1000, popperTime/1000)
	elseif guiRadioButtonGetSelected(pericaRadio) then
		local pericaCount = 0
		local pericaTimer = setTimer(function()
			pericaCount = pericaCount +1
			if pericaCount*1000 == pericaTime then
				guiProgressBarSetProgress(drugProgressBar,0)
				guiSetVisible(drugGuiProgress,false)
				guiSetVisible(factoryGui,true)
				triggerServerEvent("sSetDrugs",getLocalPlayer(),"Speed") 
			else
				guiProgressBarSetProgress( drugProgressBar, ((pericaCount*1000)/pericaTime)*100)
			end
		end
		,1000, pericaTime/1000)
	elseif guiRadioButtonGetSelected(lsdRadio) then
		local lsdCount = 0
		local lsdTimer = setTimer(function()
			lsdCount = lsdCount +1
			if lsdCount*1000 == lsdTime then
				guiProgressBarSetProgress(drugProgressBar,0)
				guiSetVisible(drugGuiProgress,false)
				guiSetVisible(factoryGui,true)
				triggerServerEvent("sSetDrugs",getLocalPlayer(),"Lsd") 
			else
				guiProgressBarSetProgress( drugProgressBar, ((lsdCount*1000)/lsdTime)*100)
			end
		end
		,1000, lsdTime/1000)
	elseif guiRadioButtonGetSelected(bazukoRadio) then
		local bazukoCount = 0
		local bazukoTimer = setTimer(function()
			bazukoCount = bazukoCount +1
			if bazukoCount*1000 == bazukoTime then
				guiProgressBarSetProgress(drugProgressBar,0)
				guiSetVisible(drugGuiProgress,false)
				guiSetVisible(factoryGui,true)
				triggerServerEvent("sSetDrugs",getLocalPlayer(),"Steroids") 
			else
				guiProgressBarSetProgress( drugProgressBar, ((bazukoCount*1000)/bazukoTime)*100)
			end
		end
		,1000, bazukoTime/1000)
	elseif guiRadioButtonGetSelected(heroinaRadio) then
			local heroinaCount = 0
		local heroinaTimer = setTimer(function()
			heroinaCount = heroinaCount +1
			if heroinaCount*1000 == heroinaTime then
				guiProgressBarSetProgress(drugProgressBar,0)
				guiSetVisible(drugGuiProgress,false)
				guiSetVisible(factoryGui,true)
				triggerServerEvent("sSetDrugs",getLocalPlayer(),"Heroin") 
			else
				guiProgressBarSetProgress( drugProgressBar, ((heroinaCount*1000)/heroinaTime)*100)
			end
		end
		,1000, heroinaTime/1000)
	end
end



function closeFactoryWindow()
	if guiGetVisible(factoryGui) == true then
		guiSetVisible(factoryGui, false)
		showCursor(false)
	end
end

function factoryShowGui(p)
		if guiGetVisible(factoryGui) == false then
			guiSetVisible(factoryGui,true)
			showCursor(true)
		end
	end
addEvent( "onServerFactoryMarkerHit", true )
addEventHandler( "onServerFactoryMarkerHit", localPlayer, factoryShowGui )

