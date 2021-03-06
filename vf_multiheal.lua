function unitWithGreatestHealthDeficitInUnitSetInRangeOfSpell(unitSet, spellName)

	local greatestHealthDeficitIndex = 1
	local greatestHealthDeficitValue = 0

	for i = 1, table.getn(unitSet) do
		if not dead(unitSet[i]) and onGrid(unitSet[i]) and spellInRange(spellName, unitSet[i]) then
			local deficit = healthDeficit(unitSet[i])
			if deficit > greatestHealthDeficitValue then
				greatestHealthDeficitValue = deficit
				greatestHealthDeficitIndex = i
			end
		end
	end

	return unitSet[greatestHealthDeficitIndex], greatestHealthDeficitValue
end

function partyHeal(spell, rank, value)
	local partyUnitSet = getPartyUnitSet()
	local unit, deficit = unitWithGreatestHealthDeficitInUnitSetInRangeOfSpell(partyUnitSet, spell)

	if deficit > 0.8*value then
		castOnUnit(spell, rank, unit)
	end
end