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

function vf_mage_superRotation()
	if vf_superExtendedRotationEnabled then
		cast("Arcane Power")
		cast("Presence of Mind")
	end
end

function vf_mage_extendedRotation()
	if vf_extendedRotationEnabled then
	end
end

function vf_mage_dps_rot()
	-- Still need to do mana gems
	partyClean()

	assistFocus()
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		vf_mage_superRotation()
		vf_mage_extendedRotation()
		castevo("Frostbolt")
	end
end