------------------------------------------
-- 				  SRNCore				--
------------------------------------------
-- Developer: Braydon Davis				--
-- File: math.lua						--
-- Copywrite 2013 (C) Braydon Davis		--
-- All rights reserved.					--
------------------------------------------	
local isMathQuestion = false
function createMathProblem ( p )
	if p and not exports["NGAdministration"]:isPlayerStaff ( p ) then return false end
	if not isMathQuestion then
		local n1 = math.random ( 50, 90 )
		local n2 = math.random ( 20, 45 )
		local n3 = math.random ( 1000, 9000 )
		local reward = math.random ( 2000, 15000 )
		local question = n1.." - "..n2.." + "..n3
		outputDebugString ( "MATEMÁTICAS: Pregunta "..question.." ha sido generada con una respueta de "..n1 - n2 + n3 )
		outputChatBox ( "#DF743F[PREGUNTA MATEMÁTICA]#ffffff La primera persona en responder #ffff00"..question.."#ffffff ganará #00ff00$"..reward.."#ffffff (Usa /result [RESPUESTA])", getRootElement ( ), 0, 0, 0, true ) 
		
		mathTable = {
			reward = reward,
			question = n1.." - "..n2.." + "..n3,
			answer = n1 - n2 + n3
		}
		
		isMathQuestion = true
		return true
	else
		isMathQuestion = false
		mathTable = nil
		createMathProblem ( )
	end
end 
setTimer ( createMathProblem, 900000, 0 )
addCommandHandler ( "math", createMathProblem )

addCommandHandler ( "result", function ( p, cmd, answer )
	if ( isMathQuestion ) then
		if ( tonumber ( answer ) == tonumber ( mathTable.answer ) ) then
			outputChatBox ( "#DF743F[PREGUNTA MATEMÁTICA] #ff0000"..getPlayerName ( p ).."#ffffff fue el primero en responder #0000ff"..mathTable.answer.."#ffffff y ganó #00ff00$"..mathTable.reward, root, 0, 0, 0, true )
			givePlayerMoney ( p, mathTable.reward )
			isMathQuestion = false
			mathTable = nil
			return true
		else
			outputChatBox ( "#DF743F[PREGUNTA MATEMÁTICA] #ffffffLo sentimos #ffff00"..getPlayerName ( p ).." #ffffffpero esa #ff0000no es#ffffff la respuesta correcta.", p, 255, 0, 0, true )
			return false
		end
	else
		outputChatBox ( "#DF743F[PREGUNTA MATEMÁTICA] #ffffffNo hay preguntas ahora mismo. Intenta de nuevo otra vez.", p, 255, 0, 0, true )
		return false
	end
end )

function getRunningMathEquation ( )
	if ( mathTable ) then
		return mathTable.question
	end
	return false
end