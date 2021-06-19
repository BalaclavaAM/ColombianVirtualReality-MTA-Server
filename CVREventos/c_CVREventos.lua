GUIEditor = {
    button = {},
    window = {},
    label = {}
}
function crearVentana3()
    GUIEditor.window[1] = guiCreateWindow(0.28, 0.22, 0.41, 0.40, "Sistema de Creación de Eventos", true)
    guiWindowSetSizable(GUIEditor.window[1], false)
    guiSetProperty(GUIEditor.window[1], "CaptionColour", "FE79FBF9")
    guiSetProperty (GUIEditor.window[1], "AlwaysOnTop", "true" )
    GUIEditor.quitjob = guiCreateCheckBox(0.07, 0.13, 0.24, 0.08, "¿Quitar job?", false, true, GUIEditor.window[1])
    GUIEditor.freeze = guiCreateCheckBox(0.07, 0.22, 0.24, 0.08, "¿Congelarlos?", true, true, GUIEditor.window[1])
    GUIEditor.mp = guiCreateCheckBox(0.07, 0.32, 0.24, 0.08, "¿Modo Pasivo?", true, true, GUIEditor.window[1])
    GUIEditor.label[1] = guiCreateLabel(0.31, 0.14, 0.23, 0.07, "Vehiculo (Inserte ID)", true, GUIEditor.window[1])
    GUIEditor.vehiculo = guiCreateEdit(0.32, 0.24, 0.23, 0.07, "", true, GUIEditor.window[1])
    GUIEditor.dimensiongui = guiCreateLabel(0.63, 0.14, 0.23, 0.07, "Dimensión", true, GUIEditor.window[1])
    dimension = guiCreateEdit(0.63, 0.24, 0.23, 0.07, "", true, GUIEditor.window[1])
    GUIEditor.passwordlabel = guiCreateLabel(0.02, 0.47, 0.35, 0.07, "Contraseña (dejar vacío si no desea)", true, GUIEditor.window[1])
    GUIEditor.password = guiCreateEdit(0.02, 0.57, 0.35, 0.07, "", true, GUIEditor.window[1])
    GUIEditor.label[2] = guiCreateLabel(0.49, 0.34, 0.22, 0.07, "Descripción del evento", true, GUIEditor.window[1])
    GUIEditor.desc = guiCreateEdit(0.49, 0.45, 0.44, 0.25, "", true, GUIEditor.window[1])
    boton = guiCreateButton(0.35, 0.83, 0.29, 0.14, "Crear!", true, GUIEditor.window[1])
    botonclose = guiCreateButton(0.1, 0.9, 0.1, 0.1, "Cerrar!", true, GUIEditor.window[1])
    guiSetFont(boton, "default-bold-small")
    guiSetProperty(boton, "NormalTextColour", "FEFA65D6")
    GUIEditor.players = guiCreateEdit(10, 225, 195, 22, "", false, GUIEditor.window[1])
    GUIEditor.label[3] = guiCreateLabel(0.03, 0.66, 0.44, 0.05, "Límite de jugadores (dejar vacío si no desea)", true, GUIEditor.window[1])    
    addEventHandler("onClientGUIClick", boton, enviarAlSv)
    addEventHandler("onClientGUIClick", botonclose, togVentana3)
end
function togVentana3()
    if GUIEditor.window[1] and isElement(GUIEditor.window[1]) then
        destroyElement(GUIEditor.window[1])
        showCursor(false)
        GUIEditor.window[1] = nil
        guiSetInputMode("allow_binds")
    else
        crearVentana3()
        showCursor(true)
        guiSetInputMode("no_binds")
    end
  end
addEvent("onServerAbrirVentana2",true)
addEventHandler("onServerAbrirVentana2", root, togVentana3)

function enviarAlSv(button)
   local quitjob = guiCheckBoxGetSelected(GUIEditor.quitjob)
   local freeze = guiCheckBoxGetSelected(GUIEditor.freeze)
   local vehiculo = guiGetText(GUIEditor.vehiculo)
   local password = guiGetText(GUIEditor.password)
   local descripcion = guiGetText(GUIEditor.desc)
   local dimension = guiGetText(dimension)
   local limitep = guiGetText(GUIEditor.players)
   local modopasivo = guiGetText(GUIEditor.mp)
   triggerServerEvent("makeItToServer2", resourceRoot, localPlayer, quitjob, vehiculo, dimension, freeze, password, limitep, descripcion, modopasivo)
   destroyElement(GUIEditor.window[1])
   showCursor(false)
   guiSetInputMode("allow_binds")
   GUIEditor.window[1] = nil
end