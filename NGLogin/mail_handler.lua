function sendMailTo ( mail, sender, headertext, text )

	callRemote ( "https://dhoyosgtest.000webhostapp.com/send.php", EMailAccepted, mail, sender, headertext, text )

end

function EMailAccepted ()

	outputDebugString ( "E-Mail was succesfully sended." )

end