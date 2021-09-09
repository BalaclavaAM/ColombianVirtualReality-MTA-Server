function replaceModel2()
    local dinero = engineLoadTXD ("archivos/dyn_cash.txd")
    engineImportTXD (dinero,1212)
    local dinerof = engineLoadDFF("archivos/money.dff")
    engineReplaceModel(dinerof,1212)
    local poker = engineLoadTXD ("archivos/break_bar.txd")
    engineImportTXD (poker,1486)
    local chris = engineLoadTXD ("archivos/gorro.txd")
    engineImportTXD (chris,2515)
    local chris2 = engineLoadDFF("archivos/gorro.dff")
    engineReplaceModel(chris2,2515)
    local velita1 = engineLoadTXD("archivos/velas.txd")
    engineImportTXD(velita1,1371)
    local velita2 = engineLoadDFF("archivos/velas.dff")
    engineReplaceModel(velita2,1371)
    local velita3 = engineLoadCOL("archivos/velas.col")
    engineReplaceCOL(velita3,1371)

    local licorera = engineLoadTXD("archivos/cunte_lik.txd")
    engineImportTXD(licorera,12843)

    local chambersin = engineLoadDFF("archivos/chamber.dff")
    engineReplaceModel(chambersin,1520)

    local chambersintxd = engineLoadTXD("archivos/chamber.txd")
    engineImportTXD(chambersintxd,1520)

    local sanco1 = engineLoadTXD("archivos/sancocho.txd")
    engineImportTXD(sanco1,902)
    local sanco2 = engineLoadDFF("archivos/sancocho.dff")
    engineReplaceModel(sanco2,902)
    local sanco3 = engineLoadCOL("archivos/sancocho.col")
    engineReplaceCOL(sanco3,902)

    local antiokenho = engineLoadTXD("archivos/propbarstuff.txd")
    engineImportTXD(antiokenho,1668)

    --Corresponsal
    local corresponsal = engineLoadTXD("archivos/shopliquor_las.txd")
    engineImportTXD(corresponsal,5040)

    --Encerrona
    local logoloscoches = engineLoadTXD("archivos/billbrd01_lan.txd")
    engineImportTXD(logoloscoches,4238)


    local SEVENDEAGOSTO = engineLoadTXD("archivos/garag3_lawn.txd")
    engineImportTXD(SEVENDEAGOSTO,5774)
   
    --Agua casa de lujo
    local water = createWater ( 297, -849, 10, 306, -849, 10, 297, -837.7998046875, 10, 306, -837.90002441406, 10 )
    setWaterLevel ( water, 10 )


end
 addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), 
     function() 
         replaceModel2()
         setTimer (replaceModel2, 1000, 1) 
     end 
) 