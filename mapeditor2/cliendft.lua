

    root = getRootElement()
localPlayer = getLocalPlayer()
 
outputChatBox("#ffff00=  | #330079Press #00ff00F4 Map editor =",0,255,0,true)
shopWddindow = guiCreateWindow(-2,-2,830,710,"Map editor: These objects will stay in the server for 1 hour",false)
guiSetVisible (shopWddindow, false)
guiWindowSetSizable(shopWddindow,false)
guiWindowSetMovable(shopWddindow,true)
tabPanel = guiCreateTabPanel(11,23,899,599,false,shopWddindow)
 

-------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------




 wereldd = guiCreateTab("*",tabPanel)
 
 
guiCreateStaticImage( 10,10,90,75, "shop10/33.png", false,wereldd )
stormweather = guiCreateButton(10,80,90,30,"Storm",false,wereldd )
guiSetProperty(stormweather,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 110,10,90,75, "shop10/34.png", false,wereldd )
foggweather = guiCreateButton(110,80,90,30,"foggy",false,wereldd )
guiSetProperty(foggweather,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 210,10,90,75, "shop10/35.png", false,wereldd )
clearweather = guiCreateButton(210,80,90,30,"clear blue sky",false,wereldd )
guiSetProperty(clearweather,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 310,10,90,75, "shop10/36.png", false,wereldd )
hotweather = guiCreateButton(310,80,90,30,"very hot",false,wereldd )
guiSetProperty(hotweather,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 410,10,90,75, "shop10/37.png", false,wereldd )
dullweather = guiCreateButton(410,80,90,30,"very dull and hazy",false,wereldd )
guiSetProperty(dullweather,"NormalTextColour", "FFFFF000")

 
 guiCreateStaticImage( 510,10,90,75, "shop10/38.png", false,wereldd )
rainyweather = guiCreateButton(510,80,90,30,"rainy",false,wereldd )
guiSetProperty(rainyweather,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 610,10,90,75, "shop10/39.png", false,wereldd )
sandweather = guiCreateButton(610,80,90,30,"sandstorm",false,wereldd )
guiSetProperty(sandweather,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 710,10,90,75, "shop10/40.png", false,wereldd )
greenfogweather = guiCreateButton(710,80,90,30,"foggy greenish",false,wereldd )
guiSetProperty(greenfogweather,"NormalTextColour", "FFFFF000")
 
 
 guiCreateStaticImage( 10,110,90,75, "shop10/41.png", false,wereldd )
darkweather = guiCreateButton(10,190,90,30,"dark sky",false,wereldd )
guiSetProperty(darkweather,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 110,110,90,75, "shop10/42.png", false,wereldd )
orangeweather = guiCreateButton(110,190,90,30,"orange like",false,wereldd )
guiSetProperty(orangeweather,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 710,110,90,75, "shop10/43.png", false,wereldd )
brightweather = guiCreateButton(710,190,90,30,"NORMAL HORIZON",false,wereldd )
guiSetProperty(brightweather,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 210,110,90,75, "shop10/44.png", false,wereldd )
purpleweather = guiCreateButton(210,190,90,30,"blue/purple clouds",false,wereldd )
guiSetProperty(purpleweather,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 410,110,90,75, "shop10/45.png", false,wereldd )
toxivweather = guiCreateButton(410,190,90,30,"toxic clouds",false,wereldd )
guiSetProperty(toxivweather,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 510,110,90,75, "shop10/46.png", false,wereldd )
whiteweather = guiCreateButton(510,190,90,30,"black/white sky",false,wereldd )
guiSetProperty(whiteweather,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 610,110,90,75, "shop10/47.png", false,wereldd )
horizonweather = guiCreateButton(610,190,90,30,"far horizon",false,wereldd )
guiSetProperty(horizonweather,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 310,110,90,75, "shop10/48.png", false,wereldd )
stormextra = guiCreateButton(310,190,90,30,"extra storm",false,wereldd )
guiSetProperty(stormextra,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 10,220,90,80, "shop10/49.png", false,wereldd )
morningtime = guiCreateButton(10,300,90,30,"morning",false,wereldd )
guiSetProperty(morningtime,"NormalTextColour", "FF00FF00")


guiCreateStaticImage( 10,330,90,80, "shop10/49.png", false,wereldd )
midtime = guiCreateButton(10,410,90,30,"mid day",false,wereldd )
guiSetProperty(midtime,"NormalTextColour", "FF00FF00")



guiCreateStaticImage( 110,330,90,80, "shop10/69.png", false,wereldd )
normalelucht = guiCreateButton(110,410,90,30,"normal sky",false,wereldd )
guiSetProperty(normalelucht,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,330,90,80, "shop10/62.png", false,wereldd )
rodelucht = guiCreateButton(210,410,90,30,"red sky",false,wereldd )
guiSetProperty(rodelucht,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 310,330,90,80, "shop10/63.png", false,wereldd )
groenelucht = guiCreateButton(310,410,90,30,"green sky",false,wereldd )
guiSetProperty(groenelucht,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,330,90,80, "shop10/64.png", false,wereldd )
gelelucht = guiCreateButton(410,410,90,30,"yellow sky",false,wereldd )
guiSetProperty(gelelucht,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,330,90,80, "shop10/65.png", false,wereldd )
blauwelucht = guiCreateButton(510,410,90,30,"real sky",false,wereldd )
guiSetProperty(blauwelucht,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 610,330,90,80, "shop10/66.png", false,wereldd )
paarselucht = guiCreateButton(610,410,90,30,"pink sky",false,wereldd )
guiSetProperty(paarselucht,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,330,90,80, "shop10/67.png", false,wereldd )
zwartelucht = guiCreateButton(710,410,90,30,"black sky",false,wereldd )
guiSetProperty(zwartelucht,"NormalTextColour", "FF00FF00")



guiCreateStaticImage( 10,440,90,80, "shop10/49.png", false,wereldd )
nighttime = guiCreateButton(10,510,90,30,"midnight",false,wereldd )
guiSetProperty(nighttime,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 110,440,90,80, "shop10/87.png", false,wereldd )
nowaterr = guiCreateButton(110,510,90,30,"No water",false,wereldd )
guiSetProperty(nowaterr,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 610,440,90,80, "shop10/50.png", false,wereldd )
maangrootte = guiCreateButton(610,510,90,30,"big moon",false,wereldd )
guiSetProperty(maangrootte,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,440,90,80, "shop10/61.png", false,wereldd )
waves = guiCreateButton(510,510,90,30,"waves",false,wereldd )
guiSetProperty(waves,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 310,440,90,80, "shop10/59.png", false,wereldd )
smalltsunami = guiCreateButton(310,510,90,30,"small tsunami",false,wereldd )
guiSetProperty(smalltsunami,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,440,90,80, "shop10/60.png", false,wereldd )
bigtsunami = guiCreateButton(410,510,90,30,"TSUNAMI",false,wereldd )
guiSetProperty(bigtsunami,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,440,90,80, "shop10/58.png", false,wereldd )
normalwater = guiCreateButton(210,510,90,30,"normal water",false,wereldd )
guiSetProperty(normalwater,"NormalTextColour", "FF00FF00")


guiCreateStaticImage( 710,440,90,80, "shop10/72.png", false,wereldd )
normalworhggld = guiCreateButton(710,510,90,30,"Normal world",false,wereldd )
guiSetProperty(normalworhggld,"NormalTextColour", "FF00FF00")




guiCreateStaticImage( 110,220,90,80, "shop10/57.png", false,wereldd )
waternnormal = guiCreateButton(110,300,90,30,"normal water",false,wereldd )
guiSetProperty(waternnormal,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,220,90,80, "shop10/51.png", false,wereldd )
waterrood = guiCreateButton(210,300,90,30,"red water",false,wereldd )
guiSetProperty(waterrood,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 310,220,90,80, "shop10/52.png", false,wereldd )
watergroen = guiCreateButton(310,300,90,30,"green water",false,wereldd )
guiSetProperty(watergroen,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,220,90,80, "shop10/53.png", false,wereldd )
watergeel = guiCreateButton(410,300,90,30,"yellow water",false,wereldd )
guiSetProperty(watergeel,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,220,90,80, "shop10/54.png", false,wereldd )
waterroos = guiCreateButton(510,300,90,30,"pink water",false,wereldd )
guiSetProperty(waterroos,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 610,220,90,80, "shop10/55.png", false,wereldd )
waterzwart = guiCreateButton(610,300,90,30,"black water",false,wereldd )
guiSetProperty(waterzwart,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,220,90,80, "shop10/56.png", false,wereldd )
waterpaars = guiCreateButton(710,300,90,30,"no water",false,wereldd )
guiSetProperty(waterpaars,"NormalTextColour", "FF00FF00")




 mapobjectstab = guiCreateTab("M1",tabPanel)

guiCreateStaticImage( 10,220,90,80, "shop12/flwrdn.png", false,mapobjectstab )
bloemekesf = guiCreateButton(10,300,90,30,"$5 flowers ",false,mapobjectstab )
guiSetProperty(bloemekesf,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 110,220,90,80, "shop12/trffco.png", false,mapobjectstab )
trafficcone = guiCreateButton(110,300,90,30,"$5 traffic cone",false,mapobjectstab )
guiSetProperty(trafficcone,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,220,90,80, "shop11/9.png", false,mapobjectstab )
coowwsd = guiCreateButton(210,300,90,30,"$5 cow",false,mapobjectstab )
guiSetProperty(coowwsd,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 10,330,90,80, "shop12/blblck.png", false,mapobjectstab )
blueblockk = guiCreateButton(10,410,90,30,"5 Blue block",false,mapobjectstab )
guiSetProperty(blueblockk,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 110,330,90,80, "shop12/wdblck.png", false,mapobjectstab )
woodblock = guiCreateButton(110,410,90,30,"5 wooden block",false,mapobjectstab )
guiSetProperty(woodblock,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,330,90,80, "shop12/ststfh.png", false,mapobjectstab )
giantstatue = guiCreateButton(210,410,90,30,"5 giant statue",false,mapobjectstab )
guiSetProperty(giantstatue,"NormalTextColour", "FF00FF00")



guiCreateStaticImage( 310,330,90,80, "shop12/wtrtt.png", false,mapobjectstab )
waterobj = guiCreateButton(310,410,90,30,"5 water",false,mapobjectstab )
guiSetProperty(waterobj,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,330,90,80, "shop12/knnn.png", false,mapobjectstab )
cannonn = guiCreateButton(410,410,90,30,"5 canon",false,mapobjectstab )
guiSetProperty(cannonn,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,330,90,80, "shop12/hzkndf.png", false,mapobjectstab )
woodcbn = guiCreateButton(510,410,90,30,"5 wooden cabin",false,mapobjectstab )
guiSetProperty(woodcbn,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 610,330,90,80, "shop12/rtskfg.png", false,mapobjectstab )
rotdfds = guiCreateButton(610,410,90,30,"5 rock",false,mapobjectstab )
guiSetProperty(rotdfds,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,330,90,80, "shop12/rtskf.png", false,mapobjectstab )
rots2 = guiCreateButton(710,410,90,30,"5 rock2",false,mapobjectstab )
guiSetProperty(rots2,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 310,220,90,80, "shop11/9.png", false,mapobjectstab )
coowws = guiCreateButton(310,300,90,30,"$5 cow 2",false,mapobjectstab )
guiSetProperty(coowws,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,220,90,80, "shop12/sptrd.png", false,mapobjectstab )
steppsd = guiCreateButton(410,300,90,30,"$5 stair steps",false,mapobjectstab )
guiSetProperty(steppsd,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,220,90,80, "shop12/strsf.png", false,mapobjectstab )
stairrss2 = guiCreateButton(510,300,90,30,"$5 Stairs",false,mapobjectstab )
guiSetProperty(stairrss2,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 610,220,90,80, "shop12/strs.png", false,mapobjectstab )
stairss1 = guiCreateButton(610,300,90,30,"$5 Stairs 2",false,mapobjectstab )
guiSetProperty(stairss1,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,220,90,80, "shop8/20.png", false,mapobjectstab )
deadcoopp = guiCreateButton(710,300,90,30,"$5 Dead cop",false,mapobjectstab )
guiSetProperty(deadcoopp,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,10,90,75, "shop11/101.png", false,mapobjectstab )
boomkedsqs = guiCreateButton(410,80,90,30,"tree 10$",false,mapobjectstab )
guiSetProperty(boomkedsqs,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 110,10,90,75, "shop11/101.png", false,mapobjectstab )
boomkedsdsqqs = guiCreateButton(110,80,90,30,"tree2 15$",false,mapobjectstab )
guiSetProperty(boomkedsdsqqs,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 210,10,90,75, "shop11/101.png", false,mapobjectstab )
boomkedsfgqs = guiCreateButton(210,80,90,30,"tree3 17$",false,mapobjectstab )
guiSetProperty(boomkedsfgqs,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 310,10,90,75, "shop12/1.png", false,mapobjectstab )
struik = guiCreateButton(310,80,90,30,"bush 10$",false,mapobjectstab )
guiSetProperty(struik,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 10,10,90,75, "shop12/gngsttu.png", false,mapobjectstab )
gangstatue = guiCreateButton(10,80,90,30,"Map editor place",false,mapobjectstab )
guiSetProperty(gangstatue,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 710,10,90,75, "shop11/122.png", false,mapobjectstab )
brievebus = guiCreateButton(710,80,90,30,"mailbox 40$",false,mapobjectstab )
guiSetProperty(brievebus,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 610,10,90,75, "shop12/dsclght.png", false,mapobjectstab )
lichtboven = guiCreateButton(610,80,90,30,"Discolight 75$",false,mapobjectstab )
guiSetProperty(lichtboven,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 510,10,90,75, "shop12/staanlichtje.png", false,mapobjectstab )
toadlightt = guiCreateButton(510,80,90,30,"Toadstool light40$",false,mapobjectstab )
guiSetProperty(toadlightt,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 10,440,90,80, "shop11/103.png", false,mapobjectstab )
fencea = guiCreateButton(10,510,90,30,"Firepole 25$",false,mapobjectstab )
guiSetProperty(fencea,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 110,440,90,80, "shop11/104.png", false,mapobjectstab )
fenceb = guiCreateButton(110,510,90,30,"skull fire 25$",false,mapobjectstab )
guiSetProperty(fenceb,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,440,90,80, "shop11/105.png", false,mapobjectstab )
fencec = guiCreateButton(210,510,90,30,"Trash can 8$",false,mapobjectstab )
guiSetProperty(fencec,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 310,440,90,80, "shop11/102.png", false,mapobjectstab )
fenced = guiCreateButton(310,510,90,30,"Fountain 150$",false,mapobjectstab )
guiSetProperty(fenced,"NormalTextColour", "FF00FF00")


guiCreateStaticImage( 410,440,90,80, "shop11/106.png", false,mapobjectstab )
streelight = guiCreateButton(410,510,90,30,"streetlight 60$",false,mapobjectstab )
guiSetProperty(streelight,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,440,90,80, "shop11/107.png", false,mapobjectstab )
strsdfeelight = guiCreateButton(510,510,90,30,"pillar 80$",false,mapobjectstab )
guiSetProperty(strsdfeelight,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 610,440,90,80, "shop11/109.png", false,mapobjectstab )
benchdss = guiCreateButton(610,510,90,30,"bench 15$",false,mapobjectstab )
guiSetProperty(benchdss,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,440,90,80, "shop11/110.png", false,mapobjectstab )
cactuds = guiCreateButton(710,510,90,30,"cactus 5$",false,mapobjectstab )
guiSetProperty(cactuds,"NormalTextColour", "FF00FF00")


guiCreateStaticImage( 10,110,90,75, "shop11/108.png", false,mapobjectstab )
gate1 = guiCreateButton(10,190,90,30,"gate A 20$",false,mapobjectstab )
guiSetProperty(gate1,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 110,110,90,75, "shop11/108.png", false,mapobjectstab )
gate2 = guiCreateButton(110,190,90,30,"gate B 20$",false,mapobjectstab )
guiSetProperty(gate2,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 210,110,90,75, "shop11/66.png", false,mapobjectstab )
walkingtest222 = guiCreateButton(210,190,90,30,"1000$ stunt ramp South",false,mapobjectstab )
guiSetProperty(walkingtest222,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 310,110,90,75, "shop11/66.png", false,mapobjectstab )
walkingtest22 = guiCreateButton(310,190,90,30,"1000$ stunt ramp East",false,mapobjectstab )
guiSetProperty(walkingtest22,"NormalTextColour", "FFFFF000")

guiCreateStaticImage( 410,110,90,75, "shop11/66.png", false,mapobjectstab )
walkingtest2 = guiCreateButton(410,190,90,30,"1000$ stunt ramp West",false,mapobjectstab )
guiSetProperty(walkingtest2,"NormalTextColour", "FFFFF000")


guiCreateStaticImage( 510,110,90,75, "shop11/66.png", false,mapobjectstab )
walkingtest = guiCreateButton(510,190,90,30,"1000$ stunt ramp North",false,mapobjectstab )
guiSetProperty(walkingtest,"NormalTextColour", "FF00FF00")


guiCreateStaticImage( 610,110,90,75, "shop11/120.png", false,mapobjectstab )
windmolen = guiCreateButton(610,190,90,30,"750$ windmill",false,mapobjectstab )
guiSetProperty(windmolen,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,110,90,75, "shop11/121.png", false,mapobjectstab )
uitkijktore = guiCreateButton(710,190,90,30,"950$ watchtower",false,mapobjectstab )
guiSetProperty(uitkijktore,"NormalTextColour", "FF00FF00")
---------------------------------------------------------------------------------------------------------   



mapedittwe = guiCreateTab("M2",tabPanel)



guiCreateStaticImage( 10,220,90,80, "shop12/bshjfg.png", false,mapedittwe )
struikieek = guiCreateButton(10,300,90,30,"$5 bush ",false,mapedittwe )
guiSetProperty(struikieek,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 110,220,90,80, "shop12/flghrtg.png", false,mapedittwe )
flwrbsh = guiCreateButton(110,300,90,30,"$5 Flower bush",false,mapedittwe )
guiSetProperty(flwrbsh,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,220,90,80, "shop12/ffghht.png", false,mapedittwe )
flowersdjgf = guiCreateButton(210,300,90,30,"$5 Flowers",false,mapedittwe )
guiSetProperty(flowersdjgf,"NormalTextColour", "FF00FF00")



guiCreateStaticImage( 310,220,90,80, "shop12/flwnrtg.png", false,mapedittwe )
flowerskgfkj = guiCreateButton(310,300,90,30,"$5 flowers ",false,mapedittwe )
guiSetProperty(flowerskgfkj,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,220,90,80, "shop12/fencdfg.png", false,mapedittwe )
fencefggh = guiCreateButton(410,300,90,30,"$5 Fence1 A",false,mapedittwe )
guiSetProperty(fencefggh,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,220,90,80, "shop12/fencdfg.png", false,mapedittwe )
fencefdggh = guiCreateButton(510,300,90,30,"$5 Fence1 B",false,mapedittwe )
guiSetProperty(fencefdggh,"NormalTextColour", "FF00FF00")



guiCreateStaticImage( 610,220,90,80, "wep/9.png", false,mapedittwe )
udfoijkf = guiCreateButton(610,300,90,30,"$5 UFO ",false,mapedittwe )
guiSetProperty(udfoijkf,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,330,90,80, "shop8/30.png", false,mapedittwe )
buyrockske = guiCreateButton(710,410,90,30,"$500 rock",false,mapedittwe )
guiSetProperty(buyrockske,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 710,220,90,80, "shop/777.png", false,mapedittwe )
weapButton_13 = guiCreateButton(710,300,90,30,"$2500 smoke",false,mapedittwe )
guiSetProperty(weapButton_13,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 10,330,90,80, "shop12/fencdfjk.png", false,mapedittwe )
fencslkked = guiCreateButton(10,410,90,30,"5 Fence2 A",false,mapedittwe )
guiSetProperty(fencslkked,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 110,330,90,80, "shop12/fencdfjk.png", false,mapedittwe )
fencslkke = guiCreateButton(110,410,90,30,"5 Fence2 B",false,mapedittwe )
guiSetProperty(fencslkke,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 610,330,90,80, "shop12/weedvggh.png", false,mapedittwe )
weedplntfg = guiCreateButton(610,410,90,30,"5 Weedplants",false,mapedittwe )
guiSetProperty(weedplntfg,"NormalTextColour", "FF00FF00")


guiCreateStaticImage( 310,110,90,80, "shop4/34.png", false,mapedittwe )
buyBarrel = guiCreateButton(310,190,90,30,"$1200 buy barrel",false,mapedittwe )
guiSetProperty(buyBarrel,"NormalTextColour", "FFFF0000")

guiCreateStaticImage( 10,110,90,80, "shop4/33.png", false,mapedittwe )
buyhay = guiCreateButton(10,190,90,30,"$600 buyhay",false,mapedittwe )
guiSetProperty(buyhay,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 210,330,90,80, "shop12/langgrs.png", false,mapedittwe )
langgras = guiCreateButton(210,410,90,30,"5 Long grass",false,mapedittwe )
guiSetProperty(langgras,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 310,330,90,80, "shop12/othrcbn.png", false,mapedittwe )
othercabion = guiCreateButton(310,410,90,30,"5 Cabin",false,mapedittwe )
guiSetProperty(othercabion,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 410,330,90,80, "shop12/brkhs.png", false,mapedittwe )
brokhouse = guiCreateButton(410,410,90,30,"5 Broken thing",false,mapedittwe )
guiSetProperty(brokhouse,"NormalTextColour", "FF00FF00")

guiCreateStaticImage( 510,330,90,80, "shop12/weidtrr.png", false,mapedittwe )
weidetree = guiCreateButton(510,410,90,30,"5 Tree",false,mapedittwe )
guiSetProperty(weidetree,"NormalTextColour", "FF00FF00")
 




-----------------------------------------------------------------------------------------------------------




 
 
bindKey ( "F4" , "down" , function()


 
if ( guiGetVisible ( shopWddindow ) == true ) then
 guiSetVisible ( shopWddindow ,false )
 showCursor(false ,false )
destroyElement(shopmuziek)

 
 elseif ( guiGetVisible ( shopWddindow ) == false ) then
 guiSetVisible ( shopWddindow ,true )
 showCursor(true ,true )
 playSound("1.wav")



 
 end
 end
 )
 
 
 
 
 
------------------------------------------------------------------------------------------------------
 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  stormweather ) then 
 
 
 
 
setWeather ( 8 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  dullweather ) then 
 
 
 
 
setWeather ( 12 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  hotweather ) then 
 
 
 
 
setWeather ( 11 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  clearweather ) then 
 
 
 
 
setWeather ( 10 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  foggweather ) then 
 
 
 
 
setWeather ( 9 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  stormweather ) then 
 
 
 
 
setWeather ( 8 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  rainyweather ) then 
 
 
 
 
setWeather ( 16 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  sandweather ) then 
 
 
 
 
setWeather ( 19 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  greenfogweather ) then 
 
 
 
 
setWeather ( 20 )
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  normalworhggld ) then 
 
 
  
triggerServerEvent("normalworhggld",getLocalPlayer()) 
 
setWeather ( 11 )
setWaterLevel ( 0 )
setSkyGradient( 60, 100, 196, 136, 170, 212 )
wavesss = setWaveHeight ( 0 )
resetWaterColor ()
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  nowaterr ) then 
 
 
  

 

setWaterLevel ( -100 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  darkweather ) then 
 
 
 
 
setWeather ( 150 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  orangeweather ) then 
 
 
 
 
setWeather ( 26 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  brightweather ) then 
 
 
 
 
 setFarClipDistance(550)
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  purpleweather ) then 
 
 
 
 
setWeather ( 42 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  toxivweather ) then 
 
 
 
 
setWeather ( 43 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  whiteweather ) then 
 
 
 
 
setWeather ( 44 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  horizonweather ) then 
 
 
 
 setFarClipDistance(5000)

 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  maangrootte ) then 
 
 
 
setMoonSize( 12 )

 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  stormextra ) then 
 
 
 
 
setWeather ( 700 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  morningtime ) then 
 
 
 
 
setTime ( 6, 00 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  midtime ) then 
 
 
 
 
setTime ( 12, 00 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  nighttime ) then 
 
 
 
 
setTime ( 00, 00 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  normalelucht ) then 
 
 
 
 
resetSkyGradient()
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  rodelucht ) then 
 
 
 
 
setSkyGradient( 200, 0, 0, 150, 0, 0 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  blauwelucht ) then 
 
 
 
setSkyGradient( 60, 100, 196, 136, 170, 212 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  gelelucht ) then 
 
 
 
 
setSkyGradient( 200, 200, 0, 150, 150, 0 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  groenelucht ) then 
 
 
 
 
setSkyGradient( 0, 200, 0, 0, 100, 0 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  paarselucht ) then 
 
 
 
 
setSkyGradient( 200, 0, 100, 150, 0, 70 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  zwartelucht ) then 
 
 
 
 
setSkyGradient( 0, 0, 0, 0, 0, 0 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  bigtsunami ) then 
 
 
 
floodWater = createWater(-2998,-2998,0,2998,-2998,0,-2998,2998,0,2998,2998,0)
 setWaterLevel ( 22 )
wavesss = setWaveHeight ( 25 )
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  normalwater ) then 
 
 
 
 setWaterLevel ( 0 )
wavesss = setWaveHeight ( 0 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  smalltsunami ) then 
 
 
 floodWater = createWater(-2998,-2998,0,2998,-2998,0,-2998,2998,0,2998,2998,0)
 setWaterLevel ( 11 )
wavesss = setWaveHeight ( 8 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  waternnormal ) then 
 
 
 
 
resetWaterColor ()
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  waterrood ) then 
 
 
 
setWaterColor ( 255, 0, 0, 200 )

 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  watergroen ) then 
 
 
 

setWaterColor ( 0, 255, 0, 200 )
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  watergeel ) then 
 
 
 
 
setWaterColor ( 255, 255, 0, 200 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  waterroos ) then 
 
 
 
 
setWaterColor ( 255, 0, 255, 200 )
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  waterzwart ) then 
 
 
 
 
setWaterColor ( 0, 0, 0, 200 )
 
end 
 end
 
 
) 




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  waterpaars ) then 
 
 
 
 
setWaterColor ( 0, 0, 0, 0 )
 
end 
 end
 
 
) 

-------------------------------------------------------





addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  blueblockk) then 
 
 
 
 
triggerServerEvent("blueblockk",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  woodblock) then 
 
 
 
 
triggerServerEvent("woodblock",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  stairss1) then 
 
 
 
 
triggerServerEvent("stairss1",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  stairrss2) then 
 
 
 
 
triggerServerEvent("stairrss2",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  steppsd) then 
 
 
 
 
triggerServerEvent("steppsd",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  coowws) then 
 
 
 
 
triggerServerEvent("coowws",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  coowwsd) then 
 
 
 
 
triggerServerEvent("coowwsd",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  trafficcone) then 
 
 
 
 
triggerServerEvent("trafficcone",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  bloemekesf) then 
 
 
 
 
triggerServerEvent("bloemekesf",getLocalPlayer()) 
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  giantstatue ) then 
 
 
 
 
triggerServerEvent("giantstatue",getLocalPlayer()) 
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  woodcbn) then 
 
 
 
 
triggerServerEvent("woodcbn",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  cannonn) then 
 
 
 
 
triggerServerEvent("cannonn",getLocalPlayer()) 
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  waterobj) then 
 
 
 
 
triggerServerEvent("waterobj",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  deadcoopp) then 
 
 
 
 
triggerServerEvent("deadcoopp",getLocalPlayer()) 
 
end 
 end
 
 
) 


 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  rotdfds ) then 


 
 
triggerServerEvent("rotdfds",getLocalPlayer()) 
 
end 
 end
 
 
) 



 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  rots2 ) then 


 
 
triggerServerEvent("rots2",getLocalPlayer()) 
 
end 
 end
 
 
) 


   addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if (source == boomkedsqs) then

    triggerServerEvent ("boomkedsqs", getLocalPlayer())
 
end 
 
end 
)



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  boomkedsdsqqs ) then 
 
 
 
 
triggerServerEvent("boomkedsdsqqs",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  gate1 ) then 
 
 
 
 
triggerServerEvent("gate1",getLocalPlayer()) 
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  boomkedsfgqs ) then 
 
 
 
 
triggerServerEvent("boomkedsfgqs",getLocalPlayer()) 
 
end 
 end
 
 
) 

   
   
   addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  struik ) then 
 
 
 
 
triggerServerEvent("struik",getLocalPlayer()) 
 
end 
 end
 
 
) 

 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  gangstatue ) then 


 
 
triggerServerEvent("gangstatue",getLocalPlayer()) 
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  brievebus ) then 
 
 
 
 
triggerServerEvent("brievebus",getLocalPlayer()) 
 
end 
 end
 
 
) 
 


 
  addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  lichtboven ) then 
 
 
triggerServerEvent("lichtboven",getLocalPlayer()) 
 
end 
 
end 
 
 
) 
 
 
 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  toadlightt ) then 
 
 
 
 
triggerServerEvent("toadlightt",getLocalPlayer()) 
 
end 
 end
 
 
) 



   addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fencea ) then 
 
triggerServerEvent("fencea",getLocalPlayer()) 
 
end 
 
end 
)



   addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fencec ) then 
 
triggerServerEvent("fencec",getLocalPlayer()) 
 
end 
 
end 
)


   addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fenceb ) then 
 
triggerServerEvent("fenceb",getLocalPlayer()) 
 
end 
 
end 
)

   addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fenced ) then 
 
triggerServerEvent("fenced",getLocalPlayer()) 
 
end 
 
end 
)



  
 addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  streelight ) then 
 
triggerServerEvent("streelight",getLocalPlayer()) 
 
end 
 
end 
 
 )
 
  addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  strsdfeelight ) then 
 
triggerServerEvent("strsdfeelight",getLocalPlayer()) 
 
end 
 
end 
 
 )
 
 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  gate2 ) then 
 
 
 
 
triggerServerEvent("gate2",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  benchdss ) then 
 
 
 
 
triggerServerEvent("benchdss",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  cactuds ) then 
 
 
 
 
triggerServerEvent("cactuds",getLocalPlayer()) 
 
end 
 end
 
 
)




addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  walkingtest222 ) then 
 
 
 
 
triggerServerEvent("walkingtest222",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  walkingtest22 ) then 
 
 
 
 
triggerServerEvent("walkingtest22",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  walkingtest2 ) then 
 
 
 
 
triggerServerEvent("walkingtest2",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  walkingtest ) then 
 
 
 
 
triggerServerEvent("walkingtest",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  windmolen ) then 
 
 
 
 
triggerServerEvent("windmolen",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  uitkijktore ) then 
 
 
 
 
triggerServerEvent("uitkijktore",getLocalPlayer()) 
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  struikieek ) then 
 
 
 
 
triggerServerEvent("struikieek",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  flwrbsh ) then 
 
 
 
 
triggerServerEvent("flwrbsh",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  flowersdjgf ) then 
 
 
 
 
triggerServerEvent("flowersdjgf",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  flowerskgfkj ) then 
 
 
 
 
triggerServerEvent("flowerskgfkj",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fencefggh ) then 
 
 
 
 
triggerServerEvent("fencefggh",getLocalPlayer()) 
 
end 
 end
 
 
) 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fencefdggh ) then 
 
 
 
 
triggerServerEvent("fencefdggh",getLocalPlayer()) 
 
end 
 end
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fencslkke ) then 
 
 
 
 
triggerServerEvent("fencslkke",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  fencslkked ) then 
 
 
 
 
triggerServerEvent("fencslkked",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  udfoijkf ) then 
 
 
 
 
triggerServerEvent("udfoijkf",getLocalPlayer()) 
 
end 
 end
 
 
) 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  buyrockske ) then 
 
 
 
 
triggerServerEvent("buyrockske",getLocalPlayer()) 
 
end 
 end
 
 
) 

 addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  weapButton_13 ) then 
 
triggerServerEvent("giveknif",getLocalPlayer()) 
 
end 
 
end 
 
 )
 
 
 
addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  weedplntfg ) then 
 
triggerServerEvent("weedplntfg",getLocalPlayer()) 
 
end 
 end
 
 
) 


 
     addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if (source == buyBarrel) then

    triggerServerEvent ("buyBarrel", getLocalPlayer())
 
end 
 
end 
)


 
  addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  buyhay ) then 
triggerServerEvent ("buyHay", getLocalPlayer())
 
 
 
end 
 
end 
 
 
) 



addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  langgras ) then 
 
triggerServerEvent("langgras",getLocalPlayer()) 
 
end 
 end
 
 
) 


addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  othercabion ) then 
 
triggerServerEvent("othercabion",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  brokhouse ) then 
 
triggerServerEvent("brokhouse",getLocalPlayer()) 
 
end 
 end
 
 
) 

addEventHandler ("onClientGUIClick", getRootElement(),
 
function(button, state, absoluteX, absoluteY)
 
if ( source ==  weidetree ) then 
 
triggerServerEvent("weidetree",getLocalPlayer()) 
 
end 
 end
 
 
) 