-- ****************************************************************************
--
-- RECURSO: PanelDeAyuda_GTACHILE
-- ARCHIVO: Cliente.lua
-- PROPOSITO: Funcionamiento del Panel de ayuda por parte del cliente
-- CREADORES: Tomas Andres Navarro < GamerCarl >
--
-- *****************************************************************************

function panelAyuda()


  local screenW, screenH = guiGetScreenSize()
  PAventanaayuda = guiCreateWindow((screenW - 627) / 2, (screenH - 495) / 2, 627, 495, "PANEL DE AYUDA", false)
  guiWindowSetSizable(PAventanaayuda, false)
  guiSetProperty(PAventanaayuda, "CaptionColour", "FFE8F00C")

  PALogoCVR = guiCreateStaticImage(169, 24, 291, 63, ":CVRPanelAyuda/Logos/logoColor.png", false, PAventanaayuda)
  PABotSalir = guiCreateButton(270, 461, 89, 24, "SALIR", false, PAventanaayuda)
  guiSetProperty(PABotSalir, "NormalTextColour", "C4FD0000")
  PAtabpanel = guiCreateTabPanel(9, 95, 608, 361, false, PAventanaayuda)

  PAtabInfo = guiCreateTab("Informacion", PAtabpanel)
  PAmemoInfo = guiCreateMemo(1, 1, 607, 336, "", false, PAtabInfo)
  guiMemoSetReadOnly(PAmemoInfo, true)

  PAtabReglas = guiCreateTab("Reglas", PAtabpanel)
  PAmemoReglas = guiCreateMemo(1, 1, 607, 336, "", false, PAtabReglas)
  guiMemoSetReadOnly(PAmemoReglas, true)

  PAtabAdmin = guiCreateTab("Administracion", PAtabpanel)
  PAmemoAdmin = guiCreateMemo(1, 1, 607, 336, "", false, PAtabAdmin)
  guiMemoSetReadOnly(PAmemoAdmin, true)

  PAtabComandos = guiCreateTab("Comandos", PAtabpanel)
  PAmemoComandos = guiCreateMemo(1, 1, 607, 336, "", false, PAtabComandos)
  guiMemoSetReadOnly(PAmemoComandos, true)

  PAtabVIP = guiCreateTab("Acerca del VIP", PAtabpanel)
  PAmemoVip = guiCreateMemo(1, 1, 607, 336, "", false, PAtabVIP)
  guiMemoSetReadOnly(PAmemoVip, true)

  PAtabEncargados = guiCreateTab("Encargados", PAtabpanel)
  PAmemoEncargados = guiCreateMemo(1, 1, 607, 336, "", false, PAtabEncargados)
  guiMemoSetReadOnly(PAmemoEncargados, true)

  PAtabRedes = guiCreateTab("Redes sociales", PAtabpanel)
  PAmemoRedes = guiCreateMemo(1, 1, 607, 336, "", false, PAtabRedes) 
  guiMemoSetReadOnly(PAmemoRedes, true)

  informacionTexto()
  reglasTexto()
  administracionTexto()
  comandosTexto()
  vipTexto()
  encargadosTexto()
  redesTexto()

  addEventHandler("onClientGUIClick",PABotSalir,abrirocerrar,false)
end

-- Funciones de los textos en el panel
function informacionTexto()
    archivo = fileOpen("Espanol/General.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoInfo:setText (contenido)
    fileClose (archivo)
  end
  
  function reglasTexto()
    archivo = fileOpen("Espanol/Reglas.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoReglas:setText (contenido)
    fileClose (archivo)
  end
  
  function administracionTexto()
    archivo = fileOpen("Espanol/Administracion.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoAdmin:setText (contenido)
    fileClose (archivo)
  end
  
  function comandosTexto()
    archivo = fileOpen("Espanol/Comandos.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoComandos:setText (contenido)
    fileClose (archivo)
  end

  function vipTexto()
    archivo = fileOpen("Espanol/VIP.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoVip:setText (contenido)
    fileClose (archivo)
  end
  
  function encargadosTexto()
    archivo = fileOpen("Espanol/Encargados.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoEncargados:setText (contenido)
    fileClose (archivo)
  end
  
  function redesTexto()
    archivo = fileOpen("Espanol/Redes.txt")
    contenido=fileRead(archivo,fileGetSize(archivo))
    PAmemoRedes:setText (contenido)
    fileClose (archivo)
  end
  

-- Funcion: centrarVentana, Argumentos: ventana, Proposito: Centrar la ventana segun la posicion de pantalla del jugador
  function centrarVentana(PAventanaayuda)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(PAventanaayuda, false)
    local x, y = (screenW - windowW) /2, (screenH - windowH) /2
    guiSetPosition(PAventanaayuda, x, y, false)
  end

  function abrirocerrar()
    -- Verificamos si la ventana se muestra en tal caso de que no se muestre se abre
    if (isElement(PAventanaayuda) == false) then
      panelAyuda()
        -- Se muestra el cursor
      showCursor(true)
        -- Se reproduce el sonido del Panel cuando abre
      playSound("abrir.wav")
    -- en caso de que el panel se esta mostrando se oculta
    else
      destroyElement(PAventanaayuda)
      -- Se deja de mostrar el cursor
      showCursor(false)
      -- Se reproduce el sonido del Panel
      playSound("abrir.wav")
    end
end
addCommandHandler("ayuda",abrirocerrar)
bindKey("F4", "down", abrirocerrar)
