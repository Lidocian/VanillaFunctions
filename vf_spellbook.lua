function spellIndex(spellName, rank)
	for tabIndex = 1, MAX_SKILLLINE_TABS do
		local tabName, tabTexture, tabSpellOffset, tabNumSpells = GetSpellTabInfo(tabIndex)

		if not tabName then
			break
		end

		for ispellIndex = tabSpellOffset + 1, tabSpellOffset + tabNumSpells do
			local ispellName, ispellRank = GetSpellName(ispellIndex, BOOKTYPE_SPELL)
			if ispellName == spellName then
				if not rank or (rank and rank == ispellRank) then
					return ispellIndex, BOOKTYPE_SPELL
				end
			end
		end
	end
	return nil, BOOKTYPE_SPELL
end

function knowSpell(spellName, rank)
	local ispellIndex = spellIndex(spellName, rank)
	return ispellIndex ~= nil
end

function spellCooldown(spellName)
	if not knowSpell(spellName) then
		return -1
	end

	local start, duration, enabled = GetSpellCooldown(spellIndex(spellName))
	if enabled == 0 then
		return 1
	else
		local remaining = start + duration - GetTime()
		if remaining < 0 then remaining = 0 end
		return remaining
	end
end

function spellReady(spellName)
	return spellCooldown(spellName) == 0
end

function spellMana(spellName)
	 local _,_,_,mana,_,_,_,_,_= GetSpellInfo(spellName)
	 return mana
end

function spellPowerCoefficient(castTime, level)
	if castTime > 3.5 then
		castTime = 3.5
	elseif castTime < 1.5 then
		castTime = 1.5
	end

	local penaltyFactor = 1
	if level < 20 then
		penaltyFactor = penaltyFactor - (20 - level)*0.0375
	end

	return (castTime / 3.5)*penaltyFactor
end