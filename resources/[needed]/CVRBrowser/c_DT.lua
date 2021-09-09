
function AbrirNavegador(link)
 if isElement( Fondo ) then

    destroyElement( Fondo )
    guiSetInputMode( "allow_binds" )
 else
    guiSetInputMode("no_binds")

  requestBrowserDomains({ link,"https://colombianvirtualreality.com/foro"},true,function(aceptao)
    if aceptao then
    showCursor( true )
    Fondo = guiCreateStaticImage( 0,0, 1,1, "Fondo.png", true)
    Botonera = guiCreateStaticImage( 0.05,0.05, .9, .075,"Botonera.png",true, Fondo)
    Navegador = guiCreateBrowser(0.05,0.125,.9,.9,false,true,true,Fondo)
    ElNavegador = guiGetBrowser(Navegador)
    Salir = guiCreateButton( .8, .05, .03, .9, "",true, Botonera )
    Casa = guiCreateButton( .275, .05, .03, .9, "",true, Botonera )
    addEventHandler( "onClientGUIClick",Casa, function()
        loadBrowserURL( ElNavegador,"https://colombianvirtualreality.com/foro" )
    end,false)
    guiSetAlpha( Casa, 0 )
    addEventHandler( "onClientGUIClick",Salir, function()destroyElement( Fondo ) showCursor( false ) guiSetInputMode( "allow_binds" )end,false)
    guiSetAlpha( Salir, 0 )
    Reload = guiCreateButton( .235, .05, .03, .9, "",true, Botonera )
    guiSetAlpha( Reload, 0 )
    BotonAdelante = guiCreateButton( .195, .05, .03, .9, "",true, Botonera )
    guiSetAlpha( BotonAdelante, 0 )
    addEventHandler( "onClientGUIClick",BotonAdelante, function() 
        navigateBrowserForward(ElNavegador)
    end,false)
    addEventHandler( "onClientGUIClick",Reload, function() reloadBrowserPage(ElNavegador) end,false)
    BotonAtras = guiCreateButton( .165, .05, .03, .9, "",true, Botonera )
    guiSetAlpha( BotonAtras, 0 )
    addEventHandler( "onClientGUIClick",BotonAtras, function() 
        navigateBrowserBack(ElNavegador)
    end,false)
    addEventHandler( "onClientBrowserCreated", ElNavegador, 
       function( )
           -- After the browser has been initialized, we can load www.youtube.com
           loadBrowserURL( source,link )
       end
   )
end
end) 

end
end


