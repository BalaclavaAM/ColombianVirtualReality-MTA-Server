mainWindow = guiCreateWindow(0.35, 0.16, 0.29, 0.71, "Top jugadores CVR", true)
guiWindowSetSizable(mainWindow, false)

tabPanel = guiCreateTabPanel(0.02, 0.05, 0.95, 0.85, true, mainWindow)

topXp = guiCreateTab("Experiencia", tabPanel)

xpGrid = guiCreateGridList(0.02, 0.03, 0.95, 0.96, true, topXp)
guiGridListAddColumn(xpGrid, "#", 0.5)
guiGridListAddColumn(xpGrid, "Jugador", 0.3)
guiGridListAddColumn(xpGrid, "Experiencia", 0.3)
guiGridListAddColumn(xpGrid, "Nivel", 0.3)

moneyTab = guiCreateTab("Dinero", tabPanel)

moneyGrid = guiCreateGridList(0.02, 0.02, 0.95, 0.96, true, moneyTab)
guiGridListAddColumn(moneyGrid, "#", 0.5)
guiGridListAddColumn(moneyGrid, "Jugador", 0.5)
guiGridListAddColumn(moneyGrid, "Dinero", 0.5)

clubTab = guiCreateTab("Clubes", tabPanel)

clubGrid = guiCreateGridList(0.02, 0.02, 0.95, 0.96, true, clubTab)
guiGridListAddColumn(clubGrid, "#", 0.1)
guiGridListAddColumn(clubGrid, "Club", 0.4)
guiGridListAddColumn(clubGrid, "Puntos Contrareloj", 0.5)



duelosTab = guiCreateTab("Duelos", tabPanel)

duelosGrid = guiCreateGridList(0.02, 0.02, 0.95, 0.96, true, duelosTab)
guiGridListAddColumn(duelosGrid, "#", 0.5)
guiGridListAddColumn(duelosGrid, "Jugador", 0.5)
guiGridListAddColumn(duelosGrid, "Duelos", 0.5)

killsTab = guiCreateTab("Kills/Deaths", tabPanel)

killsGrid = guiCreateGridList(0.02, 0.02, 0.95, 0.96, true, killsTab)
guiGridListAddColumn(killsGrid, "#", 0.2)
guiGridListAddColumn(killsGrid, "Jugador", 0.5)
guiGridListAddColumn(killsGrid, "Kills", 0.1)
guiGridListAddColumn(killsGrid, "Deaths", 0.1)
guiGridListAddColumn(killsGrid, "K/D", 0.1)

tomboTab = guiCreateTab("Tombos", tabPanel)
tomboGrid = guiCreateGridList(0.02, 0.02, 0.95, 0.96, true, tomboTab)
guiGridListAddColumn(tomboGrid, "#", 0.2)
guiGridListAddColumn(tomboGrid, "Jugador", 0.5)
guiGridListAddColumn(tomboGrid, "Arrestos", 0.5)


driftTab = guiCreateTab("Drifters", tabPanel)
driftGrid = guiCreateGridList(0.02, 0.02, 0.95, 0.96, true, driftTab)
guiGridListAddColumn(driftGrid, "#", 0.2)
guiGridListAddColumn(driftGrid, "Jugador", 0.5)
guiGridListAddColumn(driftGrid, "AccionesD", 0.5)
kdTab = guiCreateTab("Eventos", tabPanel)

  
lvlLabel = guiCreateLabel(0.12, 0.90, 0.74, 0.03, "...", true,mainWindow)
duelosLabel = guiCreateLabel(0.12, 0.90, 0.74, 0.03, "...", true,duelosTab)
totalXp = guiCreateLabel(0.12, 0.93, 0.74, 0.03, "...", true, mainWindow)
remainXp = guiCreateLabel(0.12, 0.96, 0.74, 0.03, "...", true, mainWindow) 
 
kdGrid = guiCreateGridList(0.02, 0.03, 0.95, 0.94, true, kdTab)
guiGridListAddColumn(kdGrid, "#", 0.2)
guiGridListAddColumn(kdGrid, "Jugador", 0.2)  
guiGridListAddColumn(kdGrid, "Eventos", 0.2)  
guiSetVisible(mainWindow, false)
guiGridListSetSortingEnabled ( xpGrid, false )
guiGridListSetSortingEnabled ( moneyGrid, false )
guiGridListSetSortingEnabled ( kdGrid, false )

function insertSortingByIndex(array, e)
	local data = array
	for i = 2, #data do
		local j = i - 1
		local ass = data[i]
		while j > 0 and data[j][e] < ass[e] do
			data[j + 1] = data[j]
			j = j - 1
		end
		data[j + 1] = ass
	end
	return data
end


function updateExpClient(q1,q2,q3,q4,q5,infokd,tombos,drift,puntajescontrareloj)
	local level = 10
	guiGridListClear ( xpGrid )
	guiGridListClear ( moneyGrid )
	guiGridListClear ( kdGrid )
	guiGridListClear ( duelosGrid )
	guiGridListClear ( killsGrid )
	guiGridListClear ( tomboGrid )
	guiGridListClear ( driftGrid )
	guiGridListClear ( clubGrid )
	for k, v in ipairs(q1) do
		guiGridListAddRow(xpGrid, tostring(k),q1[k]["Username"],tostring(q1[k]["total"]), tostring(math.floor(q1[k]["total"]/level)))
	end
	for key, value in ipairs(q2) do
		guiGridListAddRow(moneyGrid, tostring(key),q2[key]["Account"],tostring(q2[key]["Balance"]))
	end
	for key, value in ipairs(q4) do
		guiGridListAddRow(kdGrid, tostring(key),q4[key]["Username"],tostring(q4[key]["events"]))
	end
	for key, value in ipairs(q5) do
		guiGridListAddRow(duelosGrid, tostring(key),q5[key]["Username"],tostring(q5[key]["duelos"]))
	end
	for key, value in ipairs(q5) do
		guiGridListAddRow(duelosGrid, tostring(key),q5[key]["Username"],tostring(q5[key]["duelos"]))
	end
	for key, value in ipairs(infokd) do
		guiGridListAddRow(killsGrid, tostring(key),infokd[key]["Username"],tostring(infokd[key]["Kills"]),tostring(infokd[key]["Deaths"]),tostring(infokd[key]["(`Kills`/`Deaths`)"]))
	end
	for key, value in ipairs(tombos) do
		guiGridListAddRow(tomboGrid, tostring(key),tombos[key]["Username"],tostring(tombos[key]["Arrests"]))
	end
	for key, value in ipairs(drift) do
		guiGridListAddRow(driftGrid, tostring(key),drift[key]["Username"],tostring(drift[key]["DriftPoints"]))
	end


	local puntajesordenados = insertSortingByIndex(puntajescontrareloj, 2)
	for k, puntajes in pairs(puntajesordenados) do
		guiGridListAddRow(clubGrid,k,puntajes[1],puntajes[2])
	end
	guiGridListAutoSizeColumn ( duelosGrid, 1 )
	guiGridListAutoSizeColumn ( moneyGrid, 1 )
	guiGridListAutoSizeColumn ( xpGrid, 1 )
	guiGridListAutoSizeColumn ( killsGrid, 1 )
	guiGridListAutoSizeColumn ( tomboGrid, 1 )
	guiGridListAutoSizeColumn ( driftGrid, 1 )
	guiSetText(lvlLabel,"Tu nivel total: "..tostring(math.floor(q3[1]["total"]/level)))
	guiSetText(totalXp,"Experiencia total: "..tostring(math.floor(q3[1]["total"])))
	guiSetText(remainXp,"Siguiente nivel en: "..tostring(level-((q3[1]["total"]/level)-math.floor(q3[1]["total"]/level))*level))
	guiSetText(duelosLabel,"Para que un duelo sea válido tienes que apostar mínimo 51000")
end
addEvent ( "updateExpClient", true )
addEventHandler ( "updateExpClient", localPlayer, updateExpClient )

local cooldown=false

bindKey( "F10", "down", function()
	if not cooldown or getTickCount()-cooldown>60000 then
		if guiGetVisible(mainWindow) then
			guiSetVisible(mainWindow, false)
			showCursor(false)
			cooldown=getTickCount()
		else
			guiSetVisible(mainWindow, true)
			showCursor(true)
			if not expTime then
				expTime = getTickCount ()
				triggerServerEvent ( "serverQueryExp", resourceRoot, localPlayer)
			else if getTickCount() - expTime <= 20000 then

			else if getTickCount() - expTime >= 20000 then 
				expTime = getTickCount()
				triggerServerEvent ( "serverQueryExp", resourceRoot, localPlayer)
				
			end
			end
			end
		end
	else
		outputChatBox("Solo puedes ver la tabla de experiencia cada 60 sg")
	end
end ) 

