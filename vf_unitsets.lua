function getPartyUnitSet()
	local unitSet = {}
	unitSet[1] = "player"
	for i = 1, GetNumPartyMembers() do
		unitSet[i+1] = "party"..i
	end
	return unitSet
end

function getRaidSubgroupUnitSets()
	local unitsets = {{},{},{},{},{},{},{},{}}
	local subgroup_i = {1, 1, 1, 1, 1, 1, 1, 1}
	for raidIndex = 1, MAX_RAID_MEMBERS do
		if UnitExists("raid"..raidIndex) then
			local name, rank, subgroup = GetRaidRosterInfo(raidIndex)
			unitsets[subgroup][subgroup_i[subgroup]] = "raid"..raidIndex
			subgroup_i[subgroup] = subgroup_i[subgroup] + 1
		end
	end
	return unitsets
end

function getPartyClassUnitSets()
	local unitsets = {WARRIOR={}, PALADIN={}, HUNTER={}, SHAMAN={}, ROGUE={}, DRUID={}, MAGE={},PRIEST={},WARLOCK={}}
	local class_i = {WARRIOR=1, PALADIN=1, HUNTER=1, SHAMAN=1, ROGUE=1, DRUID=1, MAGE=1,PRIEST=1,WARLOCK=1}
	
	local playerClass = class("player")
	unitsets[playerClass][class_i[playerClass]] = "player"
	class_i[playerClass] = class_i[playerClass] + 1

	for i = 1, GetNumPartyMembers() do
		local partyClass = class("party"..i)
		unitsets[partyClass][class_i[partyClass]] = "party"..i
		class_i[partyClass] = class_i[partyClass] + 1
	end
	return unitsets
end

function getPartyClassUnitSet(class)
	local sets = getPartyClassUnitSets()
	return sets[class]
end


function getRaidClassUnitSets()
	local unitsets = {WARRIOR={}, PALADIN={}, HUNTER={}, SHAMAN={}, ROGUE={}, DRUID={}, MAGE={},PRIEST={},WARLOCK={}}
	local class_i = {WARRIOR=1, PALADIN=1, HUNTER=1, SHAMAN=1, ROGUE=1, DRUID=1, MAGE=1,PRIEST=1,WARLOCK=1}
	for raidIndex = 1, MAX_RAID_MEMBERS do
		if UnitExists("raid"..raidIndex) then
			local raidClass = class("raid"..raidIndex)
			unitsets[raidClass][class_i[raidClass]] = "raid"..raidIndex
			class_i[raidClass] = class_i[raidClass] + 1
		end
	end
	return unitsets
end

function getRaidClassUnitSet(class)
	local sets = getRaidClassUnitSets()
	return sets[class]
end