function replaceModel()  

  txd = engineLoadTXD("wheel/1074.txd", 1074 )
  engineImportTXD(txd, 1074)
  dff = engineLoadDFF("wheel/1074.dff", 1074 )
  engineReplaceModel(dff, 1074)
  
  txd = engineLoadTXD("wheel/1025.txd", 1025 )
  engineImportTXD(txd, 1025)
  dff = engineLoadDFF("wheel/1025.dff", 1025 )
  engineReplaceModel(dff, 1025)
 
  txd = engineLoadTXD("wheel/1075.txd", 1075 )
  engineImportTXD(txd, 1075)
  dff = engineLoadDFF("wheel/1075.dff", 1075 )
  engineReplaceModel(dff, 1075)
  
  txd = engineLoadTXD("wheel/1076.txd", 1076 )
  engineImportTXD(txd, 1076)
  dff = engineLoadDFF("wheel/1076.dff", 1076 )
  engineReplaceModel(dff, 1076)
  
  txd = engineLoadTXD("wheel/1077.txd", 1077 )
  engineImportTXD(txd, 1077)
  dff = engineLoadDFF("wheel/1077.dff", 1077 )
  engineReplaceModel(dff, 1077)
  
  txd = engineLoadTXD("wheel/1078.txd", 1078 )
  engineImportTXD(txd, 1078)
  dff = engineLoadDFF("wheel/1078.dff", 1078 )
  engineReplaceModel(dff, 1078)
  
  txd = engineLoadTXD("wheel/1079.txd", 1079 )
  engineImportTXD(txd, 1079)
  dff = engineLoadDFF("wheel/1079.dff", 1079 )
  engineReplaceModel(dff, 1079)
  
  txd = engineLoadTXD("wheel/1080.txd", 1080 )
  engineImportTXD(txd, 1080)
  dff = engineLoadDFF("wheel/1080.dff", 1080 )
  engineReplaceModel(dff, 1080)
  
  txd = engineLoadTXD("wheel/1081.txd", 1081 )
  engineImportTXD(txd, 1081)
  dff = engineLoadDFF("wheel/1081.dff", 1081 )
  engineReplaceModel(dff, 1081)
  
  txd = engineLoadTXD("wheel/1082.txd", 1082 )
  engineImportTXD(txd, 1082)
  dff = engineLoadDFF("wheel/1082.dff", 1082 )
  engineReplaceModel(dff, 1082)
  
  txd = engineLoadTXD("wheel/1083.txd", 1083 )
  engineImportTXD(txd, 1083)
  dff = engineLoadDFF("wheel/1083.dff", 1083 )
  engineReplaceModel(dff, 1083)
  
  txd = engineLoadTXD("wheel/1084.txd", 1084 )
  engineImportTXD(txd, 1084)
  dff = engineLoadDFF("wheel/1084.dff", 1084 )
  engineReplaceModel(dff, 1084)
  
  txd = engineLoadTXD("wheel/1085.txd", 1085 )
  engineImportTXD(txd, 1085)
  dff = engineLoadDFF("wheel/1085.dff", 1085 )
  engineReplaceModel(dff, 1085)
  
  txd = engineLoadTXD("wheel/1096.txd", 1096 )
  engineImportTXD(txd, 1096)
  dff = engineLoadDFF("wheel/1096.dff", 1096 )
  engineReplaceModel(dff, 1096)
  
  txd = engineLoadTXD("wheel/1097.txd", 1097 )
  engineImportTXD(txd, 1097)
  dff = engineLoadDFF("wheel/1097.dff", 1097 )
  engineReplaceModel(dff, 1097)
  
  txd = engineLoadTXD("wheel/1098.txd", 1098 )
  engineImportTXD(txd, 1098)
  dff = engineLoadDFF("wheel/1098.dff", 1098 )
  engineReplaceModel(dff, 1098)
  
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)

addCommandHandler ( "reloadwheel", replaceModel )