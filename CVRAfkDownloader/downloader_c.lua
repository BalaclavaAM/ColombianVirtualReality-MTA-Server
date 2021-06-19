local sx, sy = guiGetScreenSize()
local queue = {}
local modQueue = {}
local progress = 0
local downloadSize = 0
local modsSize = 0
local scriptVersion = 1.1
local canShowTheFuckingGUI = false
local window, language, guiColorR, guiColorG, guiColorB
local gridClicked = 0
local gridCache = 1
local gridRows = 10

addEvent(resname .. ":startDownload", true)
addEventHandler(resname .. ":startDownload", localPlayer,
	function(table, size, lang, colorR, colorG, colorB)
		queue = table
		language = lang
		guiColorR, guiColorG, guiColorB = colorR, colorG, colorB
		for index = 1, #queue do
			local data = queue[index]
			if fileExists(data[1]) then
				local cf = fileOpen(data[1])
				local cfSize = fileGetSize(cf)
				if cfSize ~= data[3] then
					fileDelete(cf)
				else
					size = size - cfSize
					fileClose(cf)
				end
			end
		end
		modsSize = size
		if modsSize > 0 then
			window = "request"
			showCursor(true)
			downloadButton = guiCreateButton((535/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, "", false)
			guiSetAlpha(downloadButton, 0)
			cancelButton = guiCreateButton((708/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, "", false)
			guiSetAlpha(cancelButton, 0)
			addEventHandler("onClientGUIClick", root,
				function()
					if source == downloadButton then
						showCursor(false)
						destroyElement(downloadButton)
						destroyElement(cancelButton)
						window = nil
						download()
					elseif source == cancelButton then
						for index = 1, #queue do
							local data = queue[index]
							if not fileExists(data[1]) then
								queue[index] = nil
							end
						end
						showCursor(false)
						destroyElement(downloadButton)
						destroyElement(cancelButton)
						window = nil
						download()
					end
				end
			)
		else
			download()
		end
	end
)

function download()
	if #queue >= 1 then
		downloadFile(queue[#queue][1])
	else
		queue = {}
		modsSize = 0
		downloadSize = 0
		progress = 0
		canShowTheFuckingGUI = true
	end
end

function calculateW(w, progress)
	if w and progress then
		local w = w-2
		local width = ((w*progress)/100)
		return width
	end
	return false
end

local lastUpdate = 0
local lastName = ""

function updateDownloadSize(size)
	if lastName == queue[#queue] then
		downloadSize = (downloadSize-lastUpdate) + size
	else
		downloadSize = downloadSize + size
	end
	lastName = queue[#queue]
	lastUpdate = size
end

addEventHandler("onClientRender", root,
    function()
		if #queue ~= 0 then
			if window == "request" then
				dxDrawRectangle((520/1366)*sx, (267/768)*sy, (307/1366)*sx, (125/768)*sy, tocolor(0, 0, 0, 150), true)
				dxDrawRectangle((520/1366)*sx, (267/768)*sy, (307/1366)*sx, (23/768)*sy, tocolor(0, 0, 0, 150), true)
				dxDrawText("AFK Mod Downloader v" .. scriptVersion, (520/1366)*sx, (267/768)*sy, (827/1366)*sx, (290/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				dxDrawText(translations[language].request_firstText .. "\n" .. translations[language].request_secondText .. ": " .. sizeFormat(modsSize), (520/1366)*sx, (295/768)*sy, (827/1366)*sx, (338/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, true, true, false, false)
				if getKeyState("mouse1") and isCursorHover((535/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy) then
					dxDrawRectangle((535/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 50), true)
					dxDrawText(translations[language].request_downloadButton, (534/1366)*sx, (347/768)*sy, (643/1366)*sx, (380/768)*sy, tocolor(255, 255, 255, 150), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				elseif isCursorHover((535/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy) then
					dxDrawRectangle((535/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 100), true)
					dxDrawText(translations[language].request_downloadButton, (534/1366)*sx, (347/768)*sy, (643/1366)*sx, (380/768)*sy, tocolor(255, 255, 255, 200), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				else
					dxDrawRectangle((535/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 150), true)
					dxDrawText(translations[language].request_downloadButton, (534/1366)*sx, (347/768)*sy, (643/1366)*sx, (380/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				end
				if getKeyState("mouse1") and isCursorHover((708/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy) then
					dxDrawRectangle((708/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 50), true)
					dxDrawText(translations[language].request_cancelButton, (707/1366)*sx, (347/768)*sy, (816/1366)*sx, (380/768)*sy, tocolor(255, 255, 255, 150), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				elseif isCursorHover((708/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy) then
					dxDrawRectangle((708/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 100), true)
					dxDrawText(translations[language].request_cancelButton, (707/1366)*sx, (347/768)*sy, (816/1366)*sx, (380/768)*sy, tocolor(255, 255, 255, 200), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				else
					dxDrawRectangle((708/1366)*sx, (348/768)*sy, (107/1366)*sx, (34/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 150), true)
					dxDrawText(translations[language].request_cancelButton, (707/1366)*sx, (347/768)*sy, (816/1366)*sx, (380/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				end
			else
				if fileExists(queue[#queue][1]) then
					openedFile = fileOpen(queue[#queue][1])
					if openedFile then
						local fileSize = fileGetSize(openedFile)
						fileClose(openedFile)
						updateDownloadSize(fileSize)
					end
				end
				dxDrawRectangle((413/1366)*sx, (599/768)*sy, (548/1366)*sx, (118/768)*sy, tocolor(0, 0, 0, 150), true)
				dxDrawRectangle((413/1366)*sx, (599/768)*sy, (548/1366)*sx, (23/768)*sy, tocolor(0, 0, 0, 150), true)
				dxDrawText("AFK Mod Downloader v" .. scriptVersion, (412/1366)*sx, (599/768)*sy, (961/1366)*sx, (622/768)*sy, tocolor(255, 255, 255, 254), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				dxDrawText(translations[language].firstText .. "\n" .. translations[language].secondText .. ": " .. queue[#queue][1]:gsub("files/", ""), (412/1366)*sx, (622/768)*sy, (961/1366)*sx, (666/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
				local x, y, w, h = (421/1366)*sx, (673/768)*sy, (532/1366)*sx, (34/768)*sy
				progress = ((downloadSize*100)/modsSize)
				local width = calculateW(w, progress)
				dxDrawRectangle(x, y, w, h, tocolor(0, 0, 0, 200), true)
				dxDrawRectangle(x+1, y+1, w-2, h-2, tocolor(guiColorR, guiColorG, guiColorB, 50), true)
				dxDrawRectangle(x+1, y+1, width, h-2, tocolor(guiColorR, guiColorG, guiColorB, 150), true)
				dxDrawText(sizeFormat(downloadSize) .. "/" .. sizeFormat(modsSize) .. " (" .. math.floor(progress) .. "%)", x, y, w+x, h+y, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			end
		end
		if window == "select" then
			dxDrawRectangle((431/1366)*sx, (164/768)*sy, (502/1366)*sx, (366/768)*sy, tocolor(0, 0, 0, 150), true)
			dxDrawRectangle((431/1366)*sx, (164/768)*sy, (502/1366)*sx, (23/768)*sy, tocolor(0, 0, 0, 150), true)
			dxDrawRectangle((573/1366)*sx, (196/768)*sy, (351/1366)*sx, (276.5/768)*sy, tocolor(0, 0, 0, 176), true)
			dxDrawText("AFK Mod Downloader v1.1", (430/1366)*sx, (162/768)*sy, (933/1366)*sx, (187/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			if isCursorHover((440/1366)*sx, (197/768)*sy, (112/1366)*sx, (36/768)*sy) then
				dxDrawRectangle((440/1366)*sx, (197/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 180), true)
				dxDrawText(translations[language].gui_activateSelected, (439/1366)*sx, (197/768)*sy, (552/1366)*sx, (233/768)*sy, tocolor(255, 255, 255, 150), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			else
				dxDrawRectangle((440/1366)*sx, (197/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 200), true)
				dxDrawText(translations[language].gui_activateSelected, (439/1366)*sx, (197/768)*sy, (552/1366)*sx, (233/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			end
			if isCursorHover((440/1366)*sx, (243/768)*sy, (112/1366)*sx, (36/768)*sy) then
				dxDrawRectangle((440/1366)*sx, (243/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 180), true)
				dxDrawText(translations[language].gui_desactiveSelected, (439/1366)*sx, (243/768)*sy, (552/1366)*sx, (279/768)*sy, tocolor(255, 255, 255, 150), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			else
				dxDrawRectangle((440/1366)*sx, (243/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 200), true)
				dxDrawText(translations[language].gui_desactiveSelected, (439/1366)*sx, (243/768)*sy, (552/1366)*sx, (279/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			end
			if isCursorHover((440/1366)*sx, (291/768)*sy, (112/1366)*sx, (36/768)*sy) then
				dxDrawRectangle((440/1366)*sx, (291/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 180), true)
				dxDrawText(translations[language].gui_activeAll, (439/1366)*sx, (291/768)*sy, (552/1366)*sx, (327/768)*sy, tocolor(255, 255, 255, 150), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			else
				dxDrawRectangle((440/1366)*sx, (291/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 200), true)
				dxDrawText(translations[language].gui_activeAll, (439/1366)*sx, (291/768)*sy, (552/1366)*sx, (327/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			end
			if isCursorHover((440/1366)*sx, (337/768)*sy, (112/1366)*sx, (36/768)*sy) then
				dxDrawRectangle((440/1366)*sx, (337/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 180), true)
				dxDrawText(translations[language].gui_disAll, (439/1366)*sx, (337/768)*sy, (552/1366)*sx, (373/768)*sy, tocolor(255, 255, 255, 150), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			else
				dxDrawRectangle((440/1366)*sx, (337/768)*sy, (112/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 200), true)
				dxDrawText(translations[language].gui_disAll, (439/1366)*sx, (337/768)*sy, (552/1366)*sx, (373/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			end
			if isCursorHover((594/1366)*sx, (483/768)*sy, (175/1366)*sx, (36/768)*sy) then
				dxDrawRectangle((594/1366)*sx, (483/768)*sy, (175/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 180), true)
				dxDrawText(translations[language].gui_close, (594/1366)*sx, (483/768)*sy, (769/1366)*sx, (519/768)*sy, tocolor(255, 255, 255, 150), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			else
				dxDrawRectangle((594/1366)*sx, (483/768)*sy, (175/1366)*sx, (36/768)*sy, tocolor(guiColorR, guiColorG, guiColorB, 200), true)
				dxDrawText(translations[language].gui_close, (594/1366)*sx, (483/768)*sy, (769/1366)*sx, (519/768)*sy, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "center", "center", false, false, true, false, false)
			end
			y = (197/768)*sy
			for index = gridCache, (gridCache+gridRows) do
				local mods = modQueue[index]
				if index <= #modQueue then
					x, y, w, h = (574/1366)*sx, y, (349/1366)*sx, (24/768)*sy
					if gridClicked == index then
						dxDrawRectangle(x, y, w, h, tocolor(guiColorR, guiColorG, guiColorB, 255), true)
						if isVehicle(tonumber(mods[2])) then
							dxDrawText(mods[3] .. " (" .. getVehicleNameFromModel(tonumber(mods[2])) .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						elseif isSkin(tonumber(mods[2])) then
							dxDrawText(mods[3] .. " (Skin " .. mods[2] .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						else
							dxDrawText(mods[3] .. " (Object " .. mods[2] .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						end
					elseif isCursorHover(x, y, w, h) and gridClicked ~= index then
						dxDrawRectangle(x, y, w, h, tocolor(guiColorR, guiColorG, guiColorB, 100), true)
						if isVehicle(tonumber(mods[2])) then
							dxDrawText(mods[3] .. " (" .. getVehicleNameFromModel(tonumber(mods[2])) .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 155), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						elseif isSkin(tonumber(mods[2])) then
							dxDrawText(mods[3] .. " (Skin " .. mods[2] .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 155), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						else
							dxDrawText(mods[3] .. " (Object " .. mods[2] .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 155), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						end
						if getKeyState("mouse1") then
							gridClicked = index
						end
					else
						dxDrawRectangle(x, y, w, h, tocolor(guiColorR, guiColorG, guiColorB, 50), true)
						if isVehicle(tonumber(mods[2])) then
							dxDrawText(mods[3] .. " (" .. getVehicleNameFromModel(tonumber(mods[2])) .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						elseif isSkin(tonumber(mods[2])) then
							dxDrawText(mods[3] .. " (Skin " .. mods[2] .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						else
							dxDrawText(mods[3] .. " (Object " .. mods[2] .. ")" .. " - " .. (mods[4] and tostring(translations[language].gui_enableState) or tostring(translations[language].gui_disableState)), x+(5/1366)*sx, y, w+x, h+y, tocolor(255, 255, 255, 255), (1/1366)*sx, "default-bold", "left", "center", false, false, true, false, false)
						end
					end
					y = y + (25/768)*sy
				end
			end
		end
   end
)

addEventHandler("onClientFileDownloadComplete", root,
	function(file)
		if duplicates(queue[#queue][2], modQueue) then
			table.insert(modQueue, {queue[#queue][1], queue[#queue][2], queue[#queue][4], false})
		end
		table.remove(queue, #queue)
		download()
	end
)

addCommandHandler("mods",
	function()
		if canShowTheFuckingGUI then
			if window ~= "select" then
				window = "select"
				gui_closeButton = guiCreateButton((594/1366)*sx, (483/768)*sy, (175/1366)*sx, (36/768)*sy, "", false)
				guiSetAlpha(gui_closeButton, 0)
				gui_activeSelected = guiCreateButton((440/1366)*sx, (197/768)*sy, (112/1366)*sx, (36/768)*sy, "", false)
				guiSetAlpha(gui_activeSelected, 0)
				gui_desactiveSelected = guiCreateButton((440/1366)*sx, (243/768)*sy, (112/1366)*sx, (36/768)*sy, "", false)
				guiSetAlpha(gui_desactiveSelected, 0)
				gui_activeAll = guiCreateButton((440/1366)*sx, (291/768)*sy, (112/1366)*sx, (36/768)*sy, "", false)
				guiSetAlpha(gui_activeAll, 0)
				gui_desactiveAll = guiCreateButton((440/1366)*sx, (337/768)*sy, (112/1366)*sx, (36/768)*sy, "", false)
				guiSetAlpha(gui_desactiveAll, 0)
				showCursor(true)
				addEventHandler("onClientGUIClick", root,
					function()
						if source == gui_activeSelected then
							if gridClicked > 0 then
								if modQueue[gridClicked][4] == false then
									local filePath = modQueue[gridClicked][1]:gsub(".txd", ""):gsub(".dff", "")
									local model = modQueue[gridClicked][2]
									if fileExists(filePath .. ".txd") then
										modQueue[gridClicked][4] = true
										local txd = engineLoadTXD(filePath .. ".txd")
										engineImportTXD(txd, model)
									end
									if fileExists(filePath .. ".dff") then
										modQueue[gridClicked][4] = true
										local dff = engineLoadDFF(filePath .. ".dff")
										engineReplaceModel(dff, model)
									end
								end
							end
						elseif source == gui_desactiveSelected then
							if gridClicked > 0 then
								if modQueue[gridClicked][4] == true then
									local model = modQueue[gridClicked][2]
									modQueue[gridClicked][4] = false
									engineRestoreModel(model)
								end
							end
						elseif source == gui_activeAll then
							for _, data in ipairs(modQueue) do
								if data[4] == false then
									local filePath = data[1]:gsub(".txd", ""):gsub(".dff", "")
									local model = data[2]
									if fileExists(filePath .. ".txd") then
										data[4] = true
										local txd = engineLoadTXD(filePath .. ".txd")
										engineImportTXD(txd, model)
									end
									if fileExists(filePath .. ".dff") then
										data[4] = true
										local dff = engineLoadDFF(filePath .. ".dff")
										engineReplaceModel(dff, model)
									end
								end
							end
						elseif source == gui_desactiveAll then
							for _, data in ipairs(modQueue) do
								if data[4] == true then
									data[4] = false
									engineRestoreModel(data[2])
								end
							end
						elseif source == gui_closeButton then
							destroyElement(gui_closeButton)
							destroyElement(gui_activeSelected)
							destroyElement(gui_desactiveSelected)
							destroyElement(gui_activeAll)
							destroyElement(gui_desactiveAll)
							window = nil
							gridClicked = 0
							gridCache = 1
							showCursor(false)
						end
					end
				)
			end
		end
	end
)

bindKey( "mouse_wheel_up", "down",
	function ()
		if #modQueue >= gridRows + 1 then
			gridCache = math.max(gridCache - 1, 1)
		end
	end
)
 
bindKey( "mouse_wheel_down", "down",
	function ()
		if #modQueue >= gridRows + 1 then
			gridCache = math.min(gridCache + 1, #modQueue-gridRows)
		end
	end
)