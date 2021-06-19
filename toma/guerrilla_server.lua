crimTeam = getTeamFromName("Criminals") 
--exports["slothbot"]:spawnBot(1558.71, 18.42, 24.16, 0, 73, 0, 0, crimTeam, 30, "hunting")
function spawnear()
	if crimTeam then
		local ped = exports [ "slothBot" ]:spawnBot ( 1558.71, 18.42, 24.16, 270,  73, 0, 0, crimTeam, 30, "waiting")
	end
end 
addCommandHandler("pito", spawnear)
  