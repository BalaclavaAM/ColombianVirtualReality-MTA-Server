gridler = {
    {["bus1"] = "Bus #1"},
    {["bus2"] = "Bus #2"},
    {["casual1"] = "Comercial #1"},
    {["casual2"] = "Comercial #2"},
    {["casual3"] = "Comercial #3"},
    {["casual4"] = "Comercial #4"},
    {["casual5"] = "Comercial #5"},
    {["casual6"] = "Comercial #6"},
    {["casual7"] = "Comercial #7"},
    {["motorbike1"] = "Moto #1"},
    {["motorbike2"] = "Moto #2"},
    {["motorbike3"] = "Moto #3"},
    {["motorbike4"] = "Moto #4"},
    {["motorbike5"] = "Moto #5"},
    {["sport1"] = "Deportivo #1"},
    {["sport2"] = "Deportivo #2"},
    {["sport3"] = "Deportivo #3"},
    {["sport4"] = "Deportivo #4"},
    {["sport5"] = "Deportivo #5"},
    {["sport6"] = "Deportivo #6"},
    {["sport7"] = "Deportivo #7"},
    {["sport8"] = "Deportivo #8"},
    {["sport9"] = "Deportivo #9"},
    {["truck1"] = "Camión #1"},
    {["truck2"] = "Camión #2"},
    {["truck3"] = "Camión #3"},
}

GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}
local screenW, screenH = guiGetScreenSize()
GUIEditor.window[1] = guiCreateWindow((screenW - 427) / 2, (screenH - 251) / 2, 427, 251, "Panel de escapes", false)
guiWindowSetSizable(GUIEditor.window[1], false)
guiSetVisible(GUIEditor.window[1], false)
GUIEditor.gridlist[1] = guiCreateGridList(10, 28, 407, 171, false, GUIEditor.window[1])
guiGridListAddColumn(GUIEditor.gridlist[1], "Escapes", 0.9)
GUIEditor.button[1] = guiCreateButton(10, 209, 177, 30, "Seleccionar sonido", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
GUIEditor.button[2] = guiCreateButton(240, 209, 177, 30, "Cerrar panel", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")

for index, value in ipairs(gridler) do
    for i, v in pairs(value) do
        local row = guiGridListAddRow(GUIEditor.gridlist[1])
        guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v, false, false)
        guiGridListSetItemData(GUIEditor.gridlist[1], row, 1, i)
    end
end

addEventHandler("onClientGUIClick", resourceRoot, function()
    if source == GUIEditor.button[1] then
        local selected = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
        if selected ~= -1 then
            local veh = getPedOccupiedVehicle(localPlayer)
            if veh then
                egzozDegis(veh, guiGridListGetItemData(GUIEditor.gridlist[1], selected, 1))
            end
        end
    elseif source == GUIEditor.button[2] then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
    end
end)

addCommandHandler("escape", function()
    local visible = guiGetVisible(GUIEditor.window[1])
    guiSetVisible(GUIEditor.window[1], not visible)
    showCursor(not visible)
end)

function egzozDegis(veh, egzoz)
    local data = getElementData(veh, "vehicle:engine")
	data.soundPack=egzoz
    setElementData(veh, "vehicle:engine", data)
    triggerServerEvent("EgzozSistemi:AcKapa", veh)
end