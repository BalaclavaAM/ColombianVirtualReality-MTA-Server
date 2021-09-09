--[[-------------------------------------------------
Notes:

> This code is using a relative image filepath. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move images into your local resource and reference them there.
--]]-------------------------------------------------


local imagen = false
addEventHandler("onClientResourceStart", resourceRoot,
   function()
       imagen = guiCreateStaticImage(0.91, 0.89, 0.09, 0.10, "cvrblanco.png", true)    
   end
)

function imagenInCar(bool)
    if isElement(imagen) then
        destroyElement(imagen)
    end
    if bool then
        imagen = guiCreateStaticImage(0.72, 0.86, 0.09, 0.10, "cvrblanco.png", true)    
    else
        imagen = guiCreateStaticImage(0.91, 0.89, 0.09, 0.10, "cvrblanco.png", true)  
    end
end 
addEvent("imageCar",true)
addEventHandler("imageCar",root,imagenInCar)

