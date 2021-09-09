local messages = { 
	"Disfruta tu estadía en Colombian Virtual Reality!",
	"Si encuentras un bug, por favor usa nuestro discord /dc.",
	"Si estás bugeado intenta relogear antes de preguntarle al staff",
	"Recuerda que puedes comprar VIP para ayudar el servidor!",
	"¿Tienes una sugerencia? Ponla en #Ideas en el canal de discord.",
	"Usa F3 -> Settings para mejorar tu juego",
	"Entra a nuestro nuevo foro! www.colombianvirtualreality.com/foro",
	"Ve al cine para ver tus vídeos de youtube favoritos (ícono de dragón en SF)",
	"Lee las reglas en F1 o el F4",
	"No pidas dinero, es muy molesto!",
	"Usa el banco para guardar los pesitos! Si te asesinan te lo podrían robar",
	"Recuerda que tenemos grupo de Discord y de Whatsapp",
	"No pienses en usar hacks! Podemos mirar todas tus estadísticas (:",
	"Hemos añadido venta de vehículos en nuestro servidor por dinero real. Más info en Discord!."
}

local lastI = 0
function sendNextAutomatedMessage (  )
	lastI = lastI + 1
	if ( lastI > #messages ) then
		lastI = 1
	end
	
	sendClientMessage ( messages [ lastI ], root, math.random ( 150, 255 ), math.random ( 150, 255 ), math.random ( 150, 255 ) )
	setTimer ( sendNextAutomatedMessage, 300000, 1 )
end
setTimer ( sendNextAutomatedMessage, 200, 1 )