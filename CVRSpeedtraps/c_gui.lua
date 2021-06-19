addEventHandler("onClientRender", root, function()
  local col_shapes = getElementsByType("colshape", resourceRoot)
  for i,col_shape in ipairs(col_shapes) do
    local x,y,z = getElementPosition(col_shape)
    local topscore_speed = getElementData(col_shape, 'bib_speedchallenges.topscore_speed') or 70
    local topscore_name = getElementData(col_shape, 'bib_speedchallenges.topscore_player') or '-'
    local minimum_speed = math.floor(topscore_speed * 0.9)

    dxDraw3DText('Trampa de Velocidad',x,y,z+4.2,2,"beckett",the_color,150)
    dxDraw3DText('Maneja a almenos ' .. topscore_speed * 0.9 .. 'mph para obtener una recompensa',x,y,z+3.3,0.6,"bankgothic",white,150)
    if (topscore_name ~= '-') then
      dxDraw3DText('RECORD: ' .. topscore_speed .. 'mph\n' .. topscore_name,x,y,z+2,0.6,"bankgothic",white,150)
    end
  end
end)

--[[ Utility script from: https://wiki.multitheftauto.com/wiki/Resource:DxDraw3DText ]]--
function dxDraw3DText(text, x, y, z, scale, font, color, maxDistance, colorCoded)
	if not (x and y and z) then
		outputDebugString("dxDraw3DText: One of the world coordinates is missing", 1);
		return false;
	end

	if not (scale) then
		scale = 2;
	end
	
	if not (font) then
		font = "default";
	end
	
	if not (color) then
		color = tocolor(255, 255, 255, 255);
	end
	
	if not (maxDistance) then
		maxDistance = 12;
	end
	
	if not (colorCoded) then
		colorCoded = false;
	end
	
	local pX, pY, pZ = getElementPosition( localPlayer );	
	local distance = getDistanceBetweenPoints3D(pX, pY, pZ, x, y, z);
	
	if (distance <= maxDistance) then
		local x, y = getScreenFromWorldPosition(x, y, z);
		
		if (x and y) then
			dxDrawText( text, x, y, _, _, color, scale, font, "center", "center", false, false, false, colorCoded);
			return true;
		end
	end
end