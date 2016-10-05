function multiBuffGetGroupSpell(spell)
	if spell == "Arcane Intellect" then
		return "Arcane Brilliance", 3, 3400, 1510
	end
	if spell == "Mark of the Wild" then
		return "Gift of the Wild", 3, 1200, 445
	end
	if spell == "Power Word: Fortitude" then
		return "Prayer of Fortitude", 3, 3400, 1695
	end
	if spell == "Divine Spirit" then
		return "Prayer of Spirit", 2, 1940, 970
	end
	if spell == "Shadow Protection" then
		return "Prayer of Shadow Protection", 2, 1300, 650
	end
	if spell == "Blessing of Light" then
		return "Greater Blessing of Light", 1, 0, 0
	end
	if spell == "Blessing of Wisdom" then
		return "Greater Blessing of Wisdom", 1, 0, 0
	end
	if spell == "Blessing of Kings" then
		return "Greater Blessing of Kings", 1, 0, 0
	end
	if spell == "Blessing of Salvation" then
		return "Greater Blessing of Salvation", 1, 0, 0
	end
	if spell == "Blessing of Sanctuary" then
		return "Greater Blessing of Sanctuary", 1, 0, 0
	end
	if spell == "Blessing of Might" then
		return "Greater Blessing of Might", 1, 0, 0
	end
	return nil, 0, 0, 0
end




function unitsMissingBuffInUnitSet(spell, unitSet)
	local groupSpell = multiBuffGetGroupSpell(spell)
	local unitsMissing = {}
	local unitsMissing_i = 1
	for i = 1, table.getn(unitSet) do
		if not dead(unitSet[i]) and onGrid(unitSet[i]) then
			if not buffed(spell, unitSet[i]) and not (groupSpell and buffed(groupSpell, unitSet[i])) then
				unitsMissing[unitsMissing_i] = unitSet[i]
				unitsMissing_i = unitsMissing_i + 1
			end
		end
	end
	return unitsMissing
end




function multiBuffGroupUnitSet(spell, groupUnitSet)
	local groupSpell, minForGroupSpell  = multiBuffGetGroupSpell(spell)
	if not knowSpell(groupSpell) then
		groupSpell = nil
	end
	local unitsMissingBuff = unitsMissingBuffInUnitSet(spell, groupUnitSet)
	if groupSpell and table.getn(unitsMissingBuff) >= minForGroupSpell then
		castOnUnit(groupSpell, 0, unitsMissingBuff[1])
	else
		for i = 1, table.getn(unitsMissingBuff) do
			castOnUnit(spell, 0, unitsMissingBuff[i])
		end
	end
end




function multiBuff(spell)
	if UnitInRaid("player") then
		local subgroupUnitSets = getRaidSubgroupUnitSets()
		for i = 1, table.getn(subgroupUnitSets) do
			multiBuffGroupUnitSet(spell, subgroupUnitSets[i])
		end
	elseif UnitInParty("player") then
		multiBuffGroupUnitSet(spell, getPartyUnitSet())
	end
end




function multiBless(spell, class)
	
	if UnitInRaid("player") then

		local subgroupUnitSets
		
		if class then
			subgroupUnitSets = getRaidClassUnitSet(class)
		else
			subgroupUnitSets = getRaidClassUnitSets()			
		end

		for i = 1, table.getn(subgroupUnitSets) do
			multiBuffGroupUnitSet(spell, subgroupUnitSets[i])
		end

	elseif UnitInParty("player") then

		local subgroupUnitSets

		if class then
			subgroupUnitSets = getPartyClassUnitSet(class)
		else
			subgroupUnitSets = getPartyClassUnitSets()			
		end

		multiBuffGroupUnitSet(spell, subgroupUnitSets)

	end

end