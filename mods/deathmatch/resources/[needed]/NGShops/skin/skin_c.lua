local skins = {
	{0, "CJ", 15000},
	{1, "Pandillero", 40000},
	{2, "Maccer", 150000},
	{9, "Rick The Walking Dead", 40000},
	{10, "Spiderman", 250000},
	{11, "Asuka - Evangelion", 30000},
	{12, "GTA V - Atraco", 250000},
	{13, "Akali", 70000},
	{14, "Paraco", 70000},
	{15, "Slenderman", 150000},
	{16, "GTA Online Random", 70000},
	{18, "Vegetta DBZ", 50000},
	{19, "Jotaro - Jojo's", 100000},
	{20, "Dio - Jojo's", 45000},
	{21, "Santa Marta", 150000},
	{22, "Takumi - Initial.D", 100000},
	{23, "Popeye", 0},
	{24, "James", 250000},
	{25, "Yandere", 80000},
	{26, "Bender", 30000},
	{27, "Vendedor de Bonice", 15000},
	{28, "S o r n e r o"},
	{29, "Maduro", 150000},
	{30, "Toretto", 60000},
	{31, "Momo", 40000},
	{32, "Pandillero 2", 45000},
	{33, "Espia Robot", 70000},
	{34, "Shoto Todoroki", 45000},
	{35, "Fornite Skin 1", 50000},
	{36, "Fornite Skin 2", 50000},
	{37, "Hombre Casual 1", 30000},
	{38, "Hombre Casual 2", 30000},
	{39, "Marihuanero", 40000},
	{40, "Mujer HelloKitty", 50000},
	{41, "Sengoku Otome", 55000},
	{102, "Santa Fe Barrista 1", 100000},
	{103, "Crash Bandicoot - Crash Bandicoot", 50000},
	{104, "Miracle Girls Fiesta - Kyouko Toshinou", 50000},
	{148, "Sinon - Sword Art", 50000},
	{262, "Eva Series 01 - Evangelion", 40000},
	{146, "Shinji - Evangelion", 150000},
	{56, "Samus Aran Zero Suit - Metroid", 56000},
	{150, "Luffy", 25000},
	{147, "Motociclista", 50000},
	{257, "Kurumi Tokisaki - Date A Live", 35000},
	{175, "Giorno Giovanna - Jojo's", 45000},
	{138, "PayDay Skin", 100000},
	{139, "Kagamine Len", 40000},
	{140, "Caleño", 85000},
	{143, "Don Ramón", 25000},
	{144, "Fornite Skin 3", 40000},
	{153, "Lucario", 100000},
	{154, "Nick Wilde - Zootopia", 40000},
	{156, "Condorito", 40000},
	{160, "Pablo Escobar", 250000},
	{107, "Ruby Love Live", 50000},
	{127, "Tarzan - Tarzan", 100000},
	{114, "Barrista Millonarios 1", 15000},
	{115, "Barrista Millonarios 2", 100000},
	{116, "Barrista Millonarios 3", 100000},
	{105, "Barrista Atlético Nacional 1", 150000},
	{106, "Barrista Atlético Nacional 2", 150000},
	{90, "Yandere - Yandere Simulator", 50000},
	{239, "Rick - Rick y Morty", 70000},
	{54, "Rin - Love Live", 25000},
	{69, "Nico - Love Live", 150000},
	{67, "Limonagrio - Hora de Aventura", 100000},
	{68, "Keanu Reeves", 250000},
	{303, "Steve", 50000},
	{301, "Franklin - GTA V", 100000},
	{308, "Michael - GTA V", 80000},
	{307, "Trevor - GTA V", 90000},
	{210, "Ricardo Milos", 60000},
	{222, "Mujer Casual 2", 25000},
	{238, "Travis Scott", 95000},
	{224, "Rem", 55000},
	{226, "Airi - Oni Chichi", 40000},
	{232, "Winnie Pooh", 50000},
	{240, "Joker 2019", 250000},
	{241, "Mujer", 40000},
	{70, "Jefe Maestro - Halo", 250000},
	{71, "Paul Walker", 50000},
	{49, "Ben 10", 40000},
	{82, "Donkey Kong", 75000},
	{204, "Naruto", 50000},
	{205, "Lala - To Love Ru", 40000},
	{207, "Ladybug", 30000},
	{209, "Goofy", 50000},
	{211, "Hannah Montana", 0},
	{304, "Vendedor de Vive100", 40000},
	{312, "Yasuo", 50000},
	{198, "Mujer 2", 20000},
	{172, "Hombre Casual 3", 30000},
	{99, "Arthur Morgan"},
	{93, "Megu", 50000},
	{94, "Akatsuki1", 100000},
	{95, "Akatsuki2", 100000},
	{96, "Akatsuki3", 100000},
	{92, "Mujer Casual", 55000},
	{100, "Akatsuki4", 100000},
	{101, "Akatsuki5", 100000},
	{159, "Akatsuki6", 100000},
	{108, "Akatsuki7", 100000},
	{109, "Hombre Casual 4", 0},
	{129, "Aqua - Konosuba", 65000},
	{130, "Caitlyn", 50000},
	{165, "Alvaro Uribe", 50000},
	{63, "Maika Sakuranomiya", 250000},
	{250, "Skin Leo Messi", 350000},
	{252, "Skin Trunks del Futuro", 100000},
	{258, "Skin Piccolo", 150000},
	{259, "Skin Fiona Ogro", 45000},
	{53, "Shinohara Miyu Sword Art: Militar", 150000},
	{201, "Rei Ayanami", 150000}
}

local skinsd = {
	{110, "Marshmello", "Drifter Especialista"},
	{111, "Wrench", "Keisuke Takahashi"},
	{188, "Hatsune Miku!", "Han"},
	{112, "Sasuke Uchiha", "Han"},
	{113, "Deadmau 5", "Ryosuke Takahashi"},
	{118, "Bob Esponja", "Takumi Fujiwara"},
	{97, "Takumi Fujiwara", "Takumi Fujiwara"}
}

local skinsc = {
	{43, "DeadPool", "Respetado"},
	{145, "Deku", "Lider de combo"},
	{151, "Goku", "Paraco"},
	{161, "Shaggy", "Narcotraficante"},
	{163, "Tommy Vercetti", "Pablo Escobar"}
}

local SkinLocs = {
	[1] = {
		outPos = {1459.16, -1140.48, 24.06},
		inPos = {180.5, -88.39, 1002.02},
		int = 18,
		dim = 1
	},
	[2] = {
		outPos = {2244.91, -1662.91, 15.48},
		inPos = {180.5, -88.39, 1002.02},
		int = 18,
		dim = 2
	}
}

local SkinDrifter = {
	[1] = {
		outPos = {-313.98, 1774.64, 43.64 + 2},
		inPos = {214.94, -156.2, 1000.52},
		int = 14,
		dim = 3
	}
}

local SkinCriminal = {
	[1] = {
		outPos = {1665.52, -1509.65, 13.55},
		inPos = {201.78, -4.54, 1001.21},
		int = 5,
		dim = 0
	}
}
local skinsesmeralda = {
	{122, "Skin Esmeralda1"},--comprada maga oscura
	{123, "Skin Esmeralda2"},
	{124, "Skin Esmeralda3"},
	{126, "Skin Esmeralda5"},
	{128, "Skin Esmeralda6"},
	{131, "Skin Esmeralda7"},
	{164, "Skin Esmeralda8"},
	{166, "Skin Esmeralda9"},
	{167, "Skin Esmeralda10"},
	{168, "Skin Esmeralda11"},
}

exports.ngwarpmanager:makeWarp(
	{
		pos = {-313.98, 1774.64, 43.64 + 1},
		toPos = {204.47, -168.55, 1000.52 + 2},
		cInt = 0,
		cDim = 0,
		tInt = 14,
		tDim = 3
	}
)
exports.ngwarpmanager:makeWarp(
	{
		pos = {204.47, -168.55, 1000.52 + 1},
		toPos = {-313.98, 1774.64, 43.64 + 2},
		cInt = 14,
		cDim = 3,
		tInt = 0,
		tDim = 0
	}
)

exports.ngwarpmanager:makeWarp(
	{pos = {1457.73, -1137.21, 24.97}, toPos = {161.4, -93.15, 1002}, cInt = 0, cDim = 0, tInt = 18, tDim = 1}
)
exports.ngwarpmanager:makeWarp(
	{pos = {161.28, -96.31, 1002.8}, toPos = {1459.16, -1140.48, 24.2}, cInt = 18, cDim = 1, tInt = 0, tDim = 0}
)

exports.ngwarpmanager:makeWarp(
	{pos = {2244.48, -1664.79, 16.48}, toPos = {161.4, -93.15, 1002}, cInt = 0, cDim = 0, tInt = 18, tDim = 2}
)
exports.ngwarpmanager:makeWarp(
	{pos = {161.28, -96.31, 1002.8}, toPos = {2245.4, -1661.95, 16}, cInt = 18, cDim = 2, tInt = 0, tDim = 0}
)

exports.ngwarpmanager:makeWarp(
	{pos = {-87.88, 1378.38, 10.27}, toPos = {-228.61, 1400.99, 27.77}, cInt = 0, cDim = 0, tInt = 18, tDim = 0}
)
exports.ngwarpmanager:makeWarp(
	{pos = {-228.61, 1400.99, 27.77}, toPos = {-87.88, 1378.38, 10.27}, cInt = 18, cDim = 0, tInt = 0, tDim = 0}
)
--criminals
exports.ngwarpmanager:makeWarp(
	{pos = {1667.54, -1509.82, 14.55}, toPos = {226.82, -9.12, 1003.21}, cInt = 0, cDim = 0, tInt = 5, tDim = 0}
)
exports.ngwarpmanager:makeWarp(
	{pos = {226.82, -9.12, 1003.21}, toPos = {1667.54, -1509.82, 14.55}, cInt = 5, cDim = 0, tInt = 0, tDim = 0}
)

local markers = {}
local markers2 = {}
local markers3 = {}
local sx, sy = guiGetScreenSize()
local org = {}

function onClientMarkerSkinDrifterHit(p)
	if
		(p ~= localPlayer or getElementDimension(localPlayer) ~= getElementDimension(source) or
			getElementInterior(source) ~= getElementInterior(localPlayer))
	 then
		return
	end
	org.skin = getElementModel(p)

	window = guiCreateWindow(10, (sy / 2 - 403 / 2), 222, 403, "Tienda de Skins", false)
	guiWindowSetSizable(window, false)
	tmp2 = guiCreateLabel(14, 34, 98, 30, "Precio:", false, window)
	list = guiCreateGridList(13, 64, 197, 278, false, window)
	guiGridListAddColumn(list, "", 0.9)
	tmp1 = guiCreateLabel(112, 34, 98, 30, "Todas las skins valen entre 0 y 250000", false, window)
	cancel = guiCreateButton(13, 352, 85, 32, "Cancelar", false, window)
	buy = guiCreateButton(102, 352, 85, 32, "Comprar Skin", false, window)
	showCursor(true)
	for i, v in pairs(skinsd) do
		local r = guiGridListAddRow(list)
		guiGridListSetItemText(list, r, 1, tostring(v[2]), false, false)
	end

	addEventHandler("onClientGUIClick", root, onClientGUIClick_Skin2)
end

function onClientMarkerSkinCriminalHit(p)
	if
		(p ~= localPlayer or getElementDimension(localPlayer) ~= getElementDimension(source) or
			getElementInterior(source) ~= getElementInterior(localPlayer))
	 then
		return
	end
	org.skin = getElementModel(p)

	window = guiCreateWindow(10, (sy / 2 - 403 / 2), 222, 403, "Tienda de Skins", false)
	guiWindowSetSizable(window, false)
	tmp2 = guiCreateLabel(14, 34, 98, 30, "Precio:", false, window)
	list = guiCreateGridList(13, 64, 197, 278, false, window)
	guiGridListAddColumn(list, "", 0.9)
	tmp1 = guiCreateLabel(112, 34, 98, 30, "Todas las skins valen entre 0 y 250000", false, window)
	cancel = guiCreateButton(13, 352, 85, 32, "Cancelar", false, window)
	buy = guiCreateButton(102, 352, 85, 32, "Comprar Skin", false, window)
	showCursor(true)
	for i, v in pairs(skinsc) do
		local r = guiGridListAddRow(list)
		guiGridListSetItemText(list, r, 1, tostring(v[2]), false, false)
	end

	addEventHandler("onClientGUIClick", root, onClientGUIClick_Skin3)
end

function onClientMarkerSkinHit(p)
	if
		(p ~= localPlayer or getElementDimension(localPlayer) ~= getElementDimension(source) or
			getElementInterior(source) ~= getElementInterior(localPlayer))
	 then
		return
	end
	org.skin = getElementModel(p)

	window = guiCreateWindow(10, (sy / 2 - 403 / 2), 222, 403, "Tienda de Skins", false)
	guiWindowSetSizable(window, false)
	tmp2 = guiCreateLabel(14, 34, 98, 30, "Precio", false, window)
	list = guiCreateGridList(13, 64, 197, 278, false, window)
	guiGridListAddColumn(list, "", 0.9)
	tmp1 = guiCreateLabel(112, 34, 98, 30, "Todas las skins\nValen entre 0 y 250.000", false, window)
	cancel = guiCreateButton(13, 352, 85, 32, "Cancelar", false, window)
	buy = guiCreateButton(102, 352, 85, 32, "Comprar Skin", false, window)
	showCursor(true)
	for i, v in pairs(skins) do
		local r = guiGridListAddRow(list)
		guiGridListSetItemText(list, r, 1, tostring(v[2]), false, false)
	end

	addEventHandler("onClientGUIClick", root, onClientGUIClick_Skin)
end
--------------------------------------------------------------------------------------------------------------------------------





function guiskins(lista)
	org.skin = getElementModel(localPlayer )

	window = guiCreateWindow(10, (sy / 2 - 403 / 2), 222, 403, "Selector de Skins", false)
	guiWindowSetSizable(window, false)
	list = guiCreateGridList(13, 38, 197, 282, false, window)
	guiGridListAddColumn(list, "", 0.9)
	cancel = guiCreateButton(13, 352, 85, 32, "Cancelar", false, window)
	buy = guiCreateButton(122, 352, 85, 32, "Poner Skin", false, window)
	showCursor(true)
	for i, v in pairs(skins) do
		for y,a in pairs(lista) do
	      if (v[1]==a) then
			local r = guiGridListAddRow(list)
			guiGridListSetItemText(list, r, 1,v[2] , false, false)
		  end
	    end

	end
	addEventHandler("onClientGUIClick", root, onClientGUIClick_Skins)
end
addEvent( "NGShop::GuiSkin", true )
addEventHandler( "NGShop::GuiSkin", localPlayer, guiskins )


function guiskinsesmeralda(lista)
	org.skin = getElementModel(localPlayer )
	
	window = guiCreateWindow(10, (sy / 2 - 403 / 2), 222, 403, "Selector de Skins Esmeralda", false)
	guiWindowSetSizable(window, false)
	list = guiCreateGridList(13, 38, 197, 282, false, window)
	guiGridListAddColumn(list, "", 0.9)
	cancel = guiCreateButton(13, 352, 85, 32, "Cancelar", false, window)
	buy = guiCreateButton(122, 352, 85, 32, "Poner Skin", false, window)
	showCursor(true)
	for i, v in pairs(skinsesmeralda) do
		for y,a in pairs(lista) do
	      if (v[1]==a) then
			local r = guiGridListAddRow(list)
			guiGridListSetItemText(list, r, 1,v[2] , false, false)
		  end
	    end

	end
	addEventHandler("onClientGUIClick", root, onClientGUIClick_Skinsesmeralda)
end
addEvent( "NGShop::GuiSkinesmeralda", true )
addEventHandler( "NGShop::GuiSkinesmeralda", localPlayer, guiskinsesmeralda)








----------------------------------------------------------------------------------------------------------------------------------------
function onClientMarkerSkinHit2(p)
	if
		(p ~= localPlayer or getElementDimension(localPlayer) ~= getElementDimension(source) or
			getElementInterior(source) ~= getElementInterior(localPlayer))
	 then
		return
	end
	local rango = getElementData(localPlayer, "Job Rank")
	org.skin = getElementModel(p)

	window = guiCreateWindow(10, (sy / 2 - 403 / 2), 222, 403, "Tienda de Skins", false)
	guiWindowSetSizable(window, false)
	tmp2 = guiCreateLabel(14, 34, 98, 30, "Skins Disponibles", false, window)
	list = guiCreateGridList(13, 64, 197, 278, false, window)
	guiGridListAddColumn(list, "", 0.9)
	tmp1 = guiCreateLabel(112, 34, 98, 30, "Todas las skins\nValen $12,000", false, window)
	cancel = guiCreateButton(13, 352, 85, 32, "Cancelar", false, window)
	buy = guiCreateButton(102, 352, 85, 32, "Comprar Skin", false, window)
	showCursor(true)
	for i, v in pairs(skins) do
		local r = guiGridListAddRow(list)
		guiGridListSetItemText(list, r, 1, tostring(v[2]), false, false)
	end

	addEventHandler("onClientGUIClick", root, onClientGUIClick_Skin)
end

function onClientGUIClick_Skin()
	if (source == list) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return
		end
		local t = guiGridListGetItemText(source, r, 1)
		for i, v in pairs(skins) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				setElementModel(localPlayer, v[1])
				guiSetText(tmp1, tostring(v[3]))
				break
			end
		end
	elseif (source == cancel) then
		closeSkinShop(true)
	elseif (source == buy) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return exports.NGMessages:sendClientMessage("No has seleccionado una skin", 255, 255, 255)
		end
		local t = guiGridListGetItemText(list, r, 1)
		local price = 0
		for i, v in pairs(skins) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				sI = v[1]
				price = v[3] or 0
				break
			end
		end

		if (sI == org.skin) then
			return exports.NGMessages:sendClientMessage("Esta ya es tu skin", 255, 255, 0)
		end

		if (getPlayerMoney(localPlayer) < price) then
			return exports.NGMessages:sendClientMessage(
				"No tienes los " .. tostring(price) .. " para comprar la skin",
				255,
				0,
				0
			)
		end
		closeSkinShop(true)
		triggerServerEvent("NGShops:Skin:UpdatePlayerDefaultSkin", localPlayer, sI, price)
	end
end
----------------------------------------------------------------------------------------------------------------------------------







function onClientGUIClick_Skins()
	if (source == list) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return
		end
		local t = guiGridListGetItemText(source, r, 1)
		for i, v in pairs(skins) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				setElementModel(localPlayer, v[1])
				break
			end
		end
	elseif (source == cancel) then
		closeSkinPoner(true)
	elseif (source == buy) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return exports.NGMessages:sendClientMessage("No has seleccionado una skin", 255, 255, 255)
		end
		local t = guiGridListGetItemText(list, r, 1)
		local price = 0
		for i, v in pairs(skins) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				sI = v[1]
				price = v[3] or 0
				break
			end
		end
		closeSkinPoner(true)
		triggerServerEvent("NGShops:Skin:UpdatePlayerDefaultSkin", localPlayer, sI, price)
	end
end

function onClientGUIClick_Skinsesmeralda()
	if (source == list) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return
		end
		local t = guiGridListGetItemText(source, r, 1)
		for i, v in pairs(skinsesmeralda) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				setElementModel(localPlayer, v[1])
				break
			end
		end
	elseif (source == cancel) then
		closeSkinPoneresmeralda(true)
	elseif (source == buy) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return exports.NGMessages:sendClientMessage("No has seleccionado una skin", 255, 255, 255)
		end
		local t = guiGridListGetItemText(list, r, 1)
		local price = 0
		for i, v in pairs(skinsesmeralda) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				sI = v[1]
				price = v[3] or 0
				break
			end
		end
		closeSkinPoneresmeralda(true)
		triggerServerEvent("NGShops:Skin:UpdatePlayerDefaultSkin", localPlayer, sI, price)
	end
end





---------------------------------------------------------------------------------------------------------------------------------
function onClientGUIClick_Skin2()
	if (source == list) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return
		end
		local t = guiGridListGetItemText(source, r, 1)
		for i, v in pairs(skinsd) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				setElementModel(localPlayer, v[1])
				break
			end
		end
	elseif (source == cancel) then
		closeSkinShop2(true)
	elseif (source == buy) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return exports.NGMessages:sendClientMessage("No has seleccionado una skin", 255, 255, 255)
		end
		local t = guiGridListGetItemText(list, r, 1)
		for i, v in pairs(skinsd) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				sI = v[1]
				rankNeeded = v[3]
				break
			end
		end

		if (sI == org.skin) then
			return exports.NGMessages:sendClientMessage("Esta ya es tu skin", 255, 255, 0)
		end
		local rango = getElementData(localPlayer, "Job Rank")
		if rankNeeded == "Drifter Especialista" then
			if
				not (rango == "Drifter Especialista" or rango == "Keisuke Takahashi" or rango == "Han" or
					rango == "Ryosuke Takahashi" or
					rango == "Takumi Fujiwara")
			 then
				return exports.NGMessages:sendClientMessage(
					"Necesitas tener rango Drifter Especialista para obtener esta skin",
					255,
					0,
					0
				)
			end
		elseif rankNeeded == "Keisuke Takahashi" then
			if not (rango == "Keisuke Takahashi" or rango == "Han" or rango == "Ryosuke Takahashi" or rango == "Takumi Fujiwara") then
				return exports.NGMessages:sendClientMessage(
					"Necesitas tener rango Keisuke Takahashi para obtener esta skin",
					255,
					0,
					0
				)
			end
		elseif rankNeeded == "Han" then
			if not (rango == "Han" or rango == "Ryosuke Takahashi" or rango == "Takumi Fujiwara") then
				return exports.NGMessages:sendClientMessage("Necesitas tener rango Han para obtener esta skin", 255, 0, 0)
			end
		elseif rankNeeded == "Ryosuke Takahashi" then
			if not (rango == "Ryosuke Takahashi" or rango == "Takumi Fujiwara") then
				return exports.NGMessages:sendClientMessage(
					"Necesitas tener rango Ryosuke Takahashi para obtener esta skin",
					255,
					0,
					0
				)
			end
		elseif rankNeeded == "Takumi Fujiwara" then
			if not (rango == "Takumi Fujiwara") then
				return exports.NGMessages:sendClientMessage(
					"Necesitas tener rango Takumi Fujiwara para obtener esta skin",
					255,
					0,
					0
				)
			end
		end

		if (getPlayerMoney(localPlayer) < 29000) then
			return exports.NGMessages:sendClientMessage("No tienes los 29mil para comprar la skin", 255, 0, 0)
		end
		closeSkinShop2(true)
		triggerServerEvent("NGShops:Skin:UpdatePlayerDefaultSkin", localPlayer, sI)
	end
end

function onClientGUIClick_Skin3()
	if (source == list) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return
		end
		local t = guiGridListGetItemText(source, r, 1)
		for i, v in pairs(skinsc) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				setElementModel(localPlayer, v[1])
				break
			end
		end
	elseif (source == cancel) then
		closeSkinShop2(true)
	elseif (source == buy) then
		local r, c = guiGridListGetSelectedItem(list)
		if (row == -1) then
			return exports.NGMessages:sendClientMessage("No has seleccionado una skin", 255, 255, 255)
		end
		local t = guiGridListGetItemText(list, r, 1)
		for i, v in pairs(skinsc) do
			if (tostring(v[2]):lower() == tostring(t):lower()) then
				sI = v[1]
				rankNeeded = v[3]
				break
			end
		end

		if (sI == org.skin) then
			return exports.NGMessages:sendClientMessage("Esta ya es tu skin", 255, 255, 0)
		end
		local rango = getElementData(localPlayer, "Job Rank")
		if rankNeeded == "Respetado" then
			if
				not (rango == "Respetado" or rango == "Lider de combo" or rango == "Paraco" or rango == "Narcotraficante" or
					rango == "Pablo Escobar")
			 then
				return exports.NGMessages:sendClientMessage("Necesitas tener rango Respetado para obtener esta skin", 255, 0, 0)
			end
		elseif rankNeeded == "Lider de combo" then
			if not (rango == "Lider de combo" or rango == "Paraco" or rango == "Narcotraficante" or rango == "Pablo Escobar") then
				return exports.NGMessages:sendClientMessage(
					"Necesitas tener rango Lider de combo para obtener esta skin",
					255,
					0,
					0
				)
			end
		elseif rankNeeded == "Paraco" then
			if not (rango == "Paraco" or rango == "Narcotraficante" or rango == "Pablo Escobar") then
				return exports.NGMessages:sendClientMessage("Necesitas tener rango Paraco para obtener esta skin", 255, 0, 0)
			end
		elseif rankNeeded == "Narcotraficante" then
			if not (rango == "Narcotraficante" or rango == "Pablo Escobar") then
				return exports.NGMessages:sendClientMessage(
					"Necesitas tener rango Narcotraficante para obtener esta skin",
					255,
					0,
					0
				)
			end
		elseif rankNeeded == "Pablo Escobar" then
			if not (rango == "Pablo Escobar") then
				return exports.NGMessages:sendClientMessage("Necesitas tener rango Pablo Escobar para obtener esta skin", 255, 0, 0)
			end
		end

		if (getPlayerMoney(localPlayer) < 29000) then
			return exports.NGMessages:sendClientMessage("No tienes los 29mil para comprar la skin", 255, 0, 0)
		end
		closeSkinShop3(true)
		triggerServerEvent("NGShops:Skin:UpdatePlayerDefaultSkin", localPlayer, sI)
	end
end

function closeSkinShop(rSkin)
	removeEventHandler("onClientGUIClick", root, onClientGUIClick_Skin)
	destroyElement(tmp2)
	destroyElement(tmp1)
	destroyElement(list)
	destroyElement(buy)
	destroyElement(cancel)
	destroyElement(window)
	showCursor(false)
	if (rSkin) then
		setElementModel(localPlayer, org.skin)
	end
end

function closeSkinPoner(rSkin)
	removeEventHandler("onClientGUIClick", root, onClientGUIClick_Skins)

	destroyElement(list)
	destroyElement(buy)
	destroyElement(cancel)
	destroyElement(window)
	showCursor(false)
	if (rSkin) then
		setElementModel(localPlayer, org.skin)
	end
end

function closeSkinPoneresmeralda(rSkin)
	removeEventHandler("onClientGUIClick", root, onClientGUIClick_Skinsesmeralda)

	destroyElement(list)
	destroyElement(buy)
	destroyElement(cancel)
	destroyElement(window)
	showCursor(false)
	if (rSkin) then
		setElementModel(localPlayer, org.skin)
	end
end

function closeSkinShop2(rSkin)
	removeEventHandler("onClientGUIClick", root, onClientGUIClick_Skin2)
	destroyElement(tmp2)
	destroyElement(tmp1)
	destroyElement(list)
	destroyElement(buy)
	destroyElement(cancel)
	destroyElement(window)
	showCursor(false)
	if (rSkin) then
		setElementModel(localPlayer, org.skin)
	end
end

function closeSkinShop3(rSkin)
	removeEventHandler("onClientGUIClick", root, onClientGUIClick_Skin3)
	destroyElement(tmp2)
	destroyElement(tmp1)
	destroyElement(list)
	destroyElement(buy)
	destroyElement(cancel)
	destroyElement(window)
	showCursor(false)
	if (rSkin) then
		setElementModel(localPlayer, org.skin)
	end
end

for i, s in pairs(SkinLocs) do
	local x, y, z = unpack(s.inPos)
	markers[i] = createMarker(x, y, z - 1, "cylinder", 2.5, 255, 50, 50, 200)
	setElementInterior(markers[i], s.int)
	setElementDimension(markers[i], s.dim)
	local d = {
		int = s.int,
		dim = s.dim
	}
	setElementData(markers[i], "NGShops:Skins->MarkerInfo", d)
	addEventHandler("onClientMarkerHit", markers[i], onClientMarkerSkinHit)
end

for i, s in pairs(SkinDrifter) do
	local x, y, z = unpack(s.inPos)
	markers2[i] = createMarker(x, y, z - 1, "cylinder", 2.5, 255, 50, 50, 200)
	setElementInterior(markers2[i], s.int)
	setElementDimension(markers2[i], s.dim)
	local d = {
		int = s.int,
		dim = s.dim
	}
	setElementData(markers2[i], "NGShops:Skins->MarkerInfo", d)
	addEventHandler("onClientMarkerHit", markers2[i], onClientMarkerSkinDrifterHit)
end
for i, s in pairs(SkinCriminal) do
	local x, y, z = unpack(s.inPos)
	markers3[i] = createMarker(x, y, z - 1, "cylinder", 2.5, 255, 50, 50, 200)
	setElementInterior(markers3[i], s.int)
	setElementDimension(markers3[i], s.dim)
	local d = {
		int = s.int,
		dim = s.dim
	}
	setElementData(markers3[i], "NGShops:Skins->MarkerInfo", d)
	addEventHandler("onClientMarkerHit", markers3[i], onClientMarkerSkinCriminalHit)
end

addEvent("onClientPlayerLogin", true)
addEventHandler(
	"onClientPlayerLogin",
	root,
	function()
		if (exports.NGPhone:getSetting("usersetting_display_skinshopblips")) then
			blips = {}
			for i, v in pairs(SkinLocs) do
				local x, y, z = unpack(v.outPos)
				blips[i] = createBlip(x, y, z, 45, 2, 255, 255, 255, 255, 0, 450)
			end
			blips2 = {}
			for i, v in pairs(SkinDrifter) do
				local x, y, z = unpack(v.outPos)
				blips2[i] = createBlip(x, y, z, 45, 2, 255, 255, 255, 255, 0, 450)
			end
			blips3 = {}
			for i, v in pairs(SkinCriminal) do
				local x, y, z = unpack(v.outPos)
				blips3[i] = createBlip(x, y, z, 45, 2, 255, 255, 255, 255, 0, 450)
			end
		end
	end
)

addEvent("onClientUserSettingChange", true)
addEventHandler(
	"onClientUserSettingChange",
	root,
	function(g, v)
		if (g == "usersetting_display_skinshopblips") then
			if (v and not blips) then
				blips = {}
				for i, v in pairs(SkinLocs) do
					local x, y, z = unpack(v.outPos)
					blips[i] = createBlip(x, y, z, 45, 2, 255, 255, 255, 255, 0, 450)
				end
				blips2 = {}
				for i, v in pairs(SkinDrifter) do
					local x, y, z = unpack(v.outPos)
					blips2[i] = createBlip(x, y, z, 45, 2, 255, 255, 255, 255, 0, 450)
				end
				blips3 = {}
				for i, v in pairs(SkinCriminal) do
					local x, y, z = unpack(v.outPos)
					blips3[i] = createBlip(x, y, z, 45, 2, 255, 255, 255, 255, 0, 450)
				end
			elseif (not v and blips) then
				for i, v in pairs(blips) do
					destroyElement(v)
				end
				blips = nil
			end
		end
	end
)

local ropa = {
	{"Camiseta Colombia", 3, 50000},
	{"Camiseta Junior", 51, 50000},
	{"Camiseta Nacional", 52, 50000},
	{"Camiseta Tolima",  10, 50000},
	{"Camiseta Pereira",  26, 50000},
	{"Camiseta Medellin", 53, 50000},
	{"Camiseta Santa Fe", 25, 50000},
	{"Camiseta America", 20, 50000},
	{"Camiseta Millonarios", 45, 50000},
	{"Camiseta Cali", 46, 50000},
	{"Camiseta Bucaramanga", 29, 50000}
}

function panelRopaCiyei(e,f)
	if e==localPlayer and f then
		org.skin = getElementModel(localPlayer )

		ventanaciyei = guiCreateWindow(10, (sy / 2 - 403 / 2), 222, 403, "Tienda de Ropa CJ", false)
		guiWindowSetSizable(ventanaciyei, false)
		tintin = guiCreateLabel(14, 34, 98, 30, "Ropa Disponible", false, ventanaciyei)
		listaventana = guiCreateGridList(13, 64, 197, 278, false, ventanaciyei)
		guiGridListAddColumn(listaventana, "", 0.9)
		aprrapparap = guiCreateLabel(112, 34, 98, 30, "Todas las skins\nValen $12,000", false, ventanaciyei)
		cancelasion = guiCreateButton(13, 352, 85, 32, "Cancelar", false, ventanaciyei)
		comprasion = guiCreateButton(102, 352, 85, 32, "Comprar Ropa", false, ventanaciyei)
		showCursor(true)
		for i, v in ipairs(ropa) do
			local r = guiGridListAddRow(listaventana,v[1])
			guiSetText(aprrapparap,"Precio\n"..v[3])
		end

		addEventHandler("onClientGUIClick", root, onClientGUIClick_Camiseta)
	end
end

function closeShirtShop(rSkin)
	if (rSkin) then
		triggerServerEvent("NGShops:quitarRopa",localPlayer,org.skin)
	end
	destroyElement(ventanaciyei)
	showCursor(false)
end

function onClientGUIClick_Camiseta()
	if (source == listaventana) then
		local r, c = guiGridListGetSelectedItem(listaventana)
		if (row == -1) then
			return
		end
		local t = guiGridListGetItemText(source, r, 1)
		for i, v in pairs(ropa) do
			if (tostring(v[1]):lower() == tostring(t):lower()) then
				triggerServerEvent("NGShops:ponerRopa",localPlayer,v[2])
				break
			end
		end
	elseif (source == cancelasion) then
		closeShirtShop(true)
	elseif (source == comprasion) then
		local r, c = guiGridListGetSelectedItem(listaventana)
		if (row == -1) then
			return exports.NGMessages:sendClientMessage("No has seleccionado una camiseta.", 255, 255, 255)
		end
		local t = guiGridListGetItemText(listaventana, r, 1)
		local price = 0
		local camiseta = 0
		for i, v in pairs(ropa) do
			if (tostring(v[1]):lower() == tostring(t):lower()) then
				price = v[3] or 0
				camiseta = v[2]
				break
			end
		end

		if (getPlayerMoney(localPlayer) < price) then
			return exports.NGMessages:sendClientMessage(
				"No tienes los " .. tostring(price) .. " para comprar la camiseta",
				255,
				0,
				0
			)
		end
		closeShirtShop(false)
		triggerServerEvent("NGShops:Skin:UpdateTShirt", localPlayer, camiseta, price)
	end
end




local marcadorcamisetas = createMarker(147.67, -83.84, 1001.8 - 1, "cylinder", 2.5, 255, 50, 50, 200)
setElementDimension(marcadorcamisetas,1)
setElementInterior(marcadorcamisetas,18)
addEventHandler("onClientMarkerHit",marcadorcamisetas,panelRopaCiyei)


local marcadorcamisetas2 = createMarker(147.67, -83.84, 1001.8 - 1, "cylinder", 2.5, 255, 50, 50, 200)
setElementDimension(marcadorcamisetas2,2)
setElementInterior(marcadorcamisetas2,18)
addEventHandler("onClientMarkerHit",marcadorcamisetas2,panelRopaCiyei)



