function talentRank(talentName)
	for iTab = 1, GetNumTalentTabs() do
		for iTal = 1, GetNumTalents(iTab) do
			local nameTalent, iconPath, iconX, iconY, currentRank, maxRank = GetTalentInfo(iTab, iTal)
			if nameTalent == talentName then
				return currentRank 
			end
		end
	end
	return 0
end

function haveTalent(talentName)
	return talentRank(talentName) > 0
end