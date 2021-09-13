-- [[   Written by Steve Scott  ]]--
-- [[ SeeMTA v3	Clothes-System	]]--
-- [[    All rights reserved    ]]--
numeroslocalizados={}
local clothesErstellt = {}
local screenX, screenY = guiGetScreenSize()
local editorFont = dxCreateFont("files/Roboto.ttf", 10)
local logoFont = dxCreateFont("files/Roboto.ttf", 15)

-- // Change the position of the Marker // -- 
local shopMarker = createMarker(1454.84, -1140.57, 24.01, "cylinder", 1.7, 124, 197, 118, 200)
local markerFont = dxCreateFont("files/Roboto.ttf", 15)
local fontBig = dxCreateFont("files/Roboto.ttf", 13)
local descFont = dxCreateFont("files/Roboto.ttf", 11)
local myScreenSource = dxCreateScreenSource( 715, 505)
local backgroundScreen = dxCreateScreenSource( screenX, screenY)
local updated = false

local vorschauObject = nil
local vorschauType = ""
local slotSelectorState = false
local gespeicherteKleidungenState = false
local renameState = false
local buySlotState = false
local deleteState = false
local deleteElementID = 0
local deleteElementName = ""

-- objID, Bone, Name, x,y,z, rx,ry,rz, state, type, dbid
slotTable = {
	{0,0,"",0,0,0,0,0,0,false,0,0,0,0,0 ,0,0,0},
	{0,0,"",0,0,0,0,0,0,false,0,0,0,0,0 ,0,0,0},
	{0,0,"",0,0,0,0,0,0,false,0,0,0,0,0 ,0,0,0},
	{0,0,"",0,0,0,0,0,0,false,0,0,0,0,0 ,0,0,0},
	{0,0,"",0,0,0,0,0,0,false,0,0,0,0,0 ,0,0,0},
	{0,0,"",0,0,0,0,0,0,false,0,0,0,0,0 ,0,0,0},
	{0,0,"",0,0,0,0,0,0,false,0,0,0,0,0 ,0,0,0},
}

savedSlotTable = {}

local kleidungTable = {
	{false, "", {}},
	{false,"", {}},
	{false,"", {}},
	{false,"", {}},
	{false,"", {}},
	{false,"", {}},
	{false,"", {}},
	{false,"", {}},
}
local savedKleidungTable = {}

local selectedSlot = 0
local selectedElement = nil
local selectedElementName = ""
local selectedElementModell = 0
local selectedElementBone = 0
local selectedKleidungID = 0
local selectedKleidungType = 0

local menuPoints = {
	{
		["categoryName"] = "Gorras/Sombreros",
		["state"] = false,
		["products"] = {
			{"Gorras de béisbol"},
				{"Gorrita Nacional", 250000, 7522, 1},
				{"Gorra Navideña", 200000, 2515, 1 },
				{"Gorra #1", 400000, 7438, 1},
				{"Gorra #2", 325000, 7439, 1},
				{"Gorra #3", 300000, 7440, 1},
				{"Gorra #4", 300000, 7441, 1},
				{"Gorra #5", 250000, 7442, 1},
				{"Gorra #6", 250000, 7443, 1},
				{"Gorra #7", 300000, 7444, 1},
				{"Gorra #8", 300000, 7445, 1},
				{"Gorra #9", 250000, 7446, 1},
				{"Gorra #10", 250000, 7447, 1},
			{"Sombreros"},
				{"Sombrero negro", 500000, 7448, 1},
				{"Sombrero azul", 500000, 7449, 1},
				{"Sombrero verde", 400000, 7450, 1},
				{"Sombrero rojo", 500000, 7451, 1},
				{"Sombrero Vueltiao", 1000000, 7452, 1},
				--
				--
				--
			{"Sombreros de cubo"},
				{"Sombrero de copa #1", 300000, 7453, 1},
				{"Sombrero de copa #2", 300000, 7454, 1},
				{"Sombrero de copa #3", 300000, 7455, 1},

			{"Gorros de esquí"},
			{"Graue Skimütze", 300000, 7491, 1},
			{"Grüne Skimütze", 300000, 7492, 1},
			{"Gestreifte Skimütze", 320000, 7493, 1},

			{"Cascos protectores"},
				{"Casco rosa blanco", 600000, 7494, 1},
				{"Casco marrón y blanco", 600000, 7495, 1},
				{"Casco amarillo-rojo", 600000, 7496, 1},
				{"Casco amarillo-rojo", 600000, 7497, 1},
				{"Casco cruzado #1", 700000, 7498, 1},
				{"Casco cruzado #2", 700000, 7499, 1},
				{"Casco cruzado #3", 700000, 7500, 1},
				{"Casco cruzado #4", 700000, 7501, 1},
		},
	},
	{
		["categoryName"] = "Gafas",
		["state"] = false,
		["products"] = {
			{"Gafas #1", 8266000, 8388, 1},
			{"Gafas #2", 8267000, 7415, 1},
			{"Gafas #3", 3000000, 7419, 1},
			{"Gafas #4", 3000000, 7420, 1},
			{"Gafas #5", 3000000, 7421, 1},
			{"Gafas #6", 3000000, 7422, 1},
			{"Gafas #7", 3000000, 7423, 1},
			{"Gafas #8", 3000000, 7424, 1},
			{"Gafas #9", 3000000, 7425, 1},
			{"Gafas #10", 3000000, 7426, 1},
			{"Gafas #11", 3000000, 7427, 1},
			{"Gafas #12", 3000000, 7428, 1},
			{"Gafas #13", 3000000, 7429, 1},
			{"Gafas #14", 3000000, 7430, 1},
			{"Gafas #15", 3000000, 7431, 1},
			{"Gafas #16", 3000000, 7432, 1},
			{"Gafas #17", 3000000, 7433, 1},
			{"Gafas #18", 3000000, 7434, 1},
			{"Gafas #19", 3000000, 7435, 1},
			{"Gafas #20", 3000000, 7436, 1},
			{"Gafas #21", 3000000, 7437, 1},
		},
	},
	{
		["categoryName"] = "Relojes de pulsera",
		["state"] = false,
		["products"] = {
			{"Reloj #1", 826600, 7456, 11},
			{"Reloj #2", 826700, 7457, 11},
			{"Reloj #3", 300000, 7458, 11},
			{"Reloj #4", 300000, 7459, 11},
			{"Reloj #5", 300000, 7460, 11},
			{"Reloj #6", 300000, 7461, 11},
			{"Reloj #7", 300000, 7462, 11},
			{"Reloj #8", 300000, 7463, 11},
			{"Reloj #9", 300000, 7464, 11},
			{"Reloj #10", 300000, 7465, 11},
			{"Reloj #11", 300000, 7466, 11},
			{"Reloj #12", 300000, 7467, 11},
			{"Reloj #13", 300000, 7468, 11},
			{"Reloj #14", 300000, 7469, 11},
			{"Reloj #15", 300000, 7470, 11},
		},
	},
 	{
		["categoryName"] = "Pantalón",
		["state"] = false,
		["products"] = {
			{"Pantalón #1", 3000000, 8373, 3},
			{"Pantalón #2", 3000000, 8375, 3},
			{"Pantalón #3", 3000000, 8377, 3},
			{"Pantalón #4", 3000000, 8378, 3},
			{"Pantalón #5", 3000000, 8380, 3},
			{"Pantalón #6", 3000000, 8382, 3},
		},
	},
	{
		["categoryName"] = "Mascaras",
		["state"] = false,
		["products"] = {
			{"Máscara #1", 3000000, 7471, 1},
			{"Máscara #2", 3000000, 7472, 1},
			{"Máscara #3", 3000000, 7473, 1},
			{"Tapabocas #1", 1000, 7474, 1},
			{"Máscara #5", 3000000, 7475, 1},
			{"Máscara #6", 3000000, 7476, 1},
			{"Máscara #7", 3000000, 7477, 1},
			{"Máscara #8", 3000000, 7478, 1},
			{"Máscara #9", 3000000, 7479, 1},
			{"Máscara #10", 3000000, 7480, 1},
		},
	},
	{
		["categoryName"] = "Collares",
		["state"] = false,
		["products"] = {
			{"Collar #1", 300000, 7481, 1},
			{"Collar #2", 300000, 7482, 1},
			{"Collar Arepa", 300000, 7483, 1},
			{"Collar #4", 300000, 7484, 1},
			{"Collar #5", 300000, 7485, 1},
			{"Collar #6", 300000, 7486, 1},
			{"Collar #7", 300000, 7488, 1},
			{"Collar #8", 300000, 7489, 1},
			{"Collar #9", 300000, 7490, 1},
		},
	},
	{
		["categoryName"] = "Otros",
		["state"] = false,
		["products"] = {
			{"Chaleco #1", 1600000, 7502, 3},
			{"Chaleco #2", 4000000, 7503, 3},
			{"Chaleco #3", 4000000, 7504, 3},
			{"Chaleco #4", 4000000, 7505, 3},
			{"Chaleco #5", 4000000, 7506, 3},
			{"Chaleco #6", 4000000, 7507, 3},
			{"Chaleco #7", 4000000, 7508, 3},
			{"Chaleco #8", 1200000, 7509, 3},
			{"Chaleco #9", 1200000, 7510, 3},
			{"Chaleco #10", 1400000, 7511, 3},
			{"Chaleco #11", 1600000, 7512, 3},
			{"Chaleco #12", 1600000, 7513, 3},
			{"Chaleco #13", 1600000, 7514, 3},
			{"Corbata #1", 700000, 7515, 2},
			{"Corbata #2", 700000, 7516, 2},
			{"Corbata #3", 700000, 7517, 2},
			{"Corbatín #1", 400000, 7518, 2},
			{"Corbatín #2", 400000, 7519, 2},
			{"Riñonera Nike", 10000000, 7521, 4},
			{"Riñonera Gucci", 4000000, 7520, 4}
		},
	},
}



addEventHandler( "onClientResourceStop", getRootElement( ),
    function ( stoppedRes )
		if (stoppedRes==getThisResource()) then
			for k in pairs(numeroslocalizados) do
				engineFreeModel(k)
			end
		end
    end
)

function deleteKleidungClient ( playerSource,dbid )
    destroyElement(clothesErstellt[playerSource][dbid])
end
addEvent( "deleteKleidungClient", true )
addEventHandler( "deleteKleidungClient", localPlayer, deleteKleidungClient )

for x=1,7,1 do 
	for k,v in pairs(menuPoints[x]["products"]) do
		if v[3] ~= nil then
		v[3] = engineRequestModel ( "object")
		table.insert(numeroslocalizados,v[3])
		end
	end
end

function makeItToClient ( playerSourcex, objID, x,y,z, rx,ry,rz, bone, dbid, sX, sY, sZ )
	outputChatBox(inspect(playerSourcex))
	if clothesErstellt[playerSourcex] == nil then
		clothesErstellt[playerSourcex] = {}
	end

	for x=1,7,1 do 
		
		for k,v in pairs(menuPoints[x]["products"]) do
			if v[3] ~= nil then
			 if v[1] == objID then
				objID=v[3]
				break
			 end
			end
		end
		if type(objID)=="number" then
			break
		end
		
	end
	clothesErstellt[playerSourcex][dbid] = createObject(objID, 0,0,0)
	--outputChatBox("eXServer: "..x)
    --outputChatBox("boneidS: "..bone)
	exports.bone_attach:attachElementToBone(clothesErstellt[playerSourcex][dbid],playerSourcex,bone, 0,0,0,0,0,0)
	exports.bone_attach:setElementBonePositionOffset(clothesErstellt[playerSourcex][dbid], x,y,z)
	exports.bone_attach:setElementBoneRotationOffset(clothesErstellt[playerSourcex][dbid],rx,ry,rz)
	setObjectScale(clothesErstellt[playerSourcex][dbid],sX, sY, sZ)
end
addEvent( "makeItToClient", true )
addEventHandler( "makeItToClient", localPlayer, makeItToClient )

local panelW, panelH = 505, 450
local reihenW, reihenH = 490, 27
local menuClickTimer = nil
local scrollNum = 0
local scrollNum2 = 0
local scrollNum3 = 0
local maxShowed = 16
local atvElem = 0
local atvElem2 = 0
local shopState = false
local vorschauMode = false
local vorschauModellName = nil
local rotateModell = false
local elementRZ = 0

cameraSettings = {
	["distance"] = 9,
	["movingSpeed"] = 2,
	["currentZ"] = math.rad(15),
	["maximumZ"] = math.rad(35),
	["minimumZ"] = math.rad(0),
	["freeModeActive"] = false,
	["zoomTick"] = 0,
	["zoom"] = 60
}

local playerClothes = {}
local actualNum = 0
local actualTypeBesetzt = 0

addEvent("requestDatas", true )
addEventHandler("requestDatas", getRootElement(),
	function (qType, result)

			playerClothes = result
		--	outputChatBox("request")

	end)


local invitingText = ""
local actualEditing = ""
local renameText = ""

local cursorState = false
local lastChangeCursorState = 0
local alphaAnim = false

addEventHandler('onClientCharacter', getRootElement(),
	function(character)
		if renameState then
				local maximumLetter = 20
				if (string.len(invitingText) <= maximumLetter) then
						invitingText = invitingText .. character
				end
		end
end)

addEventHandler("onClientRender", getRootElement(),
	function ()
		--if not shopState then
			local x1,y1,z1 = getElementPosition ( shopMarker )
	    local px, py, pz = getElementPosition( localPlayer )
	    local screenWidth, screenHeight = guiGetScreenSize ( )
	    local x1_, y1_, dis = getScreenFromWorldPosition( x1, y1-0.1, z1+1.5 )
			if x1_ and y1_ then
		    if getDistanceBetweenPoints3D(x1,y1,z1, px, py, pz) <= 10 then
		      dxDrawRectangle(x1_-20, y1_, 120, 30, tocolor(0,0,0,150))
		      dxDrawText("Tienda de Accesorios CVR", x1_-20, y1_,x1_+100,0, tocolor ( 255, 255, 255, 230 ), 1, markerFont, "center", "top" )
		    end
			end
	--	end
		if shopState then
			dxDrawRectangle(screenX/2-panelW/2, screenY/2-panelH/2, panelW, panelH, tocolor(0,0,0,100))
			dxDrawRectangle(screenX/2-panelW/2, screenY/2-panelH/2, panelW, reihenH+5, tocolor(0,0,0,200))
			dxDrawText("#F0FF00Colombian#0039FFVirtual#FF000CReality #ffffff- Sistema de Accesorios!",screenX/2-panelW/2+5, screenY/2-panelH/2, 0, screenY/2-panelH/2+reihenH+3, tocolor(255,255,255,255), 0.9, logoFont, "left", "center",false,false,false,true)
			if isInSlot(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15) then
				dxDrawImage(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15, "files/reset.png", 0, 0, 0, tocolor(217, 83, 79, 255))
			else
				dxDrawImage(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15, "files/reset.png")
			end

			for i = 1, 15 do
				if i %2 == 1 then
						colorAlpha = 150
				else
						colorAlpha = 100
				end
				dxDrawRectangle(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (i-1)*(reihenH), reihenW, reihenH, tocolor(0,0,0,colorAlpha))
			end
			local elem = 1
			local elemIn = 0
			local realElem = 0

			for k, v in pairs(menuPoints) do
				if (k+elemIn > scrollNum and elem < maxShowed) then

					if isInSlot(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH), reihenW, reihenH) then
						dxDrawRectangle(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH), reihenW, reihenH, tocolor(0,0,0,50))
						--[[if getKeyState("mouse1") and not menuClickTimer then
							if not menuPoints[k]["state"] then
								menuPoints[k]["state"] = true
							else
								menuPoints[k]["state"] = false
							end
							menuClickTimer = setTimer(function() menuClickTimer = nil end, 100, 1)
						end]]
					end
					dxDrawText(v["categoryName"], screenX/2-panelW/2+30, screenY/2-panelH/2+35 + (elem-1)*(reihenH), screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+reihenH, tocolor(255,255,255,255), 1, editorFont, "left", "center")
					if menuPoints[k]["state"] then
						dxDrawImage(screenX/2-panelW/2+10, screenY/2-panelH/2+40 + (elem-1)*(reihenH), 15, 15, "files/down.png")
					else
						dxDrawImage(screenX/2-panelW/2+10, screenY/2-panelH/2+40 + (elem-1)*(reihenH), 15, 15, "files/right.png")
					end
					elem = elem+1
				end


					for inK, inV in pairs(v["products"]) do
						if v["state"] == true then
							elemIn = elemIn +1
							atvElem1 = elemIn
							if (k+elemIn > scrollNum and elem < maxShowed) then
								if v["products"][inK][2] then
									dxDrawText(v["products"][inK][1], screenX/2-panelW/2+35, screenY/2-panelH/2+35 + (elem-1)*(reihenH), screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+reihenH, tocolor(255,255,255,255), 1, editorFont, "left", "center")

									-- vorschau
									if isInSlot(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
										dxDrawRectangle(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 255))
									else
										dxDrawRectangle(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 200))
									end
									dxDrawText("Revisar", screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-65+65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(0,0,0,255), 1, editorFont, "center", "center")
									-- vorschau

									-- kaufen
									for clothK, clothV in ipairs(playerClothes) do
										--outputChatBox(clothV["ObjectID"])
										if v["products"][inK][3] == clothV["ObjectID"] then
											actualNum = clothK
										--	outputChatBox(actualNum)
										end
									end
									if actualNum > 0 then
										if playerClothes[actualNum]["ObjectID"] == v["products"][inK][3] then
											dxDrawText("Compró", screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-(65*2)+65-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(255,255,255,255), 1, editorFont, "center", "center")
										else
											if isInSlot(screenX/2-panelW/2+reihenW-(65*2), screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
												dxDrawRectangle(screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 255))
											else
												dxDrawRectangle(screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 200))
											end
											dxDrawText("Comprar", screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-(65*2)+65-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(0,0,0,255), 1, editorFont, "center", "center")
											dxDrawText("Precio: "..v["products"][inK][2].."$", screenX/2-panelW/2+reihenW-(65*3)-10, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-(65*3)+65-10, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(255,255,255,255), 1, editorFont, "right", "center")
										end
									else
										if isInSlot(screenX/2-panelW/2+reihenW-(65*2), screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
											dxDrawRectangle(screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 255))
										else
											dxDrawRectangle(screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 200))
										end
										dxDrawText("Comprar", screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-(65*2)+65-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(0,0,0,255), 1, editorFont, "center", "center")
										dxDrawText("Precio: "..v["products"][inK][2].."$", screenX/2-panelW/2+reihenW-(65*3)-10, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-(65*3)+65-10, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(255,255,255,255), 1, editorFont, "right", "center")

									end
									-- kaufen

								else
									dxDrawText(v["products"][inK][1], screenX/2-panelW/2+20, screenY/2-panelH/2+35 + (elem-1)*(reihenH), screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+reihenH, tocolor(150,150,150,255), 1, editorFont, "left", "center")
								end
								elem = elem + 1

							end
						else
							 atvElem1 = elemIn
						end

					end

			end
			--outputChatBox(7+atvElem1)
			gorgetesRajzolas(screenX/2-panelW/2+reihenW+5, screenY/2-panelH/2+35, 3, panelH-45, 8+atvElem1, maxShowed, scrollNum, tocolor(0, 0, 0, 255), tocolor(124, 197, 118,255))
		--	outputChatBox(atvElem1+atvElem2)
		end
		if vorschauMode and not shopState then
			if myScreenSource then
					--if not updated then
					--	dxUpdateScreenSource(backgroundScreen)
						--updated = true
					--end
					dxDrawImage ( 0,0, screenX, screenY, backgroundScreen, 0, 0, 0, tocolor(255,255,255,255))
					dxUpdateScreenSource( myScreenSource )
					dxDrawImage ( screenX/2-715/2,screenY/2-505/2, 715, 505, myScreenSource, 0, 0, 0, tocolor(255,255,255,255))
			end
			drawTextWithBorder(vorschauModellName, 1, screenX/2-715/2,screenY/2-505/2-30,screenX/2-715/2+715,0, tocolor(0, 0, 0, 255), tocolor(255, 255, 255, 255), 1, 1, fontBig, "center", "top", false, false,false, true)
			drawTextWithBorder("Rotar: Mouse | Salir: ESC | Agrandar: Scroll", 1, screenX/2-715/2,screenY/2+505/2+10,screenX/2-715/2+715,0, tocolor(0, 0, 0, 255), tocolor(255, 255, 255, 255), 1, 1, descFont, "center", "top", false, false,false, true)

			if rotateModell then
					local relX, relY = getCursorPosition()
					local cameraRotation = getCameraRotation()
					local elementRZ = 0
					elementRZ = getInFrontOf(elementRZ, false, -(cameraRotation + 90), -((relX - 0.5) * 700))
					setElementRotation(vorschauObject, 0, 0, elementRZ)
			end
		end
	end
)

addEventHandler("onClientRender", getRootElement(),
	function()
		if kleidungSelect and not slotSelectorState then
			dxDrawRectangle(screenX/2-panelW/2, screenY/2-panelH/2, panelW, panelH, tocolor(0,0,0,100))
			dxDrawRectangle(screenX/2-panelW/2, screenY/2-panelH/2, panelW, reihenH+5, tocolor(0,0,0,200))
			dxDrawText("#F0FF00Colombian#0039FFVirtual#FF000CReality #ffffff- Sistema de Accesorios!",screenX/2-panelW/2+5, screenY/2-panelH/2, 0, screenY/2-panelH/2+reihenH+3, tocolor(255,255,255,255), 0.9, logoFont, "left", "center",false,false,false,true)
			if isInSlot(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15) then
				dxDrawImage(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15, "files/reset.png", 0, 0, 0, tocolor(217, 83, 79, 255))
			else
				dxDrawImage(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15, "files/reset.png")
			end

			for i = 1, 15 do
				if i %2 == 1 then
						colorAlpha = 150
				else
						colorAlpha = 100
				end
				dxDrawRectangle(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (i-1)*(reihenH), reihenW, reihenH, tocolor(0,0,0,colorAlpha))
			end
			local elem = 1
			local elemIn = 0
			local realElem = 0
			local counter = 0
			local counter2 = 0

			for k, v in pairs(menuPoints) do
				if (k+elemIn > scrollNum2 and elem < maxShowed) then

					if isInSlot(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH), reihenW, reihenH) then
						dxDrawRectangle(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH), reihenW, reihenH, tocolor(0,0,0,50))
					end
					dxDrawText(v["categoryName"], screenX/2-panelW/2+30, screenY/2-panelH/2+35 + (elem-1)*(reihenH), screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+reihenH, tocolor(255,255,255,255), 1, editorFont, "left", "center")
					if menuPoints[k]["state"] then
						dxDrawImage(screenX/2-panelW/2+10, screenY/2-panelH/2+40 + (elem-1)*(reihenH), 15, 15, "files/down.png")
					else
						dxDrawImage(screenX/2-panelW/2+10, screenY/2-panelH/2+40 + (elem-1)*(reihenH), 15, 15, "files/right.png")
					end
					elem = elem+1
				end


					for inK, inV in pairs(v["products"]) do
						if v["state"] == true then
							elemIn = elemIn +1
							--atvElem2 = elemIn
							if (k+elemIn > scrollNum2 and elem < maxShowed) then
								if v["products"][inK][2] then
									for clothK, clothV in ipairs(playerClothes) do
										if v["products"][inK][3] == clothV["ObjectID"] then
											actualNum = clothK
										end
									end
									if actualNum > 0 then
										if playerClothes[actualNum]["ObjectID"] == v["products"][inK][3] then
											for sK, sV in pairs(savedSlotTable) do
												if sV[11] == k then
													actualTypeBesetzt = k
												end
											end
											if k ~= actualTypeBesetzt then
												dxDrawText(v["products"][inK][1], screenX/2-panelW/2+45, screenY/2-panelH/2+35 + (elem-1)*(reihenH), screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+reihenH, tocolor(255,255,255,255), 1, editorFont, "left", "center")

												if isInSlot(screenX/2-panelW/2+30, screenY/2-panelH/2+43 + (elem-1)*(reihenH), 12, 10) then
													dxDrawImage(screenX/2-panelW/2+30, screenY/2-panelH/2+43 + (elem-1)*(reihenH), 12, 10, "files/reset.png", 0, 0, 0, tocolor(217, 83, 79, 255))
												else
													dxDrawImage(screenX/2-panelW/2+30, screenY/2-panelH/2+43 + (elem-1)*(reihenH), 12, 10, "files/reset.png")
												end

												-- choose
												if isInSlot(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
													dxDrawRectangle(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 255))
												else
													dxDrawRectangle(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 200))
												end
												dxDrawText("Poner", screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-65+65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(0,0,0,255), 1, editorFont, "center", "center")
												-- choose

												-- vorschau

												if isInSlot(screenX/2-panelW/2+reihenW-(65*2), screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
													dxDrawRectangle(screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 255))
												else
													dxDrawRectangle(screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(124, 197, 118, 200))
												end
												dxDrawText("Revisar", screenX/2-panelW/2+reihenW-(65*2)-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-(65*2)+65-5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(0,0,0,255), 1, editorFont, "center", "center")
												elem = elem + 1
												counter = counter + 1
											else
												for sK2, sV2 in pairs(savedSlotTable) do
													if sV2[11] > 0 then
														if sV2[11] == actualTypeBesetzt then
															counter2 = counter2 + 1
															if counter2 == 1 then
																dxDrawText("Du hast es schon an ("..v["categoryName"]..")", screenX/2-panelW/2+35, screenY/2-panelH/2+35 + (elem-1)*(reihenH), screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+reihenH, tocolor(100,100,100,255), 1, editorFont, "left", "center")

																if isInSlot(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
																	dxDrawRectangle(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(217, 83, 79, 255))
																else
																	dxDrawRectangle(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20, tocolor(217, 83, 79, 200))
																end
																dxDrawText("Ausziehen", screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, screenX/2-panelW/2+reihenW-65+65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3+20, tocolor(0,0,0,255), 1, editorFont, "center", "center")

																elem = elem + 1
																counter = counter + 1
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
					counter2 = 0
					atvElem2 = counter
			end
			--outputChatBox(atvElem2)
			gorgetesRajzolas(screenX/2-panelW/2+reihenW+5, screenY/2-panelH/2+35, 3, panelH-45, atvElem2+8, maxShowed, scrollNum2, tocolor(0, 0, 0, 255), tocolor(255,255,255,255))
		end
		if deleteState then
			dxDrawRectangle(screenX/2-310/2,screenY/2-155/2,310,155, tocolor(0,0,0,150))
			dxDrawText("Willst du dieses Accessoire ("..deleteElementName.. ") wegwerfen?", screenX/2-310/2,screenY/2-155/2-20,screenX/2-310/2+310,screenY/2-155/2+155 ,tocolor(255,255,255,255), 0.72, logoFont, "center", "center", false, true)
		--	dxDrawText(string text, int left, int top [, int right=left, int bottom=top, int color=white, float scale=1, string font, string alignX="left", string alignY="top", bool clip=false, bool wordBreak=false, bool postGUI])
			if isInSlot(screenX/2-310/2+15,screenY/2-155/2+155-35-15,125,35) then
				dxDrawRectangle(screenX/2-310/2+15,screenY/2-155/2+155-35-15,125,35, tocolor(124, 197, 118,255))
			else
				dxDrawRectangle(screenX/2-310/2+15,screenY/2-155/2+155-35-15,125,35, tocolor(124, 197, 118,200))
			end
			dxDrawText("Ja", screenX/2-310/2+15,screenY/2-155/2+155-35-15, screenX/2-310/2+15+125,screenY/2-155/2+155-35-15+35,tocolor(0,0,0,255), 0.72, logoFont, "center", "center")

			if isInSlot(screenX/2-310/2+15+30+125,screenY/2-155/2+155-35-15,125,35) then
				dxDrawRectangle(screenX/2-310/2+15+30+125,screenY/2-155/2+155-35-15,125,35, tocolor(217, 83, 79,255))
			else
				dxDrawRectangle(screenX/2-310/2+15+30+125,screenY/2-155/2+155-35-15,125,35, tocolor(217, 83, 79,200))
			end
			dxDrawText("Nein", screenX/2-310/2+15+30+125,screenY/2-155/2+155-35-15,screenX/2-310/2+15+30+125+125,screenY/2-155/2+155-35-15+35,tocolor(0,0,0,255), 0.72, logoFont, "center", "center")

		end
	end
)

local playerSlot = 2
local slotPanelW, slotPanelH = 465,345
addEventHandler("onClientRender", getRootElement(),
	function()
		triggerServerEvent("checkSlots", localPlayer, localPlayer)
		playerSlot=getElementData(localPlayer,"slots") or 2
		if slotSelectorState then
			dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2-slotPanelH/2, slotPanelW,slotPanelH, tocolor(0,0,0,130))
			dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2-slotPanelH/2, slotPanelW,reihenH, tocolor(0,0,0,150))
			dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH, tocolor(0,0,0,100))
			if isInSlot(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH) then
				dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH, tocolor(0,0,0,100))
			end
			dxDrawText("Ropa guardada", screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH-4, screenX/2-slotPanelW/2+slotPanelW, screenY/2+slotPanelH/2, tocolor(255,255,255,255), 0.7, logoFont, "center", "center",false,false,false,true)

			dxDrawText("#F0FF00Colombian#0039FFVirtual#FF000CReality #ffffff- Sistema de Accesorios!",screenX/2-slotPanelW/2+5, screenY/2-slotPanelH/2-2, screenX/2-slotPanelW/2, screenY/2-slotPanelH/2+reihenH, tocolor(255,255,255,255), 0.9, logoFont, "left", "center",false,false,false,true)

			if isInSlot(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15) then
				dxDrawImage(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15, "files/reset.png", 0, 0, 0, tocolor(217, 83, 79, 255))
			else
				dxDrawImage(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15, "files/reset.png")
			end

			for k, v in pairs(savedSlotTable) do
					dxDrawRectangle(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, 445,30, tocolor(0,0,0,100))
				--if not v[3] then
					if k <= playerSlot then
						if not v[10] then
							if isInSlot(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, 445,30) then
								dxDrawRectangle(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, 445,30, tocolor(0,0,0,100))
							end
							dxDrawText("Slot Libre",screenX/2-slotPanelW/2, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, screenX/2-slotPanelW/2+slotPanelW, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+reihenH, tocolor(255,255,255,255), 0.7, logoFont, "center", "center",false,false,false,true)
						else
							dxDrawText(v[3],screenX/2-slotPanelW/2+15, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, screenX/2-slotPanelW/2+slotPanelW, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+reihenH, tocolor(255,255,255,255), 0.7, logoFont, "left", "center",false,false,false,true)
							if isInSlot(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20) then
								dxDrawRectangle(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20, tocolor(217, 83, 79,255))
							else
								dxDrawRectangle(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20, tocolor(217, 83, 79,200))
							end
							dxDrawText("Quitar",screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5,screenX/2-slotPanelW/2+445-65+70, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+3+20,tocolor(0,0,0,255), 0.7, logoFont, "center", "center",false,false,false,true)

							if isInSlot(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20) then
								dxDrawRectangle(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20, tocolor(124, 197, 118,255))
							else
								dxDrawRectangle(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20, tocolor(124, 197, 118,200))
							end
							dxDrawText("Mover",screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5,screenX/2-slotPanelW/2+445-65+70-75, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+3+20,tocolor(0,0,0,255), 0.7, logoFont, "center", "center",false,false,false,true)

						end
					else

						if playerSlot + 1 == k then
							if not buySlotState then
								if isInSlot(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, 445,30) then
									dxDrawRectangle(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, 445,30, tocolor(0,0,0,100))
								end
								dxDrawText("#969696Slot cerrado #ffffff- Si eres vip compra el slot por #33ccff3000000#ffffff -",screenX/2-slotPanelW/2, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, screenX/2-slotPanelW/2+slotPanelW, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+reihenH, tocolor(100,100,100,200), 0.7, logoFont, "center", "center",false,false,false,true)
							else
								if isInSlot(screenX/2-slotPanelW/2+reihenW-90, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4, 50,20) then
									dxDrawRectangle(screenX/2-slotPanelW/2+reihenW-90, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4, 50,20, tocolor(217, 83, 79,255))
								else
									dxDrawRectangle(screenX/2-slotPanelW/2+reihenW-90, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4, 50,20, tocolor(217, 83, 79,200))
								end
								dxDrawText("Nocas",screenX/2-slotPanelW/2+reihenW-90, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4,screenX/2-slotPanelW/2+reihenW-90+50, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4+20 ,tocolor(0,0,0,255), 0.7, logoFont, "center", "center",false,false,false,true)

								if isInSlot(screenX/2-slotPanelW/2+reihenW-90-55, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4, 50,20) then
									dxDrawRectangle(screenX/2-slotPanelW/2+reihenW-90-55, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4, 50,20, tocolor(124, 197, 118,255))
								else
									dxDrawRectangle(screenX/2-slotPanelW/2+reihenW-90-55, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4, 50,20, tocolor(124, 197, 118,200))
								end
								dxDrawText("Sisas",screenX/2-slotPanelW/2+reihenW-90-55, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4,screenX/2-slotPanelW/2+reihenW-90+50-55, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+4+20 ,tocolor(0,0,0,255), 0.7, logoFont, "center", "center",false,false,false,true)
								dxDrawText("#ffffff¿Estás comprando la ranura por#33ccff3000000#ffffff?",screenX/2-slotPanelW/2+15, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, screenX/2-slotPanelW/2+slotPanelW, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+reihenH, tocolor(100,100,100,200), 0.7, logoFont, "left", "center",false,false,false,true)

							end
						else
							dxDrawText("Slot Bloqueado",screenX/2-slotPanelW/2, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, screenX/2-slotPanelW/2+slotPanelW, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+reihenH, tocolor(100,100,100,255), 0.7, logoFont, "center", "center",false,false,false,true)

						end
					end
				--end
			end
		elseif gespeicherteKleidungenState then
			dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2-slotPanelH/2, slotPanelW,slotPanelH, tocolor(0,0,0,130))
			dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2-slotPanelH/2, slotPanelW,reihenH, tocolor(0,0,0,150))
			dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH, tocolor(0,0,0,100))
			if isInSlot(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH) then
				dxDrawRectangle(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH, tocolor(0,0,0,100))
			end
			dxDrawText("Mi ropa", screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH-4, screenX/2-slotPanelW/2+slotPanelW, screenY/2+slotPanelH/2, tocolor(255,255,255,255), 0.7, logoFont, "center", "center",false,false,false,true)

			dxDrawText("#F0FF00Colombian#0039FFVirtual#FF000CReality #ffffff- Ropa guardada",screenX/2-slotPanelW/2+5, screenY/2-slotPanelH/2-2, screenX/2-slotPanelW/2, screenY/2-slotPanelH/2+reihenH, tocolor(255,255,255,255), 0.9, logoFont, "left", "center",false,false,false,true)

			if isInSlot(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15) then
				dxDrawImage(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15, "files/reset.png", 0, 0, 0, tocolor(217, 83, 79, 255))
			else
				dxDrawImage(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15, "files/reset.png")
			end

			for k, v in pairs(savedKleidungTable) do
				dxDrawRectangle(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35, 445,25, tocolor(0,0,0,100))
				if isInSlot(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35, 445,25) then
					dxDrawRectangle(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35, 445,25, tocolor(0,0,0,100))
				end
				if not v[1] then
					dxDrawText("Guardar ropa actual",screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35,screenX/2-slotPanelW/2+10+445, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+25 ,tocolor(255,255,255,255), 0.7, logoFont, "center", "center",false,false,false,true)
				else
					if not renameState then
						dxDrawText(v[2],screenX/2-slotPanelW/2+15, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35,screenX/2-slotPanelW/2+10+445, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+25 ,tocolor(255,255,255,255), 0.7, logoFont, "left", "center",false,false,false,true)

						if isInSlot(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15) then
							dxDrawRectangle(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15, tocolor(217, 83, 79,255))
						else
							dxDrawRectangle(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15, tocolor(217, 83, 79,200))
						end
						dxDrawText("Claro",screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5,screenX/2-slotPanelW/2+445-65+70, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+3+15,tocolor(0,0,0,255), 0.7, logoFont, "center", "center",false,false,false,true)

						if isInSlot(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+10+(k-1)*40+5, 70,15) then
							dxDrawRectangle(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15, tocolor(124, 197, 118,255))
						else
							dxDrawRectangle(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15, tocolor(124, 197, 118,200))
						end
						dxDrawText("Rebautizar",screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5,screenX/2-slotPanelW/2+445-65+70-75, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+3+15,tocolor(0,0,0,255), 0.6, logoFont, "center", "center",false,false,false,true)
					else
						local time = getTickCount() - lastChangeCursorState

						if time >= 500 then
							cursorState = not cursorState
							lastChangeCursorState = getTickCount()
						end
						if actualEditing == "rename" then
				       renameText = invitingText
							 if cursorState then
					       local w = dxGetTextWidth(renameText, 0.7, logoFont)
								 dxDrawLine(screenX/2-slotPanelW/2+15+w+3, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+2, screenX/2-slotPanelW/2+15+w+3, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+20,tocolor(255, 255, 255, lineAlpha), 1)
							 end
				    end
				    dxDrawText(renameText, screenX/2-slotPanelW/2+15, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35,screenX/2-slotPanelW/2+10+445, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+25, tocolor(255,255,255, 255), 0.7, logoFont, "left", "center")

						if isInSlot(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15) then
							dxDrawRectangle(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15, tocolor(124, 197, 118,255))
						else
							dxDrawRectangle(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15, tocolor(124, 197, 118,200))
						end
						dxDrawText("Rebautizar",screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5,screenX/2-slotPanelW/2+445-65+70, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+3+15,tocolor(0,0,0,255), 0.6, logoFont, "center", "center",false,false,false,true)

					end
				end
			end
		end
	end
)




addCommandHandler("ropita", function(p)
		if getElementInterior(localPlayer) ~= 0 then return end
		if getElementDimension(localPlayer) ~= 0 then return end
		if getElementData(localPlayer,"WantedPoints") > 0 then return end
	--triggerServerEvent("requestDatas", localPlayer, 0,  getElementData(localPlayer, "dbid"))
--	if getElementData(localPlayer, "loggedin") > 0 then
		slotSelectorState = not slotSelectorState
		playSound("sounds/open.mp3")
--	end
end)


local oldcX, oldcY = 0,0
addEventHandler("onClientClick", getRootElement(),
	function (button, state, absX, absY)
		if button == "left" and state == "down" then
			if shopState then
				if isInSlot(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15) then
					if shopState then
						shopState = false
						playSound("sounds/close.mp3")
					end
				end

				-- shop
				local elem = 1
				local elemIn = 0
				local realElem = 0

				for k, v in pairs(menuPoints) do
					if (k+elemIn > scrollNum and elem < maxShowed) then
						if isInSlot(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH), reihenW, reihenH) then
							playSound("sounds/mobilebuttosnel.mp3")
							if not menuPoints[k]["state"] then
								menuPoints[k]["state"] = true
							else
								menuPoints[k]["state"] = false
							end
						end
						elem = elem+1
					end


					for inK, inV in pairs(v["products"]) do
						if v["state"] == true then
							elemIn = elemIn +1
							if (k+elemIn > scrollNum and elem < maxShowed) then
								if v["products"][inK][2] then
									if isInSlot(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
									--	v["products"][inK][3]
										dxUpdateScreenSource(backgroundScreen)
										vorschauObject = createObject(v["products"][inK][3], 255.078125+0.6, -42.923828125+0.7, 1002.0234375+0.6)
										setElementInterior(vorschauObject, 14)
										setElementFrozen(vorschauObject, true)
										setElementDimension(vorschauObject, 14)
										setElementFrozen(localPlayer, true)
										setElementInterior(localPlayer, 14)
										setElementDimension(localPlayer, 14)

										setCameraMatrix(257.88922119141, -40.352851867676, 1003.2253417969, 180.87554931641, -101.27004241943, 984.30474853516)
										vorschauMode = true
										vorschauType = "shop"
										shopState = false
										vorschauModellName = v["products"][inK][1]
									end
									if isInSlot(screenX/2-panelW/2+reihenW-(65*2), screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
										if #playerClothes > 0 then
											for clothK, clothV in pairs(playerClothes) do
												if v["products"][inK][3] == clothV["ObjectID"] then
													return
												end
											end
											if getPlayerMoney(localPlayer) > v["products"][inK][2] then
												triggerServerEvent("buyClothesServer", localPlayer, localPlayer, k, v["products"][inK][3], v["products"][inK][1], v["products"][inK][2])
												triggerServerEvent("requestDatas", localPlayer, 0,  getElementData(localPlayer, "dbid"))
											else
												exports.NGMessages:addNotification("No tienes suficiente dinero para eso!", "error")
											end
										else
											if getPlayerMoney(localPlayer) > v["products"][inK][2] then
												triggerServerEvent("buyClothesServer", localPlayer, localPlayer, k, v["products"][inK][3], v["products"][inK][1], v["products"][inK][2])
												triggerServerEvent("requestDatas", localPlayer, 0,  getElementData(localPlayer, "dbid"))
											else
												exports.NGMessages:addNotification("No tienes suficiente dinero para eso!", "error")
											end
										end
									end
								end
								elem = elem + 1
							end
						end
					end
				end
			end
			-- rotate
			if vorschauMode and not shopState then
				oldcX, oldcY = getCursorPosition()
				oldcRelX, oldcRelY = oldcX*screenX, oldcY*screenY
				setCursorPosition(screenX / 2, screenY / 2)
				setCursorAlpha(0)
				rotateModell = true
			end
		elseif button == "left" and state == "up" then
			if vorschauMode and not shopState then
				rotateModell = false
				setCursorAlpha(255)
				setCursorPosition(oldcRelX, oldcRelY)
			end
		end
	end
)

-- selector

addEventHandler("onClientClick", getRootElement(),
	function (button, state, absX, absY)
		if button == "left" and state == "down" then

			if kleidungSelect and not slotSelectorState then
				if isInSlot(screenX/2-panelW/2+reihenW-15, screenY/2-panelH/2+7.5, 15, 15) then
					if kleidungSelect then
						kleidungSelect = false
						playSound("sounds/close.mp3")
						slotSelectorState = true
					end
				end

				-- shop
				local elem = 1
				local counter2 = 0
				local elemIn = 0
				local realElem = 0

				for k, v in pairs(menuPoints) do
					if (k+elemIn > scrollNum2 and elem < maxShowed) then
						if isInSlot(screenX/2-panelW/2+5, screenY/2-panelH/2+35 + (elem-1)*(reihenH), reihenW, reihenH) then
							playSound("sounds/mobilebuttosnel.mp3")
							if not menuPoints[k]["state"] then
								menuPoints[k]["state"] = true
							else
								menuPoints[k]["state"] = false
							end
						end
						elem = elem+1
					end


					for inK, inV in pairs(v["products"]) do
						if v["state"] == true then
							elemIn = elemIn +1
							if (k+elemIn > scrollNum2 and elem < maxShowed) then
								if v["products"][inK][2] then
									for clothK, clothV in ipairs(playerClothes) do
										if v["products"][inK][3] == clothV["ObjectID"] then
											actualNum = clothK
										end
									end
									if actualNum > 0 then
										if playerClothes[actualNum]["ObjectID"] == v["products"][inK][3] then
											for sK, sV in pairs(savedSlotTable) do
												if sV[11] == k then
													actualTypeBesetzt = k
												end
											end
											if k ~= actualTypeBesetzt then
												if isInSlot(screenX/2-panelW/2+30, screenY/2-panelH/2+43 + (elem-1)*(reihenH), 12, 10) then
													deleteState = true
													playSound("sounds/prompt.mp3")
													kleidungSelect = false
													deleteElementID = playerClothes[actualNum]["ObjectID"]
													deleteElementName = v["products"][inK][1]
												end
												if isInSlot(screenX/2-panelW/2+reihenW-(65*2), screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
												--	v["products"][inK][3]
													vorschauObject = createObject(v["products"][inK][3], 255.078125+0.6, -42.923828125+0.7, 1002.0234375+0.6)
													setElementInterior(vorschauObject, 14)
													setElementFrozen(vorschauObject, true)
													setElementDimension(vorschauObject, 14)
													setElementFrozen(localPlayer, true)
													setElementInterior(localPlayer, 14)
													setElementDimension(localPlayer, 14)

													setCameraMatrix(257.88922119141, -40.352851867676, 1003.2253417969, 180.87554931641, -101.27004241943, 984.30474853516)
													vorschauMode = true
													vorschauType = "selector"
													kleidungSelect = false
													vorschauModellName = v["products"][inK][1]
												end
												if isInSlot(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
												--	outputChatBox("key")
													local boneX, boneY, boneZ = getPedBonePosition ( localPlayer,  v["products"][inK][4])
													editingObj = createObject(v["products"][inK][3], boneX,boneY,boneZ)
													exports.bone_attach:attachElementToBone(editingObj,localPlayer,v["products"][inK][4],0,0,0,0,0,0)
													setElementCollisionsEnabled(editingObj, false)
													toggleEditor(editingObj)
													kleidungSelect = false
													--selectedElement = v["products"][inK]
													selectedElementName = v["products"][inK][1]
													selectedElementBone = v["products"][inK][4]
													selectedElementModell = v["products"][inK][3]
													selectedKleidungID = playerClothes[actualNum]["ObjectID"]
													selectedKleidungType = k
												--	outputChatBox("dbid: "..selectedKleidungID)
												--	outputChatBox("selectedKleidungType: "..k)
													--slotTable[selectedSlot] = {v["products"][inK][3], v["products"][inK][4], v["products"][inK][1]}
												end
												elem = elem + 1
											else
												for sK2, sV2 in pairs(savedSlotTable) do
													if sV2[11] > 0 then
														if sV2[11] == actualTypeBesetzt then
															counter2 = counter2 + 1
															if counter2 == 1 then
																if isInSlot(screenX/2-panelW/2+reihenW-65, screenY/2-panelH/2+35 + (elem-1)*(reihenH)+3, 65,20) then
																--	outputChatBox(sK2)
																	savedSlotTable[sK2] = {0,0,"",0,0,0,0,0,0,false,0,0}
																	actualTypeBesetzt = 0
																	--setClipboard(inspect(sV2))
																	triggerServerEvent("deleteKleidungServer", localPlayer, localPlayer, sV2[12])
																	saveSlots()
																end
															--	counter2 = counter2 + 1
																elem = elem + 1
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
					counter2 = 0
				end
				--counter2 = 0
			end
			-- rotate
			if vorschauMode and not shopState then
				oldcX, oldcY = getCursorPosition()
				oldcRelX, oldcRelY = oldcX*screenX, oldcY*screenY
				setCursorPosition(screenX / 2, screenY / 2)
				setCursorAlpha(0)
				rotateModell = true
			end

			if slotSelectorState then
				if isInSlot(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15) then
					slotSelectorState = false
				end
				if isInSlot(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH) then
					slotSelectorState = false
					gespeicherteKleidungenState = true
				end
				for k, v in pairs(savedSlotTable) do
					if k <= playerSlot then
						if not v[10] then
							if isInSlot(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, 445,30) then
								kleidungSelect = true
								slotSelectorState = false
								triggerServerEvent("requestDatas", localPlayer, 0,  getElementData(localPlayer, "dbid"))
								selectedSlot = k
								playSound("sounds/open.mp3")
							end
						else
							if isInSlot(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20) then
								triggerServerEvent("deleteKleidungServer", localPlayer, localPlayer, v[12])
								--outputChatBox("mentett: "..v[12])
								
								savedSlotTable[k] = {0,0,"",0,0,0,0,0,0,false,0,0}
								actualTypeBesetzt = 0
								saveSlots()

							end
							if isInSlot(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 70,20) then
								slotSelectorState = false
								triggerServerEvent("deleteKleidungServer", localPlayer, localPlayer, v[12])
								--selectedElement = nil
							--	selectedElement = {v[k], 3000, 7438, 1}
								selectedSlot = k
								selectedElementName = v[3]
								selectedElementBone = v[2]
								selectedElementModell = v[1]
								selectedKleidungType = v[11]
								selectedKleidungID = v[12]
								editingObj = createObject(v[1], 0,0,0)
								exports.bone_attach:attachElementToBone(editingObj,localPlayer,v[2],v[4],v[5],v[6],v[7],v[8],v[9])
								setElementCollisionsEnabled(editingObj, false)
								toggleEditor(editingObj)
							end
						end
					else
						if playerSlot + 1 == k then
							if isInSlot(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40, 445,30) then
								if not buySlotState then
									buySlotState = true
									playSound("sounds/prompt.mp3")
								end
							end
							if buySlotState then
								if isInSlot(screenX/2-slotPanelW/2+reihenW-90, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 50,20) then
									buySlotState = false
									playSound("sounds/promptdecline.mp3")
								end
								if isInSlot(screenX/2-slotPanelW/2+reihenW-90-55, screenY/2-slotPanelH/2+reihenH+15+(k-1)*40+5, 50,20) then
									buySlotState = false
									if exports.NGVIP:isPlayerVIP(localplayer) and getPlayerMoney(localPlayer)>=3000000 then
										triggerServerEvent("buySlotPPServer", localPlayer, localPlayer, 3000000)
										playerSlot = playerSlot + 1
										playSound("sounds/promptaccept.mp3")
									else
										exports.sas_hud:addNotification("Du hast dafür nicht genug Premium Punkte.", "error")
									end
								end
							end
						end
					end
				end
			elseif gespeicherteKleidungenState then
				if isInSlot(screenX/2-slotPanelW/2+slotPanelW-25, screenY/2-slotPanelH/2+5.5, 15, 15) then
					gespeicherteKleidungenState = false
				end
				if isInSlot(screenX/2-slotPanelW/2, screenY/2+slotPanelH/2-reihenH, slotPanelW,reihenH) then
					gespeicherteKleidungenState = false
					slotSelectorState = true
				end
				for k, v in pairs(savedKleidungTable) do
					if v[1] then
						if not renameState then
							if isInSlot(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15) then
								v[1] = false
								v[2] = ""
								v[3] = {}
								saveOutfits()
							elseif isInSlot(screenX/2-slotPanelW/2+445-65-75, screenY/2-slotPanelH/2+reihenH+10+(k-1)*40+5, 70,15) then
								renameState = true
								actualEditing = "rename"
							elseif isInSlot(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35, 445,25) then
								--savedSlotTable = {}
								for clothK, clothV in pairs(savedSlotTable) do
									if clothV[12] > 0 then
										triggerServerEvent("deleteKleidungServer", localPlayer, localPlayer,clothV[12])
									end
								end

								savedSlotTable = table.copy(v[3], true)

								for createK, createV in pairs(savedSlotTable) do
									if createV[12] > 0 then

										triggerServerEvent("makeItToServer", localPlayer, localPlayer, createV[3], createV[4], createV[5], createV[6], createV[7], createV[8], createV[9], createV[2], createV[12], createV[13], createV[14], createV[15])
										

									end
								end
								saveOutfits()
								saveSlots()
							end
						else
							if isInSlot(screenX/2-slotPanelW/2+445-65, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35+5, 70,15) then
								v[2] = renameText
								renameText = ""
								invitingText = ""
								actualEditing = ""
								renameState = false
								saveOutfits()
							end
						end
					elseif not v[1] then
						if not renameState then
							if isInSlot(screenX/2-slotPanelW/2+10, screenY/2-slotPanelH/2+reihenH+10+(k-1)*35, 445,25) then
								v[1] = true
								v[2] = "Kleidung "..k
							--	v[3] = savedSlotTable
								v[3] = table.copy(savedSlotTable, true)
								saveOutfits()
							end
						end
					end
				end
			end

			if deleteState then
				if isInSlot(screenX/2-310/2+15,screenY/2-155/2+155-35-15,125,35) then
					triggerServerEvent("deleteClothesServer", localPlayer, deleteElementID)
					deleteState = false
					--playerClothes = {}
					actualNum = 0
					triggerServerEvent("requestDatas", localPlayer, 0,  getElementData(localPlayer, "dbid"))
					kleidungSelect = true
					deleteElementID = 0
					playSound("sounds/promptaccept.mp3")
				end
				if isInSlot(screenX/2-310/2+15+30+125,screenY/2-155/2+155-35-15,125,35) then
					deleteState = false
					deleteElementID = 0
					kleidungSelect = true
					playSound("sounds/promptdecline.mp3")
				end
			end

		elseif button == "left" and state == "up" then
			if vorschauMode and not shopState then
				rotateModell = false
				setCursorAlpha(255)
				setCursorPosition(oldcRelX, oldcRelY)
			end
		end
	end
)

addEventHandler("onClientPreRender", root, function()
	if vorschauMode then
		local camx,camy,camz, _, _, _, roll, fov = getCameraMatrix()
		local cameraZoomProgress = (getTickCount() - cameraSettings["zoomTick"]) / 500
		local cameraZoomAnimation = interpolateBetween(fov, 0, 0, cameraSettings["zoom"], 0, 0, cameraZoomProgress, "Linear")
		local objx, objy, objz = getElementPosition(vorschauObject)

		--if cameraSettings["moveState"] == "freeMode" then
			local cameraX, cameraY, cameraZ, elementX, elementY, elementZ = camx,camy,camz, objx, objy, objz

			setCameraMatrix(cameraX, cameraY, cameraZ, elementX, elementY, elementZ, roll, cameraZoomAnimation)

	--	end
	end
end)

addEventHandler("onClientKey", root, function(key, pressed)
	if vorschauMode then
		if pressed then
			if key == "mouse_wheel_up" then
				if not isMTAWindowActive() then
					cameraSettings["zoom"] = math.max(cameraSettings["zoom"] - 5, 30)
					cameraSettings["zoomTick"] = getTickCount()
				end
			elseif key == "mouse_wheel_down" then
				if not isMTAWindowActive() then
					cameraSettings["zoom"] = math.min(cameraSettings["zoom"] + 5, 60)
					cameraSettings["zoomTick"] = getTickCount()
				end
			elseif key == "escape" then
				if vorschauMode then
					cancelEvent()
					vorschauMode = false
					--updated = false
					if vorschauType == "shop" then
						shopState = true
						vorschauType = ""
					elseif vorschauType == "selector" then
						kleidungSelect = true
						vorschauType = ""
					end
					destroyElement(vorschauObject)
					setCameraTarget(localPlayer, localPlayer)
					setElementInterior(localPlayer, 0)
					setElementDimension(localPlayer, 0)
					setElementFrozen(localPlayer, false)

				end
			end
		end
	end
	if pressed then
		if key == "backspace" then
			if renameState then
				if string.len(invitingText) >= 1 then
					invitingText = string.sub(invitingText, 1, string.len(invitingText)-1)
				end
			end
		elseif key == "i" or key == "t" or key == "m" or key == "n" then
			if renameState then
				cancelEvent()
			end
		end
	end
end)


function makeSlotChanges(x, y, z, rx, ry, rz)
	local sX, sY, sZ = getObjectScale(editingObj)
	savedSlotTable[selectedSlot] = {selectedElementModell, selectedElementBone, selectedElementName, x, y, z, rx, ry, rz, true, selectedKleidungType, selectedKleidungID, sX, sY, sZ}
--	outputChatBox("dbid2: "..selectedKleidungID)

	triggerServerEvent("makeItToServer", localPlayer, localPlayer, selectedElementName, x, y, z, rx, ry, rz, selectedElementBone, selectedKleidungID, sX, sY, sZ)
--	outputChatBox("boneidC: "..selectedElementBone)
	destroyElement(editingObj)

--	outputChatBox("saved")
end



addEventHandler("onClientMarkerHit", shopMarker,
	function(hitPlayer)
		if hitPlayer == localPlayer then
			if not shopState then
				shopState = true
				playSound("sounds/open.mp3")
				triggerServerEvent("requestDatas", localPlayer, 0,  getElementData(localPlayer, "dbid"))
			end
		end
	end
)

addEventHandler("onClientMarkerLeave", shopMarker,
	function(hitPlayer)
		if hitPlayer == localPlayer then
			if shopState then
				shopState = false
				playSound("sounds/close.mp3")
			end
		end
	end
)

bindKey("mouse_wheel_down", "down",
	function()
			--if scrollNum < atvElem - maxShowed then
			if not vorschauMode then
				if kleidungSelect then
					if scrollNum < 8+atvElem2-maxShowed then
						scrollNum2 = scrollNum2 + 1
					end
				elseif shopState then
					if scrollNum < 8+atvElem1-maxShowed then
						scrollNum = scrollNum + 1
					end
				end
			end
		--	end
	end
)

bindKey("mouse_wheel_up", "down",
	function()
		if not vorschauMode then
			if shopState then
					if scrollNum > 0 then
						scrollNum = scrollNum - 1
					end
			elseif kleidungSelect then
				if scrollNum2 > 0 then
					scrollNum2 = scrollNum2 - 1
				end
			end
		end
	end
)

function isInSlot(xS,yS,wS,hS)
    if(isCursorShowing()) then
        XY = {guiGetScreenSize()}
        local cursorX, cursorY = getCursorPosition()
        cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
        if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
            return true
        else
            return false
        end
    end
end

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
    if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
        return true
    else
        return false
    end
end

function drawTextWithBorder(text, offset, x, y, w, h, borderColor, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	for offsetX = -offset, offset do
		for offsetY = -offset, offset do
			dxDrawText(text:gsub("#%x%x%x%x%x%x", ""), x + offsetX, y + offsetY, w + offsetX, h + offsetY, borderColor, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		end
	end

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function _getCameraPosition(element)
	if element == "both" then

		elementX, elementY, elementZ = getElementPosition(vorschauObject)
		local camx,camy,camz, _, _, _, roll, fov = getCameraMatrix()
		local elementZ = elementZ + 0.2

		local cameraX = elementX + math.cos(cameraSettings["currentX"]) * cameraSettings["distance"]
		local cameraY = elementY + math.sin(cameraSettings["currentY"]) * cameraSettings["distance"]
		local cameraZ = elementZ + math.sin(cameraSettings["currentZ"]) * cameraSettings["distance"]

		return cameraX, cameraY, cameraZ, elementX, elementY, elementZ
	end
end

function getInFrontOf(x, y, angle, distance)
	distance = distance or 1
	if x and not y then
		return x + distance * math.sin(math.rad(-angle))
	elseif not x and y then
		return y + distance * math.cos(math.rad(-angle))
	elseif x and y then
		return x + distance * math.sin(math.rad(-angle)), y + distance * math.cos(math.rad(-angle))
	end
end

local modTable = {
	--gorras 1
	{"mods/analgorra", menuPoints[1]["products"][2][3], "mods/analgorra"},
	{"mods/MatClothes", menuPoints[1]["products"][4][3],"mods/Hat1"},
	{"mods/MatClothes", menuPoints[1]["products"][5][3],"mods/Hat2"},
	{"mods/MatClothes", menuPoints[1]["products"][6][3],"mods/Hat3"},
	{"mods/MatClothes", menuPoints[1]["products"][7][3],"mods/Hat4"},
	{"mods/MatClothes", menuPoints[1]["products"][8][3],"mods/Hat5"},
	{"mods/MatClothes", menuPoints[1]["products"][9][3],"mods/Hat6"},
	{"mods/MatClothes", menuPoints[1]["products"][10][3],"mods/Hat7"},
	{"mods/MatClothes", menuPoints[1]["products"][11][3],"mods/Hat8"},
	{"mods/MatClothes", menuPoints[1]["products"][12][3],"mods/Hat9"},
	{"mods/MatClothes", menuPoints[1]["products"][13][3],"mods/Hat10"},
	{"mods/MatClothes", menuPoints[1]["products"][15][3], "mods/HatBowler1"},
	{"mods/MatClothes", menuPoints[1]["products"][16][3], "mods/HatBowler2"},
	{"mods/MatClothes", menuPoints[1]["products"][17][3], "mods/HatBowler3"},
	{"mods/MatClothes", menuPoints[1]["products"][18][3], "mods/HatBowler4"},
	{"mods/vueltiao", menuPoints[1]["products"][19][3], "mods/vueltiao"},
	{"mods/MatClothes", menuPoints[1]["products"][21][3],"mods/HatCool1"},
	{"mods/MatClothes", menuPoints[1]["products"][22][3],"mods/HatCool2"},
	{"mods/MatClothes", menuPoints[1]["products"][23][3],"mods/HatCool3"},
	{"mods/MatClothes", menuPoints[1]["products"][25][3],"mods/SkullyCap1"},
	{"mods/MatClothes", menuPoints[1]["products"][26][3],"mods/SkullyCap2"},
	{"mods/MatClothes", menuPoints[1]["products"][27][3],"mods/SkullyCap3"},
	{"mods/MatClothes", menuPoints[1]["products"][29][3],"mods/MotorcycleHelmet1"},
	{"mods/MatClothes", menuPoints[1]["products"][30][3],"mods/MotorcycleHelmet2"},
	{"mods/MatClothes", menuPoints[1]["products"][31][3],"mods/MotorcycleHelmet3"},
	{"mods/MatClothes", menuPoints[1]["products"][32][3],"mods/MotorcycleHelmet4"},
	{"mods/cross", menuPoints[1]["products"][33][3],"mods/cross"},
	{"mods/cross2", menuPoints[1]["products"][34][3],"mods/cross"},
	{"mods/cross3", menuPoints[1]["products"][35][3],"mods/cross"},
	{"mods/cross4", menuPoints[1]["products"][36][3],"mods/cross"},
	--gorras
	
	{"mods/armor", 8368},
	{"mods/armor5", 8369, "mods/armor"},

	--maletas4
	{"mods/BackPack1", menuPoints[4]["products"][1][3]},
	{"mods/BackPack2", menuPoints[4]["products"][2][3]},
	{"mods/BackPack3", menuPoints[4]["products"][3][3]},
	{"mods/BackPack4", menuPoints[4]["products"][4][3]},
	{"mods/BackPack5", menuPoints[4]["products"][5][3]},
	{"mods/BackPack6", menuPoints[4]["products"][6][3]},
	--maletas4

	{"mods/greencamobikerhelmet"},

	{"mods/CapTrucker"},
	
	

	{"mods/duffelbag"},
	{"mods/duffelbag2"},
	--gafas2
	{"mods/MatGlasses", menuPoints[2]["products"][1][3], "mods/GlassesType1"},
	{"mods/MatGlasses", menuPoints[2]["products"][2][3], "mods/GlassesType2"},
	{"mods/MatGlasses", menuPoints[2]["products"][3][3],"mods/GlassesType5"},
	{"mods/MatGlasses", menuPoints[2]["products"][4][3],"mods/GlassesType6"},
	{"mods/MatGlasses", menuPoints[2]["products"][5][3],"mods/GlassesType7"},
	{"mods/MatGlasses", menuPoints[2]["products"][6][3],"mods/GlassesType8"},
	{"mods/MatGlasses", menuPoints[2]["products"][7][3],"mods/GlassesType9"},
	{"mods/MatGlasses", menuPoints[2]["products"][8][3],"mods/GlassesType10"},
	{"mods/MatGlasses", menuPoints[2]["products"][9][3],"mods/GlassesType11"},
	{"mods/MatGlasses", menuPoints[2]["products"][10][3],"mods/GlassesType12"},
	{"mods/MatGlasses", menuPoints[2]["products"][11][3],"mods/GlassesType13"},
	{"mods/MatGlasses", menuPoints[2]["products"][12][3],"mods/GlassesType14"},
	{"mods/MatGlasses", menuPoints[2]["products"][13][3],"mods/GlassesType15"},
	{"mods/MatGlasses", menuPoints[2]["products"][14][3],"mods/GlassesType16"},
	{"mods/MatGlasses", menuPoints[2]["products"][15][3],"mods/GlassesType17"},
	{"mods/MatGlasses", menuPoints[2]["products"][16][3],"mods/GlassesType18"},
	{"mods/MatGlasses", menuPoints[2]["products"][17][3],"mods/GlassesType19"},
	{"mods/MatGlasses", menuPoints[2]["products"][18][3],"mods/GlassesType20"},
	{"mods/MatGlasses", menuPoints[2]["products"][19][3],"mods/GlassesType21"},
	{"mods/MatGlasses", menuPoints[2]["products"][20][3],"mods/GlassesType22"},
	{"mods/MatGlasses", menuPoints[2]["products"][21][3],"mods/GlassesType23"},
	--gafas2


	

	
	{"mods/HikerBackpack1"},
	--{"mods/hut", 7518,"mods/hut"},
	--{"mods/hut2", 7519,"mods/hut"},
	--{"mods/hut3", 7520,"mods/hut"},
	{"mods/JESSE_Szakall"},
	{"mods/JESSE_Triko"},
	{"mods/JESSE_Triko2"},
	--mascaras5
	{"mods/MatClothes",  menuPoints[5]["products"][1][3],"mods/Mask1"},
	{"mods/MatClothes", menuPoints[5]["products"][2][3],"mods/Mask2"},
	{"mods/MatClothes", menuPoints[5]["products"][3][3],"mods/Mask3"},
	{"mods/tapabocasbala", menuPoints[5]["products"][4][3],"mods/tapabocasbala"},
	{"mods/MatClothes", menuPoints[5]["products"][5][3],"mods/Mask5"},
	{"mods/MatClothes", menuPoints[5]["products"][6][3],"mods/Mask6"},
	{"mods/MatClothes", menuPoints[5]["products"][7][3],"mods/Mask7"},
	{"mods/MatClothes", menuPoints[5]["products"][8][3],"mods/Mask8"},
	{"mods/MatClothes", menuPoints[5]["products"][9][3],"mods/Mask9"},
	{"mods/MatClothes", menuPoints[5]["products"][10][3],"mods/Mask10"},
	--mascaras5

	
	--Collares6
	{"mods/NeckLace1",  menuPoints[6]["products"][1][3],"mods/NeckLace"},
	{"mods/NeckLace2", menuPoints[6]["products"][2][3],"mods/NeckLace"},
	{"mods/Arepa", menuPoints[6]["products"][3][3],"mods/Arepa"},
	{"mods/NeckLace4", menuPoints[6]["products"][4][3],"mods/NeckLace"},
	{"mods/NeckLace5", menuPoints[6]["products"][5][3],"mods/NeckLace"},
	{"mods/NeckLace6", menuPoints[6]["products"][6][3],"mods/NeckLace"},
	{"mods/NeckLace7", menuPoints[6]["products"][7][3],"mods/NeckLace"},
	{"mods/NeckLace8", menuPoints[6]["products"][8][3],"mods/NeckLace"},
	{"mods/NeckLace9", menuPoints[6]["products"][9][3],"mods/NeckLace"},
	--Collares6
	
	{"mods/Nyaklanc_3"},
	{"mods/oldaltaska"},
	{"mods/polgi"},
	{"mods/Sapka_7"},
	{"mods/SchoolPack"},
	{"mods/SchoolPack1"},
	{"mods/SchoolPack2"},
	{"mods/SchoolPack3"},
	
	{"mods/SWATHelmet1"},
	{"mods/TheParrot1"},
	--otros7
	{"mods/trafficvest",  menuPoints[7]["products"][1][3], "mods/trafficvest"},
	{"mods/trafficvest2", menuPoints[7]["products"][2][3], "mods/trafficvest"},
	{"mods/trafficvest3", menuPoints[7]["products"][3][3], "mods/trafficvest"},
	{"mods/trafficvest4", menuPoints[7]["products"][4][3], "mods/trafficvest"},
	{"mods/trafficvest5", menuPoints[7]["products"][5][3], "mods/trafficvest"},
	{"mods/trafficvest6", menuPoints[7]["products"][6][3], "mods/trafficvest"},
	{"mods/trafficvest7", menuPoints[7]["products"][7][3], "mods/trafficvest"},
	{"mods/trafficvest8", menuPoints[7]["products"][8][3], "mods/trafficvest"},
	{"mods/trafficvest9", menuPoints[7]["products"][9][3], "mods/trafficvest"},
	{"mods/trafficvest10", menuPoints[7]["products"][10][3], "mods/trafficvest"},
	{"mods/trafficvest11", menuPoints[7]["products"][11][3], "mods/trafficvest"},
	{"mods/trafficvest12", menuPoints[7]["products"][12][3], "mods/trafficvest"},
	{"mods/trafficvest13", menuPoints[7]["products"][13][3], "mods/trafficvest"},
	{"mods/nyakkendo", menuPoints[7]["products"][14][3],"mods/nyakkendo"},
	{"mods/nyakkendo1", menuPoints[7]["products"][15][3],"mods/nyakkendo"},
	{"mods/nyakkendo2", menuPoints[7]["products"][16][3],"mods/nyakkendo"},
	{"mods/csokor", menuPoints[7]["products"][17][3],"mods/csokor"},
	{"mods/csokor1", menuPoints[7]["products"][18][3],"mods/csokor"},
	{"mods/hasitasi", menuPoints[7]["products"][19][3], "mods/hasitasi"},
	{"mods/gucci", menuPoints[7]["products"][20][3],"mods/gucci"},
	--otros7
	--Reloj3
	{"mods/MatWatches", menuPoints[3]["products"][1][3], "mods/WatchType1"},
	{"mods/MatWatches", menuPoints[3]["products"][2][3], "mods/WatchType2"},
	{"mods/MatWatches", menuPoints[3]["products"][3][3],"mods/WatchType3"},
	{"mods/MatWatches", menuPoints[3]["products"][4][3],"mods/WatchType4"},
	{"mods/MatWatches", menuPoints[3]["products"][5][3],"mods/WatchType5"},
	{"mods/MatWatches", menuPoints[3]["products"][6][3],"mods/WatchType6"},
	{"mods/MatWatches", menuPoints[3]["products"][7][3],"mods/WatchType7"},
	{"mods/MatWatches", menuPoints[3]["products"][8][3],"mods/WatchType8"},
	{"mods/MatWatches", menuPoints[3]["products"][9][3],"mods/WatchType9"},
	{"mods/MatWatches", menuPoints[3]["products"][10][3],"mods/WatchType10"},
	{"mods/MatWatches", menuPoints[3]["products"][11][3],"mods/WatchType11"},
	{"mods/MatWatches", menuPoints[3]["products"][12][3],"mods/WatchType12"},
	{"mods/MatWatches", menuPoints[3]["products"][13][3],"mods/WatchType13"},
	{"mods/MatWatches", menuPoints[3]["products"][14][3],"mods/WatchType14"},
	{"mods/MatWatches", menuPoints[3]["products"][15][3],"mods/WatchType15"},
	--Reloj3
	
	
	{"mods/whitecamobikerhelmet"},
	{"mods/WitchesHat1"},
}

function load()
	startLoading(true)
	checkJSON_File()
end
addEventHandler("onClientResourceStart",getResourceRootElement(),load)




function saveSlots()
	fileDelete("clothes.json")
	local file = fileCreate("clothes.json")
	fileWrite(file, toJSON(savedSlotTable))
	fileClose(file)
end

function saveOutfits()
	fileDelete("outfits.json")
	local file = fileCreate("outfits.json")
	fileWrite(file, toJSON(savedKleidungTable))
	fileClose(file)
end

function checkJSON_File()
	savedSlotTable = {}
	if not fileExists("clothes.json") then

		local file = fileCreate("clothes.json")
		fileWrite(file, toJSON(slotTable))
		fileClose(file)
		savedSlotTable = slotTable
	else

		local file = fileOpen("clothes.json")
		local config = fromJSON(fileRead(file, 9999))

		for k, v in ipairs(config) do

			savedSlotTable[k] = {tonumber(v[1]), tonumber(v[2]), tostring(v[3]), tonumber(v[4]), tonumber(v[5]), tonumber(v[6]), tonumber(v[7]), tonumber(v[8]), tonumber(v[9]), convertToBool(v[10]), tonumber(v[11]), tonumber(v[12]), tonumber(v[13]), tonumber(v[14]), tonumber(v[15]), tonumber(v[16])}
		--	slotTable[k][1] = tonumber(v[1])
		--	outputChatBox(slotTable[1][1])
			if v[12] > 0 then
				triggerServerEvent("makeItToServer", localPlayer, localPlayer, tostring(v[3]), tonumber(v[4]), tonumber(v[5]), tonumber(v[6]), tonumber(v[7]), tonumber(v[8]),tonumber(v[9]), tonumber(v[2]), tonumber(v[12]), tonumber(v[13]), tonumber(v[14]), tonumber(v[15]))
				

			end
		end

		fileClose(file)
	end

	if not fileExists("outfits.json") then

		local file = fileCreate("outfits.json")
		fileWrite(file, toJSON(kleidungTable))
		fileClose(file)
		savedKleidungTable = kleidungTable
	else

		local file = fileOpen("outfits.json")
		local config = fromJSON(fileRead(file, 9999))

		for k, v in ipairs(config) do
			savedKleidungTable[k] = {v[1], v[2], v[3]}
			--savedSlotTable[k] = {tonumber(v[1]), tonumber(v[2]), tostring(v[3]), tonumber(v[4]), tonumber(v[5]), tonumber(v[6]), tonumber(v[7]), tonumber(v[8]), tonumber(v[9]), convertToBool(v[10]), tonumber(v[11]), tonumber(v[12])}
		--	slotTable[k][1] = tonumber(v[1])
			--outputChatBox(slotTable[1][1])
			--triggerServerEvent("makeItToServer", localPlayer, localPlayer, tonumber(v[1]), tonumber(v[4]), tonumber(v[5]), tonumber(v[6]), tonumber(v[7]), tonumber(v[8]),tonumber(v[9]), tonumber(v[2]), tonumber(v[12]), tonumber(v[13]), tonumber(v[14]), tonumber(v[15]))
		end

		fileClose(file)
	end
end

function startLoading(s)
	if s then
		for k, v in pairs(modTable) do
			if v[2] then
				if v[3] then
					ChangeObjectModel(v[1], v[3], v[2])
				else
					ChangeObjectModel(v[1], v[1], v[2])
				end
			end
		end
		ChangeObjectModel("mods/MatGlasses","mods/GlassesType1", 8388)
	end
end

function ChangeObjectModel (txdname,dffname,id)
	if id and txdname then
		if fileExists(txdname..".txd") then
			txd = engineLoadTXD( txdname..".txd", true)
			engineImportTXD( txd, id )
		end
		if fileExists(dffname..".dff") then
			dff = engineLoadDFF( dffname..".dff", 0)
			engineReplaceModel( dff, id )
		end
	end
end



function convertToBool(string)
	if tostring(string) == "true" then
		return true
	else
		return false
	end
end

function table.copy(tab, recursive)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and recursive then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end
