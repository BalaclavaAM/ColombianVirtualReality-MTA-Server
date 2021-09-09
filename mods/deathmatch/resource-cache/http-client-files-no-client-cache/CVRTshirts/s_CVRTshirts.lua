local camisetas={
    {"archivos/tshirtbobomonk.txd",30499},
    {"archivos/tshirterisyell.txd",30502},
    {"archivos/tshirtlocgrey.txd",30505},
    {"archivos/tshirtsuburb.txd",30514},
    {"archivos/tshirtmaddgrey.txd",30506},
    {"archivos/tshirtheatwht.txd",30503},
    {"archivos/tshirtmaddgrn.txd",30507},
    {"archivos/tshirtproblk.txd",30511},
    {"archivos/tshirtzipcrm.txd",30516},
    {"archivos/tshirtzipgry.txd",30517},
    {"archivos/tshirt2horiz.txd",30496}
}
function cargarCamiseta()
    for k,camiseta in ipairs(camisetas) do
        local tshirtfile = engineLoadTXD(camiseta[1])
        engineImportTXD(tshirtfile,camiseta[2])
    end
end
addEventHandler("onClientResourceStart",root,cargarCamiseta)