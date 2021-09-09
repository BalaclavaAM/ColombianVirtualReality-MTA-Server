function createMoney(player)
	if (exports['CVRCapturaelCamion']:isPlayerInMinigame(source) ) then return end
   if ( getElementInterior(player) ~= 3 ) then
      local x, y, z = getElementPosition(player);
      local x1, y1, x2, y2;
      x1 = (x-2)+(math.random()*4);
      y1 = (y-2)+(math.random()*4);
      x2 = (x-2)+(math.random()*4);
      y2 = (y-2)+(math.random()*4);
      local moneyAmmount = getPlayerMoney(player);
      if moneyAmmount <0 then return end
      if getElementDimension(player)~=0 then return end
      -- it is not fair too get all the player money.
      moneyAmmount = math.floor(moneyAmmount/10);
 
      takePlayerMoney(player, moneyAmmount);
 
      -- We are going to create 3 pickups, zo we are just cut the ammount in half
      moneyAmmount = math.floor(moneyAmmount/3);
 
      -- Create the pickups
      local p1 = createPickup(x1, y1, z, 3, 1212)
      local p2 = createPickup(x2, y2, z, 3, 1212)
      local p3 = createPickup(x2-0.5, y2, z, 3, 1212)
      setElementData(p1, "ammount", moneyAmmount);
      setElementData(p2, "ammount", moneyAmmount);
      setElementData(p3, "ammount", moneyAmmount);
   end
end
 
function moneyPickupHit(player)
   local money = getElementData(source, "ammount");
   if money then
      givePlayerMoney(player, money);
      destroyElement(source);
   end
end

 
function playerJustGotDied(ammo, attacker, weapon, bodypart)
   if (exports['CVRCapturaelCamion']:isPlayerInMinigame(cPlayer) ) then return end
   createMoney(source);
end
 
addEventHandler("onPickupUse", getRootElement(), moneyPickupHit);
addEventHandler("onPlayerWasted", getRootElement(), playerJustGotDied);