local FireTotem = 1
local EarthTotem = 2 
local WaterTotem = 3 
local AirTotem = 4


function havePriorityFireTotem()
	local haveTotem, totemName, startTime, duration = GetTotemInfo(FireTotem)
	if totemName == "Fire Elemental Totem" then
		return true
	end
	return false
end

function havePriorityEarthTotem()
	local haveTotem, totemName, startTime, duration = GetTotemInfo(EarthTotem)
	if totemName == "Earth Elemental Totem" then
		return true
	end
	return false
end

function havePriorityWaterTotem()
	local haveTotem, totemName, startTime, duration = GetTotemInfo(WaterTotem)
	if totemName == "Mana Tide Totem" then
		return true
	end
	return false
end

function havePriorityAirTotem()
	return false
end



-- Fire
function flameTotem()
	if havePriorityFireTotem() then return end
	local haveTotem, totemName, startTime, duration = GetTotemInfo(FireTotem)
	if totemName ~= "Flametongue Totem V" then
		cast("Flametongue Totem")
	end	
end

function spellcritTotem()
	if havePriorityFireTotem() then return end
	if not buffed("Totem of Wrath") then cast("Totem of Wrath") end
end

function fireelementalTotem()
	local haveTotem, totemName, startTime, duration = GetTotemInfo(FireTotem)
	if totemName ~= "Fire Elemental Totem" then
		cast("Fire Elemental Totem")
	end
end

-- Earth
function stoneskinTotem()
	if havePriorityEarthTotem() then return end
	if not buffed("Stoneskin") then cast("Stoneskin Totem") end
end

function strengthTotem()
	if havePriorityEarthTotem() then return end
	if not buffed("Strength of Earth") then cast("Strength of Earth Totem") end
end

function tremorTotem()
	if havePriorityEarthTotem() then return end
	local haveTotem, totemName, startTime, duration = GetTotemInfo(EarthTotem)
	if totemName ~= "Tremor Totem" then
		cast("Tremor Totem")
	end
end

function earthelementalTotem()
	local haveTotem, totemName, startTime, duration = GetTotemInfo(EarthTotem)
	if totemName ~= "Earth Elemental Totem" then
		cast("Earth Elemental Totem")
	end
end

-- Water
function manaTotem()
	if havePriorityWaterTotem() then return end
	if not buffed("Mana Spring") then cast("Mana Spring Totem") end
end

function manatideTotem()
	local haveTotem, totemName, startTime, duration = GetTotemInfo(WaterTotem)
	if totemName ~= "Mana Tide Totem" then
		cast("Mana Tide Totem")
	end
end

-- Air

function windfuryTotem()
	if havePriorityAirTotem() then return end
	local haveTotem, totemName, startTime, duration = GetTotemInfo(AirTotem)
	if totemName ~= "Windfury Totem" then
		cast("Windfury Totem")
	end
end

function agilityTotem()
	if havePriorityAirTotem() then return end
	if not buffed("Grace of Air") then cast("Grace of Air Totem") end
end

function spellpowerTotem()
	if havePriorityAirTotem() then return end
	if not buffed("Wrath of Air Totem") then cast("Wrath of Air Totem") end
end

-- Rotations

function vf_shaman_superRotation()
	if vf_superExtendedRotationEnabled then
		cast("Bloodlust")
		useTrinkets()
		earthelementalTotem()
		fireelementalTotem()
	end
end

function vf_shaman_heal_rot()
	if not inCombat() then
		buffSelf("Water Shield")
	end

	vf_shaman_superRotation()

	if mana() < spellMana("Healing Wave") then
		manatideTotem()
	end

	basicPartyHeal("Healing Wave", 12, 3100)
	--strengthTotem()
	tremorTotem()
	--stoneskinTotem()
	manaTotem()
	spellpowerTotem()
	flameTotem()

	partyClean()

	basicPartyHeal("Healing Wave", 9, 2100)
	basicPartyHeal("Healing Wave", 6, 1000)

	targetFocus()
	buffTarget("Earth Shield")
	
end