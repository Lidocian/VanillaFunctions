function spellCritTotem()
	buffSelf("Totem of Wrath")
end

function manaTotem()
	if not buffed("Mana Spring") then cast("Mana Spring Totem") end
end

function strengthTotem()
	if not buffed("Strength of Earth") then cast("Strength of Earth Totem") end
end

function windfuryTotem()
	--if not buffed("Mana Spring") then cast("Mana Spring Totem") end
	--Need to implement windfury buff detection
end

function agilityTotem()
	if not buffed("Grace of Air") then cast("Grace of Air Totem") end
end

function spellPowerTotem()
	buffSelf("Wrath of Air Totem")
end


function vf_shaman_dps_rot()
	if not inCombat() then
		buffSelf("Water Shield")
		buffSelf("Elemental Mastery")
	end

	partyClean()

	basicPartyHeal("Healing Wave", 9, 2000)
	basicPartyHeal("Healing Wave", 6, 920)
	
	manaTotem()
	spellPowerTotem()
	--wrathTotem()

	assistFocus()
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		--cast("Earth Shock")
		cast("Lightning Bolt")
	end
end

function vf_shaman_heal_rot()
	if not inCombat() then
		buffSelf("Water Shield")
	end

	partyClean()

	basicPartyHeal("Healing Wave", 9, 2000)
	basicPartyHeal("Healing Wave", 6, 920)
	
	manaTotem()
	spellPowerTotem()

	targetFocus()
	buffTarget("Earth Shield")
end