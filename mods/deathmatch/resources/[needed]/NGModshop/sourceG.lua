availableTuningMarkers = {
	--X, Y, Z, Vehicle Rotation (Use /markerpos to get perfect position and rotation (The command in sourceC.lua last row))
	{1986.5765380859, -2270.5290527344, 13.54, 90},
	{1041.3745117188, -1015.1922607422, 31.754657745361, 358.49920654297},
	{2644.7028808594, -2043.3992919922, 13.495246887207, 179.55780029297},
	{2386.1440429688, 1052.5614013672, 10.695282936096, 178.58911132813},
	{-2723.7197265625, 217.05860900879, 4.3594174385071, 88.758850097656},
	{-1936.55, 245.92, 34.14},
	{-267.67, 1556.27, 75.43, 312},
	{1986.06, -2259.01, 13.54, 90},
	{1986.02, -2248.41, 14.61, 90}
}

tuningMenu = {
	[1] = {
		["categoryName"] = getLocalizedText("menu.performance"),
		["subMenu"] = {
			[1] = {
				["categoryName"] = getLocalizedText("menu.performance.engine"),
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true}, -- component, offsetX, offsetZ, zoom, hide component
				["upgradeData"] = "engine",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"engineAcceleration"}, {"maxVelocity"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 1500, ["tuningData"] = {{"engineAcceleration", 2}, {"maxVelocity", 10}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 3000, ["tuningData"] = {{"engineAcceleration", 6}, {"maxVelocity", 20}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 6000, ["tuningData"] = {{"engineAcceleration", 8}, {"maxVelocity", 30}}}
				}
			},
			[2] = {
				["categoryName"] = getLocalizedText("menu.performance.turbo"),
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true},
				["upgradeData"] = "turbo",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"engineInertia"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 6000, ["tuningData"] = {{"engineInertia", -10}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 12000, ["tuningData"] = {{"engineInertia", -20}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 18000, ["tuningData"] = {{"engineInertia", -30}}}
				}
			},
			[3] = {
				["categoryName"] = getLocalizedText("menu.performance.tires"),
				["cameraSettings"] = {"wheel_rb_dummy", 60, 10, 4},
				["upgradeData"] = "tires",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"tractionMultiplier"}, {"tractionLoss"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 4500, ["tuningData"] = {{"tractionMultiplier", 0.05}, {"tractionLoss", 0.02}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 9000, ["tuningData"] = {{"tractionMultiplier", 0.1}, {"tractionLoss", 0.03}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 12500, ["tuningData"] = {{"tractionMultiplier", 0.15}, {"tractionLoss", 0.04}}}
				}
			},
			[4] = {
				["categoryName"] = getLocalizedText("menu.performance.brakes"),
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeData"] = "brakes",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"brakeDeceleration"}, {"brakeBias"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 4500, ["tuningData"] = {{"brakeDeceleration", 0.05}, {"brakeBias", 0.1}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 9000, ["tuningData"] = {{"brakeDeceleration", 0.1}, {"brakeBias", 0.175}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 12500, ["tuningData"] = {{"brakeDeceleration", 0.15}, {"brakeBias", 0.25}}}
				}
			},
			[5] = {
				["categoryName"] = getLocalizedText("menu.performance.weightReduction"),
				["upgradeData"] = "weightreduction",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"mass"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 4250, ["tuningData"] = {{"mass", -100}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 7500, ["tuningData"] = {{"mass", -200}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 15000, ["tuningData"] = {{"mass", -300}}}
				}
			}
		}
	},
	[2] = {
		["categoryName"] = getLocalizedText("menu.optical"),
		["availableUpgrades"] = {}, -- automatic getting optical upgrades to selected category
		["subMenu"] = {
			[1] = {["categoryName"] = getLocalizedText("menu.optical.frontBumper"), ["upgradeSlot"] = 14, ["tuningPrice"] = 25000, ["cameraSettings"] = {"bump_front_dummy", 130, 10, 6}},
			[2] = {["categoryName"] = getLocalizedText("menu.optical.rearBumper"), ["upgradeSlot"] = 15, ["tuningPrice"] = 25000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[3] = {["categoryName"] = getLocalizedText("menu.optical.hood"), ["upgradeSlot"] = 0, ["tuningPrice"] = 25000},
			[4] = {["categoryName"] = getLocalizedText("menu.optical.exhaust"), ["upgradeSlot"] = 13, ["tuningPrice"] = 15000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[5] = {["categoryName"] = getLocalizedText("menu.optical.spoiler"), ["upgradeSlot"] = 2, ["tuningPrice"] = 15000, ["cameraSettings"] = {"boot_dummy", -65, 3, 8}},
			[6] = {["categoryName"] = getLocalizedText("menu.optical.wheels"), ["upgradeSlot"] = 12, ["tuningPrice"] = 50000},
			[7] = {["categoryName"] = getLocalizedText("menu.optical.sideSkirt"), ["upgradeSlot"] = 3, ["tuningPrice"] = 20000, ["cameraSettings"] = {"ug_wing_right", 65, 3, 4}},
			[8] = {["categoryName"] = getLocalizedText("menu.optical.roofScoop"), ["upgradeSlot"] = 7, ["tuningPrice"] = 20000},
			[9] = {["categoryName"] = getLocalizedText("menu.optical.hidraulics"), ["upgradeSlot"] = 9, ["tuningPrice"] = 150000},
			[10] = { -- custom optical item
				["categoryName"] = "Air-Ride",
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeSlot"] = 17,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.install"), ["tuningPrice"] = 0, ["tuningData"] = true}
				}
			},
			[11] = { -- custom optical item
				["categoryName"] = getLocalizedText("menu.optical.lampColor"),
				["cameraSettings"] = {"bonnet_dummy", 90, 3, 13},
				["upgradeSlot"] = 18,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("menu.optical.lampColor"), ["tuningPrice"] = 0, ["tuningData"] = "headlight"},
				}
			},
			[12] = { -- custom optical item
				["categoryName"] = "Neon",
				["cameraSettings"] = {"chassis_dummy", 0, 3, 10},
				["upgradeSlot"] = 19,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.1"), ["tuningPrice"] = 100000, ["tuningData"] = "white"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.2"), ["tuningPrice"] = 100000, ["tuningData"] = "blue"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.3"), ["tuningPrice"] = 100000, ["tuningData"] = "green"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.4"), ["tuningPrice"] = 100000, ["tuningData"] = "red"},
					[6] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.5"), ["tuningPrice"] = 100000, ["tuningData"] = "yellow"},
					[7] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.6"), ["tuningPrice"] = 100000, ["tuningData"] = "pink"},
					[8] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.7"), ["tuningPrice"] = 100000, ["tuningData"] = "orange"},
					[9] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.8"), ["tuningPrice"] = 100000, ["tuningData"] = "lightblue"},
					[10] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.9"), ["tuningPrice"] = 100000, ["tuningData"] = "rasta"},
					[11] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.10"), ["tuningPrice"] = 100000, ["tuningData"] = "ice"},
				}
			},
		}
	},
	[3] = {
		["categoryName"] = getLocalizedText("menu.extras"),
		["subMenu"] = {
			[1] = {
				["categoryName"] = getLocalizedText("menu.extras.frontWheelSize"),
				["cameraSettings"] = {"bump_front_dummy", 105, 5, 5, true},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryNarrow"), ["tuningPrice"] = 2000, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.narrow"), ["tuningPrice"] = 1000, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 5000, ["tuningData"] = "default"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.wide"), ["tuningPrice"] = 1000, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryWide"), ["tuningPrice"] = 2000, ["tuningData"] = "verywide"}
				}
			},
			[2] = {
				["categoryName"] = getLocalizedText("menu.extras.rearWheelSize"),
				["cameraSettings"] = {"bump_rear_dummy", -90, 5, 5, true},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryNarrow"), ["tuningPrice"] = 2000, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.narrow"), ["tuningPrice"] = 1000, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 5000, ["tuningData"] = "default"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.wide"), ["tuningPrice"] = 1000, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryWide"), ["tuningPrice"] = 2000, ["tuningData"] = "verywide"}
				}
			},
			[3] = {
				["categoryName"] = getLocalizedText("menu.extras.offroad"),
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 2500, ["tuningData"] = "default"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.offroad.dirt"), ["tuningPrice"] = 2500, ["tuningData"] = "dirt"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.offroad.sand"), ["tuningPrice"] = 2500, ["tuningData"] = "sand"}
				}
			},
			[4] = {
				["categoryName"] = getLocalizedText("menu.extras.driveType"),
				["propertyName"] = "driveType",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.driveType.front"), ["tuningPrice"] = 10000, ["tuningData"] = "fwd"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.driveType.all"), ["tuningPrice"] = 10000, ["tuningData"] = "awd"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.driveType.rear"), ["tuningPrice"] = 10000, ["tuningData"] = "rwd"}
				}
			},
			[5] = {
				["categoryName"] = getLocalizedText("menu.extras.bulletproofTires"),
				["cameraSettings"] = {"wheel_rb_dummy", 60, 10, 4},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.bulletproofTires"), ["tuningPrice"] = 5000, ["tuningData"] = true}
				}
			},
			[6] = {
				["categoryName"] = getLocalizedText("menu.extras.lsdDoor"),
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("menu.extras.lsdDoor"), ["tuningPrice"] = 0, ["tuningData"] = true}
				}
			},
			[7] = {
				["categoryName"] = getLocalizedText("menu.extras.steeringLock"),
				["propertyName"] = "steeringLock",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 7500, ["tuningData"] = false},
					[2] = {["categoryName"] = "30°", ["tuningPrice"] = 7500, ["tuningData"] = 30},
					[3] = {["categoryName"] = "40°", ["tuningPrice"] = 7500, ["tuningData"] = 40},
					[4] = {["categoryName"] = "50°", ["tuningPrice"] = 7500, ["tuningData"] = 50},
					[5] = {["categoryName"] = "60°", ["tuningPrice"] = 7500, ["tuningData"] = 60}
				}
			},
			[8] = {
				["categoryName"] = getLocalizedText("menu.extras.numberplate"),
				["cameraSettings"] = {"wheel_lb_dummy", -65, 4, 5},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.numberplate.random"), ["tuningPrice"] = 0, ["tuningData"] = "random"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.numberplate.custom"), ["tuningPrice"] = 0, ["tuningData"] = "custom"}
				}
			},
		}
	},
	[4] = {
		["categoryName"] = getLocalizedText("menu.color"),
		["subMenu"] = {}
	}
}

function getMainCategoryIDByName(name)
	if name then
		for categoryID, row in ipairs(tuningMenu) do
			if name == row["categoryName"] then
				return categoryID
			end
		end
	end
	
	return -1
end