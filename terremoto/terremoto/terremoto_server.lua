loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local timer = {};
local LSTerremoto = false;
local TerremotoTiempo = 10; -- segundos, son 2 dias
local TerremotoDuracion = 30;

addEventHandler("onResourceStart", resourceRoot, function()
	startTimer();
end);

function startTimer()
	timerTerremoto = setTimer (desminuirTimer, 1000, 0);
end

function desminuirTimer()
	if LSTerremoto == false then
		if TerremotoTiempo == 0 then
			for i, v in ipairs(Element.getAllByType("player")) do
				if not notIsGuest( v ) then
					v:triggerEvent("EmpezarTerremoto", v);
					timersAllPlayers(v);
					v:outputChat("#FFFFFF[#FF0000ADVERTENCIA#FFFFFF] ESTA OCURRIENDO UN TERREMOTO AHORITA MISMO", 255, 255, 255, true)
				end;
			end;
			LSTerremoto = true;
			startTimerDuracion();
			if isTimer( timerTerremoto ) then
				timerTerremoto:destroy();
			end;
		else
			TerremotoTiempo = TerremotoTiempo - 1;
		end;
	end;
end

function startTimerDuracion()
	timerDuracion = setTimer(desminuirDuracion, 1000, 0);
end

function desminuirDuracion()
	if LSTerremoto == true then
		if TerremotoDuracion == 0 then
			for i, v in ipairs(Element.getAllByType("player")) do
				if not notIsGuest( v ) then
					v:triggerEvent("StopTerremoto", v);
					stopTimersAllPlayers(v);
					v:outputChat("#FFFFFF[#FF0000ADVERTENCIA#FFFFFF] EL TERREMOTO ACABA DE PARAR..", 255, 255, 255, true);
				end;
			end;
			startTimer();
			TerremotoTiempo = 15;
			TerremotoDuracion = 30;
			LSTerremoto = false;
			if isTimer( timerDuracion ) then
				timerDuracion:destroy();
			end
		else
			TerremotoDuracion = TerremotoDuracion - 1;
		end
	end;
end

addEventHandler("onPlayerJoin", getRootElement(), function()
	if LSTerremoto == true then
		source:outputChat("* El servidor se encuentra en un Terremoto ahorita mismo.", 150, 0, 0, true);
	end;
end);

addEventHandler("onPlayerLogin", getRootElement(), function()
	if LSTerremoto == true then
		source:triggerEvent("EmpezarTerremoto", source);
		timersAllPlayers(source);
	end;
end);

function timersAllPlayers( player )
	timer[player] = setTimer(function(player) 
	player:setHealth( player:getHealth() - 1 );
	end, 5000, 0, player);
end

function stopTimersAllPlayers( player )
	if isTimer(timer[player]) then
		timer[player]:destroy();
	end
end