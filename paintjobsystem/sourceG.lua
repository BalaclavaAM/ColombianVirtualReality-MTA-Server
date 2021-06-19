local availablePaintjobs = {
	[559] = {
		{"*vehiclegrunge256*", "jester/1.png"},
		{"*vehiclegrunge256*", "jester/2.png"},
	},
	[517] = {
		{"*vehiclegrunge256*", "majestic/1.jpg"},
		{"*vehiclegrunge256*", "majestic/2.jpg"},
	},
	[579] = {
		{"*vehiclegrunge256*", "huntley/1.png"},
		{"*vehiclegrunge256*", "huntley/2.png"},
	},
}

function getAvailablePaintjobs(model)
	if model then
		if availablePaintjobs[model] then
			return availablePaintjobs[model]
		end
	end
	
	return nil
end