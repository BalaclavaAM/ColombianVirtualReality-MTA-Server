gmontext = get("gmontext")
gmoncolor = get("gmoncolor")
gmofftext = get("gmofftext")
gmoffcolor = get("gmoffcolor")
function gmon()
		for theKey,thePlayer in ipairs(getElementsByType("player")) do
			setElementData( thePlayer, "overrideCollide.uniqueblah", 0, false )
			outputChatBox(gmoncolor..gmontext,thePlayer,186,212,71,true)
		end
end
function gmoff()
		for theKey,thePlayer in ipairs(getElementsByType("player")) do
			setElementData(thePlayer, "overrideCollide.uniqueblah", nil, false )
			outputChatBox(gmoffcolor..gmofftext,thePlayer,255,255,255,true)
		end
end

addCommandHandler ( "gmon", gmon )
addCommandHandler ( "gmoff", gmoff )