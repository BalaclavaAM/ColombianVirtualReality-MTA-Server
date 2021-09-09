function outputBarraMensaje(msj,usuario,numero)
   if  numero ~=nil then
      triggerClientEvent( usuario, "msJoin"..tostring(numero), usuario,msj)
   else
   	triggerClientEvent( usuario, "msJoin", usuario,msj)
   end
end

function removeHex (s)
   if type (s) == "string" then
       while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
           s = s:gsub ("#%x%x%x%x%x%x", "")
       end
   end
   return s or false
end

local contadores = {[1]=0,[2]=0,[3]=0,[4]=0}


--Ejemplo
--outputBarMessage( string text [, element visibleTo=getRootElement() ] )
function anunciofx( source,mensaje,carro,precio)
   local persona = getPlayerName(source)
   local namesinhexa = removeHex(persona)
   local tick = getTickCount( )
   local valoranuncio = get("CVRCompraVenta.valorAnuncio")--25000
   local esperamin = get("CVRCompraVenta.TiempoEsperaEnMin")
   local espera = esperamin*(60000)
   if getPlayerMoney( source ) > valoranuncio then
      if mensaje and carro then
         if tick - (contadores[1]) > espera then
            if precio then
            outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." "..carro.." Por: $ #FF0000"..precio.."", root )
            else
            outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." #FF0000"..carro.."", root )
            end
            contadores[1] = tick
            takePlayerMoney( source, valoranuncio )
            return
         elseif tick - (contadores[2]) > espera then
            if precio then
               outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." "..carro.." Por: $ #FF0000"..precio.."", root,2 )
            else
               outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." #FF0000"..carro.."", root,2 )
            end
            contadores[2] = tick
            takePlayerMoney( source, valoranuncio )
            return
         elseif tick - (contadores[3]) > espera then
            if precio then
               outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." "..carro.." Por: $ #FF0000"..precio.."", root,3 )
            else
               outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." #FF0000"..carro.."", root,3 )
            end
            contadores[3] = tick
            takePlayerMoney( source, valoranuncio )
            return
         elseif tick - (contadores[4]) > espera then
            if precio then
               outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." "..carro.." Por: $ #FF0000"..precio.."", root,4 )
            else
               outputBarraMensaje("#FFFE00"..namesinhexa..": ".."#0050FF"..mensaje.." #FF0000"..carro.."", root,4 )
            end
            contadores[4] = tick
            takePlayerMoney( source, valoranuncio )
            return
         else
            outputChatBox( "#FF0000 Debes esperar "..tonumber(string.format("%.1f",esperamin)).. " min antes de poner otro anuncio",source,231,217,176,true)
         end

      else 
         outputChatBox( "#0000FF Recuerda que no debes usar letras en el precio.",source,231,217,176,true)
      end
   else
      outputChatBox( "#FF0000 Debes tener $"..valoranuncio.." para poder anunciar",source,231,217,176,true)
   end
end
addEvent( "CrearAnuncio", true )
addEventHandler( "CrearAnuncio",root, anunciofx) 


local contadoranuncio = {}
local esperaanuncio = 1200000
local esperaminanuncio= esperaanuncio* (0.001/60)
local valoranunciocv = 5000
function anuncio( source,_,mensaje,carro,precio)
   if getPlayerMoney( source ) > valoranunciocv then
       if contadoranuncio[source] and getTickCount(  ) - contadoranuncio[source] < esperaanuncio then
         return outputChatBox( "#FF0000 Debes esperar "..tonumber(string.format("%.1f",esperaminanuncio)).. " min antes de poner otro anuncio",source,231,217,176,true)
      end
      if mensaje and carro and precio then
         outputChatBox ( "#FFFE00====== #0050FF[Compra-Venta] #FF0000=====", root, 255, 120, 0 ,true)
         outputChatBox ( "#FFFE00 "..getPlayerName(source)..":#FFFFFF "..mensaje.."", root, 255, 255, 255, true)
         outputChatBox ( "#0050FF Vehículo: #FFFFFF"..carro.."", root, 255, 255, 255, true)
         outputChatBox ( "#FF0000 Precio: #FFFFFF$"..precio.."", root, 255, 255, 255, true )
         outputChatBox ( "#FFFE00=======#0050FF========#FF0000=======", root, 255, 120, 0 ,true)
         takePlayerMoney( source, valoranunciocv )
         contadoranuncio[source] = getTickCount(  )
      else 
         outputChatBox( "#0000FF sintaxis: /anuncio Vende/Compra, Nombre Del Carro, Precio del carro Ej; Vendo Elejy  4.500.000",source,231,217,176,true)
      end
   else
      outputChatBox( "#FF0000 Debes tener $"..valoranunciocv.." para poder anunciar",source,231,217,176,true)
   end
end
addCommandHandler( "anunciochat", anuncio )
