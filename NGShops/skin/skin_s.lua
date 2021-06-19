addEvent ( "NGShops:Skins:ResetPlayerSkin", true )
addEventHandler ( "NGShops:Skins:ResetPlayerSkin", root, function ( )
	setElementModel ( source, getElementModel ( source ) ) 
end )

addEvent ( "NGShops:Skin:UpdatePlayerDefaultSkin", true )
addEventHandler ( "NGShops:Skin:UpdatePlayerDefaultSkin", root, function ( s, price )
	local account = getPlayerAccount(source)
	local t = getPlayerTeam ( source )
	local cur = tonumber ( getElementData ( source, "NGUser.UnemployedSkin" ) ) or 28
	local tabla = getAccountData ( account, "skinscompradas" ) or toJSON({})
	tabla = fromJSON(tabla)
	local posee = false
	for k,v in ipairs(tabla) do
		if v == s then
			posee=true
		end
	end
	if ( posee ~= true ) then
		if not price then 
			price=0
		end
		if s == 230 then
			if getPlayerMoney ( source ) < 100000 then outputChatBox("Esta skin vale 100k!") end
			takePlayerMoney ( source, 100000 )
		else
			takePlayerMoney (source, price)
		end
		exports.NGMessages:sendClientMessage ( "Compraste un skin nuevo! Id:"..s.." por: "..tostring(price), source, 0, 255, 0 )
		setElementData ( source, "NGUser.UnemployedSkin", s )
		table.insert(tabla,s)
		setAccountData ( account, "skinscompradas", toJSON(tabla) )
		if ( getElementModel ( source ) == cur ) then
			setElementModel ( source, s )
		else
			exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
		end
	else
		setElementData ( source, "NGUser.UnemployedSkin", s )
		exports.NGMessages:sendClientMessage ( "Ya tenías esa skin! Id:"..s, source, 0, 255, 0 )
		if ( getElementModel ( source ) == cur ) then
			setElementModel ( source, s )
		else
			exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
		end
	end
end )

local cooldown = {}

addCommandHandler ( "darskin", function ( p, _, p2, s )
	if ( exports.NGAdministration:isPlayerInACL ( p, "Admin" ) or getAccountName((getPlayerAccount(p)))=="XohyanGuaracha" or  exports.NGAdministration:isPlayerInACL ( p, "Level 4" ) or exports.NGAdministration:isPlayerInACL ( p, "Console" ) ) then
		if ( p2 ) then
			local c = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
				if c then
					setElementModel ( getPlayerFromName(p2), s )
					setElementData ( getPlayerFromName(p2), "NGUser.UnemployedSkin", s )
				else exports['NGMessages']:sendClientMessage ( p2.." No existe. ", p, 255, 255, 0 ) end
		else exports['NGMessages']:sendClientMessage ( "Error, use /darskin [jugador] [skin]", p, 255, 255, 0 ) end
	else  exports['NGMessages']:sendClientMessage ( "Error, tienes que ser administrador para usar este comando" , p, 255, 255, 0 ) end
end )

function openExternalSkinPanel()
	p=source
	if not cooldown[p] or getTickCount()-cooldown[p]>=300000 then
		if not (exports['NGPolice']:isPlayerJailed(p)) and (getElementData(p,"Job")=="UnEmployed" or getElementData(p,"Job")=="Criminal" or getElementData(p,"Job")=="Drifter") then
			local account = getPlayerAccount( p )
			local skinscompradas = getAccountData(account,"skinscompradas") or toJSON{"None"}
			skinscompradas = fromJSON(skinscompradas)
			local posee = false
			for k,v in ipairs(skinscompradas) do
				if v == tonumber(s) then
					posee=true
				end
			end
			triggerClientEvent( p, "NGShop::GuiSkin",p, skinscompradas )
			cooldown[p]=getTickCount()
		end
	end
end
addEvent("NGShop>OpenSkinPanel",true)
addEventHandler("NGShop>OpenSkinPanel",root,openExternalSkinPanel)

addCommandHandler ( "ponerskin", function ( p, _, s )
	if not cooldown[p] or getTickCount()-cooldown[p]>=300000 then
		if not (exports['NGPolice']:isPlayerJailed(p)) and (getElementData(p,"Job")=="UnEmployed" or getElementData(p,"Job")=="Criminal" or getElementData(p,"Job")=="Drifter") then
			local cur = tonumber ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 28
			local account = getPlayerAccount( p )
			local skinscompradas = getAccountData(account,"skinscompradas") or toJSON{"None"}
			skinscompradas = fromJSON(skinscompradas)
			local posee = false
			for k,v in ipairs(skinscompradas) do
				if v == tonumber(s) then
					posee=true
				end
			end
			if s then
				if ( posee )  then
					setElementData ( p, "NGUser.UnemployedSkin", s )
					if ( getElementModel ( p ) == cur ) then
						setElementModel ( p, s )
						cooldown[p]=getTickCount()
					else
						exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
					end
				else
					exports['NGMessages']:sendClientMessage ( "Error, no tienes la skin comprada" , p, 255, 255, 0 )
				end
			else 
				triggerClientEvent( p, "NGShop::GuiSkin",p, skinscompradas )
				cooldown[p]=getTickCount()
			end
		else
			outputChatBox("Para cambiar tu skin sal de tu trabajo o de la cárcel",p,255,0,0,false)
		end
	else
		outputChatBox("Solo te puedes cambiar la skin cada 5 minutos",p,255,0,0,true)
	end
end )

addCommandHandler ( "skinesmeralda", function ( p, _, s )
	if getElementData(p,"VIP")=="Esmeralda" or getAccountName((getPlayerAccount(p)))=="ReizerB" then
		if not cooldown[p] or getTickCount()-cooldown[p]>=30000 then
			local cur = tonumber ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 28
			local account = getPlayerAccount( p )
			local skinscompradas = {122,123,124,126,128,131,164,166,167,168}
			local posee = false
			for k,v in ipairs(skinscompradas) do
				if v == tonumber(s) then
					posee=true
				end
			end
			if s then
				if ( posee )  then
					setElementData ( p, "NGUser.UnemployedSkin", s )
					if ( getElementModel ( p ) == cur ) then
						setElementModel ( p, s )
						cooldown[p]=getTickCount()
					else
						exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
					end
				else
					exports['NGMessages']:sendClientMessage ( "Error, esa skin no es de VIP esmeralda." , p, 255, 255, 0 )
				end
			else 
				exports['NGMessages']:sendClientMessage ( "Error: formato: /ponerskin skin(id)" , p, 255, 255, 0 ) 
				outputChatBox("Las skins del VIP Esmeralda (Seleccionadas por los Bundle) son: "..table.concat(skinscompradas,", "), p, 255, 255, 0)
				triggerClientEvent( p, "NGShop::GuiSkinesmeralda",p, skinscompradas )
				cooldown[p]=getTickCount()
			end
		else
			outputChatBox("Solo te puedes cambiar la skin cada 30 segundos",p,255,0,0,true)
		end
	else
		outputChatBox("Este comando es para vip esmeralda",p,255,0,0,true)
	end
end )

addCommandHandler ( "skingang", function ( p )
	if not cooldown[p] or getTickCount()-cooldown[p]>=300000 then
		local cur = tonumber ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 28
		local account = getPlayerAccount( p )
		local s = false
		if exports['NGGroups']:getPlayerGroup(p)=="2cB" then
			s=132
		elseif exports['NGGroups']:getPlayerGroup(p)=="AUC" then
			s=171
		elseif exports['NGGroups']:getPlayerGroup(p)=="EVG" then
			s=299
		elseif exports['NGGroups']:getPlayerGroup(p)=="Ghost Turfers" then
			s=189
		elseif exports['NGGroups']:getPlayerGroup(p)=="Los Zetas Cali" then
			s=141
		elseif exports['NGGroups']:getPlayerGroup(p)=="CapuGang" then
			s=190
		elseif exports['NGGroups']:getPlayerGroup(p)=="Krips セ" then
			s=297
		elseif exports['NGGroups']:getPlayerGroup(p)=="ELN BLOQUE 4" then
			s=184
		elseif exports['NGGroups']:getPlayerGroup(p)=="Ak47" then
			s=270
		elseif exports['NGGroups']:getPlayerGroup(p)=="ClanD'Golfo" then
			s=200
		elseif getElementData(p,"Club")=="AUC" then
			s=44
		end
		if s then
				setElementData ( p, "NGUser.UnemployedSkin", s )
				if ( getElementModel ( p ) == cur ) then
					setElementModel ( p, s )
					cooldown[p]=getTickCount()
				else
					exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
				end
		else exports['NGMessages']:sendClientMessage ( "Tu gang no tiene skin personalizada, don momos" , p, 255, 255, 0 ) end
	else
		outputChatBox("Solo te puedes cambiar la skin cada 5 minutos",p,255,0,0,true)
	end
end )

addCommandHandler ( "skinclub", function ( p )
	if not cooldown[p] or getTickCount()-cooldown[p]>=300000 then
		local cur = tonumber ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 28
		local account = getPlayerAccount( p )
		local s = false
		if getElementData(p,"Club")=="Guaracha Drift Team" then
			s=44
		end
		if s then
				setElementData ( p, "NGUser.UnemployedSkin", s )
				if ( getElementModel ( p ) == cur ) then
					setElementModel ( p, s )
					cooldown[p]=getTickCount()
				else
					exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
				end
		else exports['NGMessages']:sendClientMessage ( "Tu club no tiene skin personalizada, don momos" , p, 255, 255, 0 ) end
	else
		outputChatBox("Solo te puedes cambiar la skin cada 5 minutos",p,255,0,0,true)
	end
end )

addCommandHandler ( "skingang2", function ( p )
	if not cooldown[p] or getTickCount()-cooldown[p]>=300000 then
		local cur = tonumber ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 28
		local account = getPlayerAccount( p )
		local s = false
		--if exports['NGGroups']:getPlayerGroup(p)=="2cB" then
			--s=230
		--end
		if s then
				setElementData ( p, "NGUser.UnemployedSkin", s )
				if ( getElementModel ( p ) == cur ) then
					setElementModel ( p, s )
					cooldown[p]=getTickCount()
				else
					exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
				end
		else exports['NGMessages']:sendClientMessage ( "Tu gang no tiene skin personalizada, don momos" , p, 255, 255, 0 ) end
	else
		outputChatBox("Solo te puedes cambiar la skin cada 5 minutos",p,255,0,0,true)
	end
end )

addCommandHandler ( "skinpersonal", function ( p )
	if not cooldown[p] or getTickCount()-cooldown[p]>=300000 then
		local cur = tonumber ( getElementData ( p, "NGUser.UnemployedSkin" ) ) or 28
		local account = getPlayerAccount( p )
		local s = false
		if getAccountName(account)=="lizcanogang" then
			s=120
		end
		if getAccountName(account)=="iMegu" then
			s=152
			exports['NGMessages']:sendClientMessage ( "Papu megu :v" , p, 255, 255, 0 )
		end
		if getAccountName(account)=="XohyanGuaracha" then
			s=212
			exports['NGMessages']:sendClientMessage ( "COOMO?" , p, 255, 255, 0 )
		elseif getAccountName(account)=="BalaclavaAM" then
			s=268
			exports['NGMessages']:sendClientMessage ( "Balaclava skin" , p, 255, 255, 0 )
		elseif getAccountName(account)=="DannyUnU" then
			s=215
			exports['NGMessages']:sendClientMessage ( "Te odio perro malparido" , p, 255, 255, 0 )
		elseif getAccountName(account)=="Aluna" then
			s=191
			exports['NGMessages']:sendClientMessage ( "Te amo <tres" , p, 255, 255, 0 )
		elseif getAccountName(account)=="ReizerB" then
			s=125
			exports['NGMessages']:sendClientMessage ( "Skin personal ReizerB" , p, 255, 255, 0 )
		elseif getAccountName(account)=="Klausen" then
			s=169
			exports['NGMessages']:sendClientMessage ( "Q recochita" , p, 255, 255, 0 )
		elseif getAccountName(account)=="lauraaa" then
			s=251
			exports['NGMessages']:sendClientMessage ( "Doña hp" , p, 255, 255, 0 )
		elseif getAccountName(account)=="Jimenez" then
			s=254
			exports['NGMessages']:sendClientMessage ( "Don maricon" , p, 255, 255, 0 )
		elseif getAccountName(account)=="Brayan_Sneyder" then
			s=162
			exports['NGMessages']:sendClientMessage ( "q recocha con los founders" , p, 255, 255, 0 )
		elseif getAccountName(account)=="DokiC4C0RR0" then
			s=182
			exports['NGMessages']:sendClientMessage ( "q recocha con los founders" , p, 255, 255, 0 )
		end
		if s then
				setElementData ( p, "NGUser.UnemployedSkin", s )
				if ( getElementModel ( p ) == cur ) then
					setElementModel ( p, s )
					cooldown[p]=getTickCount()
				else
					exports.NGMessages:sendClientMessage ( "Para cambiar tu skin sal de tu trabajo con /resign", source, 255, 255, 0 )
				end
		else exports['NGMessages']:sendClientMessage ( "Tú no tienes skin personalizada" , p, 255, 255, 0 ) end
	else
		outputChatBox("Solo te puedes cambiar la skin cada 5 minutos",p,255,0,0,true)
	end
end )

function ponerRopa(clothesType)
	setElementModel(source,0)
	local clothesTexture, clothesModel = getClothesByTypeIndex(0,clothesType)
	addPedClothes ( source, clothesTexture, clothesModel, 0 )
end
addEvent("NGShops:ponerRopa",true)
addEventHandler("NGShops:ponerRopa",root,ponerRopa)

function quitarRopa(skin)
	setElementModel(source,skin)
	addPedClothes ( source, "vestblack", "vest", 0 )
end
addEvent("NGShops:quitarRopa",true)
addEventHandler("NGShops:quitarRopa",root,quitarRopa)

function actualizarCamiseta(camiseta,price)
	setElementModel(source,0)
	local clothesTexture, clothesModel = getClothesByTypeIndex(0,camiseta)
	addPedClothes ( source, clothesTexture, camiseta, 0 )
	takePlayerMoney(source,price)
end
addEvent("NGShops:Skin:UpdateTShirt",true)
addEventHandler("NGShops:Skin:UpdateTShirt",root,actualizarCamiseta)