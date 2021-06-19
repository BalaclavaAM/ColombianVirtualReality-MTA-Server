local momo=false
function modofoto()
    if not momo then
        setPlayerHudComponentVisible ( "all", false )
        showChat ( false )
        local players = getElementsByType ( "player" ) -- Store all the players in the server into a table
        for key, player in ipairs ( players ) do       -- for all the players in the table
            setPlayerNametagShowing ( player, false )  -- turn off their nametag
        end
        momo=true
    else
        setPlayerHudComponentVisible ( "all", true )
        showChat ( true )
        local players = getElementsByType ( "player" ) -- Store all the players in the server into a table
        for key, player in ipairs ( players ) do       -- for all the players in the table
            setPlayerNametagShowing ( player, true )  -- turn off their nametag
        end
        momo=false
    end
end
addCommandHandler("modofoto",modofoto)




--[[
Press 'M' to show the cursor.
Double click on the map to mark the position
Double click again to remove the mark!
By M7mdAl7arthy
]]

local blipMark
local fScreen = { guiGetScreenSize( ) };
local bind = 'M' -- bind show the cursor 

addEventHandler( 'onClientDoubleClick', getRootElement( ),
	function( button, absoluteX, absoluteY )
		if not isPlayerMapVisible( ) then return end
		local minX, minY, maxX, maxY = getPlayerMapBoundingBox( )
		if( absoluteX >= minX and absoluteX <= ( minX + ( maxX-minX ) ) )and( absoluteY >= minY and absoluteY <= ( minY + ( maxY-minY ) ) )then
			if isElement( blipMark ) then
				local retDestroy =  destroyElement( blipMark )
				if retDestroy then
					-- outputChatBox( '* You removed the mark from your radar!', 255, 0, 0 )
				end
				return
			end
			blipMark = createBlip( 
				( ( ( absoluteX - minX ) / ( maxX - minX ) ) * 6000 - 3000 ),
				( 3000 - ( ( absoluteY - minY ) / ( maxY-minY)  ) * 6000 ),
				0, 41
			)
			if blipMark then
				-- outputChatBox( '* You successfully placed a mark on your radar!', 0, 255, 0 )
			end
		end
	end
);

addEventHandler( 'onClientRender', getRootElement( ),
    function( )
		if not isPlayerMapVisible( ) then return end
        dxDrawText( 'Presione #ffff00\'' .. bind .. '\' #ffffffpara mostrar el cursor. \n Haga doble clic en el mapa para marcar la posición. \n ¡Haz doble clic de nuevo para eliminar la marca!',
		(fScreen[1]/1), (fScreen[2]/0.6), 0, 0,
		tocolor( 255, 255, 255, 255 ),
		1.2, 'default', 'center', 'center',
		false, true, false, true, false )
		--dxDrawText( string text, float left, float top [, float right=left, float bottom=top, int color=white,                   float scale=1, mixed font="default", string alignX="left", string alignY="top",                  bool clip=false, bool wordBreak=false, bool postGUI=false,                  bool colorCoded=false, bool subPixelPositioning=false,                   float fRotation=0, float fRotationCenterX=0, float fRotationCenterY=0 ] )
    end
);