local prefix = "#646464[#FFF700C#0042FFV#8A0202R#646464]#FFFFFF"
local gangTag = {}
--Utils
function getPlayerFromAccountName(name) 
    local acc = getAccount(name)
    if not acc or isGuestAccount(acc) then
        return false
    end
    return getAccountPlayer(acc)
end


function getRaces()
	local races=exports.NGSQL:db_query([[SELECT DISTINCT(race) FROM racedata; ]])
	local reraces={}
	for k,v in ipairs(races) do
		table.insert(reraces,races[k]['race'])
	end
	return reraces
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


function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end
--
function getClubName(id)
	local q = exports['NGSQL']:db_query ( "SELECT * FROM gang WHERE Id=? ", id)
	return q[1]['Nombre']
end


function asignarClub(player,id,rank)
	setElementData(player,"Club",getClubName(id))
	setElementData(player,"Club Rank",rank)
end

function existsClub(name)
	local q = exports['NGSQL']:db_query ( "SELECT * FROM gang WHERE Nombre=? ",name)
	if #q>0 then
		return true
	else
		return false
	end
end

function getClubId(name)
	local q = exports['NGSQL']:db_query ( "SELECT * FROM gang WHERE Nombre=? ",name)
	if #q>0 then
		return q[1]['Id']
	else
		return false
	end
end
function obtenerPlayerClub(player)
	if isElement(player) then
		local q = exports['NGSQL']:db_query ( "SELECT * FROM gangmembers WHERE Member=? ", tostring(getAccountName(getPlayerAccount(player))))
		if #q>0 then
			return q[1]
		else
			return false
		end
	end	
end
function obtenerAcclountClub(account)
	local q = exports['NGSQL']:db_query ( "SELECT * FROM gangmembers WHERE Member=? ", getAccountName(account))
	if #q>0 then
		return q
	else
		return false
	end
end

function obtenerAccountClub(player)
	if isElement(player) then
		local q = exports['NGSQL']:db_query ( "SELECT * FROM gangmembers WHERE Member=? ", player)
		if #q>0 then
			return q[1]['Id']
		else
			return false
		end
	end	
end


addEventHandler ( "onResourceStart", resourceRoot, function ( )
	exports['NGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS `gang` ( `Id` INT NOT NULL AUTO_INCREMENT, `R` INT NOT NULL,  `G` INT NOT NULL,  `B` INT NOT NULL, `Nombre` TEXT NOT NULL , `Tag` TEXT NOT NULL , `Creator` TEXT NOT NULL , PRIMARY KEY (`Id`)) ENGINE = InnoDB;" )
	exports['NGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS `gangmembers` ( `Id` INT NOT NULL, `Member` TEXT NOT NULL, `Rank` TEXT NOT NULL) ENGINE = InnoDB;" )

	local players = getElementsByType ( "player" )

	for key,player in ipairs(players) do
		local q = obtenerPlayerClub(player)
		if q~=false then
			asignarClub(player,q['Id'],q['Rank'])	
		end
	end

	local q = exports['NGSQL']:db_query ( "SELECT * FROM gang WHERE 1")
	for k,v in ipairs(q) do
		gangTag[v['Nombre']]=(RGBToHex(v['R'],v['G'],v['B'])..v['Tag'])
	end
end )

addEventHandler ( "onResourceStop", resourceRoot, function ( )
	local players = getElementsByType ( "player" )

	for key,player in ipairs(players) do
		removeElementData(player,"Club")
		removeElementData(player,"Club Rank")
	end
end )
--INSERT INTO `gang`(`Nombre`, `Tag`, `Creator`) VALUES ("Guaracha Drift Team","GDT","BalaclavaAM")
--exports['NGSQL']:db_exec ( "INSERT INTO `gangmembers`(`Id`,`Member`, `Rank`) VALUES (?,?)","BalaclavaAM","Lider" )



function crearClub(clubname,tag,r,g,b)
	if getPlayerMoney(source)>9999999 then
		if not (existsClub(clubname)) then
			local creator = source
			local boolcreated = exports['NGSQL']:db_exec ( "INSERT INTO `gang`(`Nombre`, `R`, `G`, `B`, `Tag`, `Creator`) VALUES (?,?,?,?,?,?)",clubname,r,g,b,tag,getAccountName(getPlayerAccount(creator)))
			if boolcreated then
				takePlayerMoney(source,10000000)
				outputChatBox ( prefix.."Has creado satisfactoriamente tu club "..RGBToHex(r,g,b)..clubname.."#FFFFFF con el tag "..RGBToHex(r,g,b)..(tag), creator, 255, 222, 0, true ) 
				local id = getClubId(clubname)
				anhadirAlClub(creator,id,"Creador")
				setElementData(creator,"Club",clubname)
				setElementData(creator,"Club Rank","Creador")
				gangTag[clubname]=tag
			else
				outputChatBox ( prefix.."Error creando el club", creator, 255, 0, 0, true ) 
			end
		else
			outputChatBox ( prefix.."Ya existe un club con ese nombre", creator, 255, 0, 0, true ) 
		end
	else
		outputChatBox ( prefix.."Para crear un club de drift debes tener mínimo 10 millones", source, 255, 0, 0, true ) 
	end
end
addEvent("CVRClub->CreateClub",true)
addEventHandler("CVRClub->CreateClub",root,crearClub)


function eliminarClub()
	local club = getElementData(source,"Club")
	if (existsClub(club)) then
		local idclub = getClubId(club)
		local booldeleted = exports['NGSQL']:db_exec ( "DELETE FROM `gang` WHERE `Id`=?",idclub)
		local q = getClubMembers(idclub)
		local booldeleted2 = exports['NGSQL']:db_exec ( "DELETE FROM `gangmembers` WHERE `Id`=?",idclub)
		for k,v in ipairs(q) do
			local playergang = getPlayerFromAccountName(v['Member'])
			if playergang then
				removeElementData(playergang,"Club")
				removeElementData(playergang,"Club Rank")
			end
		end
		if booldeleted and booldeleted2 then
			outputChatBox ( prefix.."Se ha eliminado correctamente el club", source, 255, 222, 0, true ) 
		else
			outputChatBox ( prefix.."Error creando el club", source, 255, 0, 0, true ) 
		end
	else
		outputChatBox ( prefix.."No existe el club que intentas eliminar", source, 255, 0, 0, true ) 
	end
end
addEvent("CVRClub->DeleteClub",true)
addEventHandler("CVRClub->DeleteClub",root,eliminarClub)

--exports['Scoreboard']:scoreboardAddColumn  ( "Club", root, 90, "Club", 4 )
--exports['Scoreboard']:scoreboardAddColumn  ( "Club Rank", root, 90, "Club Rank", 5 )


function handleLoginClub(thePreviousAccount, theCurrentAccount)
	local q = obtenerAcclountClub(theCurrentAccount)
	if q ~= false then
		for k,v in ipairs(q) do
			setElementData(source,"Club",getClubName(v['Id']))
			setElementData(source,"Club Rank",v['Rank'])
		end
	end
end
addEventHandler("onPlayerLogin",root,handleLoginClub)

local petitions={}

function enviarPeticion( p, _, p2, ... )
	if getElementData(p,"Club") then
		if getElementData(p,"Club Rank")=="Lider" or getElementData(p,"Club Rank")=="Creador" then
			if p2 then
				local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
				if toJ then
					if toJ~=p then
						if not(getElementData(toJ,"Club")) then
							if not(petitions[toJ]) then
								petitions[toJ]=p
								outputChatBox(prefix.."Invitaste a #00F5F5"..getPlayerName(toJ).."#FFFFFF a tu club de drift!.",p,255,232,0,true)
								outputChatBox(prefix.."#00F5F5"..getPlayerName(p).."#FFFFFF te ha invitado al club de drift #00F5F5"..getElementData(p,"Club").."#FFFFFF usa #34FF02/aceptarclub #FFFFFF(en 20 sg la petición se #FF0202eliminará#FFFFFF)",toJ,255,0,0,true)
								setTimer(function()
									petitions[toJ]=nil
								end, 30000, 0)
							else
								outputChatBox(prefix.."Este jugador tiene una petición pendiente",p,255,0,0,true)
							end
						else
							outputChatBox(prefix.."Este está en el club #00F5F5"..getElementData(toJ,"Club").."#FFFFFF por lo tanto no puedes enviarle peticiones",p,255,0,0,true)
						end
					else
						outputChatBox( "Hermano cómo te vas a dar club a tí mismo", p, 255, 0, 0,true)
					end
				else
					outputChatBox( "El usuario "..p2.." no existe o no está conectado", p, 255, 0, 0,true)
				end
			else
				outputChatBox( prefix.."La sintaxis del CMD es /darclub [Usuario]", p, 255, 0, 0,true)
			end
		else
			outputChatBox( "Tienes que ser líder del club para añadir nuevos miembros", p, 255, 0, 0,true)
		end
	else
		outputChatBox( "Usted no posee club", p, 255, 0, 0,true)
	end
end
addCommandHandler("darclub",enviarPeticion)

function anhadirAlClub(p,id,rank)
	if p and id and rank then
		exports['NGSQL']:db_exec ( "INSERT INTO `gangmembers`(`Id`,`Member`, `Rank`) VALUES (?,?,?)",id,getAccountName(getPlayerAccount(p)),rank)
		asignarClub(p,id,rank)
	end
end


function recibirPeticion( p )
	if petitions[p] then
		if not(getElementData(p,"Club")) then
			if isElement(petitions[p]) then
				local queryclub=obtenerPlayerClub(petitions[p])
				if queryclub then
					anhadirAlClub(p,queryclub['Id'],"Miembro")	
					outputChatBox(prefix.."#00F5F5"..getPlayerName(p).."#FFFFFF se ha unido al club de drift",petitions[p],255,0,0,true)
					outputChatBox(prefix.."Te has unido al club de drift #00F5F5"..getElementData(p,"Club").."#FFFFFF!",p,255,0,0,true)
				end
			else
				outputChatBox(prefix.."Quien te envió la petición salió del server, pídele que entre y te reenvíe la invitación!.",p,255,232,0,true)
			end
		else
			outputChatBox(prefix.."Ya te uniste a un club!.",p,255,232,0,true)
		end
	else
		outputChatBox(prefix.."No tienes peticiones pendientes, pide que te la reenvíen!.",p,255,232,0,true)
	end
end
addCommandHandler("aceptarclub",recibirPeticion)

function getClubMembers(id)
	local q = exports['NGSQL']:db_query("SELECT * FROM `gangmembers` WHERE `Id`=?",id)
	if #q>0 then
		return q
	else
		return false
	end
end

function feedClient(club)
	if existsClub(club) then
		local id = getClubId(club)
		local q = getClubMembers(id)
		local races = getRaces()
		local puntaje = 0
		for k,v in ipairs(races) do
			puntaje=puntaje+getBestClubPointsRace(v,club)
		end
		if q~=false then
			triggerClientEvent(source,"CVRClubs->feedTheClient",source,q,puntaje)	
		end
	end
end
addEvent("CVRClubs->requestFeed",true)
addEventHandler("CVRClubs->requestFeed",root,feedClient)

function giveLeader(leader)
	local club = getElementData(source,"Club")
	if club == getElementData(source,"Club") then
		if getPlayerFromAccountName(leader) then
			setElementData(getPlayerFromAccountName(leader),"Club Rank","Lider")
			outputChatBox(prefix.."Te han otorgado el rango de líder en el club "..club..", felicidades!",getPlayerFromAccountName(leader),255,0,0,true)
		end
		local boolean = exports['NGSQL']:db_exec ("UPDATE `gangmembers` SET `Rank`=? WHERE `Member`=?","Lider",leader)
		if boolean then
			outputChatBox(prefix.."Se ha asignado correctamente el rango para este miembro.",source,255,0,0,true)
		end
	else
		outputChatBox(prefix.."Error, ustedes dos no están en la misma gang, refresca el panel.",source,255,0,0,true)
	end
end
addEvent("CVRClubs->updateLeader",true)
addEventHandler("CVRClubs->updateLeader",root,giveLeader)

function updateTag(newTag,r,g,b)
	local club = getElementData(source,"Club")
	if club then
		local id = getClubId(club)
		local boolean = exports['NGSQL']:db_exec ("UPDATE `gang` SET `R`=?,`G`=?,`B`=?,`Tag`=? WHERE Id=?",r,g,b,newTag,id)
		gangTag[club]=(RGBToHex(r,g,b)..newTag)
		if boolean then
			outputChatBox(prefix.."Se ha actualizado el tag de tu gang. Ahora es "..RGBToHex(r,g,b)..newTag,source,255,0,0,true)
		end
	end
end
addEvent("CVRClubs->updateTag",true)
addEventHandler("CVRClubs->updateTag",root,updateTag)

function getClubTag(club)
	return gangTag[club]
end

function exitGang()
	local booldeleted2 = exports['NGSQL']:db_exec ( "DELETE FROM `gangmembers` WHERE `Member`=?",getAccountName(getPlayerAccount(source)))
	removeElementData(source,"Club")
	removeElementData(source,"Club Rank")
	if booldeleted2 then
		outputChatBox(prefix.."Has salido satisfactoriamente del club",source,255,0,0,true)
	end
end
addEvent("CVRClubs->exitGang",true)
addEventHandler("CVRClubs->exitGang",root,exitGang)

function kickGang(member)
	if (getElementData(source,"Club Rank")=="Lider" or getElementData(source,"Club Rank")=="Creador") then
		local booldeleted2 = exports['NGSQL']:db_exec ( "DELETE FROM `gangmembers` WHERE `Member`=?",member)
		if getPlayerFromAccountName(member) then
			removeElementData(getPlayerFromAccountName(member),"Club")
			removeElementData(getPlayerFromAccountName(member),"Club Rank")
			if booldeleted2 then
				outputChatBox(prefix.."Te han sacado del club de drift",getPlayerFromAccountName(member),255,0,0,true)
			end
		end
		if booldeleted2 then
			outputChatBox(prefix.."Sacaste al miembro de tu club.",source,255,0,0,true)
		end
	end
end
addEvent("CVRClubs->kickGang",true)
addEventHandler("CVRClubs->kickGang",root,kickGang)