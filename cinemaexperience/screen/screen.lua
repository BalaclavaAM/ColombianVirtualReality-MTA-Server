local models = {
	{filename = "screen", id = 3944},
	{filename = "screen_curved", id = 3942},
}

function loadModels()
	local txd = engineLoadTXD("screen/screen.txd")
	local loaded = 0
	local failed = 0

	for i=1, #models do
		local v = models[i]
		engineImportTXD(txd, v.id)
		
		local dff = engineLoadDFF("screen/models/"..v.filename..".dff")
		local dffSuccess = engineReplaceModel(dff, v.id)
		
		local col = engineLoadCOL("screen/models/"..v.filename..".col")
		local colSuccess = engineReplaceCOL(col, v.id)
		
		if dffSuccess and colSuccess then
			loaded = loaded + 1
		else
			failed = failed + 1
		end
	end

	print('[Cinema Experience] '..loaded.." models replaced. Failed to load: "..failed)
end

loadModels()