addEvent ( "killP", true )
addEventHandler ( "killP", root, function ( )
	if (not getPlayerAccount(source)) then return end
	if (isGuestAccount ( getPlayerAccount(source) )) then return end  
	killPed ( source )
end )