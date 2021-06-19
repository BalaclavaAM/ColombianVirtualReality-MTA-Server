
--MODELS REPLACE / REEMPLAZO DE MODELOS

local skins = { 

    { "bigfoot", 122 },
    { "cavedemon", 220 }, 
    { "jason", 112 }, 
    { "leatherface", 118 }, 
    { "lizard", 209 }, 
    { "nemesis", 103 },  
    { "nessie", 1851 }, 	
    { "pigsy", 131 }, 
    { "samara", 101 },	
    { "yeti", 102 }, 

}

function replaceModel()
    for k,v in ipairs(skins) do
    txd = engineLoadTXD("files/"..v[1]..".txd", v[2] )
    engineImportTXD(txd, v[2])
    dff = engineLoadDFF("files/"..v[1]..".dff", v[2] )
    engineReplaceModel(dff, v[2])
    end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)

--MYSTERIES SKILLS

function takeElementHealth( element, numb )
    if not numb then
	    return false
	end	
    local health = getElementHealth(element)
	if health then
        setElementHealth( element, health-numb )	
	end
end

function mysteriesStrength( attacker, weapon )
    if attacker then
        if getElementType(attacker) == "ped" then
            if isPedAMystery(attacker,"Jason") then
                takeElementHealth( source, 10 )
			elseif isPedAMystery(attacker,"Samara") then
                takeElementHealth( source, 15 )
            elseif isPedAMystery(attacker,"Bigfoot") then
                takeElementHealth( source, 15 )
            elseif isPedAMystery(attacker,"Yeti") then
                takeElementHealth( source, 10 )
            elseif isPedAMystery(attacker,"Lizard") then
                takeElementHealth( source, 4 )
            elseif isPedAMystery(attacker,"CaveDemon") then
                takeElementHealth( source, 6 )			
			end
        end		
	end
end
addEventHandler("onClientPlayerDamage", root, mysteriesStrength )

