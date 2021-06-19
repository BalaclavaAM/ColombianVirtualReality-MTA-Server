local modsSize = 0
local queue = {}
local translationCountry, guiColorR, guiColorG, guiColorB, errors

addEventHandler("onResourceStart", resourceRoot,
	function()
		local author = getResourceInfo(getThisResource(), "author")
		if (author == "Dannys (AFK)") then
			local meta = xmlLoadFile("meta.xml")
			for _, node in ipairs(xmlNodeGetChildren(meta)) do
				local nodeName = xmlNodeGetName(node)
				if nodeName == "translation" then
					translationCountry = xmlNodeGetAttribute(node, "language")
				elseif nodeName == "gui" then
					local r, g, b = xmlNodeGetAttribute(node, "r"), xmlNodeGetAttribute(node, "g"), xmlNodeGetAttribute(node, "b")
					local r, g, b = tonumber(r), tonumber(g), tonumber(b)
					if r and g and b then
						guiColorR, guiColorG, guiColorB = r, g, b
					else
						outputDebugString("[" .. resname  .. "] You have an error on 'meta.xml', the syntax of color code is wrong.")
						errors = true
						cancelEvent()
					end
				elseif nodeName == "file" then
					if not errors then
						local file = xmlNodeGetAttribute(node, "src")
						local model = xmlNodeGetAttribute(node, "model")
						local name = xmlNodeGetAttribute(node, "displayName")
						local openedFile = fileOpen(file)
						local size = fileGetSize(openedFile)
						modsSize = modsSize + size
						fileClose(openedFile)
						table.insert(queue, {file, model, size, name})
					end
				end
			end
			if not errors then
				outputDebugString("[" .. resname  .. "] Started, loaded " .. sizeFormat(modsSize) .. " - Language: " .. translationCountry .. ".")
			end
			xmlUnloadFile(meta)
		else
			outputDebugString("AFK say: You edited author in the meta.xml, ¡don't remove the fucking credits! Stopping '" .. resname .. "' ...")
			cancelEvent()
		end
	end
)

function download(player)
	if player then
		triggerClientEvent(resname .. ":startDownload", player, queue, modsSize, translationCountry, guiColorR, guiColorG, guiColorB)
	end
end
addEvent("afkdownloader:startDownload", true)
addEventHandler("afkdownloader:startDownload", root, download)