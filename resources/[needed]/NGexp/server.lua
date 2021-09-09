function queryExp(user)
	acc =  getPlayerAccount(user)
	name = getAccountName(acc)
	q3 = exports.NGSQL:db_query("SELECT `Username`, `Arrests`+`TimesArrested`+`CriminalActions`+`FixedVehicles`+`HealedPlayers`+`TowedVehicles`+`CaughtFish`/100+`SolvedCrims`+`completeflights`+`stunts`/100 +`entregas`+`completeroutes`+`carreras` as total FROM jobdata WHERE `Username` = '"..name.."'")
	q1 = exports.NGSQL:db_query("SELECT `Username`, `Arrests`+`TimesArrested`+`CriminalActions`+`FixedVehicles`+`HealedPlayers`+`TowedVehicles`+`CaughtFish`/100+`SolvedCrims`+`completeflights`+`stunts`/100 +`entregas`+`completeroutes`+`carreras` as total FROM jobdata ORDER BY total DESC LIMIT 30")
	q2 =exports.NGSQL:db_query("SELECT * FROM `bank_accounts` ORDER BY `bank_accounts`.`Balance` DESC LIMIT 30") 
	q4 = exports.NGSQL:db_query("SELECT `Username`,`events` FROM jobdata ORDER BY events DESC LIMIT 30")
	q5 = exports.NGSQL:db_query("SELECT `Username`,`duelos` FROM jobdata ORDER BY duelos DESC LIMIT 30")
	killsinfo = exports.NGSQL:db_query("SELECT `Username`, `Kills`,`Deaths`, (`Kills`/`Deaths`) FROM `accountdata` WHERE 1 ORDER BY Kills DESC LIMIT 50")
	tomboinfo = exports.NGSQL:db_query("SELECT `Username`, `Arrests` FROM `jobdata` ORDER BY `Arrests` DESC LIMIT 50")
	driftinfo = exports.NGSQL:db_query("SELECT `Username`,`DriftPoints` FROM `jobdata` ORDER BY `DriftPoints` DESC LIMIT 30")
	puntajescontrareloj = queryClub()
	triggerClientEvent ( user, "updateExpClient", user, q1,q2,q3,q4,q5,killsinfo,tomboinfo,driftinfo,puntajescontrareloj )

end
addEvent ( "serverQueryExp", true )
addEventHandler ( "serverQueryExp", root, queryExp )

function getRaces()
	local races=exports.NGSQL:db_query([[SELECT DISTINCT(race) FROM racedata; ]])
	local reraces={}
	for k,v in ipairs(races) do
		table.insert(reraces,races[k]['race'])
	end
	return reraces
end

function getClubs()
	local clubs=exports.NGSQL:db_query([[SELECT DISTINCT(Nombre) FROM gang; ]])
	local reclubs={}
	for k,v in ipairs(clubs) do
		table.insert(reclubs,clubs[k]['Nombre'])
	end
	return reclubs
end

function getBestClubPointsRace(race,club)
    local data,quantity = exports['NGSQL']:db_query ( "SELECT * FROM racedata WHERE race=? ORDER BY `besttime` ASC LIMIT 20", race )
    local retorno = 0
    if ( type ( data ) == "table" and #data >0 ) then
        for k,v in ipairs(data) do
            local gang=data[k]['club']
            if gang==club then
                local points=tonumber(data[k]['besttime'])
                retorno=retorno+(data[quantity]['besttime']/points)
            end
        end
    end
    return retorno
end



function queryClub()
	local races=getRaces()
	local clubs=getClubs()
	local puntajes={}
	for k2,club in ipairs(clubs) do
		if not(puntajes[club]) then
			puntajes[club]=0
		end
		for k,race in ipairs(races) do
			puntajes[club]=puntajes[club]+getBestClubPointsRace(race,club)
		end
	end
	local arreglo={}
	for club,puntaje in pairs(puntajes) do
		table.insert(arreglo,{club,puntaje})
	end
	return arreglo
end