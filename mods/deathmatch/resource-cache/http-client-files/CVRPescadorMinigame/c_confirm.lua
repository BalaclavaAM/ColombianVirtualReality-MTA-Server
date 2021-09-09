local W, H = guiGetScreenSize();
local _cancel;
local _confirm;
_renderingConfirm = false;
local _yes;
local _no;
local _text;

local width, height, btnwidth, btnheight = 370, 100, 120, 25;
local x, y = (W - width) / 2, (H - height) / 2;

function confirm (text, confirmFunc, cancelFunc)
    if _renderingConfirm then
        closeConfirm();
    end

    _yes = guiCreateButton(x+5, y+height-btnheight-5, btnwidth, btnheight, "Sisa", false);
    _no =  guiCreateButton(x+width-btnwidth-5, y+height-btnheight-5, btnwidth, btnheight, "Nocas", false);

    if text then _text = text end;
    if confirmFunc then _confirm = confirmFunc end;
    if cancelFunc then _cancel = cancelFunc end;

    addEventHandler("onClientGUIClick", _yes, function()
        _confirm();
        closeConfirm();
    end, false);

    addEventHandler("onClientGUIClick", _no, function()
        _cancel();
        closeConfirm();
    end, false);

    addEventHandler("onClientRender", root, renderPurchase);
    _renderingConfirm = true;
end

function closeConfirm ()
    if _renderingConfirm then
        removeEventHandler("onClientRender", root, renderPurchase);
        ------------
        _yes:destroy();
        _no:destroy();
        ------------
        _yes = nil;
        _no = nil;
        _confirm = nil;
        _cancel = nil;
        --------------
        _renderingConfirm = false;
    end
end

function renderPurchase ()
    dxDrawRectangle(x, y, width, height, tocolor(0, 0, 0, 165))
    dxDrawText(tostring(_text), 0, y, W, 0, tocolor(255, 255, 255, 255), 1.00, "clear", "center", "top", false, false, false, false, false)
end