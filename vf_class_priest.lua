function vf_priest_buffs()
	if not inCombat() then
		multiBuff("Power Word: Fortitude")
		buffSelf("Shadowform")
		buffSelf("Inner Fire")
	end
end

function vf_priest_superExtendedRotation()
	if vf_superExtendedRotationEnabled then
		useTrinkets()
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
	if not inCombat() then
		buffSelf("Shadowform")
		buffSelf("Inner Fire")
	end

	partyClean()

	--target("Ethereal Beacon")
	--if targetName() ~= "Ethereal Beacon" or dead("target") then assistFocus() end
	
	assistFocus()
	--if wand() then return end
	if haveTarget() and targetIsEnemy() and targetInCombat() then
		if haveAggro() then cast("Fade") end
		vf_priest_superExtendedRotation()
		vf_priest_extendedRotation()
		cast("Mind Blast")
		cast("Mind Flay")
	end
end