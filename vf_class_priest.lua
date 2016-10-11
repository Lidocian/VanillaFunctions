function vf_priest_buffs()
	if not inCombat() then
		buffSelf("Inner Fire")
		multiBuff("Power Word: Fortitude")
		buffSelf("Shadowform")
	end
end

function vf_priest_superRotation()
	if vf_superExtendedRotationEnabled then
		cast("Shadowfiend")
		cast("Devouring Plague")
		debuffTarget("Vampiric Touch")
		debuffTarget("Vampiric Embrace")
	end
end

function vf_priest_extendedRotation()
	if vf_extendedRotationEnabled then
		debuffTarget("Shadow Word: Pain")
	end
end

function vf_priest_dps_rot()

	partyClean()

	assistFocus()
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		if haveAggro() then cast("Fade") end
		vf_priest_superRotation()
		vf_priest_extendedRotation()
		cast("Mind Blast")
		cast("Mind Flay")
	end
end