function vf_summon(player)
	if haveTarget() then
		whisperChat("Summoning you", UnitName("target"))
		sayChat("Summoning %t")
		cast("Ritual of Summoning")
	end
end

function vf_soulstone(player)
	if haveInBags("Major Soulstone") then
		if UnitName("target") then
			useFromBags("Major Soulstone")
			sayChat("Soulstoning %t")
		end
	else
		cast("Create Soulstone (Major)()")
	end
end

function darkPact()
	if petMana() > 250 then cast("Dark Pact") end
end

function casttap(spell)
	if mana() > spellMana(spell) then
		cast(spell)
	else
		darkPact()
		cast("Life Tap")
	end
end

function debufftap(spell)
	if mana() > spellMana(spell) then
		debuffTarget(spell)
	else
		darkPact()
		cast("Life Tap")
	end
end

function lifeTapMana()
	return 130
end

function fullWarlockWhammy()
	debufftap("Corruption")
	debufftap("Immolate")
	debufftap("Siphon Life")
end

function vf_warlock_dps_rot(curse)
	if not inCombat() then
		buffSelf("Fel Armor")
		if not buffed("Blood Pact") then cast("Summon Imp") end
	end

	assistFocus()
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		--if healthPct("target") < 0.4 then cast("Drain Soul", 1) end
		
		if curse then debufftap(curse) end
		--fullWarlockWhammy()

		casttap("Shadow Bolt")
	end

	if manaDeficit() > lifeTapMana() then
		darkPact()
		cast("Life Tap")
	end
end