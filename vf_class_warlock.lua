function summon(player)
	if haveTarget() then
		whisperChat("Summoning you", UnitName("target"))
		sayChat("Summoning %t")
		cast("Ritual of Summoning")
	end
end

function soulstone(player)
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
	if petMana() > 700 then cast("Dark Pact") end
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
	return 1250
end

function vf_warlock_buffs()
	if not inCombat() then
		buffSelf("Fel Armor")
		if not buffed("Blood Pact") then cast("Summon Imp") end
	end
end




function vf_warlock_superExtendedRotation()
	if vf_superExtendedRotationEnabled then
		useTrinkets()
		debufftap("Siphon Life")
	end
end

function vf_warlock_extendedRotation(curse)
	if vf_extendedRotationEnabled then
		if curse then debufftap(curse) end
		debufftap("Corruption")
		debufftap("Immolate")
	end
end

local vf_getShards = false
function vf_warlock_dps_rot(curse)
	if not inCombat() then
		buffSelf("Fel Armor")
	end
	--target("Ethereal Beacon")
	--if targetName() ~= "Ethereal Beacon" or dead("target") then assistFocus() end

	assistFocus()
	--if haveTarget() and targetIsEnemy() and targetInCombat() then cast("Shoot") return end
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		if vf_getShards == true and health("target") < 2500 then cast("Drain Soul", 1) end
		if buffed("Shadow Trance") then casttap("Shadow Bolt") end
		--if targetName() ~= "Ethereal Beacon" then
		vf_warlock_superExtendedRotation()
		vf_warlock_extendedRotation(curse)
		--end
		casttap("Shadow Bolt")
	end

	if manaDeficit() > lifeTapMana() then
		darkPact()
		cast("Life Tap")
	end
end














function vf_warlock_sextendedRotation(curse)
	if vf_extendedRotationEnabled then
		debufftap("Corruption")
		debufftap("Siphon Life")
		debufftap("Immolate")
	end
end

function vf_warlock_sdps_rot(curse)

	if haveTarget() and targetIsEnemy() then
		if curse then debufftap(curse) end
		if buffed("Shadow Trance") then casttap("Shadow Bolt") end
		vf_warlock_sextendedRotation(curse)
		casttap("Shadow Bolt")
	end

	if manaDeficit() > lifeTapMana() then
		darkPact()
		cast("Life Tap")
	end
end