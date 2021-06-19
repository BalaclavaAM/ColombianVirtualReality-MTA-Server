function updateJobRank()
	triggerServerEvent ( "NGJobs->SQL->UpdateColumn", localPlayer, localPlayer, "entregas", "AddOne" )
end
addEvent("updateTruckerJob", true)
addEventHandler("updateTruckerJob",localPlayer, updateJobRank)