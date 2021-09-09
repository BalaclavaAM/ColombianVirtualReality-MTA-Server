defaultMusic = {
    { "Radio Uno", "http://live4.rcnmundo.com/radiouno.mp3" },
    { "Olímpica", "http://i50.letio.com/9114.aac" },
    { "Tropicana", "http://15373.live.streamtheworld.com/TR_BUCARAMANGAAAC.aac" },
    { "Vibra Bogotá", "http://provisioning.streamtheworld.com/asx/VIBRAAAC.asx" },
	{ "Amor Stereo", "http://live3.rcnmundo.com/amor.mp3"},
	{ "Radio Policia Nacional", "https://radio.policia.gov.co:8080/bogota"},
	{ "La Kalle", "http://14073.live.streamtheworld.com/LA_KALLE.mp3?"},
	{ "La Mega", "http://live3.rcnmundo.com/lamega.aac"},
	{ "Radiónica", "http://shoutcast.rtvc.gov.co:8010/;"},
	{ "W Radio", "http://playerservices.streamtheworld.com/api/livestream-redirect/WRADIO_SC"},
	{"Radio Eventos", "https://freeus2.listen2myradio.com/live.mp3?typeportmount=s1_36367_stream_181721103"},
	{"CVR Radio 2020", "http://node-25.zeno.fm/yeghg6y9x4zuv?rj-ttl=5&rj-tok=AAABdQOecu0AwBWy-6iKZn1LeQ"},
}

function createUserMusicFile ( doReturn )
	if ( not fileExists ( "@xml/temitas2.xml" ) ) then
		local file = xmlCreateFile ( "@xml/temitas2.xml", "list" )
		for i, v in ipairs ( defaultMusic ) do 
			local child = xmlCreateChild ( file, "radio" )
			xmlNodeSetAttribute ( child, "name", v[1] )
			xmlNodeSetAttribute ( child, "url", v[2] )
		end
		xmlSaveFile ( file )
		if doReturn then
			return file
		else
			xmlUnloadFile ( file )
		end
	end
end

function getRadioStations ( )
	local data = { }
	local file = xmlLoadFile ( "@xml/temitas2.xml" ) or createUserMusicFile ( true )
	for i, v in ipairs ( xmlNodeGetChildren ( file ) ) do 
		table.insert ( data, { tostring ( xmlNodeGetAttribute ( v, "name" ) ), tostring ( xmlNodeGetAttribute ( v, "url" ) ) } )
	end
	xmlUnloadFile ( file )
	return data
end

function removeRadioStation ( name, url )
	local file = xmlLoadFile ( "@xml/temitas2.xml" ) or createUserMusicFile ( true )
	for i, v in ipairs ( xmlNodeGetChildren ( file ) ) do 
		if ( xmlNodeGetAttribute ( v, "name" ) == name and xmlNodeGetAttribute ( v, "url" ) == url ) then
			xmlDestroyNode ( v )
			xmlSaveFile ( file )
			xmlUnloadFile ( file )
			return true
		end
	end
	xmlSaveFile ( file )
	xmlUnloadFile ( file )
	return false
end

function addRadioStation ( name, url )
	local file = xmlLoadFile ( "@xml/temitas2.xml" ) or createUserMusicFile ( true )
	local child = xmlCreateChild ( file, "radio" )
	xmlNodeSetAttribute ( child, "name", name )
	xmlNodeSetAttribute ( child, "url", url )
	xmlSaveFile ( file )
	xmlUnloadFile ( file )
end
createUserMusicFile ( )