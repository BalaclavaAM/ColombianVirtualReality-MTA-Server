---------------------------------------------------------------------------------------------
function panelMain()
	-----------------------------------------------------------------------------------------
    ---                                  Panel main                                       ---
	-----------------------------------------------------------------------------------------

	Panelanim = guiCreateWindow(0.80, 0.59, 0.20, 0.39, "Panel de animaciones By: ReizerB", true)
	guiWindowSetSizable(Panelanim, false)
	guiSetAlpha(Panelanim , 0.70)
	guiSetProperty(Panelanim , "CaptionColour", "FFFFFFFF")
	---rojo FFFF0D0D ; azul FF34C5D7;
	-----------------------------------------------------------------------------------------
	Bbailes = guiCreateButton(0.05, 0.11, 0.44, 0.08, "Bailes 1", true, Panelanim)
	guiSetProperty(Bbailes, "NormalTextColour", "FF34C5D7")
	Botros2 = guiCreateButton(0.53, 0.11, 0.44, 0.08, "Bailes 2", true, Panelanim)
	guiSetProperty(Botros2, "NormalTextColour", "FF34C5D7")
	Bcrack = guiCreateButton(0.05, 0.23, 0.44, 0.08, "Crack", true, Panelanim)
	guiSetProperty(Bcrack , "NormalTextColour", "FF34C5D7")
	Bgym = guiCreateButton(0.53, 0.23, 0.44, 0.08, "Gym", true, Panelanim)
	guiSetProperty(Bgym, "NormalTextColour", "FF34C5D7")
	Bsenales = guiCreateButton(0.05, 0.34, 0.44, 0.08, "Señales", true, Panelanim)
	guiSetProperty(Bsenales, "NormalTextColour", "FF34C5D7")
	Bhablar = guiCreateButton(0.53, 0.34, 0.44, 0.08, "Hablar", true, Panelanim)
	guiSetProperty(Bhablar, "NormalTextColour", "FF34C5D7")
	Bdiler = guiCreateButton(0.05, 0.45, 0.44, 0.08, "Diler & Fumar", true, Panelanim)
	guiSetProperty(Bdiler, "NormalTextColour", "FF34C5D7")
	Bbesos = guiCreateButton(0.53, 0.45, 0.44, 0.08, "Besos & Sex", true, Panelanim)
	guiSetProperty(Bbesos, "NormalTextColour", "FF34C5D7")
	Bsentarse = guiCreateButton(0.05, 0.56, 0.44, 0.08, "Sentarse", true, Panelanim)
	guiSetProperty(Bsentarse, "NormalTextColour", "FF34C5D7")
	Bdj = guiCreateButton(0.53, 0.56, 0.44, 0.08, "DJ", true, Panelanim)
	guiSetProperty(Bdj, "NormalTextColour", "FF34C5D7")
	Bvarios = guiCreateButton(0.05, 0.68, 0.44, 0.08, "Rol & otros", true, Panelanim)
	guiSetProperty(Bvarios, "NormalTextColour", "FF34C5D7")
	Bpose = guiCreateButton(0.53, 0.68, 0.44, 0.08, "Fornite", true, Panelanim)
	guiSetProperty(Bpose, "NormalTextColour", "FF34C5D7")
	Botrosmas = guiCreateButton(0.05, 0.79, 0.44, 0.08, "Otros más", true, Panelanim)
	guiSetProperty(Botrosmas, "NormalTextColour", "FF34C5D7")
	Bbar = guiCreateButton(0.53, 0.79, 0.44, 0.08, "Bar & Bat", true, Panelanim)
	guiSetProperty(Bbar, "NormalTextColour", "FF0ED2FC")



	addEventHandler("onClientGUIClick",Bbailes,mpbailes, false)
	addEventHandler("onClientGUIClick",Bbar,mpbarybat, false)
	addEventHandler("onClientGUIClick",Bcrack,mpcrack, false)
	addEventHandler("onClientGUIClick",Bgym,mpgym, false)
	addEventHandler("onClientGUIClick",Bsenales,mpsenales, false)
	addEventHandler("onClientGUIClick",Bhablar,mphablar, false)
	addEventHandler("onClientGUIClick",Bdiler,mPdiler, false)
	addEventHandler("onClientGUIClick",Bbesos,mpbesos, false)
	addEventHandler("onClientGUIClick",Bdj,mpdj, false)
	addEventHandler("onClientGUIClick",Bsentarse,mpsentarse, false)
	addEventHandler("onClientGUIClick",Bvarios,mpvarios, false)
	addEventHandler("onClientGUIClick",Bpose,mppose, false)
    addEventHandler("onClientGUIClick",Botrosmas,mpotrosmas, false)
  	addEventHandler("onClientGUIClick",Botros2,mpotros2, false)



	-----------------------------------------------------------------------------------------
    ---                                  B0t0n Salir                                      ---
	-----------------------------------------------------------------------------------------
	Bsalir = guiCreateButton(0.58, 0.89, 0.2, 0.07, "SALIR", true, Panelanim)
	guiSetProperty(Bsalir, "NormalTextColour", "FFFFFB03")
	addEventHandler("onClientGUIClick",Bsalir,cerrarpanel, false)

	-----------------------------------------------------------------------------------------
    ---                           B0t0n Parar animacion                                   ---
	-----------------------------------------------------------------------------------------
	Bstop = guiCreateButton(0.18, 0.89, 0.2, 0.07, "STOP", true, Panelanim)
	guiSetProperty(Bstop, "NormalTextColour", "FFFF0D0D")
	addEventHandler("onClientGUIClick",Bstop, pararanim, false)
end
	-----------------------------------------------------------------------------------------
    ---                                  Paneles                                       ---
	-----------------------------------------------------------------------------------------
function PbailesFun()

	Pbailes = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Bailes.", true)
	guiWindowSetSizable(Pbailes, false)
	guiSetProperty(Pbailes, "CaptionColour", "FF34C5D7")	

	Baile1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Baile 1", true, Pbailes)
	guiSetProperty(Baile1, "NormalTextColour", "FFFFFFFF")
	Baile2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Baile 2", true, Pbailes)
	guiSetProperty(Baile2, "NormalTextColour", "FFFFFFFF")
	Baile3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Baile 3", true, Pbailes)
	guiSetProperty(Baile3, "NormalTextColour", "FFFFFFFF")
	Baile4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Baile 4", true, Pbailes)
	guiSetProperty(Baile4, "NormalTextColour", "FFFFFFFF")
	Baile5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Baile 5", true, Pbailes)
	guiSetProperty(Baile5, "NormalTextColour", "FFFFFFFF")
	Baile6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Baile 6", true, Pbailes)
	guiSetProperty(Baile6, "NormalTextColour", "FFFFFFFF")
	Baile7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Baile 7", true, Pbailes)
	guiSetProperty(Baile7, "NormalTextColour", "FFFFFFFF")
	Baile8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Baile 8", true, Pbailes)
	guiSetProperty(Baile8, "NormalTextColour", "FFFFFFFF")
	Baile9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Baile 9", true, Pbailes)
	guiSetProperty(Baile9, "NormalTextColour", "FFFFFFFF")
	Baile10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Baile 10", true, Pbailes)
	guiSetProperty(Baile10, "NormalTextColour", "FFFFFFFF")
	Baile11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Baile 11", true, Pbailes)
	guiSetProperty(Baile11, "NormalTextColour", "FFFFFFFF")
	Baile12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Baile 12", true, Pbailes)
	guiSetProperty(Baile12, "NormalTextColour", "FFFFFFFF")
	Baile13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Baile 13", true, Pbailes)
	guiSetProperty(Baile13, "NormalTextColour", "FFFFFFFF")
	Baile14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Baile 14", true, Pbailes)
	guiSetProperty(Baile14, "NormalTextColour", "FFFFFFFF")
	Baile15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Baile 15", true, Pbailes)
	guiSetProperty(Baile15, "NormalTextColour", "FFFFFFFF")
	--Baile16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Baile 16", true, Pbailes)
	--guiSetProperty(Baile16, "NormalTextColour", "FFFFFFFF")

	addEventHandler("onClientGUIClick",Baile1,B1, false)
	addEventHandler("onClientGUIClick",Baile2,B2, false)
	addEventHandler("onClientGUIClick",Baile3,B3, false)
	addEventHandler("onClientGUIClick",Baile4,B4, false)
	addEventHandler("onClientGUIClick",Baile5,B5, false)
	addEventHandler("onClientGUIClick",Baile6,B6, false)
	addEventHandler("onClientGUIClick",Baile7,B7, false)
	addEventHandler("onClientGUIClick",Baile8,B8, false)
	addEventHandler("onClientGUIClick",Baile9,B9, false)
	addEventHandler("onClientGUIClick",Baile10,B10, false)
	addEventHandler("onClientGUIClick",Baile11,B11, false)
	addEventHandler("onClientGUIClick",Baile12,B12, false)
	addEventHandler("onClientGUIClick",Baile13,B13, false)
	addEventHandler("onClientGUIClick",Baile14,B14, false)
	addEventHandler("onClientGUIClick",Baile15,B15, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PbarFun()

	Pbar = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Bar & Bat.", true)
	guiWindowSetSizable(Pbar, false)
	guiSetProperty(Pbar, "CaptionColour", "FF34C5D7")	

	Bar1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Bar1", true, Pbar)
	guiSetProperty(Bar1, "NormalTextColour", "FFFFFFFF")
	Bar2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Bar2", true, Pbar)
	guiSetProperty(Bar2, "NormalTextColour", "FFFFFFFF")
	Bar3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Bar3", true, Pbar)
	guiSetProperty(Bar3, "NormalTextColour", "FFFFFFFF")
	Bar4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Bar4", true, Pbar)
	guiSetProperty(Bar4, "NormalTextColour", "FFFFFFFF")
	Bar5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Bar5", true, Pbar)
	guiSetProperty(Bar5, "NormalTextColour", "FFFFFFFF")
	Bar6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Bar6", true, Pbar)
	guiSetProperty(Bar6, "NormalTextColour", "FFFFFFFF")
	Bar7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Bar7", true, Pbar)
	guiSetProperty(Bar7, "NormalTextColour", "FFFFFFFF")
	Bar8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Bar8", true, Pbar)
	guiSetProperty(Bar8, "NormalTextColour", "FFFFFFFF")
	Bat1 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Bat1", true, Pbar)
	guiSetProperty(Bat1, "NormalTextColour", "FFFFFFFF")
	Bat2 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Bat2", true, Pbar)
	guiSetProperty(Bat2, "NormalTextColour", "FFFFFFFF")
	Bat3 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Bat3", true, Pbar)
	guiSetProperty(Bat3, "NormalTextColour", "FFFFFFFF")
	Bat4 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Bat4", true, Pbar)
	guiSetProperty(Bat4, "NormalTextColour", "FFFFFFFF")
	Bat5 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Bat5", true, Pbar)
	guiSetProperty(Bat5, "NormalTextColour", "FFFFFFFF")
	Bat6 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Bat6", true, Pbar)
	guiSetProperty(Bat6, "NormalTextColour", "FFFFFFFF")
	Bat7 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Bat7", true, Pbar)
	guiSetProperty(Bat7, "NormalTextColour", "FFFFFFFF")
	--Bat8 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Bat8", true, Pbar)
	--guiSetProperty(Bat8, "NormalTextColour", "FFFFFFFF")

	addEventHandler("onClientGUIClick",Bar1,Ba1, false)
	addEventHandler("onClientGUIClick",Bar2,Ba2, false)
	addEventHandler("onClientGUIClick",Bar3,Ba3, false)
	addEventHandler("onClientGUIClick",Bar4,Ba4, false)
	addEventHandler("onClientGUIClick",Bar5,Ba5, false)
	addEventHandler("onClientGUIClick",Bar6,Ba6, false)
	addEventHandler("onClientGUIClick",Bar7,Ba7, false)
	addEventHandler("onClientGUIClick",Bar8,Ba8, false)
	addEventHandler("onClientGUIClick",Bat1,Bt1, false)
	addEventHandler("onClientGUIClick",Bat2,Bt2, false)
	addEventHandler("onClientGUIClick",Bat3,Bt3, false)
	addEventHandler("onClientGUIClick",Bat4,Bt4, false)
	addEventHandler("onClientGUIClick",Bat5,Bt5, false)
	addEventHandler("onClientGUIClick",Bat6,Bt6, false)
	addEventHandler("onClientGUIClick",Bat7,Bt7, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PcrackFun()
	Pcrack = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Crack", true)
	guiWindowSetSizable(Pcrack, false)
	guiSetProperty(Pcrack, "CaptionColour", "FF34C5D7")	

	Crack1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Crack 1", true, Pcrack)
	guiSetProperty(Crack1, "NormalTextColour", "FFFFFFFF")
	Crack2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Crack 2", true, Pcrack)
	guiSetProperty(Crack2, "NormalTextColour", "FFFFFFFF")
	Crack3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Crack 3", true, Pcrack)
	guiSetProperty(Crack3, "NormalTextColour", "FFFFFFFF")
	Crack4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Crack 4", true, Pcrack)
	guiSetProperty(Crack4, "NormalTextColour", "FFFFFFFF")
	Crack5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Crack 5", true, Pcrack)
	guiSetProperty(Crack5, "NormalTextColour", "FFFFFFFF")
	Crack6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Crack 6", true, Pcrack)
	guiSetProperty(Crack6, "NormalTextColour", "FFFFFFFF")
	Crack7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Crack 7", true, Pcrack)
	guiSetProperty(Crack7, "NormalTextColour", "FFFFFFFF")
	Crack8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Crack 8", true, Pcrack)
	guiSetProperty(Crack8, "NormalTextColour", "FFFFFFFF")
	Crack9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Crack 9", true, Pcrack)
	guiSetProperty(Crack9, "NormalTextColour", "FFFFFFFF")
	Crack10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Crack 10", true, Pcrack)
	guiSetProperty(Crack10, "NormalTextColour", "FFFFFFFF")
	Crack11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Crack 11", true, Pcrack)
	guiSetProperty(Crack11, "NormalTextColour", "FFFFFFFF")
	--Crack12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Crack 12", true, Pcrack)
	--guiSetProperty(Crack12, "NormalTextColour", "FFFFFFFF")
	--Crack13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Crack 13", true, Pcrack)
	--guiSetProperty(Crack13, "NormalTextColour", "FFFFFFFF")
	--Crack14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Crack 14", true, Pcrack)
	--guiSetProperty(Crack14, "NormalTextColour", "FFFFFFFF")
	--Crack15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Crack 15", true, Pcrack)
	--guiSetProperty(Crack15, "NormalTextColour", "FFFFFFFF")
	--Crack16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Crack 16", true, Pcrack)
	--guiSetProperty(Crack16, "NormalTextColour", "FFFFFFFF")

	addEventHandler("onClientGUIClick",Crack1,Ck1, false)
	addEventHandler("onClientGUIClick",Crack2,Ck2, false)
	addEventHandler("onClientGUIClick",Crack3,Ck3, false)
	addEventHandler("onClientGUIClick",Crack4,Ck4, false)
	addEventHandler("onClientGUIClick",Crack5,Ck5, false)
	addEventHandler("onClientGUIClick",Crack6,Ck6, false)
	addEventHandler("onClientGUIClick",Crack7,Ck7, false)
	addEventHandler("onClientGUIClick",Crack8,Ck8, false)
	addEventHandler("onClientGUIClick",Crack9,Ck9, false)
	addEventHandler("onClientGUIClick",Crack10,Ck10, false)
	addEventHandler("onClientGUIClick",Crack11,Ck11, false)
	--addEventHandler("onClientGUIClick",Crack12,Ck12, false)
	--addEventHandler("onClientGUIClick",Crack13,Ck13, false)
	--addEventHandler("onClientGUIClick",Crack14,Ck14, false)
	--addEventHandler("onClientGUIClick",Crack15,Ck15, false)
	--addEventHandler("onClientGUIClick",Crack16,Ck16, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PgymFun()
	Pgym = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Gym.", true)
	guiWindowSetSizable(Pgym, false)
	guiSetProperty(Pgym, "CaptionColour", "FF34C5D7")	

	Gym1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Gym 1", true, Pgym)
	guiSetProperty(Gym1, "NormalTextColour", "FFFFFFFF")
	Gym2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Gym 2", true, Pgym)
	guiSetProperty(Gym2, "NormalTextColour", "FFFFFFFF")
	Gym3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Gym 3", true, Pgym)
	guiSetProperty(Gym3, "NormalTextColour", "FFFFFFFF")
	Gym4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Gym 4", true, Pgym)
	guiSetProperty(Gym4, "NormalTextColour", "FFFFFFFF")
	Gym5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Gym 5", true, Pgym)
	guiSetProperty(Gym5, "NormalTextColour", "FFFFFFFF")
	Gym6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Gym 6", true, Pgym)
	guiSetProperty(Gym6, "NormalTextColour", "FFFFFFFF")
	Gym7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Gym 7", true, Pgym)
	guiSetProperty(Gym7, "NormalTextColour", "FFFFFFFF")
	Gym8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Gym 8", true, Pgym)
	guiSetProperty(Gym8, "NormalTextColour", "FFFFFFFF")
	Gym9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Gym 9", true, Pgym)
	guiSetProperty(Gym9, "NormalTextColour", "FFFFFFFF")
	Gym10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Gym 10", true, Pgym)
	guiSetProperty(Gym10, "NormalTextColour", "FFFFFFFF")
	Gym11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Gym 11", true, Pgym)
	guiSetProperty(Gym11, "NormalTextColour", "FFFFFFFF")
	--Gym12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Gym 12", true, Pgym)
	--guiSetProperty(Gym12, "NormalTextColour", "FFFFFFFF")
	--Gym13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Gym 13", true, Pgym)
	--guiSetProperty(Gym13, "NormalTextColour", "FFFFFFFF")
	--Gym14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Gym 14", true, Pgym)
	--guiSetProperty(Gym14, "NormalTextColour", "FFFFFFFF")
	--Gym15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Gym 15", true, Pgym)
	--guiSetProperty(Gym15, "NormalTextColour", "FFFFFFFF")
	--Gym16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Gym 16", true, Pgym)
	--guiSetProperty(Gym16, "NormalTextColour", "FFFFFFFF")

	addEventHandler("onClientGUIClick",Gym1,Gm1, false)
	addEventHandler("onClientGUIClick",Gym2,Gm2, false)
	addEventHandler("onClientGUIClick",Gym3,Gm3, false)
	addEventHandler("onClientGUIClick",Gym4,Gm4, false)
	addEventHandler("onClientGUIClick",Gym5,Gm5, false)
	addEventHandler("onClientGUIClick",Gym6,Gm6, false)
	addEventHandler("onClientGUIClick",Gym7,Gm7, false)
	addEventHandler("onClientGUIClick",Gym8,Gm8, false)
	addEventHandler("onClientGUIClick",Gym9,Gm9, false)
	addEventHandler("onClientGUIClick",Gym10,Gm10, false)
	addEventHandler("onClientGUIClick",Gym11,Gm11, false)
	--addEventHandler("onClientGUIClick",Gym12,Gm12, false)
	--addEventHandler("onClientGUIClick",Gym13,Gm13, false)
	--addEventHandler("onClientGUIClick",Gym14,Gm14, false)
	--addEventHandler("onClientGUIClick",Gym15,Gm15, false)
	--addEventHandler("onClientGUIClick",Gym16,Gm16, false)

end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PsenalesFun()
	Psenales = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Señales.", true)
	guiWindowSetSizable(Psenales, false)
	guiSetProperty(Psenales, "CaptionColour", "FF34C5D7")	

	Senal1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Señal 1", true, Psenales)
	guiSetProperty(Senal1, "NormalTextColour", "FFFFFFFF")
	Senal2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Señal 2", true, Psenales)
	guiSetProperty(Senal2, "NormalTextColour", "FFFFFFFF")
	Senal3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Señal 3", true, Psenales)
	guiSetProperty(Senal3, "NormalTextColour", "FFFFFFFF")
	Senal4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Señal 4", true, Psenales)
	guiSetProperty(Senal4, "NormalTextColour", "FFFFFFFF")
	Senal5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Señal 5", true, Psenales)
	guiSetProperty(Senal5, "NormalTextColour", "FFFFFFFF")
	Senal6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Señal 6", true, Psenales)
	guiSetProperty(Senal6, "NormalTextColour", "FFFFFFFF")
	Senal7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Señal 7", true, Psenales)
	guiSetProperty(Senal7, "NormalTextColour", "FFFFFFFF")
	Senal8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Señal 8", true, Psenales)
	guiSetProperty(Senal8, "NormalTextColour", "FFFFFFFF")
	Senal9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Señal 9", true, Psenales)
	guiSetProperty(Senal9, "NormalTextColour", "FFFFFFFF")
	Senal10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Señal 10", true, Psenales)
	guiSetProperty(Senal10, "NormalTextColour", "FFFFFFFF")
	Senal11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Señal 11", true, Psenales)
	guiSetProperty(Senal11, "NormalTextColour", "FFFFFFFF")
	Senal12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Señal 12", true, Psenales)
	guiSetProperty(Senal12, "NormalTextColour", "FFFFFFFF")
	Senal13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Señal 13", true, Psenales)
	guiSetProperty(Senal13, "NormalTextColour", "FFFFFFFF")
	--Senal14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Señal 14", true, Psenales)
	--guiSetProperty(Senal14, "NormalTextColour", "FFFFFFFF")
	--Senal15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Señal 15", true, Psenales)
	--guiSetProperty(Senal15, "NormalTextColour", "FFFFFFFF")
	--Senal16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Señal 16", true, Psenales)
	--guiSetProperty(Senal16, "NormalTextColour", "FFFFFFFF")

	addEventHandler("onClientGUIClick",Senal1,Sig1, false)
	addEventHandler("onClientGUIClick",Senal2,Sig2, false)
	addEventHandler("onClientGUIClick",Senal3,Sig3, false)
	addEventHandler("onClientGUIClick",Senal4,Sig4, false)
	addEventHandler("onClientGUIClick",Senal5,Sig5, false)
	addEventHandler("onClientGUIClick",Senal6,Sig6, false)
	addEventHandler("onClientGUIClick",Senal7,Sig7, false)
	addEventHandler("onClientGUIClick",Senal8,Sig8, false)
	addEventHandler("onClientGUIClick",Senal9,Sig9, false)
	addEventHandler("onClientGUIClick",Senal10,Sig10, false)
	addEventHandler("onClientGUIClick",Senal11,Sig11, false)
	addEventHandler("onClientGUIClick",Senal12,Sig12, false)
	addEventHandler("onClientGUIClick",Senal13,Sig13, false)
	--addEventHandler("onClientGUIClick",Senal14,Sig14, false)
	--addEventHandler("onClientGUIClick",Senal15,Sig15, false)
	--addEventHandler("onClientGUIClick",Senal16,Sig16, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PhablarFun()
	Phablar = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Hablar.", true)
	guiWindowSetSizable(Phablar, false)
	guiSetProperty(Phablar, "CaptionColour", "FF34C5D7")	

	Hablar1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Hablar 1", true, Phablar)
	guiSetProperty(Hablar1, "NormalTextColour", "FFFFFFFF")
	Hablar2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Hablar 2", true, Phablar)
	guiSetProperty(Hablar2, "NormalTextColour", "FFFFFFFF")
	Hablar3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Hablar 3", true, Phablar)
	guiSetProperty(Hablar3, "NormalTextColour", "FFFFFFFF")
	Hablar4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Hablar 4", true, Phablar)
	guiSetProperty(Hablar4, "NormalTextColour", "FFFFFFFF")
	Hablar5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Hablar 5", true, Phablar)
	guiSetProperty(Hablar5, "NormalTextColour", "FFFFFFFF")
	Hablar6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Hablar 6", true, Phablar)
	guiSetProperty(Hablar6, "NormalTextColour", "FFFFFFFF")
	Hablar7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Hablar 7", true, Phablar)
	guiSetProperty(Hablar7, "NormalTextColour", "FFFFFFFF")
	Hablar8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Hablar 8", true, Phablar)
	guiSetProperty(Hablar8, "NormalTextColour", "FFFFFFFF")
	Hablar9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Hablar 9", true, Phablar)
	guiSetProperty(Hablar9, "NormalTextColour", "FFFFFFFF")
	Hablar10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Hablar 10", true, Phablar)
	guiSetProperty(Hablar10, "NormalTextColour", "FFFFFFFF")
	Hablar11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Hablar 11", true, Phablar)
	guiSetProperty(Hablar11, "NormalTextColour", "FFFFFFFF")
	Hablar12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Hablar 12", true, Phablar)
	guiSetProperty(Hablar12, "NormalTextColour", "FFFFFFFF")
	Hablar13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Hablar 13", true, Phablar)
	guiSetProperty(Hablar13, "NormalTextColour", "FFFFFFFF")
	Hablar14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Hablar 14", true, Phablar)
	guiSetProperty(Hablar14, "NormalTextColour", "FFFFFFFF")
	Hablar15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Hablar 15", true, Phablar)
	guiSetProperty(Hablar15, "NormalTextColour", "FFFFFFFF")
	--Hablar16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Hablar 16", true, Phablar)
	--guiSetProperty(Hablar16, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",Hablar1,Hb1, false)
	addEventHandler("onClientGUIClick",Hablar2,Hb2, false)
	addEventHandler("onClientGUIClick",Hablar3,Hb3, false)
	addEventHandler("onClientGUIClick",Hablar4,Hb4, false)
	addEventHandler("onClientGUIClick",Hablar5,Hb5, false)
	addEventHandler("onClientGUIClick",Hablar6,Hb6, false)
	addEventHandler("onClientGUIClick",Hablar7,Hb7, false)
	addEventHandler("onClientGUIClick",Hablar8,Hb8, false)
	addEventHandler("onClientGUIClick",Hablar9,Hb9, false)
	addEventHandler("onClientGUIClick",Hablar10,Hb10, false)
	addEventHandler("onClientGUIClick",Hablar11,Hb11, false)
	addEventHandler("onClientGUIClick",Hablar12,Hb12, false)
	addEventHandler("onClientGUIClick",Hablar13,Hb13, false)
	addEventHandler("onClientGUIClick",Hablar14,Hb14, false)
	addEventHandler("onClientGUIClick",Hablar15,Hb15, false)
	--addEventHandler("onClientGUIClick",Hablar16,Hb16, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PdilerFun()
	Pdiler = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Diler & Fumar.", true)
	guiWindowSetSizable(Pdiler, false)
	guiSetProperty(Pdiler, "CaptionColour", "FF34C5D7")	

	Diler1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Diler 1", true, Pdiler)
	guiSetProperty(Diler1, "NormalTextColour", "FFFFFFFF")
	Diler2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Diler 2", true, Pdiler)
	guiSetProperty(Diler2, "NormalTextColour", "FFFFFFFF")
	Diler3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Diler 3", true, Pdiler)
	guiSetProperty(Diler3, "NormalTextColour", "FFFFFFFF")
	Diler4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Diler 4", true, Pdiler)
	guiSetProperty(Diler4, "NormalTextColour", "FFFFFFFF")
	Diler5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Diler 5", true, Pdiler)
	guiSetProperty(Diler5, "NormalTextColour", "FFFFFFFF")
	Diler6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Diler 6", true, Pdiler)
	guiSetProperty(Diler6, "NormalTextColour", "FFFFFFFF")
	Diler7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Diler 7", true, Pdiler)
	guiSetProperty(Diler7, "NormalTextColour", "FFFFFFFF")
	Diler8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Diler 8", true, Pdiler)
	guiSetProperty(Diler8, "NormalTextColour", "FFFFFFFF")
	Fumar1 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Fumar 1", true, Pdiler)
	guiSetProperty(Fumar1, "NormalTextColour", "FFFFFFFF")
	Fumar2 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Fumar 2", true, Pdiler)
	guiSetProperty(Fumar2, "NormalTextColour", "FFFFFFFF")
	Fumar3 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Fumar 3", true, Pdiler)
	guiSetProperty(Fumar3, "NormalTextColour", "FFFFFFFF")
	Fumar4 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Fumar 4", true, Pdiler)
	guiSetProperty(Fumar4, "NormalTextColour", "FFFFFFFF")
	Fumar5 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Fumar 5", true, Pdiler)
	guiSetProperty(Fumar5, "NormalTextColour", "FFFFFFFF")
	Fumar6 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Fumar 6", true, Pdiler)
	guiSetProperty(Fumar6, "NormalTextColour", "FFFFFFFF")
	Fumar7 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Fumar 7", true, Pdiler)
	guiSetProperty(Fumar7, "NormalTextColour", "FFFFFFFF")
	Fumar8 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Fumar 8", true, Pdiler)
	guiSetProperty(Fumar8, "NormalTextColour", "FFFFFFFF")
	addEventHandler("onClientGUIClick",Diler1,Dl1, false)
	addEventHandler("onClientGUIClick",Diler2,Dl2, false)
	addEventHandler("onClientGUIClick",Diler3,Dl3, false)
	addEventHandler("onClientGUIClick",Diler4,Dl4, false)
	addEventHandler("onClientGUIClick",Diler5,Dl5, false)
	addEventHandler("onClientGUIClick",Diler6,Dl6, false)
	addEventHandler("onClientGUIClick",Diler7,Dl7, false)
	addEventHandler("onClientGUIClick",Diler8,Dl8, false)
	addEventHandler("onClientGUIClick",Fumar1,Fm1, false)
	addEventHandler("onClientGUIClick",Fumar2,Fm2, false)
	addEventHandler("onClientGUIClick",Fumar3,Fm3, false)
	addEventHandler("onClientGUIClick",Fumar4,Fm4, false)
	addEventHandler("onClientGUIClick",Fumar5,Fm5, false)
	addEventHandler("onClientGUIClick",Fumar6,Fm6, false)
	addEventHandler("onClientGUIClick",Fumar7,Fm7, false)
	addEventHandler("onClientGUIClick",Fumar8,Fm8, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PbesosFun()
	Pbesos = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Besos & Sex.", true)
	guiWindowSetSizable(Pbesos, false)
	guiSetProperty(Pbesos, "CaptionColour", "FF34C5D7")	

	Beso1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Beso 1", true, Pbesos)
	guiSetProperty(Beso1, "NormalTextColour", "FFFFFFFF")
	Beso2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Beso 2", true, Pbesos)
	guiSetProperty(Beso2, "NormalTextColour", "FFFFFFFF")
	Beso3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Beso 3", true, Pbesos)
	guiSetProperty(Beso3, "NormalTextColour", "FFFFFFFF")
	Beso4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Beso 4", true, Pbesos)
	guiSetProperty(Beso4, "NormalTextColour", "FFFFFFFF")
	Beso5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Beso 5", true, Pbesos)
	guiSetProperty(Beso5, "NormalTextColour", "FFFFFFFF")
	Beso6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Beso 6", true, Pbesos)
	guiSetProperty(Beso6, "NormalTextColour", "FFFFFFFF")
	Sex1 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Sex 1 (H)", true, Pbesos)
	guiSetProperty(Sex1, "NormalTextColour", "FFFFFFFF")
	Sex2 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Sex 1 (M)", true, Pbesos)
	guiSetProperty(Sex2, "NormalTextColour", "FFFFFFFF")
	Sex3 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Sex 2 (H)", true, Pbesos)
	guiSetProperty(Sex3, "NormalTextColour", "FFFFFFFF")
	Sex4 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Sex 2 (M)", true, Pbesos)
	guiSetProperty(Sex4, "NormalTextColour", "FFFFFFFF")
	Sex5 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Sex 3 (H)", true, Pbesos)
	guiSetProperty(Sex5, "NormalTextColour", "FFFFFFFF")
	Sex6 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Sex 3 (M)", true, Pbesos)
	guiSetProperty(Sex6, "NormalTextColour", "FFFFFFFF")
	Sex7 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Sex 4 (H)", true, Pbesos)
	guiSetProperty(Sex7, "NormalTextColour", "FFFFFFFF")
	Sex8 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Sex 4 (M)", true, Pbesos)
	guiSetProperty(Sex8, "NormalTextColour", "FFFFFFFF")
	--Sex9 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Culear Man", true, Pbesos)
	--guiSetProperty(Sex9, "NormalTextColour", "FFFFFFFF")
	--Sex10 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Culear Vieja", true, Pbesos)
	--guiSetProperty(Sex10, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",Beso1,Ks1, false)
	addEventHandler("onClientGUIClick",Beso2,Ks2, false)
	addEventHandler("onClientGUIClick",Beso3,Ks3, false)
	addEventHandler("onClientGUIClick",Beso4,Ks4, false)
	addEventHandler("onClientGUIClick",Beso5,Ks5, false)
	addEventHandler("onClientGUIClick",Beso6,Ks6, false)
	addEventHandler("onClientGUIClick",Sex1, Sx1, false)
	addEventHandler("onClientGUIClick",Sex2, Sx2, false)
	addEventHandler("onClientGUIClick",Sex3, Sx3, false)
	addEventHandler("onClientGUIClick",Sex4, Sx4, false)
	addEventHandler("onClientGUIClick",Sex5, Sx5, false)
	addEventHandler("onClientGUIClick",Sex6, Sx6, false)
	addEventHandler("onClientGUIClick",Sex7, Sx7, false)
	addEventHandler("onClientGUIClick",Sex8, Sx8, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PsentarseFun()
	Psentarse = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Sentarse.", true)
	guiWindowSetSizable(Psentarse, false)
	guiSetProperty(Psentarse, "CaptionColour", "FF34C5D7")	

	Sentarse1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Sentarse 1", true, Psentarse)
	guiSetProperty(Sentarse1, "NormalTextColour", "FFFFFFFF")
	Sentarse2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Sentarse 2", true, Psentarse)
	guiSetProperty(Sentarse2, "NormalTextColour", "FFFFFFFF")
	Sentarse3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Sentarse 3", true, Psentarse)
	guiSetProperty(Sentarse3, "NormalTextColour", "FFFFFFFF")
	Sentarse4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Sentarse 4", true, Psentarse)
	guiSetProperty(Sentarse4, "NormalTextColour", "FFFFFFFF")
	Sentarse5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Sentarse 5", true, Psentarse)
	guiSetProperty(Sentarse5, "NormalTextColour", "FFFFFFFF")
	Sentarse6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Sentarse 6", true, Psentarse)
	guiSetProperty(Sentarse6, "NormalTextColour", "FFFFFFFF")
	Sentarse7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Sentarse 7", true, Psentarse)
	guiSetProperty(Sentarse7, "NormalTextColour", "FFFFFFFF")
	Sentarse8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Sentarse 8", true, Psentarse)
	guiSetProperty(Sentarse8, "NormalTextColour", "FFFFFFFF")
	Sentarse9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Sentarse 9", true, Psentarse)
	guiSetProperty(Sentarse9, "NormalTextColour", "FFFFFFFF")
	Sentarse10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Sentarse 10", true, Psentarse)
	guiSetProperty(Sentarse10, "NormalTextColour", "FFFFFFFF")
	Sentarse11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Sentarse 11", true, Psentarse)
	guiSetProperty(Sentarse11, "NormalTextColour", "FFFFFFFF")
	Sentarse12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Sentarse 12", true, Psentarse)
	guiSetProperty(Sentarse12, "NormalTextColour", "FFFFFFFF")
	Sentarse13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Sentarse 13", true, Psentarse)
	guiSetProperty(Sentarse13, "NormalTextColour", "FFFFFFFF")
	Sentarse14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Sentarse 14", true, Psentarse)
	guiSetProperty(Sentarse14, "NormalTextColour", "FFFFFFFF")
	Sentarse15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Sentarse 15", true, Psentarse)
	guiSetProperty(Sentarse15, "NormalTextColour", "FFFFFFFF")
	Sentarse16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "Sentarse 16", true, Psentarse)
	guiSetProperty(Sentarse16, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",Sentarse1,Sts1, false)
	addEventHandler("onClientGUIClick",Sentarse2,Sts2, false)
	addEventHandler("onClientGUIClick",Sentarse3,Sts3, false)
	addEventHandler("onClientGUIClick",Sentarse4,Sts4, false)
	addEventHandler("onClientGUIClick",Sentarse5,Sts5, false)
	addEventHandler("onClientGUIClick",Sentarse6,Sts6, false)
	addEventHandler("onClientGUIClick",Sentarse7,Sts7, false)
	addEventHandler("onClientGUIClick",Sentarse8,Sts8, false)
	addEventHandler("onClientGUIClick",Sentarse9,Sts9, false)
	addEventHandler("onClientGUIClick",Sentarse10,Sts10, false)
	addEventHandler("onClientGUIClick",Sentarse11,Sts11, false)
	addEventHandler("onClientGUIClick",Sentarse12,Sts12, false)
	addEventHandler("onClientGUIClick",Sentarse13,Sts13, false)
	addEventHandler("onClientGUIClick",Sentarse14,Sts14, false)
	addEventHandler("onClientGUIClick",Sentarse15,Sts15, false)
	addEventHandler("onClientGUIClick",Sentarse16,Sts16, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PdjFun()
	Pdj = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "DJ.", true)
	guiWindowSetSizable(Pdj, false)
	guiSetProperty(Pdj, "CaptionColour", "FF34C5D7")	

	DJ1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "DJ 1", true, Pdj)
	guiSetProperty(DJ1, "NormalTextColour", "FFFFFFFF")
	DJ2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "DJ 2", true, Pdj)
	guiSetProperty(DJ2, "NormalTextColour", "FFFFFFFF")
	DJ3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "DJ 3", true, Pdj)
	guiSetProperty(DJ3, "NormalTextColour", "FFFFFFFF")
	DJ4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "DJ 4", true, Pdj)
	guiSetProperty(DJ4, "NormalTextColour", "FFFFFFFF")
	DJ5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "DJ 5", true, Pdj)
	guiSetProperty(DJ5, "NormalTextColour", "FFFFFFFF")
	DJ6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "DJ 6", true, Pdj)
	guiSetProperty(DJ6, "NormalTextColour", "FFFFFFFF")
	DJ7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "DJ 7", true, Pdj)
	guiSetProperty(DJ7, "NormalTextColour", "FFFFFFFF")
	DJ8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "DJ 8", true, Pdj)
	guiSetProperty(DJ8, "NormalTextColour", "FFFFFFFF")
	DJ9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "DJ 9", true, Pdj)
	guiSetProperty(DJ9, "NormalTextColour", "FFFFFFFF")
	DJ10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "DJ 10", true, Pdj)
	guiSetProperty(DJ10, "NormalTextColour", "FFFFFFFF")
	DJ11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "DJ 11", true, Pdj)
	guiSetProperty(DJ11, "NormalTextColour", "FFFFFFFF")
	DJ12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "DJ 12", true, Pdj)
	guiSetProperty(DJ12, "NormalTextColour", "FFFFFFFF")
	--DJ13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "DJ 13", true, Pdj)
	--guiSetProperty(DJ13, "NormalTextColour", "FFFFFFFF")
	--DJ14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "DJ 14", true, Pdj)
	--guiSetProperty(DJ14, "NormalTextColour", "FFFFFFFF")
	--DJ15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "DJ 15", true, Pdj)
	--guiSetProperty(DJ15, "NormalTextColour", "FFFFFFFF")
	--DJ16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "DJ 16", true, Pdj)
	--guiSetProperty(DJ16, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",DJ1,Dj1, false)
	addEventHandler("onClientGUIClick",DJ2,Dj2, false)
	addEventHandler("onClientGUIClick",DJ3,Dj3, false)
	addEventHandler("onClientGUIClick",DJ4,Dj4, false)
	addEventHandler("onClientGUIClick",DJ5,Dj5, false)
	addEventHandler("onClientGUIClick",DJ6,Dj6, false)
	addEventHandler("onClientGUIClick",DJ7,Dj7, false)
	addEventHandler("onClientGUIClick",DJ8,Dj8, false)
	addEventHandler("onClientGUIClick",DJ9,Dj9, false)
	addEventHandler("onClientGUIClick",DJ10,Dj10, false)
	addEventHandler("onClientGUIClick",DJ11,Dj11, false)
	addEventHandler("onClientGUIClick",DJ12,Dj12, false)
	--addEventHandler("onClientGUIClick",DJ13,Dj13, false)
	--addEventHandler("onClientGUIClick",DJ14,Dj14, false)
	--addEventHandler("onClientGUIClick",DJ15,Dj15, false)
	--addEventHandler("onClientGUIClick",DJ16,Dj16, false)

end 
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PvariosFun()
	Pvarios = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Rol & otros.", true)
	guiWindowSetSizable(Pvarios, false)
	guiSetProperty(Pvarios, "CaptionColour", "FF34C5D7")	

	Varios1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "RCP", true, Pvarios)
	guiSetProperty(Varios1, "NormalTextColour", "FFFFFFFF")
	Varios2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Fix carro", true, Pvarios)
	guiSetProperty(Varios2, "NormalTextColour", "FFFFFFFF")
	Varios3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Saludar", true, Pvarios)
	guiSetProperty(Varios3, "NormalTextColour", "FFFFFFFF")
	Varios4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Vomitar", true, Pvarios)
	guiSetProperty(Varios4, "NormalTextColour", "FFFFFFFF")
	Varios5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Caido 1", true, Pvarios)
	guiSetProperty(Varios5, "NormalTextColour", "FFFFFFFF")
	Varios6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Caido 2", true, Pvarios)
	guiSetProperty(Varios6, "NormalTextColour", "FFFFFFFF")
	Varios7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Subir manos", true, Pvarios)
	guiSetProperty(Varios7, "NormalTextColour", "FFFFFFFF")
	Varios8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Miedo", true, Pvarios)
	guiSetProperty(Varios8, "NormalTextColour", "FFFFFFFF")
	Varios9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Sacar Cel", true, Pvarios)
	guiSetProperty(Varios9, "NormalTextColour", "FFFFFFFF")
	Varios10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Pare", true, Pvarios)
	guiSetProperty(Varios10, "NormalTextColour", "FFFFFFFF")
	Varios11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Degollado", true, Pvarios)
	guiSetProperty(Varios11, "NormalTextColour", "FFFFFFFF")
	Varios12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Degollar", true, Pvarios)
	guiSetProperty(Varios12, "NormalTextColour", "FFFFFFFF")
	Varios13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Protesta 1", true, Pvarios)
	guiSetProperty(Varios13, "NormalTextColour", "FFFFFFFF")
	Varios14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Protesta 2", true, Pvarios)
	guiSetProperty(Varios14, "NormalTextColour", "FFFFFFFF")
	Varios15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Si", true, Pvarios)
	guiSetProperty(Varios15, "NormalTextColour", "FFFFFFFF")
	Varios16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "No", true, Pvarios)
	guiSetProperty(Varios16, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",Varios1,Vr1, false)
	addEventHandler("onClientGUIClick",Varios2,Vr2, false)
	addEventHandler("onClientGUIClick",Varios3,Vr3, false)
	addEventHandler("onClientGUIClick",Varios4,Vr4, false)
	addEventHandler("onClientGUIClick",Varios5,Vr5, false)
	addEventHandler("onClientGUIClick",Varios6,Vr6, false)
	addEventHandler("onClientGUIClick",Varios7,Vr7, false)
	addEventHandler("onClientGUIClick",Varios8,Vr8, false)
	addEventHandler("onClientGUIClick",Varios9,Vr9, false)
	addEventHandler("onClientGUIClick",Varios10,Vr10, false)
	addEventHandler("onClientGUIClick",Varios11,Vr11, false)
	addEventHandler("onClientGUIClick",Varios12,Vr12, false)
	addEventHandler("onClientGUIClick",Varios13,Vr13, false)
	addEventHandler("onClientGUIClick",Varios14,Vr14, false)
	addEventHandler("onClientGUIClick",Varios15,Vr15, false)
	addEventHandler("onClientGUIClick",Varios16,Vr16, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PposeFun()
	Ppose = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Fornite.", true)
	guiWindowSetSizable(Ppose, false)
	guiSetProperty(Ppose, "CaptionColour", "FF34C5D7")	

	Fornais1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Fornais 1", true, Ppose)
	guiSetProperty(Fornais1, "NormalTextColour", "FFFFFFFF")
	Fornais2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Fornais 2", true, Ppose)
	guiSetProperty(Fornais2, "NormalTextColour", "FFFFFFFF")
	Fornais3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Fornais 3", true, Ppose)
	guiSetProperty(Fornais3, "NormalTextColour", "FFFFFFFF")
	Fornais4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Fornais 4", true, Ppose)
	guiSetProperty(Fornais4, "NormalTextColour", "FFFFFFFF")
	Fornais5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Fornais 5", true, Ppose)
	guiSetProperty(Fornais5, "NormalTextColour", "FFFFFFFF")
	Fornais6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Fornais 6", true, Ppose)
	guiSetProperty(Fornais6, "NormalTextColour", "FFFFFFFF")
	Fornais7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Fornais 7", true, Ppose)
	guiSetProperty(Fornais7, "NormalTextColour", "FFFFFFFF")
	Fornais8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Fornais 8", true, Ppose)
	guiSetProperty(Fornais8, "NormalTextColour", "FFFFFFFF")
	Fornais9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Fornais 9", true, Ppose)
	guiSetProperty(Fornais9, "NormalTextColour", "FFFFFFFF")
	Fornais10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Fornais 10", true, Ppose)
	guiSetProperty(Fornais10, "NormalTextColour", "FFFFFFFF")
	Fornais11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Fornais 11", true, Ppose)
	guiSetProperty(Fornais11, "NormalTextColour", "FFFFFFFF")
	Fornais12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Fornais 12", true, Ppose)
	guiSetProperty(Fornais12, "NormalTextColour", "FFFFFFFF")
	Fornais13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Fornais 13", true, Ppose)
	guiSetProperty(Fornais13, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",Fornais1,Fr1, false)
	addEventHandler("onClientGUIClick",Fornais2,Fr2, false)
	addEventHandler("onClientGUIClick",Fornais3,Fr3, false)
	addEventHandler("onClientGUIClick",Fornais4,Fr4, false)
	addEventHandler("onClientGUIClick",Fornais5,Fr5, false)
	addEventHandler("onClientGUIClick",Fornais6,Fr6, false)
	addEventHandler("onClientGUIClick",Fornais7,Fr7, false)
	addEventHandler("onClientGUIClick",Fornais8,Fr8, false)
	addEventHandler("onClientGUIClick",Fornais9,Fr9, false)
	addEventHandler("onClientGUIClick",Fornais10,Fr10, false)
	addEventHandler("onClientGUIClick",Fornais11,Fr11, false)
	addEventHandler("onClientGUIClick",Fornais12,Fr12, false)
	addEventHandler("onClientGUIClick",Fornais13,Fr13, false)
end
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function PotrosmasFun()
	Potrosmas = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Otros más.", true)
	guiWindowSetSizable(Potrosmas, false)
	guiSetProperty(Potrosmas, "CaptionColour", "FF34C5D7")	

	Otrosm1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "Mear", true, Potrosmas)
	guiSetProperty(Otrosm1, "NormalTextColour", "FFFFFFFF")
	Otrosm2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "Paja", true, Potrosmas)
	guiSetProperty(Otrosm2, "NormalTextColour", "FFFFFFFF")
	Otrosm3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "Borracho 1", true, Potrosmas)
	guiSetProperty(Otrosm3, "NormalTextColour", "FFFFFFFF")
	Otrosm4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "Borracho 2", true, Potrosmas)
	guiSetProperty(Otrosm4, "NormalTextColour", "FFFFFFFF")
	Otrosm5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "Pensativo", true, Potrosmas)
	guiSetProperty(Otrosm5, "NormalTextColour", "FFFFFFFF")
	Otrosm6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "Esperando", true, Potrosmas)
	guiSetProperty(Otrosm6, "NormalTextColour", "FFFFFFFF")
	Otrosm7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "Fuck U", true, Potrosmas)
	guiSetProperty(Otrosm7, "NormalTextColour", "FFFFFFFF")
	Otrosm8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "Cansado", true, Potrosmas)
	guiSetProperty(Otrosm8, "NormalTextColour", "FFFFFFFF")
	Otrosm9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "Recostado", true, Potrosmas)
	guiSetProperty(Otrosm9, "NormalTextColour", "FFFFFFFF")
	Otrosm10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "Beber", true, Potrosmas)
	guiSetProperty(Otrosm10, "NormalTextColour", "FFFFFFFF")
	Otrosm11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "Pose 1", true, Potrosmas)
	guiSetProperty(Otrosm11, "NormalTextColour", "FFFFFFFF")
	Otrosm12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "Pose 2", true, Potrosmas)
	guiSetProperty(Otrosm12, "NormalTextColour", "FFFFFFFF")
	Otrosm13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "Pose 3", true, Potrosmas)
	guiSetProperty(Otrosm13, "NormalTextColour", "FFFFFFFF")
	Otrosm14 = guiCreateButton(0.54, 0.76, 0.41, 0.08, "Pose 4", true, Potrosmas)
	guiSetProperty(Otrosm14, "NormalTextColour", "FFFFFFFF")
	Otrosm15 = guiCreateButton(0.05, 0.87, 0.41, 0.08, "Dormir 1", true, Potrosmas)
	guiSetProperty(Otrosm15, "NormalTextColour", "FFFFFFFF")
	Otrosm16 = guiCreateButton(0.54, 0.87, 0.41, 0.08, "dormir 2", true, Potrosmas)
	guiSetProperty(Otrosm16, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",Otrosm1,Otm1, false)
	addEventHandler("onClientGUIClick",Otrosm2,Otm2, false)
	addEventHandler("onClientGUIClick",Otrosm3,Otm3, false)
	addEventHandler("onClientGUIClick",Otrosm4,Otm4, false)
	addEventHandler("onClientGUIClick",Otrosm5,Otm5, false)
	addEventHandler("onClientGUIClick",Otrosm6,Otm6, false)
	addEventHandler("onClientGUIClick",Otrosm7,Otm7, false)
	addEventHandler("onClientGUIClick",Otrosm8,Otm8, false)
	addEventHandler("onClientGUIClick",Otrosm9,Otm9, false)
	addEventHandler("onClientGUIClick",Otrosm10,Otm10, false)
	addEventHandler("onClientGUIClick",Otrosm11,Otm11, false)
	addEventHandler("onClientGUIClick",Otrosm12,Otm12, false)
	addEventHandler("onClientGUIClick",Otrosm13,Otm13, false)
	addEventHandler("onClientGUIClick",Otrosm14,Otm14, false)
	addEventHandler("onClientGUIClick",Otrosm15,Otm15, false)
	addEventHandler("onClientGUIClick",Otrosm16,Otm16, false)
end

	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
function Potros2Fun()
	Potros2 = guiCreateWindow(0.66, 0.59, 0.14, 0.39, "Otros bailes.", true)
	guiWindowSetSizable(Potros2, false)
	guiSetProperty(Potros2, "CaptionColour", "FF34C5D7")	

	BailesR1 = guiCreateButton(0.05, 0.08, 0.41, 0.08, "BailesR 1", true, Potros2)
	guiSetProperty(BailesR1, "NormalTextColour", "FFFFFFFF")
	BailesR2 = guiCreateButton(0.54, 0.08, 0.41, 0.08, "BailesR 2", true, Potros2)
	guiSetProperty(BailesR2, "NormalTextColour", "FFFFFFFF")
	BailesR3 = guiCreateButton(0.05, 0.20, 0.41, 0.08, "BailesR 3", true, Potros2)
	guiSetProperty(BailesR3, "NormalTextColour", "FFFFFFFF")
	BailesR4 = guiCreateButton(0.54, 0.20, 0.41, 0.08, "BailesR 4", true, Potros2)
	guiSetProperty(BailesR4, "NormalTextColour", "FFFFFFFF")
	BailesR5 = guiCreateButton(0.05, 0.31, 0.41, 0.08, "BailesR 5", true, Potros2)
	guiSetProperty(BailesR5, "NormalTextColour", "FFFFFFFF")
	BailesR6 = guiCreateButton(0.54, 0.31, 0.41, 0.08, "BailesR 6", true, Potros2)
	guiSetProperty(BailesR6, "NormalTextColour", "FFFFFFFF")
	BailesR7 = guiCreateButton(0.05, 0.42, 0.41, 0.08, "BailesR 7", true, Potros2)
	guiSetProperty(BailesR7, "NormalTextColour", "FFFFFFFF")
	BailesR8 = guiCreateButton(0.54, 0.42, 0.41, 0.08, "BailesR 8", true, Potros2)
	guiSetProperty(BailesR8, "NormalTextColour", "FFFFFFFF")
	BailesR9 = guiCreateButton(0.05, 0.53, 0.41, 0.08, "BailesR 9", true, Potros2)
	guiSetProperty(BailesR9, "NormalTextColour", "FFFFFFFF")
	BailesR10 = guiCreateButton(0.54, 0.53, 0.41, 0.08, "BailesR 10", true, Potros2)
	guiSetProperty(BailesR10, "NormalTextColour", "FFFFFFFF")
	BailesR11 = guiCreateButton(0.05, 0.65, 0.41, 0.08, "BailesR 11", true, Potros2)
	guiSetProperty(BailesR11, "NormalTextColour", "FFFFFFFF")
	BailesR12 = guiCreateButton(0.54, 0.65, 0.41, 0.08, "BailesR 12", true, Potros2)
	guiSetProperty(BailesR12, "NormalTextColour", "FFFFFFFF")
	--BailesR13 = guiCreateButton(0.05, 0.76, 0.41, 0.08, "BailesR 13", true, Potros2)
	--guiSetProperty(BailesR13, "NormalTextColour", "FFFFFFFF")


	addEventHandler("onClientGUIClick",BailesR1,BaiR1, false)
	addEventHandler("onClientGUIClick",BailesR2,BaiR2, false)
	addEventHandler("onClientGUIClick",BailesR3,BaiR3, false)
	addEventHandler("onClientGUIClick",BailesR4,BaiR4, false)
	addEventHandler("onClientGUIClick",BailesR5,BaiR5, false)
	addEventHandler("onClientGUIClick",BailesR6,BaiR6, false)
	addEventHandler("onClientGUIClick",BailesR7,BaiR7, false)
	addEventHandler("onClientGUIClick",BailesR8,BaiR8, false)
	addEventHandler("onClientGUIClick",BailesR9,BaiR9, false)
	addEventHandler("onClientGUIClick",BailesR10,BaiR10, false)
	addEventHandler("onClientGUIClick",BailesR11,BaiR11, false)
	addEventHandler("onClientGUIClick",BailesR12,BaiR12, false)
	--addEventHandler("onClientGUIClick",BailesR13,BaiR13, false)
end

----------------------------------------------------------------------------------------------
---                               FUNCIONES PARA CADA PANEL                                ---
----------------------------------------------------------------------------------------------
function mpbailes(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PbailesFun()

		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpbarybat(player)
	local player = getLocalPlayer()
	if (guiGetVisible(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PbarFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpcrack(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PcrackFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpgym(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PgymFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpsenales(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PsenalesFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mphablar(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PhablarFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mPdiler(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PdilerFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpbesos(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PbesosFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpdj(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PdjFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpsentarse(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PsentarseFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpvarios(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PvariosFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mppose(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PposeFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpotrosmas(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and (not getPedOccupiedVehicle(player)) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		PotrosmasFun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
function mpotros2(player)
	local player = getLocalPlayer()
	if (isElement(Panelanim)) and not getPedOccupiedVehicle(player) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		Potros2Fun()
		-- Se muestra el cursor
		--showCursor(true)
	-- en caso de que el panel se esta mostrando se oculta
	else
		destroyElement(Panelanim)
		-- Se deja de mostrar el cursor
		--showCursor(false)
	end      
end
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Cierra el panel
function cerrarpanel()
	if isElement(Panelanim) then
		if isElement(Pbailes) then
			destroyElement(Pbailes)
		elseif isElement(Pbar) then
			destroyElement(Pbar)
		elseif isElement(Pcrack) then
			destroyElement(Pcrack)
		elseif isElement(Pgym) then
			destroyElement(Pgym)
		elseif isElement(Psenales) then
			destroyElement(Psenales)
		elseif isElement(Phablar) then
			destroyElement(Phablar)
		elseif isElement(Pdiler) then
			destroyElement(Pdiler)
		elseif isElement(Pbesos) then
			destroyElement(Pbesos)
		elseif isElement(Pdj) then
			destroyElement(Pdj)
		elseif isElement(Psentarse) then
			destroyElement(Psentarse)
		elseif isElement(Pvarios) then
			destroyElement(Pvarios)
		elseif isElement(Ppose) then
			destroyElement(Ppose)
		elseif isElement(Potrosmas) then
			destroyElement(Potrosmas)
		elseif isElement(Potros2) then
			destroyElement(Potros2)
		end
		destroyElement(Panelanim)
		showCursor(false)
	else
		panelMain()
	  	showCursor(true)
	end        
end
-- Sacar el panel
function panelanim()
	local player = getLocalPlayer()
	if getElementData(player,"tased") == false then
		if (getElementDimension( getLocalPlayer() ) ~= 100)  then
			if not(exports['NGPolice']:isPlayerJailed(player)) then
				if not getPedOccupiedVehicle ( player ) then
						-- Verificamos si la ventana se muestra en tal caso de que no se muestre se abre
					if not (isElement(Panelanim)) then
						panelMain()
						-- Se muestra el cursor
						showCursor(true) 
						-- en caso de que el panel se esta mostrando se oculta
					else
						if isElement(Pbailes) then
							destroyElement(Pbailes)
						elseif isElement(Pbar) then
							destroyElement(Pbar)
						elseif isElement(Pcrack) then
							destroyElement(Pcrack)
						elseif isElement(Pgym) then
							destroyElement(Pgym)
						elseif isElement(Psenales) then
							destroyElement(Psenales)
						elseif isElement(Phablar) then
							destroyElement(Phablar)
						elseif isElement(Pdiler) then
							destroyElement(Pdiler)
						elseif isElement(Pbesos) then
							destroyElement(Pbesos)
						elseif isElement(Pdj) then
							destroyElement(Pdj)
						elseif isElement(Psentarse) then
							destroyElement(Psentarse)
						elseif isElement(Pvarios) then
							destroyElement(Pvarios)
						elseif isElement(Ppose) then
							destroyElement(Ppose)
						elseif isElement(Potrosmas) then
							destroyElement(Potrosmas)
						elseif isElement(Potros2) then
							destroyElement(Potros2)
						end
						destroyElement(Panelanim)
							--Se deja de mostrar el cursor
						showCursor(false)
					end
				else
					outputChatBox ("#ff4000No puedes usar animaciones dentro de vehículos",255,0,0,true)
				end
			end
		end
	else
		outputChatBox ("¿ "..getPlayerName(player).." para qué quiere usar animaciones estando taseado ._.?",255,0,0,true)
	end
end
bindKey("k", "down", panelanim)
----------------------------------------------------------------------------------------------
function pararanim ()
	triggerServerEvent ("pararanim", getLocalPlayer())
end
---Bailes 
function B1 ()
	triggerServerEvent ("B1", getLocalPlayer())
end
function B2 ()
	triggerServerEvent ("B2", getLocalPlayer())
end
function B3 ()
	triggerServerEvent ("B3", getLocalPlayer())
end
function B4 ()
	triggerServerEvent ("B4", getLocalPlayer())
end
function B5 ()
	triggerServerEvent ("B5", getLocalPlayer())
end
function B6 ()
	triggerServerEvent ("B6", getLocalPlayer())
end
function B7 ()
	triggerServerEvent ("B7", getLocalPlayer())
end
function B8 ()
	triggerServerEvent ("B8", getLocalPlayer())
end
function B9 ()
	triggerServerEvent ("B9", getLocalPlayer())
end
function B10 ()
	triggerServerEvent ("B10", getLocalPlayer())
end
function B11 ()
	triggerServerEvent ("B11", getLocalPlayer())
end
function B12 ()
	triggerServerEvent ("B12", getLocalPlayer())
end
function B13 ()
	triggerServerEvent ("B13", getLocalPlayer())
end
function B14 ()
	triggerServerEvent ("B14", getLocalPlayer())
end
function B15 ()
	triggerServerEvent ("B15", getLocalPlayer())
end
---Bar&Bat
function Ba1 ()
	triggerServerEvent ("Ba1", getLocalPlayer())
end
function Ba2 ()
	triggerServerEvent ("Ba2", getLocalPlayer())
end
function Ba3 ()
	triggerServerEvent ("Ba3", getLocalPlayer())
end
function Ba4 ()
	triggerServerEvent ("Ba4", getLocalPlayer())
end
function Ba5 ()
	triggerServerEvent ("Ba5", getLocalPlayer())
end
function Ba6 ()
	triggerServerEvent ("Ba6", getLocalPlayer())
end
function Ba7 ()
	triggerServerEvent ("Ba7", getLocalPlayer())
end
function Ba8 ()
	triggerServerEvent ("Ba8", getLocalPlayer())
end
function Bt1 ()
	triggerServerEvent ("Bt1", getLocalPlayer())
end
function Bt2 ()
	triggerServerEvent ("Bt2", getLocalPlayer())
end
function Bt3 ()
	triggerServerEvent ("Bt3", getLocalPlayer())
end
function Bt4 ()
	triggerServerEvent ("Bt4", getLocalPlayer())
end
function Bt5 ()
	triggerServerEvent ("Bt5", getLocalPlayer())
end
function Bt6 ()
	triggerServerEvent ("Bt6", getLocalPlayer())
end
function Bt7 ()
	triggerServerEvent ("Bt7", getLocalPlayer())
end
---Crack
function Ck1 ()
	triggerServerEvent ("Ck1", getLocalPlayer())
end
function Ck2 ()
	triggerServerEvent ("Ck2", getLocalPlayer())
end
function Ck3 ()
	triggerServerEvent ("Ck3", getLocalPlayer())
end
function Ck4 ()
	triggerServerEvent ("Ck4", getLocalPlayer())
end
function Ck5 ()
	triggerServerEvent ("Ck5", getLocalPlayer())
end
function Ck6 ()
	triggerServerEvent ("Ck6", getLocalPlayer())
end
function Ck7 ()
	triggerServerEvent ("Ck7", getLocalPlayer())
end
function Ck8 ()
	triggerServerEvent ("Ck8", getLocalPlayer())
end
function Ck9 ()
	triggerServerEvent ("Ck9", getLocalPlayer())
end
function Ck10 ()
	triggerServerEvent ("Ck10", getLocalPlayer())
end
function Ck11 ()
	triggerServerEvent ("Ck11", getLocalPlayer())
end
function Ck12 ()
	triggerServerEvent ("Ck12", getLocalPlayer())
end
function Ck13 ()
	triggerServerEvent ("Ck13", getLocalPlayer())
end
function Ck14 ()
	triggerServerEvent ("Ck14", getLocalPlayer())
end
function Ck15 ()
	triggerServerEvent ("Ck15", getLocalPlayer())
end
function Ck16 ()
	triggerServerEvent ("Ck16", getLocalPlayer())
end
---Gym
function Gm1 ()
	triggerServerEvent ("Gm1", getLocalPlayer())
end
function Gm2 ()
	triggerServerEvent ("Gm2", getLocalPlayer())
end
function Gm3 ()
	triggerServerEvent ("Gm3", getLocalPlayer())
end
function Gm4 ()
	triggerServerEvent ("Gm4", getLocalPlayer())
end
function Gm5 ()
	triggerServerEvent ("Gm5", getLocalPlayer())
end
function Gm6 ()
	triggerServerEvent ("Gm6", getLocalPlayer())
end
function Gm7 ()
	triggerServerEvent ("Gm7", getLocalPlayer())
end
function Gm8 ()
	triggerServerEvent ("Gm8", getLocalPlayer())
end
function Gm9 ()
	triggerServerEvent ("Gm9", getLocalPlayer())
end
function Gm10 ()
	triggerServerEvent ("Gm10", getLocalPlayer())
end
function Gm11 ()
	triggerServerEvent ("Gm11", getLocalPlayer())
end
function Gm12 ()
	triggerServerEvent ("Gm12", getLocalPlayer())
end
function Gm13 ()
	triggerServerEvent ("Gm13", getLocalPlayer())
end
function Gm14 ()
	triggerServerEvent ("Gm14", getLocalPlayer())
end
function Gm15 ()
	triggerServerEvent ("Gm15", getLocalPlayer())
end
function Gm16 ()
	triggerServerEvent ("Gm16", getLocalPlayer())
end
--- Señales
function Sig1 ()
	triggerServerEvent ("Sig1", getLocalPlayer())
end
function Sig2 ()
	triggerServerEvent ("Sig2", getLocalPlayer())
end
function Sig3 ()
	triggerServerEvent ("Sig3", getLocalPlayer())
end
function Sig4 ()
	triggerServerEvent ("Sig4", getLocalPlayer())
end
function Sig5 ()
	triggerServerEvent ("Sig5", getLocalPlayer())
end
function Sig6 ()
	triggerServerEvent ("Sig6", getLocalPlayer())
end
function Sig7 ()
	triggerServerEvent ("Sig7", getLocalPlayer())
end
function Sig8 ()
	triggerServerEvent ("Sig8", getLocalPlayer())
end
function Sig9 ()
	triggerServerEvent ("Sig9", getLocalPlayer())
end
function Sig10 ()
	triggerServerEvent ("Sig10", getLocalPlayer())
end
function Sig11 ()
	triggerServerEvent ("Sig11", getLocalPlayer())
end
function Sig12 ()
	triggerServerEvent ("Sig12", getLocalPlayer())
end
function Sig13 ()
	triggerServerEvent ("Sig13", getLocalPlayer())
end
function Sig14 ()
	triggerServerEvent ("Sig14", getLocalPlayer())
end
function Sig15 ()
	triggerServerEvent ("Sig15", getLocalPlayer())
end
function Sig16 ()
	triggerServerEvent ("Sig16", getLocalPlayer())
end
---Hablar
function Hb1 ()
	triggerServerEvent ("Hb1", getLocalPlayer())
end
function Hb2 ()
	triggerServerEvent ("Hb2", getLocalPlayer())
end
function Hb3 ()
	triggerServerEvent ("Hb3", getLocalPlayer())
end
function Hb4 ()
	triggerServerEvent ("Hb4", getLocalPlayer())
end
function Hb5 ()
	triggerServerEvent ("Hb5", getLocalPlayer())
end
function Hb6 ()
	triggerServerEvent ("Hb6", getLocalPlayer())
end
function Hb7 ()
	triggerServerEvent ("Hb7", getLocalPlayer())
end
function Hb8 ()
	triggerServerEvent ("Hb8", getLocalPlayer())
end
function Hb9 ()
	triggerServerEvent ("Hb9", getLocalPlayer())
end
function Hb10 ()
	triggerServerEvent ("Hb10", getLocalPlayer())
end
function Hb11 ()
	triggerServerEvent ("Hb11", getLocalPlayer())
end
function Hb12 ()
	triggerServerEvent ("Hb12", getLocalPlayer())
end
function Hb13 ()
	triggerServerEvent ("Hb13", getLocalPlayer())
end
function Hb14 ()
	triggerServerEvent ("Hb14", getLocalPlayer())
end
function Hb15 ()
	triggerServerEvent ("Hb15", getLocalPlayer())
end
function Hb16 ()
	triggerServerEvent ("Hb16", getLocalPlayer())
end
-- diler cambiar
function Dl1 ()
	triggerServerEvent ("Dl1", getLocalPlayer())
end
function Dl2 ()
	triggerServerEvent ("Dl2", getLocalPlayer())
end
function Dl3 ()
	triggerServerEvent ("Dl3", getLocalPlayer())
end
function Dl4 ()
	triggerServerEvent ("Dl4", getLocalPlayer())
end
function Dl5 ()
	triggerServerEvent ("Dl5", getLocalPlayer())
end
function Dl6 ()
	triggerServerEvent ("Dl6", getLocalPlayer())
end
function Dl7 ()
	triggerServerEvent ("Dl7", getLocalPlayer())
end
function Dl8 ()
	triggerServerEvent ("Dl8", getLocalPlayer())
end
function Fm1 ()
	triggerServerEvent ("Fm1", getLocalPlayer())
end
function Fm2 ()
	triggerServerEvent ("Fm2", getLocalPlayer())
end
function Fm3 ()
	triggerServerEvent ("Fm3", getLocalPlayer())
end
function Fm4 ()
	triggerServerEvent ("Fm4", getLocalPlayer())
end
function Fm5 ()
	triggerServerEvent ("Fm5", getLocalPlayer())
end
function Fm6 ()
	triggerServerEvent ("Fm6", getLocalPlayer())
end
function Fm7 ()
	triggerServerEvent ("Fm7", getLocalPlayer())
end
function Fm8 ()
	triggerServerEvent ("Fm8", getLocalPlayer())
end
---Besos y strip
function Ks1 ()
	triggerServerEvent ("Ks1", getLocalPlayer())
end
function Ks2 ()
	triggerServerEvent ("Ks2", getLocalPlayer())
end
function Ks3 ()
	triggerServerEvent ("Ks3", getLocalPlayer())
end
function Ks4 ()
	triggerServerEvent ("Ks4", getLocalPlayer())
end
function Ks5 ()
	triggerServerEvent ("Ks5", getLocalPlayer())
end
function Ks6 ()
	triggerServerEvent ("Ks6", getLocalPlayer())
end
function Sx1 ()
	triggerServerEvent ("Sx1", getLocalPlayer())
end
function Sx2 ()
	triggerServerEvent ("Sx2", getLocalPlayer())
end
function Sx3 ()
	triggerServerEvent ("Sx3", getLocalPlayer())
end
function Sx4 ()
	triggerServerEvent ("Sx4", getLocalPlayer())
end
function Sx5 ()
	triggerServerEvent ("Sx5", getLocalPlayer())
end
function Sx6 ()
	triggerServerEvent ("Sx6", getLocalPlayer())
end
function Sx7 ()
	triggerServerEvent ("Sx7", getLocalPlayer())
end
function Sx8 ()
	triggerServerEvent ("Sx8", getLocalPlayer())
end
-- sentarse
function Sts1 ()
	triggerServerEvent ("Sts1", getLocalPlayer())
end
function Sts2 ()
	triggerServerEvent ("Sts2", getLocalPlayer())
end
function Sts3 ()
	triggerServerEvent ("Sts3", getLocalPlayer())
end
function Sts4 ()
	triggerServerEvent ("Sts4", getLocalPlayer())
end
function Sts5 ()
	triggerServerEvent ("Sts5", getLocalPlayer())
end
function Sts6 ()
	triggerServerEvent ("Sts6", getLocalPlayer())
end
function Sts7 ()
	triggerServerEvent ("Sts7", getLocalPlayer())
end
function Sts8 ()
	triggerServerEvent ("Sts8", getLocalPlayer())
end
function Sts9 ()
	triggerServerEvent ("Sts9", getLocalPlayer())
end
function Sts10 ()
	triggerServerEvent ("Sts10", getLocalPlayer())
end
function Sts11 ()
	triggerServerEvent ("Sts11", getLocalPlayer())
end
function Sts12 ()
	triggerServerEvent ("Sts12", getLocalPlayer())
end
function Sts13 ()
	triggerServerEvent ("Sts13", getLocalPlayer())
end
function Sts14 ()
	triggerServerEvent ("Sts14", getLocalPlayer())
end
function Sts15 ()
	triggerServerEvent ("Sts15", getLocalPlayer())
end
function Sts16 ()
	triggerServerEvent ("Sts16", getLocalPlayer())
end
---DJ
function Dj1 ()
	triggerServerEvent ("Dj1", getLocalPlayer())
end
function Dj2 ()
	triggerServerEvent ("Dj2", getLocalPlayer())
end
function Dj3 ()
	triggerServerEvent ("Dj3", getLocalPlayer())
end
function Dj4 ()
	triggerServerEvent ("Dj4", getLocalPlayer())
end
function Dj5 ()
	triggerServerEvent ("Dj5", getLocalPlayer())
end
function Dj6 ()
	triggerServerEvent ("Dj6", getLocalPlayer())
end
function Dj7 ()
	triggerServerEvent ("Dj7", getLocalPlayer())
end
function Dj8 ()
	triggerServerEvent ("Dj8", getLocalPlayer())
end
function Dj9 ()
	triggerServerEvent ("Dj9", getLocalPlayer())
end
function Dj10 ()
	triggerServerEvent ("Dj10", getLocalPlayer())
end
function Dj11 ()
	triggerServerEvent ("Dj11", getLocalPlayer())
end
function Dj12 ()
	triggerServerEvent ("Dj12", getLocalPlayer())
end
function Dj13 ()
	triggerServerEvent ("Dj13", getLocalPlayer())
end
function Dj14 ()
	triggerServerEvent ("Dj14", getLocalPlayer())
end
function Dj15 ()
	triggerServerEvent ("Dj15", getLocalPlayer())
end
function Dj16 ()
	triggerServerEvent ("Dj16", getLocalPlayer())
end
---varios
function Vr1 ()
	triggerServerEvent ("Vr1", getLocalPlayer())
end
function Vr2 ()
	triggerServerEvent ("Vr2", getLocalPlayer())
end
function Vr3 ()
	triggerServerEvent ("Vr3", getLocalPlayer())
end
function Vr4 ()
	triggerServerEvent ("Vr4", getLocalPlayer())
end
function Vr5 ()
	triggerServerEvent ("Vr5", getLocalPlayer())
end
function Vr6 ()
	triggerServerEvent ("Vr6", getLocalPlayer())
end
function Vr7 ()
	triggerServerEvent ("Vr7", getLocalPlayer())
end
function Vr8 ()
	triggerServerEvent ("Vr8", getLocalPlayer())
end
function Vr9 ()
	triggerServerEvent ("Vr9", getLocalPlayer())
end
function Vr10 ()
	triggerServerEvent ("Vr10", getLocalPlayer())
end
function Vr11 ()
	triggerServerEvent ("Vr11", getLocalPlayer())
end
function Vr12 ()
	triggerServerEvent ("Vr12", getLocalPlayer())
end
function Vr13 ()
	triggerServerEvent ("Vr13", getLocalPlayer())
end
function Vr14 ()
	triggerServerEvent ("Vr14", getLocalPlayer())
end
function Vr15 ()
	triggerServerEvent ("Vr15", getLocalPlayer())
end
function Vr16 ()
	triggerServerEvent ("Vr16", getLocalPlayer())
end
---otros
function Otm1 ()
	triggerServerEvent ("Otm1", getLocalPlayer())
end
function Otm2 ()
	triggerServerEvent ("Otm2", getLocalPlayer())
end
function Otm3 ()
	triggerServerEvent ("Otm3", getLocalPlayer())
end
function Otm4 ()
	triggerServerEvent ("Otm4", getLocalPlayer())
end
function Otm5 ()
	triggerServerEvent ("Otm5", getLocalPlayer())
end
function Otm6 ()
	triggerServerEvent ("Otm6", getLocalPlayer())
end
function Otm7 ()
	triggerServerEvent ("Otm7", getLocalPlayer())
end
function Otm8 ()
	triggerServerEvent ("Otm8", getLocalPlayer())
end
function Otm9 ()
	triggerServerEvent ("Otm9", getLocalPlayer())
end
function Otm10 ()
	triggerServerEvent ("Otm10", getLocalPlayer())
end
function Otm11 ()
	triggerServerEvent ("Otm11", getLocalPlayer())
end
function Otm12 ()
	triggerServerEvent ("Otm12", getLocalPlayer())
end
function Otm13 ()
	triggerServerEvent ("Otm13", getLocalPlayer())
end
function Otm14 ()
	triggerServerEvent ("Otm14", getLocalPlayer())
end
function Otm15 ()
	triggerServerEvent ("Otm15", getLocalPlayer())
end
function Otm16 ()
	triggerServerEvent ("Otm16", getLocalPlayer())
end

-- Fornais by balaclava :vvvvvvvvvvv
local customIfp = nil 

function setPedFortniteAnimation (ped,animation,tiempo,repetir,mover,interrumpible)
    if (type(animation) ~= "string" or type(tiempo) ~= "number" or type(repetir) ~= "boolean" or type(mover) ~= "boolean" or type(interrumpible) ~= "boolean") then return false end
        if isElement(ped) then
            if animation == "baile 1" or animation == "baile 2" or animation == "baile 3" or animation == "baile 4" or animation == "baile 5" or animation == "baile 6" or animation == "baile 7" or animation == "baile 8" or animation == "baile 9" or animation == "baile 10" or animation == "baile 11" or animation == "baile 12" or animation == "baile 13" then
				for i = 1,3 do
                    setPedAnimation(ped, "Fortnite_"..i.."", animation, tiempo, true, false, false) 
                if tiempo > 1 then
                    setTimer(setPedAnimation,tiempo,1,ped,false)
                    setTimer(setPedAnimation,tiempo+100,1,ped,false)
                end
            end
        end
    end
end

addEvent("setPedFortniteAnimation",true)
addEventHandler("setPedFortniteAnimation",getRootElement(),setPedFortniteAnimation)

addEventHandler("onClientResourceStart", resourceRoot,
    function ( startedRes )
		customIfp  = engineLoadIFP ("Fortnite pt1.ifp", "Fortnite_1")
		customIfp2 = engineLoadIFP ("Fortnite pt2.ifp", "Fortnite_2")
		customIfp3 = engineLoadIFP ("Fortnite pt3.ifp", "Fortnite_3")
		if customIfp and customIfp2 and customIfp3 then 
			outputDebugString ("Animaciones de Fortnite cargadas")
		else
			outputDebugString ("Las animaciones de Fortnite no fueron cargadas")
		end
    end
)



function Fr1 ()
	triggerServerEvent ("Fr1", localPlayer,localPlayer)
end
function Fr2 ()
	triggerServerEvent ("Fr2", localPlayer,localPlayer)
end
function Fr3 ()
	triggerServerEvent ("Fr3", localPlayer,localPlayer)
end
function Fr4 ()
	triggerServerEvent ("Fr4", localPlayer,localPlayer)
end
function Fr5 ()
	triggerServerEvent ("Fr5", localPlayer,localPlayer)
end
function Fr6 ()
	triggerServerEvent ("Fr6", localPlayer,localPlayer)
end
function Fr7 ()
	triggerServerEvent ("Fr7", localPlayer,localPlayer)
end
function Fr8 ()
	triggerServerEvent ("Fr8", localPlayer,localPlayer)
end
function Fr9 ()
	triggerServerEvent ("Fr9", localPlayer,localPlayer)
end
function Fr10 ()
	triggerServerEvent ("Fr10", localPlayer,localPlayer)
end
function Fr11 ()
	triggerServerEvent ("Fr11", localPlayer,localPlayer)
end
function Fr12 ()
	triggerServerEvent ("Fr12", localPlayer,localPlayer)
end
function Fr13 ()
	triggerServerEvent ("Fr13", localPlayer,localPlayer)
end

-- Realistas by balaclava modificado 
local customIR = nil 

function setPedRealistaAnimation (ped,animation,tiempo,repetir,mover,interrumpible)
    if (type(animation) ~= "string" or type(tiempo) ~= "number" or type(repetir) ~= "boolean" or type(mover) ~= "boolean" or type(interrumpible) ~= "boolean") then return false end
        if isElement(ped) then
            if animation == "makarena" or animation == "salsa" or animation == "twerk" or animation == "bdnce_uprock" or animation == "flair" or animation == "head_spin" or animation == "aplaudir" or animation == "gangnam_style" or animation == "thriller1" or animation == "thriller2" or animation == "thriller3" or animation == "thriller4" then
                setPedAnimation(ped, "Realistas_1", animation, tiempo, true, false, false)
                if tiempo > 1 then
                    setTimer(setPedAnimation,tiempo,1,ped,false)
                    setTimer(setPedAnimation,tiempo+100,1,ped,false)
                end
            end
        end
end


addEvent("setPedRealistaAnimation",true)
addEventHandler("setPedRealistaAnimation",getRootElement(),setPedRealistaAnimation)

addEventHandler("onClientResourceStart", resourceRoot,
    function ( startedRes )
    customIR  = engineLoadIFP ("bailes_w.ifp", "Realistas_1")
		if customIR then 
		
			outputDebugString ("Animaciones realistas cargadas")
		
		else
			outputDebugString ("Las animaciones realistas no fueron cargadas")
		end
    end
)



function BaiR1 ()
	triggerServerEvent ("BaiR1", localPlayer,localPlayer)
end
function BaiR2 ()
	triggerServerEvent ("BaiR2", localPlayer,localPlayer)
end
function BaiR3 ()
	triggerServerEvent ("BaiR3", localPlayer,localPlayer)
end
function BaiR4 ()
	triggerServerEvent ("BaiR4", localPlayer,localPlayer)
end
function BaiR5 ()
	triggerServerEvent ("BaiR5", localPlayer,localPlayer)
end
function BaiR6 ()
	triggerServerEvent ("BaiR6", localPlayer,localPlayer)
end
function BaiR7 ()
	triggerServerEvent ("BaiR7", localPlayer,localPlayer)
end
function BaiR8 ()
	triggerServerEvent ("BaiR8", localPlayer,localPlayer)
end
function BaiR9 ()
	triggerServerEvent ("BaiR9", localPlayer,localPlayer)
end
function BaiR10 ()
	triggerServerEvent ("BaiR10", localPlayer,localPlayer)
end
function BaiR11 ()
	triggerServerEvent ("BaiR11", localPlayer,localPlayer)
end
function BaiR12 ()
	triggerServerEvent ("BaiR12", localPlayer,localPlayer)
end
function BaiR13 ()
	triggerServerEvent ("BaiR13", localPlayer,localPlayer)
end