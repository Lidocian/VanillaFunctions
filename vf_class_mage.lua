function castevo(spell)
	if mana() > spellMana(spell) then
		cast(spell)
	else
		cast("Evocation")
	end
end

function vf_mage_buffs()
	if not inCombat() then
		buffSelf("Molten Armor")
		multiBuff("Arcane Intellect")
	end
end

function vf_mage_superExtendedRotation()
	if vf_superExtendedRotationEnabled then
		useTrinkets()
		cast("Arcane Power")
		cast("Presence of Mind")
	end
end

function vf_mage_extendedRotation()
	if vf_extendedRotationEnabled then
	end
end

function vf_mage_dps_rot()
	if not inCombat() then
		buffSelf("Molten Armor")
		-- Still need to do mana gems
	end

	partyClean()

	--target("Ethereal Beacon")
	--if targetName() ~= "Ethereal Beacon" or dead("target") then assistFocus() end

	assistFocus()
	--if haveTarget() and targetIsEnemy() and targetInCombat() then cast("Shoot") return end
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		vf_mage_superExtendedRotation()
		vf_mage_extendedRotation()
		castevo("Frostbolt")
	end
end