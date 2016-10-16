local classCleansable = {
	PALADIN = {Magic="Cleanse", Poison="Cleanse", Disease="Cleanse"},
	SHAMAN  = {Poison="Curse Poison", Disease="Cure Disease"},
	DRUID   = {Poison="Abolish Poison", Curse="Remove Curse"},
	PRIEST  = {Magic="Dispel Magic", Disease="Abolish Disease"},
	MAGE    = {Curse="Remove Lesser Curse"}
}

function getCleansableDebuffSpell(unit)
	local playerClass = class()

	local iDebuff = 1
	local name, rank, iconTexture, count, debuffType, duration, timeLeft = UnitDebuff(unit, iDebuff)
	while debuffType ~= nil do
		if debuffType and classCleansable[playerClass][debuffType] then
			return classCleansable[playerClass][debuffType]
		end
		iDebuff = iDebuff + 1
		name, rank, iconTexture, count, debuffType, duration, timeLeft = UnitDebuff(unit, iDebuff)
	end

	return nil
end


function partyClean()
	local unitSet = getPartyUnitSet()
	
	for iParty = 1, table.getn(unitSet) do
		if not dead(unitSet[iParty]) and onGrid(unitSet[Party]) then
			local spell = getCleansableDebuffSpell(unitSet[iParty])
			if spell then
				castOnUnit(spell, 0, unitSet[iParty])
				return
			end
		end
	end
end