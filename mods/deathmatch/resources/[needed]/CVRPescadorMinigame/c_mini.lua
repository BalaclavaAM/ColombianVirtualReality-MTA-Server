-- minigame you need to complete after you reel a fish in order to catch it. you can disable this in fishlist.lua
-- balığı çektikten sonra küçük bir oyun tamamlamamızı gerektiren script. fishlist.lua dosyasından devre dışı bırakılabilir.

SELECTED_FISH = nil; 

local inMinigame = false;

local W, H = guiGetScreenSize ();

-- variables for rendering.
local x, y = 900, 350; 

local windW, windH = 32, 255
local rodW, rodH = 128, 205; 
local progW, progH = 20, 255; 
local fishW, fishH = 32, 32; 
local hookW, hookH = 32, 76;

local progress;
local progress_speed = 0.0065 / 16; 
local progress_down_speed = 0.0025 / 16;

local fish_position;
local fish_speed = 0.01; 

local hook_position;
local hook_up_speed = 0.02 / 16;
local hook_down_speed = 0.01 / 16; 

x, y = (W - rodW - windW - progW)/2, H*.3

local start_tick;

local fish_rot = 0; 

running = false;

function play_reel_sounds (b, c)
    if b == FISHING_KEY or b == FISHING_KEY_2 then
        if not c then return end; 
        local a = math.random(1, 5);
        local s = playSound("sound/reel"..a..".mp3");
    end
end

function enableMinigame( enabled )
    if ( enabled ) then
        if not running then
            if getElementData(localPlayer,"Job")~="Fisherman" then return outputChatBox("Tienes que ser pescador para jugar este minijuego",255,255,0) end
            hook_position = math.random(1, 9)/10;
            fish_position = math.random(3, 5)/10;

            SELECTED_FISH = fish[ math.random(#fish) ];

            progress = .35;
            start_tick = getTickCount(); 
            addEventHandler( "onClientPreRender", root, renderMinigame );
            inMinigame = true;
            running = true;
            fish_rot = math.random(180)

            addEventHandler("onClientKey", root, play_reel_sounds);
        end
    else
        removeEventHandler( "onClientPreRender", root, renderMinigame );
        removeEventHandler("onClientKey", root, play_reel_sounds);
        inMinigame = false;
        running = false;
    end
end


function toggleMinigame()
    enableMinigame( not inMinigame );
end


-- colors
local pink = "#ff41a6";
local blue = "#00bbff";
local red = "#ff3737";
local white = "#ffffff";
local green = "#37ff76";
--

function renderMinigame(dt)

     dxDrawImage(x+25, y+95, 64, 64, "img/"..SELECTED_FISH.icon, fish_rot );
     dxDrawImage(x-55, y, rodW, rodH, "img/rod.png");

     dxDrawRectangle(x+rodW, y, windW, windH, tocolor(0, 188, 255, 165));

     local hook_y = y + (windH * hook_position);
     if hook_y + hookH >= y + windH then
         hook_y = y + windH - hookH;
     end

     hook_position = hook_position + (hook_down_speed*dt);

    dxDrawRectangle( x+rodW+3, hook_y, hookW-6, hookH, tocolor(0, 255, 0, 165) )

    local fish_y = y + (windH * fish_position);
    if fish_y + fishH >= y + windH then
        fish_y = y + windH - fishH;
    end

    fish_position = fish_position + ( fish_speed * ( math.random(-1, 1) ) );

    dxDrawImage( x+rodW, fish_y, fishW, fishH, "img/"..SELECTED_FISH.icon )

    dxDrawRectangle(x+rodW+windW, y, progW, progH, tocolor(0, 0, 0, 165));
    dxDrawRectangle(x+rodW+windW+3, (y + progH) - progH*progress, progW-6, progH*progress, tocolor(0, 255, 0, 165));

    local is_over = isRectangleOverRectangle( x+rodW+3, fish_y, fishW-6, fishH, x+rodW+3, hook_y, hookW-6, hookH );

    if ( is_over ) then 
        progress = progress + (progress_speed*dt);
        if progress > 1 then progress = 1; end
    else
        progress = progress - (progress_down_speed*dt);
    end

    if ( getKeyState( FISHING_KEY_2 ) or getKeyState(FISHING_KEY) ) then 
        hook_position = hook_position - (hook_up_speed*dt);
    
    end

    if hook_position > .7 then hook_position = .7; end
    if hook_position < 0 then hook_position = 0; end  

    if fish_position > 1 then fish_position = 1; end
    if fish_position < 0 then fish_position = 0; end 

    local text = pink.."Atrapaste un " .. white..(SELECTED_FISH.display_name or SELECTED_FISH.name) .."!" .. pink .. " Mantiene "..white.."'"..FISHING_KEY.."'"..white.." o '"..FISHING_KEY_2.."' "..pink.."' para atraparlo!";
    local text_nocc = "Atrapaste un " .. (SELECTED_FISH.display_name or SELECTED_FISH.name) .. "! Mantiene '"..FISHING_KEY.."' o '"..FISHING_KEY_2.."' para atraparlo!";

    local tx, ty, tw, wh = (x+rodW)*2, (y-20)-(15*progress), windW, windH;
    dxDrawText(tostring( text_nocc ), tx+1, ty+1, tw+1, wh+1, tocolor(0, 0, 0, 255), 1.00 + (.5*progress), "clear", "center", "top", false, false, false, false, false);
    dxDrawText(tostring( text ),      tx,   ty,   tw,   wh,   tocolor(255, 255, 255, 255), 1.00 + (.5*progress), "clear", "center", "top", false, false, false, true, false);

    if progress >= 1 then
        triggerEvent("fish:onMinigameCompleted", localPlayer, getTickCount() - start_tick);
    end

    if progress <= 0 then
        triggerEvent("fish:onMinigameFailed", localPlayer, getTickCount() - start_tick);
    end
end

function isRectangleOverRectangle ( x1, y1, w1, h1, x2, y2, w2, h2 )
	return ( ( x1 >= x2 and x1 <= x2 + w2 ) and ( y1 >= y2 and y1 <= y2 + h2 ) );
end


addEvent("fish:onMinigameCompleted")
addEventHandler("fish:onMinigameCompleted", root, function ()
    enableMinigame(false);
    running = false;
end );

addEvent("fish:onMinigameFailed")
addEventHandler("fish:onMinigameFailed", root, function ()
    enableMinigame(false);
    running = false;
    doAnim(nil, nil);
end );