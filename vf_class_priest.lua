function fullPriestWhammy()
	debuffTarget("Vampiric Touch")
	debuffTarget("Vampiric Embrace")
	debuffTarget("Shadow Word: Pain")
end

function vf_priest_dps_rot()
	if not inCombat() then
		buffSelf("Inner Fire")
		multiBuff("Power Word: Fortitude")
		buffSelf("Shadowform")
	end

	partyClean()
	
	assistFocus()
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		--fullPriestWhammy()
		cast("Mind Blast")
		cast("Mind Flay")
	end
end