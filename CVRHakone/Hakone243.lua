-- Script generated with
-- 50p's MTA:SA MAXScript v0.3 (18/05/2010)

local modelNames = { "map/hka01", "map/hka02", "map/hka03", "map/hka04", "map/hka05", "map/hka06", "map/hka07", "map/hka08", "map/hka09", "map/hka10", "map/hka11", "map/hka12", "map/hka13", "map/hka14", "map/hka15", "map/hka16", "map/hka17", "map/hka18", "map/hka19", "map/hka20", "map/hka21", "map/hka22", "map/hka23", "map/hka24", "map/hka25", "map/hka26", "map/hka27", "map/hka28", "map/hka29", "map/hka30", "map/hka31", "map/hka32", "map/hka33", "map/hka34", "map/hka35", "map/hka36", "map/hka37", "map/hka38", "map/hka39", "map/hka40", "map/hka41", "map/hka42", "map/hka43", "map/hka44", }

function reloadModels( )
		txd=engineLoadTXD("map/hka1.txd");
		engineImportTXD(txd,4000);
		engineImportTXD(txd,4001);
	for i, modelName in ipairs( modelNames ) do
		local temp = engineLoadDFF( modelName .. ".dff", 0 );
		engineReplaceModel( temp, (i-1) + 4000 );
		temp = engineLoadCOL( modelName .. ".col" );
		engineReplaceCOL( temp, (i-1) + 4000 );
		txd=engineLoadTXD("map/hka1.txd");
		engineImportTXD(txd,(i+1)+4000);
	end
end
addEventHandler( "onClientResourceStart", getResourceRootElement(), reloadModels );
addCommandHandler( "reload", reloadModels );