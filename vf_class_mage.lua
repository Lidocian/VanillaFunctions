function castevo(spell)
	if mana() > spellMana(spell) then
		cast(spell)
	else
		cast("Evocation")
	end
end

function vf_mage_dps_rot()
	if not inCombat() then
		buffSelf("Molten Armor")
		multiBuff("Arcane Intellect")
		buffSelf("Combustion")
	end

	partyClean()

	assistFocus()
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		castevo("Fireball")
	end
end