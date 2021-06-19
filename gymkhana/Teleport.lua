local posicoes =
    {
        {  -2091.2104492188, 1796.537109375, 2.2999999523163 },
        {  -2091.2104492188, 1796.537109375, 2.2999999523163 },
        {  -2091.2104492188, 1796.537109375, 2.2999999523163 },
    }
	
function PosicaoPlayer ( thePlayer, command )
    local azar = math.random ( #posicoes )
	local veh = getPedOccupiedVehicle(thePlayer)
		if (veh) then
			setElementPosition(veh, unpack ( posicoes [ azar ] ) )
		else
			setElementPosition(thePlayer, unpack ( posicoes [ azar ] ) )
		end	
			outputChatBox ( "#FFFFFF[#00FF00Tele#FFFFFF] ".. getPlayerName(thePlayer) .." #FFFFFFFue para la pista drift4 (#00FF00/drift4#FFFFFF)", root, 0, 255, 0, true )
end
addCommandHandler ( "drift4", PosicaoPlayer  )

