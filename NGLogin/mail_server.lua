function sendMailTo ( mail, sender, headertext, text )

	callRemote ( "https://colombianvirtualreality.com/recover/test.php", EMailAccepted, mail, sender, headertext, text )

end

function EMailAccepted (value)
	if value == true then
		outputDebugString( "E-Mail was succesfully sended." )
	else
		outputDebugString( "E-Mail wasnnttt succesfully sended." )
	end
end


function attemptRecovery ( email)
		q = exports.NGSQL:email_exist ( email )
		if q then
			s1 = math.random(0,9)
			s2 = math.random(0,9)
			s3 = math.random(0,9)
			s4 = math.random(0,9)
			s5 = math.random(0,9)
			s6 = math.random(0,9)
			passN = s1..s2..s3..s4..s5..s6
			local account = getAccount(q[1]["Username"])
			local account_name = tostring(getAccountName(account))
			sendMailTo ( email, "no-responder@colombianvirtualreality.com", "[CVR]Actualizacion de password", "<p>Usuario: <strong>"..account_name.."</strong></p><p>Tu nueva contrase&ntilde;a es:&nbsp;<strong>"..passN.."</strong></p><p><span style='color: #ff0000;'>IMPORTANTE!</span> Recuerda usar el comando <strong>/chgmypass</strong>&nbsp;<strong>"..passN.."</strong> <strong>lacontrasenaquequieras</strong> para cambiar por completo tu clave.</p><p>Links:<br /><a href='https://www.facebook.com/colombianvirtualreality'>Facebook</a> | <a href='https://www.instagram.com/mta.cvr/'>Instagram</a> | <a href='https://discord.gg/EeaemXa'>Discord</a></p><p><img src='https://colombianvirtualreality.com/recover/cvrbandera.png' alt='Bandera CVR' width='316' height='213' /></p>")
			setAccountPassword ( account, tostring(passN) )
			
		else

		end
	
	
end
addEvent ( "Login:onClientAttemptRecovery", true )
addEventHandler ( "Login:onClientAttemptRecovery", root, attemptRecovery )



 

 
addEventHandler ( 'onPlayerLogin', getRootElement ( ),
    function ( _, theCurrentAccount )
		local accN = getAccountName(theCurrentAccount)
		q = exports.NGSQL:account_exist ( accN )
		if (#q>0) then
			if (q[1]['Email'] == "un") then
				outputChatBox("[ALERTA]No has definido un email para esta cuenta!", source, 255,0,0)
				outputChatBox("Usa /setemail tuemailaqui para definir el email de tu cuenta", source, 255,0,0)
			end
		end
    end
)

function setEmail ( playerSource, commandName, email)
	if ( playerSource ) then
		local account = getPlayerAccount ( playerSource )
		if ( account ~= false and email) then
			exports.NGSQL:set_email ( getAccountName(account), email )
			outputChatBox("[ALERTA]tu email ha sido cambiado a "..email, playerSource, 255,0,0)
		end
	end
end
addCommandHandler ( "setemail", setEmail )