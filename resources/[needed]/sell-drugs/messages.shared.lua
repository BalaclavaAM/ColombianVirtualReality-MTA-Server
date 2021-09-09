-- Don't change the '%s' in strings - they are for variables 

MESSAGES = { }
MESSAGES.SERVER = { }
MESSAGES.CLIENT = { }
MESSAGES.SHARED = { }

MESSAGES.SERVER.ALREADY_DEALING = "Ya estas vendiendo drogas.";
MESSAGES.SERVER.CMD_STOP_SELLING = "pararventa";
MESSAGES.SERVER.NOT_SELLING = "No estas vendiendo droga";
MESSAGES.SERVER.ON_BEGIN_SELLING = "Estas vendiendo droga. copia /%s para parar de vender.";
MESSAGES.SERVER.NO_LONGER_SELLING = "Ya no estas vendiendo droga";
MESSAGES.SERVER.NOT_ENOUGH_MONEY = "No tienes $%s";
MESSAGES.SERVER.ON_SALE_DEALER = "%s ha comprado %s %s!";
MESSAGES.SERVER.ON_SALE_CLIENT = "Has comprado %s %s de %s!";

MESSAGES.SHARED.DRUG_GOD = "Popper";
MESSAGES.SHARED.DRUG_WEED = "Bareta";
MESSAGES.SHARED.DRUG_SPEED = 'Perica';
MESSAGES.SHARED.DRUG_LSD = "LSD";
MESSAGES.SHARED.DRUG_STEROIDS = "Bazuko";
MESSAGES.SHARED.DRUG_HEROIN = "Heroina";

MESSAGES.CLIENT.COMMAND = "venderdroga";
MESSAGES.CLIENT.BEGIN_SELL = "Comenzar";
MESSAGES.CLIENT.CANCEL = "Cancelar";

MESSAGES.CLIENT.SETUP_WINDOW_ALREADY_OPEN = "El panel ya esta abierto.";
MESSAGES.CLIENT.SETUP_NOT_NUMBERS = "Ingrese numeros validos [0-infinito]";
MESSAGES.CLIENT.SETUP_INVALID_AMOUNT = "No tienes %s de '%s'.";
MESSAGES.CLIENT.NOT_WHOLE = "Todos los numeros deben ser enteros.";
MESSAGES.CLIENT.AMOUNT = "Cantidad";
MESSAGES.CLIENT.PRICE_UNIT = "Precio/Unidad"
MESSAGES.CLIENT.TOTAL = "Total"

MESSAGES.CLIENT.CANNOT_SELL_BUYING = "No puedes vender drogas mientras compras.";