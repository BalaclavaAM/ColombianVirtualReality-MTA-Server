--> Script By: *Nicol*<
--> Modified By: BalaclavaAM :)

-- ∧,,∧
--(•·̫ •)  ♡°
--┏ー∪∪━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--★∙never stop doing what you like∙★
--┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

--> Be careful when adding or deleting a text, since you may get an error if you do it wrong. 
--> Tenga cuidado al agregar o eliminar un texto, ya que puede obtener un error si lo hace mal.
--> Tenha cuidado ao adicionar ou remover um texto, pois você pode obter um erro se fizer errado.

----------------------------------------------LEAVE SOME INFORMATION ON HOW TO EDIT----------------------------------------------------------------
local marcadores = {} --> Ahora uso una tabla para evitar el ciclo alrededor de todos los marcadores del server :)

function renderIng( )
	local x, y, z = getCameraMatrix( )
	local dimension = getElementDimension( localPlayer )
	for key, marker in ipairs ( marcadores ) do
		if getElementDimension( marker ) == dimension then
			local px, py, pz = getElementPosition( marker )
			local distance = getDistanceBetweenPoints3D( px, py, pz, x, y, z )
			if distance <= 20 then --> distance from text , distancia del texto , distància do texto
				local text1 = getElementData( marker, "message1" ) or false --> message 1 
				local text2 = getElementData( marker, "message2" ) or false--> message 2
				local text3 = getElementData( marker, "message3" ) or false--> message 3 
				local text4 = getElementData( marker, "message4" ) or false--> message 4 
				local text5 = getElementData( marker, "message5" ) or false--> message 5 
				local text6 = getElementData( marker, "message6" ) or false--> message 6 
		        local text7 = getElementData( marker, "message7" ) or false--> message 7 to add, adicinar , agregar
	                                                                      --> ↓ text7 and ↓
				if text1 and ( distance < 2 or isLineOfSightClear( x, y, z, px, py, pz + 1.2, true, true, true, true, false, false, true, localPlayer ) ) then
				-->Ahora sólo necesitas tener 1 texto para que funcione
					local sx, sy = getScreenFromWorldPosition( px, py, pz + 1.2 )
					if sx and sy then
                        dxDrawText( tostring( text1 ), sx, sy, sx, sy, tocolor(0, 255, 249), 1.52, "default-bold", "center", "center", false, false, false, true, false)
						                                                      --> r, g, b,
						if text2 then
							dxDrawText( tostring( text2 ), sx, sy, sx, sy, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
							dxDrawText( tostring( text2 ), sx, sy, sx, sy, tocolor(255, 4, 0), 1.52, "default-bold", "center", "center", false, false, false, false, false)
						end                                                 --> r, g, b,					
						if text3 then
							dxDrawText( tostring( text3 ), sx, sy, sx, sy, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
							dxDrawText( tostring( text3 ), sx, sy, sx, sy, tocolor(4, 255, 0), 1.52, "default-bold", "center", "center", false, false, false, false, false)
						end
						                                                      --> r, g, b,					
						if text4 then
							dxDrawText( tostring( text4 ), sx, sy, sx, sy, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
							dxDrawText( tostring( text4 ), sx, sy, sx, sy, tocolor(255, 193, 0), 1.52, "default-bold", "center", "center", false, false, false, false, false)
						end
						                                                      --> r, g, b,					
						if text5 then
							dxDrawText( tostring( text5 ), sx, sy, sx, sy, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
							dxDrawText( tostring( text5 ), sx, sy, sx, sy, tocolor(253, 255, 0), 1.52, "default-bold", "center", "center", false, false, false, false, false)
						end
						                                                      --> r, g, b,		
						if text6 then				
							dxDrawText( tostring( text6 ), sx, sy, sx, sy, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
							dxDrawText( tostring( text6 ), sx, sy, sx, sy, tocolor(255, 0, 167), 1.52, "default-bold", "center", "center", false, false, false, false, false)
						end
											                                  --> r, g, b,
						if text7 then
							dxDrawText( tostring( text7 ), sx, sy, sx, sy, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
							dxDrawText( tostring( text7 ), sx, sy, sx, sy, tocolor(4, 4, 4 ), 1.52, "default-bold", "center", "center", false, false, false, false, false)
						end
					end						                                  --> r, g, b,
				end
			end
		end
	end
	end
addEventHandler( "onClientRender", getRootElement( ),renderIng)

---------------------------------------------

if not getElementData(localPlayer,"waterElkaRP") then
    setElementData(localPlayer, "waterElkaRP", 0)
end

markElka = { --> edit text coordinates , editar coordenas del texto , editar coordenadas de texto 
    {1545.58, 
	-1675.52, 
	13.56,
	  "★ Bienvenido a ★ ┋ 乂 Colombian Virtual Reality 乂\n\n\n\n\n\n\n",
	  "ツ Esperamos que tengas un buen rato jugando ツ\n\n\n\n\n",
	  "✔ Recuerda usar F1 para obtener información del sv ✔\n\n\n",
	  "✎ También puedes utilizar /ayuda ✎\n",
	  "\n\nHay muchos trabajos en nuestro servidor :D",
	  "\n\n\n\n❤ Todo el dinero que recoge el servidor es donado ❤",
	  "\n\n\n\n\n\n✪ Si lo requieres puedes contactar al equipo staff ✪"
	},
	{1279.71, -1359.79, 13.58,
	"#6F6F6F✪ #FFE400C#1865FFV#FF0101R #FFFFFFPresenta: Captura Camión #6F6F6F✪\n\n\n\n\n\n\n"
	},
	{1321.14, -1356.37, 13.63,
	"#6F6F6F✪ #FFE400C#1865FFV#FF0101R #FFFFFFPresenta: Cuida al Capitán #6F6F6F✪\n\n\n\n\n\n\n"
	},
	{1322.83, -1319.77, 13.63,
	"#6F6F6F✪ #FFE400C#1865FFV#FF0101R #FFFFFFPresenta: Carreras CVR #6F6F6F✪\n\n\n\n\n\n\n"},
	{1268.29, -1337.46, 13.34,
	"#6F6F6F✪ #FFE400C#1865FFV#FF0101R #FFFFFFPresenta: Minijuegos! #6F6F6F✪\n\n\n\n\n\n\n"}
}

function createElka()
	for k,m in pairs(markElka) do
		local markPod=createMarker(m[1], m[2], m[3], "cylinder", 1.5, 30, 144, 255, 0)
		table.insert(marcadores,markPod)
		if m[4] then
			setElementData(markPod,"message1",m[4],false) --> text 1
		end
		if m[5] then
			setElementData(markPod,"message2",m[5],false) --> text 2
		end
		if m[6] then
			setElementData(markPod,"message3",m[6],false) --> text 3
		end
		if m[7] then
			setElementData(markPod,"message4",m[7],false) --> text 4
		end
		if m[8] then
			setElementData(markPod,"message5",m[8],false) --> text 5
		end
		if m[9] then
			setElementData(markPod,"message6",m[9],false) --> text 6
		end
		if m[10] then
			setElementData(markPod,"message7",m[10],false) --> text 7
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, createElka)