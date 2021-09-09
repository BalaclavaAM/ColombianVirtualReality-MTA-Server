--[[

-- making a table with allowed fonts' names
local fonts = { [ "default" ] = true, [ "default-bold" ] = true,[ "clear" ] = true,[ "arial" ] = true,[ "sans" ] = true,
	  [ "pricedown" ] = true, [ "bankgothic" ] = true,[ "diploma" ] = true,[ "beckett" ] = true
};

function dxDraw3DText( text, x, y, z, scale, font, r, g, b, maxDistance )
	-- checking required arguments
	assert( type( text ) == "string", "Bad argument @ dxDraw3DText" );
	assert( type( x ) == "number", "Bad argument @ dxDraw3DText" );
	assert( type( y ) == "number", "Bad argument @ dxDraw3DText" );
	assert( type( z ) == "number", "Bad argument @ dxDraw3DText" );
	-- checking optional arguments
	if not scale or type( scale ) ~= "number" or scale <= 0 then
		scale = 2
	end
	if not font or type( font ) ~= "string" or not fonts[ font ] then
		font = "default"
	end
	if not r or type( r ) ~= "number" or r < 0 or r > 255 then
		r = 255
	end
	if not g or type( g ) ~= "number" or g < 0 or g > 255 then
		g = 255
	end
	if not b or type( b ) ~= "number" or b < 0 or b > 255 then
		b = 255
	end
	if not maxDistance or type( maxDistance ) ~= "number" or maxDistance <= 1 then
		maxDistance = 12
	end
	local textElement = createElement( "text" );
	-- checking if the element was created
	if textElement then 
		-- setting the element datas
		setElementData( textElement, "text", text );
		setElementData( textElement, "x", x );
		setElementData( textElement, "y", y );
		setElementData( textElement, "z", z );
		setElementData( textElement, "scale", scale );
		setElementData( textElement, "font", font );
		setElementData( textElement, "rgba", { r, g, b, 255 } );
		setElementData( textElement, "maxDistance", maxDistance );
		-- returning the text element
		return textElement
	end
	-- returning false in case of errors
	return false
end

addEventHandler( "onClientRender", root,
	function( )
		local texts = getElementsByType( "text" );
		if #texts > 0 then
			local pX, pY, pZ = getElementPosition( localPlayer );
			for i = 1, #texts do
				local text = getElementData( texts[i], "text" );
				local tX, tY, tZ = getElementData( texts[i], "x" ), getElementData( texts[i], "y" ), getElementData( texts[i], "z" );
				local font = getElementData( texts[i], "font" );
				local scale = getElementData( texts[i], "scale" );
				local color = getElementData( texts[i], "rgba" );
				local maxDistance = getElementData( texts[i], "maxDistance" );
				if not text or not tX or not tY or not tZ then
					return
				end
				if not font then font = "default" end
				if not scale then scale = 2 end
				if not color or type( color ) ~= "table" then
					color = { 255, 255, 255, 255 };
				end
				if not maxDistance then maxDistance = 12 end
				local distance = getDistanceBetweenPoints3D( pX, pY, pZ, tX, tY, tZ );
				if distance <= maxDistance then
					local x, y = getScreenFromWorldPosition( tX, tY, tZ );
					if x and y then
						dxDrawText( text, x, y, _, _, tocolor( color[1], color[2], color[3], color[4] ), scale, font, "center", "center" );

					end
				end
			end
		end
	end
);
--]]
randomPed = createMarker ( -2021.86,-44.18,34.5, "cylinder", 1, 0, 0, 0, 0 )
tag = dxCreateTexture("taxi.png")
 
addEventHandler("onClientPreRender", root,
function()
dxDrawImageOnElement(randomPed,tag)
end)

function dxDrawImageOnElement(TheElement,Image,distance,height,width,R,G,B,alpha)
				local x, y, z = getElementPosition(TheElement)
				local x2, y2, z2 = getElementPosition(localPlayer)
				local distance = distance or 20
				local height = height or 1
				local width = width or 1
                                local checkBuildings = checkBuildings or true
                                local checkVehicles = checkVehicles or false
                                local checkPeds = checkPeds or false
                                local checkObjects = checkObjects or true
                                local checkDummies = checkDummies or true
                                local seeThroughStuff = seeThroughStuff or false
                                local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
                                local ignoredElement = ignoredElement or nil
				if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
					local sx, sy = getScreenFromWorldPosition(x, y, z+height)
					if(sx) and (sy) then
						local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
						if(distanceBetweenPoints < distance) then
							dxDrawMaterialLine3D(x, y, z+1+height-(distanceBetweenPoints/distance), x, y, z+height, Image, width-(distanceBetweenPoints/distance), tocolor(R or 255, G or 255, B or 255, alpha or 255))
						end
					end
			end
	end


