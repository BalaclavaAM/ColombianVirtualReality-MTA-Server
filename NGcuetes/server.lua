function takeCueteMoney (  )
	-- the predefined variable 'client' points to the player who triggered the event and should be used due to security issues   
	takePlayerMoney(client, 10000)
end
addEvent( "takeCueteServerMoney", true )
addEventHandler( "takeCueteServerMoney", resourceRoot, takeCueteMoney ) 