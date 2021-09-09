max_wanted = {
    community = 4,
    law = 3,
    criminal = 7,
	militar = 3
}

jobRanks = {
    ['criminal'] = {
        [0] = "Don Nadie",
        [50] = "Marihuanero",
        [75] = "Jibaro",
        [120] = "Visajoso",
        [200] = "Criminal mediocre",
        [310] = "Respetado",
        [499] = "Lider de combo",
		[650] = "Paraco",
		[800] = "Narcotraficante",
		[900] = "Pablo Escobar",
    },
    ['police officer'] = {
        [0] ="Bachiller",
        [90]="Tombo",
        [200]="Tombo Corrupto",
        [310]="Sargento",
        [450]="Teniente",
        [600]="Capitan",
        [900]="General",
		[1200] = "Mariscal",
		[1300] = "Heroe patrio",
		[1400] = "RoboCop"
    },
    ['medic'] = {
        [0] = "Asistente",
        [50] = "Practicante",
        [100]= "Enfermero",
        [130] = "Paramedico",
        [200] = "Doctor",
        [260] = "Cirujano",
		[300] = "Medico General",
		[400] = "De planta",
		[500] = "Medico Especialista",
		[600] = "Curandero",
    },
    ['mechanic'] = {
        [0] = "Novato",
        [40] = "Deshonesto",
        [100]= "Experimentado",
        [140]= "Profesional en coches",
        [200]= "Profesional en motos",
        [245]= "Mecanico maestro",
    },
	['drifter'] = {
	[0] = "Drifter Novato",
	[100] = "Drifter",
	[200] = "Drifter Especialista",
    [300] = "Keisuke Takahashi",
    [500] = "Han",
	[1000] = "Ryosuke Takahashi",
	[1600] = "Takumi Fujiwara",
	},
    ['fisherman'] = {
        [0] = "Deck Hand",
        [20]= "Net Baiter",
        [75]= "Line Thrower",
        [100]="Line Roller",
        [140]="Boat Captain",
        [200]="Experienced Fisherman",
        [270]="Underwater Trap Setter",
    },
	['detective'] = {
		[0] = "Detective",
	},
	['pilot'] = {
		[0] = "Aspirante",
		[100] = "Asistente",
		[200] = "Segundo Oficial",
		[350] = "Primer Oficial",
		[480] = "Capitan",
		[650] = "Primer Oficial Comercial",
		[760] = "Capitan Comercial",
		[990] = "Comandante Comercial",
		[1060] = "Maestro De Vuelo",
		[1300] = "Veterano",
	},
	['stunter'] = {
		[0] = "Visajoso",
		[100] = "RappiNoob",
		[200] = "Piquete",
		[300] = "Arraquetilla",
		[400] = "Sorner",
		[500] = "Piquete PRO",
		[600] = "Rappi Stunter",
		[700] = "Stunter PRO",
		[800] = "Azotante",
		[900] = "OnFire",
		[1000] = "RappiStuntMaster",
	},
	['busetero'] = {
		[0] = "Microbusetero",
		[50] = "Busetero de ciudad",
		[150] = "Busetero de tours",
		[200] = "Toretto",	
	},
	['camionero'] = {
	[0] = "Conductor Nuevo",
	[100] = "Acarreos",
	[200] = "Trasteos",
	[300] = "Transportador",
	[400] = "Camionero Novato",
	[500] = "Camionero",
	[600] = "Camionero Experimentado",
	[700] = "Lider Camionero",
	[800] = "Comandante Camionero",
	[900] = "Camionero emputado",
	[1000] = "Toretto",
	},
	['taxista'] = {
	[0] = "Conductor Nuevo",
	[100] = "Piqueador básico",
	[200] = "Piqueador experimentado",
	[300] = "Transportador",
	[400] = "Corredor",
	[500] = "Toretto",
	[1000] = "Takumi Fujiwara",
	},
	['militar'] = {
	[0] = "Cabo",
	[100] = "General",
	},
	['granjero'] = {
	[0] = "Granjero"	
    },
    ['Basurero'] = {
        [0] = "Reciclador",
        [500] = "Recogebasura",
        [200] = "Recogebasura experimentado",
        [500] = "Transportador de la basura",
        [800] = "Maestro de la basura",
        [1000] = "CAPO de la basura"
    }
}

function getJobRankTable ( )
	return jobRanks
end

exports['Scoreboard']:scoreboardAddColumn  ( "Job", root, 90, "Job", 4 )
exports['Scoreboard']:scoreboardAddColumn  ( "Job Rank", root, 90, "Job Rank", 5 )

function create3DText ( str, pos, color, parent, settings ) 
    if str and pos and color then
        local text = createElement ( '3DText' )
        local settings = settings or  { }
        setElementData ( text, "text", str )
        setElementData ( text, "position", pos )
        setElementData ( text, "color", color )
        if ( not parent ) then
            parent = nil
        else
            if ( isElement ( parent ) ) then
                parent = parent
            else
                parent = nil
            end
        end
        setElementData ( text, "Settings", settings )
        setElementData ( text, "parentElement", parent )
        setElementData ( text, "sourceResource", sourceResource or getThisResource ( ))
        return text
    end
    return false
end

addEventHandler ( "onResourceStop", root, function ( r )
    for i, v in pairs ( getElementsByType ( "3DText" ) ) do
        if ( r == getElementData ( v, "sourceResource" ) ) then
            destroyElement ( v )
        end 
    end 
end )

function createJob ( name, x, y, z, rz )
    if ( name == 'Criminal' ) then
        create3DText ( 'Criminal', { x, y, z }, { 255, 0, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 109 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 59, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.criminal ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.criminal )..".", p, 255, 0, 0 )
                end 
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'criminal' )
            end
        end )
    elseif ( name == 'Drifter' ) then
        create3DText ( 'Drifter', { x, y, z }, { 255, 0, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 22 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 59, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.criminal ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.criminal )..".", p, 255, 0, 0 )
                end 
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'Drifter' )
            end
        end )
    ----------------------------------
	-- Law Jobs						--
	----------------------------------    
    elseif ( name == 'Police' ) then
        create3DText ( 'Policia', { x, y, z }, { 0, 100, 255 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 281 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 61, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.law ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.law )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'police' )
            end
        end )
		
	elseif ( name == 'Detective' ) then
        create3DText ( 'Detective', { x, y, z }, { 0, 120, 255 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 17 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 61, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.law ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.law )..".", p, 255, 0, 0 )
                end
				
				local arrests = getJobColumnData ( getAccountName ( getPlayerAccount ( p ) ), getDatabaseColumnTypeFromJob ( "police officer" ) )
				if ( arrests < 150 ) then
					return exports.NGMessages:sendClientMessage ( "This job requires at least 150 arrests", p, 255, 255, 0 )
				end
				
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'detective' )
            end
        end )
	elseif ( name == 'militar' ) then
        create3DText ( 'Militar', { x, y, z }, { 0, 100, 255 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 287 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 62, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.law ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.law )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'militar' )
            end
        end )
		
	----------------------------------
	-- Emergency Jobs				--
	----------------------------------
    elseif ( name == 'Medic' ) then
        create3DText ( 'Medico', { x, y, z }, { 0, 255, 255 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 274 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 58, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'medic' )
            end
        end )
		
    ----------------------------------
	-- Community Jobs				--
	----------------------------------
	elseif ( name == 'Mechanic' ) then
        create3DText ( 'Mecanico', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 30 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'mechanic' )
            end
        end )
    elseif ( name == 'Fisher' ) then
        create3DText ( 'Pescador', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 45 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'fisherman' )
            end
        end )
	elseif ( name == 'Granjero' ) then
        create3DText ( 'Granjero', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 158 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'granjero' )
            end
        end )
	elseif ( name == "Pilot" ) then
		create3DText ( 'Piloto', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 61 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'pilot' )
            end
        end )
	elseif ( name == 'Camionero' ) then
        create3DText ( 'Camionero', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 202 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'Camionero' )
            end
        end )
	elseif ( name == 'Taxista' ) then
        create3DText ( 'Taxista', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 142 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'Taxista' )
            end
        end )
	elseif ( name == 'Busetero' ) then
        create3DText ( 'Busetero', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 253 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'Busetero' )
            end
        end )
	elseif ( name == 'Basurero' ) then
        create3DText ( 'Basurero', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 183 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'Basurero' )
            end
        end )
	elseif ( name == 'Stunter' ) then
		create3DText ( 'Rappi/Stunter', { x, y, z }, { 255, 255, 0 }, { nil, true } )
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 155 )
        setElementData ( p, "Position", { x, y, z, rz } )
        createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return exports['NGMessages']:sendClientMessage ( "El máximo nivel de búsqueda para este trabajo es "..tostring ( max_wanted.community )..".", p, 255, 0, 0 )
                end
                triggerClientEvent ( p, 'NGJobs:OpenJobMenu', p, 'stunter' )
            end
        end )
    end
end
createJob ( 'Criminal', 1625.92, -1508.65, 13.6, 180 )
createJob ( 'Criminal', 2141.75, -1733.94, 17.28, 0 )
createJob ( 'Criminal', 2460.31, 1324.94, 10.82, -90 )
createJob ( 'Criminal', 1042.26, 2154.03, 10.82, -90 )
createJob ( 'Criminal', -1832.49, 584.03, 35.16, 0 )
createJob ( 'Criminal', 2124.29, 889.1, 11.18, -90 )
createJob ( 'Criminal', -2530.02, -624.22, 132.75, 0 )
createJob ( 'Mechanic', 2276.12, -2359.67, 13.55, 318 )
createJob ( 'Mechanic', -1710.16, 403.56, 7.42, 140.4 )
createJob ( 'Mechanic', 1658.34, 2199.65, 10.82, 180 )
createJob ( 'Pilot', 2003.13, -2294.49, 13.55, 90 )
createJob ( 'Pilot', 1651.48, 1614.14, 10.82, -90 )
createJob ( 'Pilot', -1253.7, 16.99, 14.15, 131 )
createJob ( 'Police', 1576.59, -1634.24, 13.56, 90 )
createJob ( 'Police', -1614.66, 682.42, 7.19, 90 )
createJob ( 'Police', 2297.12, 2463.87, 10.82, 90 )
createJob ( 'Medic', 1177.88, -1329.2, 14.08, 0 )
createJob ( 'Medic', 1615.18, 1819.67, 10.83, 0 )
createJob ( 'Fisher', 2158.27, -98.15, 2.81, 27.44 )
createJob ( "Detective", 1559.69, -1690.48, 5.89, 180 )
createJob ( "Camionero", 2175.97, -2258.71, 14.77, 210 )
createJob ( "Camionero", 1629.29, 966.81, 10.82, 270 )
createJob ( "Camionero", -2137.88, -238.66, 35.32, -90 )
createJob ( "Detective",-1573.45, 653.08, 7.19, 90 )
createJob ( "Taxista",2001.01, -1281.73, 23.98, 0 )
createJob ( "Detective", 2297.12, 2455.66, 10.82, 90 )
createJob ( "Stunter", 1948.64, -1364.5, 18.58, 90 )
createJob ( "Criminal", 2143.14, -1583.53, 14.35, 180 );
createJob ( "Criminal", 2216.16, 2711.91, 10.82, -90 );
createJob ( "Busetero", 1767.09, -1906.73, 13.57, 0 );
createJob ( "Drifter", -319.76, 1537.04, 75.56, 180 );
createJob ( "Drifter", -4235.16, 642.56, 620.64, 215 );
createJob ( "militar", -1061.06, -1203.17, 129.22, 260);
createJob ( "Drifter", 1812.01, -1900.54, 13.57, 270);
createJob ("Drifter", -2035.55, -120.56, 35.18, 180);
createJob ("Drifter",1983.1, 1756.52, 11.88,344);
createJob ("Mechanic",2641.36, -2033.67, 13.55,262);
createJob ("Drifter",2237.74, 1957.37, 32.01,270);
createJob ("Drifter",-1906.83, 1802.42, 2.3,190);
createJob ("Drifter",-3290.35, 885.08, 321.03,45);
createJob ("Basurero",2193.44, -1991.19, 13.55,45);
createJob ("Taxista",2082.67, 93.85, 28.87,35);
createJob ("Camionero",-2436.7, 2320.35, 4.98,0);
createJob ("Drifter",2345.72, 1393.56, 42.82,90);
createJob ("Drifter",2378.43, 2542.27, 10.82,270);
createJob ("Drifter",-2946.13, 471.65, 4.92,0)
createJob ("Drifter",2104.91, -2870.63, 1002.8,270)



function setPlayerJob ( p, job, prtyJob )
    if ( isGuestAccount ( getPlayerAccount ( p ) ) ) then
        return exports['NGMessages']:sendClientMessage ( "You need to be logged in to take a job.", p, 255, 0, 0 )
    end

    exports['NGLogs']:outputActionLog ( getPlayerName ( p ).." ahora está empleado como "..tostring ( job ) )
    addPlayerToJobDatabase ( p )
    setElementData(p,"isPassive",nil)
    local weapons = { }
	for i=1,12 do 
		weapons[i] = { 
			weap = getPedWeapon ( source, i ),
			ammo = getPedTotalAmmo ( source, i ) 
		} 
	end

    if ( job == 'Drifter' ) then
        local skin = getElementData ( p, 'NGUser.UnemployedSkin' )
        if ( not tonumber ( skin ) ) then skin = 22
        else skin = tonumber ( skin ) end
        
        triggerEvent("NGGreenzones>Redzones",p,true)
        setElementData ( p, 'Job', 'Drifter' )
        exports['NGPlayerFunctions']:setTeam ( p, "Criminals" )
        setElementModel ( p, skin )
        job = "Drifter"
    else
        triggerEvent("NGGreenzones>Redzones",p,false)
        if ( job == 'criminal' ) then
            local skin = getElementData ( p, 'NGUser.UnemployedSkin' )
            if ( not tonumber ( skin ) ) then skin = 109
            else skin = tonumber ( skin ) end
        
            setElementData ( p, 'Job', 'Criminal' )
            exports['NGPlayerFunctions']:setTeam ( p, "Criminals" )
            setElementModel ( p, skin )
            job = "Criminal"
        elseif ( job == 'mechanic' ) then
            setElementData ( p, 'Job', 'Mechanic' )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
            setElementModel ( p, 30 )
            job = "Mechanic"
        elseif ( job == 'militar' ) then
            setElementData ( p, 'Job', 'Militar' )
            exports['NGPlayerFunctions']:setTeam ( p, "Fuerzas Armadas" )
            setElementModel ( p, 287 )
            job = "militar"
        elseif ( job == 'police' ) then
            setElementData ( p, 'Job', 'Police Officer' )
            exports['NGPlayerFunctions']:setTeam ( p, "Law Enforcement" )
            setElementModel ( p, 281 )
            job = "Police Officer"
        weapons[1] = { weap=3, ammo=2 }
        elseif ( job == "medic" ) then
            job = "Medic"
            setElementData ( p, "Job", "Medic" )
            setElementModel ( p, 274 )
            exports['NGPlayerFunctions']:setTeam ( p, "Emergency" )
        elseif ( job == "fisherman" ) then
            job = "Fisherman"
            setElementData ( p, "Job", "Fisherman" )
            setElementModel ( p, 45 )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
        elseif ( job == "detective" ) then
            job = "Detective"
            setElementData ( p, "Job", "Detective" )
            setElementModel ( p, 17 )
            exports['NGPlayerFunctions']:setTeam ( p, "Law Enforcement" )
            weapons[1] = { weap=3, ammo=2 }
        elseif ( job == "pilot" ) then
            job = "Pilot"
            setElementData ( p, "Job", "Pilot" )
            setElementModel ( p, 61 )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
        elseif ( job == "Taxista" ) then
            job = "Taxista"
            setElementData ( p, "Job", "Taxista" )
            setElementModel ( p, 142 )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
        elseif ( job == "Basurero" ) then
            job = "Basurero"
            setElementData ( p, "Job", "Basurero" )
            setElementModel ( p, 183 )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
        elseif ( job == "Camionero" ) then
            job = "Camionero"
            setElementData ( p, "Job", "Camionero" )
            setElementModel ( p, 202 )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
        elseif ( job == "Busetero" ) then
            job = "Busetero"
            setElementData ( p, "Job", "Busetero" )
            setElementModel ( p, 253 )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
        elseif ( job == 'stunter' ) then
            job = "Stunter"
            local skin = tonumber ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 155
            setElementData ( p, "Job", "Stunter" )
            setElementModel ( p, 155 )
            exports['NGPlayerFunctions']:setTeam ( p, "Services" )
        end
	end
    if ( prtyJob ) then
        job = prtyJob 
    end

   	takeAllWeapons ( p )
   	for i, v in pairs ( weapons ) do
   		giveWeapon ( p, v.weap, v.ammo )
   	end 

    exports['NGMessages']:sendClientMessage ( "Ahora estás empleado como "..tostring ( job ).."!", p, 0, 255, 0 )
    updateRank ( p, job )
	
	triggerEvent ( "NGJobs:onPlayerJoinNewJob", p, tostring ( job ):lower ( ) )
	weapons = nil
end
addEvent ( 'NGJobs:SetPlayerJob', true )
addEventHandler ( 'NGJobs:SetPlayerJob', root, function ( j ) setPlayerJob ( source, j ) end )

function getJobType ( job )
    local job = string.lower ( tostring ( job ) )
    if ( job == "criminal" or job == "unemployed" or job == "drifter" ) then
        return "criminal"
    elseif ( job == "medic" or job == "mechanic" or job == "Camionero" or job == "Busetero" or job == "fisherman" or job == 'pilot' or job == "stunter" or job == "Taxista" ) then
        return "community"
	    elseif ( job == "militar" ) then
        return "Fuerzas Armadas"
    elseif ( job == "police officer" or job == "detective" ) then
        return "law" 
    end
end

function updateRank ( p, job )
    local job = tostring ( job ):lower ( )
    local rank = "None"
    local current = 0
    local column = getDatabaseColumnTypeFromJob ( job )
    local data = getJobColumnData ( getAccountName ( getPlayerAccount ( p ) ), column or "" )
    if ( jobRanks[job] ) then
        for i, v in pairs ( jobRanks[job] ) do 
            if ( data >= i and i >= current ) then
                rank = v
                current = i
            end
        end
    end
    setElementData ( p, "Job Rank",tostring ( rank ) )
    if ( job == "fisherman" ) then
        fisherman_refreshMaxCatch ( p )
    end
end

function getDatabaseColumnTypeFromJob ( job )
    local column = "None"
    local job = tostring ( job ):lower ( )
    if ( job == "criminal" ) then
        column="CriminalActions"
	elseif ( job == "drifter" ) then
		column = "DriftPoints"
    elseif ( job == "mechanic" ) then
        column = "FixedVehicles"
    elseif ( job == "police officer" ) then
        column = "Arrests"
    elseif ( job == "medic" ) then
        column = "HealedPlayers"
    elseif ( job == "fisherman" ) then
        column = "CaughtFish"
	elseif ( job == "detective" ) then
		column = "SolvedCrims"
	elseif ( job == "pilot" ) then
		column = "completeflights"
	elseif ( job == "stunter" ) then
		column = "stunts"
	elseif ( job == "Camionero" ) then
		column = "entregas"
	elseif ( job == "Busetero" ) then
		column = "completeroutes"
	elseif ( job == "Taxista" ) then
		column = "carreras"
    elseif ( job == "Basurero" ) then
        column = "repartos"
    end
    return column
end

function addPlayerToJobDatabase ( p )
    local acc = getPlayerAccount ( p )
    if ( isGuestAccount ( acc ) ) then
        return false
    end
    local data = exports['NGSQL']:db_query ( "SELECT * FROM jobdata WHERE Username=? LIMIT 1", getAccountName ( acc ) )
    if ( type ( data ) ~= "table" or #data < 1 ) then
        exports['NGSQL']:db_exec ( "INSERT INTO jobdata ( `Username`, `Arrests`, `TimesArrested`, `CriminalActions`, `FixedVehicles`, `HealedPlayers`, `TowedVehicles`, `CaughtFish`, `SolvedCrims`, `completeflights`, `stunts`, `entregas`, `completeroutes`, `carreras`, `DriftPoints` ) VALUES ( '"..getAccountName ( acc ) .."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0' );" )
        return true
    end
    return false
end

exports['NGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS jobdata ( Username TEXT, Arrests INT, TimesArrested INT, CriminalActions INT, FixedVehicles INT, HealedPlayers INT, TowedVehicles INT, CaughtFish INT, SolvedCrims INT, completeflights INT, stunts INT, entregas INT, completeroutes INT, carreras INT, DriftPoints INT )" )
function updateJobColumn ( user, col, to ) 
    if ( user and col and to ) then
        if ( type ( user ) == 'string' and type ( col ) == 'string' ) then
            if ( to ~= "AddOne" ) then
                exports['NGSQL']:db_exec ( "UPDATE jobdata SET "..tostring ( col ).."='"..to.."' WHERE Username='"..user.."'" )
                return true
            elseif ( to == "AddOne" ) then
                local q = exports['NGSQL']:db_query ( "SELECT "..tostring ( col ).." FROM jobdata WHERE Username='"..user.."'" )
                local to = q[1][col]+1
                exports['NGSQL']:db_exec ( "UPDATE jobdata SET "..tostring ( col ).."='"..to.."' WHERE Username='"..user.."'" )
                return true
            end
        end
    end
    return false
end

function getJobColumnData ( user, col )
    if user and col then
        local user, col = tostring ( user ), tostring ( col )
        local q = exports['NGSQL']:db_query ( "SELECT * FROM jobdata WHERE Username=?", user )
        if ( q and q[1] ) then
        	return q[1][col] or 0
        else
        	return 0
        end
    end
end

function outputTeamMessage ( msg, team, r, g, b )
    for i, v in ipairs ( getPlayersInTeam ( getTeamFromName ( team ) ) ) do
        exports['NGMessages']:sendClientMessage ( msg, v, r, g, b )
    end
    return true
end

function resignPlayer ( player, forced )
    if (exports['CVRCapturaelCamion']:isPlayerInMinigame(source) ) then return end
    if ( player and isElement ( player ) and getElementType ( player ) == 'player' ) then
		if ( forced == nil ) then
			forced = true
		end
		
        triggerEvent("NGGreenzones>Redzones",player,false)
		local j = getElementData ( player, "Job" )
		local r = getElementData ( player, "Job Rank" )
        setElementData ( player, "Job", "UnEmployed" )
        exports['NGPlayerFunctions']:setTeam ( player, "Unemployed" )
        setElementData ( player, "Job Rank", "None" )
		if ( isPedInVehicle ( player ) ) then removePedFromVehicle ( player ) end
		local skin = tonumber ( getElementData ( player, "NGUser.UnemployedSkin" ) )
		if ( not skin ) then
			setElementData ( player, "NGUser.UnemployedSkin", 28 )
			skin = 28
		end
		
		triggerClientEvent ( player, "onPlayerResign", player, j, r, skin )
        setPedSkin ( player, skin )
    end
end
addEvent("NGJobs:resign",true)
addEventHandler("NGJobs:resign",root,resignPlayer)

addCommandHandler ( "resign", function ( player )
	if ( isPedInVehicle ( player ) ) then
		return exports.NGMessages:sendClientMessage ( "Sal de tu vehiculo para usar este comando.", player, 255, 255, 0 )
	end
	resignPlayer ( player )
end )

addCommandHandler ( "renunciar", function ( player )
	if ( isPedInVehicle ( player ) ) then
		return exports.NGMessages:sendClientMessage ( "Sal de tu vehiculo para usar este comando.", player, 255, 255, 0 )
	end
	resignPlayer ( player )
end )

addCommandHandler ( "dardetective", function ( p, _, p2 )
	if ( exports.NGAdministration:isPlayerInACL ( p, "Admin" ) or exports.NGAdministration:isPlayerInACL ( p, "Level 5" ) or exports.NGAdministration:isPlayerInACL ( p, "Console" ) ) then
		if ( p2 ) then
			local c = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
				if c then
					triggerClientEvent ( c, 'NGJobs:OpenJobMenu', c, 'detective' )
				else exports['NGMessages']:sendClientMessage ( p2.." No existe. ", p, 255, 255, 0 ) end
		else exports['NGMessages']:sendClientMessage ( "Error, use /dardetective [jugador]", p, 255, 255, 0 ) end
	else  exports['NGMessages']:sendClientMessage ( "Error, tienes que ser administrador para usar este comando" , p, 255, 255, 0 ) end
end )

addCommandHandler ( "dardrifter", function ( p, _, p2 )
	if ( exports.NGAdministration:isPlayerInACL ( p, "Admin" ) or exports.NGAdministration:isPlayerInACL ( p, "Level 5" ) or exports.NGAdministration:isPlayerInACL ( p, "Console" ) ) then
		if ( p2 ) then
			local c = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
				if c then
					triggerClientEvent ( c, 'NGJobs:OpenJobMenu', c, 'drifter' )
				else exports['NGMessages']:sendClientMessage ( p2.." No existe. ", p, 255, 255, 0 ) end
		else exports['NGMessages']:sendClientMessage ( "Error, use /dardetective [jugador]", p, 255, 255, 0 ) end
	else  exports['NGMessages']:sendClientMessage ( "Error, tienes que ser administrador para usar este comando" , p, 255, 255, 0 ) end
end )



function createJobPickup ( x, y, z, id, jobs )
    local e = createPickup ( x, y, z, 2, id, 50, 4000)
    setElementData ( e, "NGJobs:pickup.jobLock", jobs )
    addEventHandler ( "onPickupHit", e, function ( p )
        if ( getElementType ( p ) ~= "player" or isPedInVehicle ( p ) ) then return end
        local jobs = getElementData ( source, "NGJobs:pickup.jobLock" )
        local job = getElementData ( p, "Job" ) or ""
        local done = false
        for i, v in ipairs ( jobs ) do
            if ( v == job ) then
                done = true
                break
            end
        end 
        if ( not done or isPedInVehicle ( p ) ) then
            if ( not isPedInVehicle ( p ) ) then
                exports['NGMessages']:sendClientMessage ( "You don't have access to this pickup.", p, 255, 255, 0 )
            end
            cancelEvent ( )
        end
    end )
end
createJobPickup ( 1576.18, -1620.43, 13.55, 3, { "Police Officer", "Detective" } )
createJobPickup ( 1177.97, -1319.01, 14.1, 42, { "Medic" } )
createJobPickup (-1059.44, -1213.04, 129.22, 9, { "Militar" } )





function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function table.nextIndex ( tab, i2 )
    local isTHis = false
    for i, v in pairs ( tab ) do
        if ( isThis ) then
            return i
        end
        if ( i == i2 ) then
            isThis = true
        end
    end
end


addEvent ( "NGJobs->GivePlayerMoney", true )
addEventHandler ( "NGJobs->GivePlayerMoney", root, function ( player, amount, msg ) 
	givePlayerMoney ( player, amount )
	if ( msg ) then
		exports.NGMessages:sendClientMessage ( msg, player, 0, 255, 0 )
	end
end )


addEvent ( "NGJobs->SQL->UpdateColumn", true )
addEventHandler ( "NGJobs->SQL->UpdateColumn", root, function ( player, column, to )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), column, to )
	
	local j = tostring ( getElementData ( player, "Job" ):lower ( ) )
	updateRank ( player, j )
	q = exports.NGSQL:db_query("SELECT `Username`, `Arrests`+`TimesArrested`+`CriminalActions`+`FixedVehicles`+`HealedPlayers`+`TowedVehicles`+`CaughtFish`/100+`SolvedCrims`+`completeflights`+`stunts`/100+`entregas`+`completeroutes`+`carreras`+`repartos` as total FROM jobdata WHERE `Username` = '"..getAccountName ( getPlayerAccount ( player ) ).."'")
	triggerClientEvent( player, "checkLvl", player, q); 
end )

addEvent ( "NGJobs:onPlayerJoinNewJob", true )

function foreachinorder(t, f, cmp)
    local keys = {}
    for k,_ in pairs(t) do
        keys[#keys+1] = k
    end
    table.sort(keys,cmp)
    local data = { }
    for _, k in ipairs ( keys ) do 
    	table.insert ( data, { k, t[k] } )
    end 
    return data
end

