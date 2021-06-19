local logo = dxCreateTexture("logo.png")
local Marca = dxCreateTexture("Marca.png")
local x,y,z =2799.5805664062,-1087.7957763672,50.2
local x2,y2,z2= 2788.3176269531,-1094.4,34

function RenderLogo ()
	dxDrawMaterialLine3D( x,y, z , x,  y,z-5 ,logo, 8,tocolor( 255,255, 255),x+5,y,z  )
	dxDrawMaterialLine3D( x2,y2, z2 , x2,  y2,z2-2 ,Marca, 4,tocolor( 255,255, 255),x2,y2-5,z2  )
end
addEventHandler ( "onClientPreRender", root, RenderLogo )
