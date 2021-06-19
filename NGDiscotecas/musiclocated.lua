function potensia ( link )
	local desusound =playSound3D(link,487.32943725586, -1.9113925695419, 1002.3828125, true)
	setSoundVolume(desusound,14)
	setSoundMaxDistance(desusound, 200)
end
addCommandHandler("ponertema", potensia, (_, link)