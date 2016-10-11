function paladinMount()
	buffSelf("Crusader Aura")
	cast("Summon Warhorse")
end

function paladinTaunt()
	if not haveAggro() then
		target("targettarget")
		cast("Righteous Defense")
		targetLast()
	end
end

function vf_paladin_buff_rot()
	multiBless("Blessing of Salvation", "SHAMAN")
	multiBless("Blessing of Salvation", "PRIEST")
	multiBless("Blessing of Salvation", "WARLOCK")
	multiBless("Blessing of Salvation", "MAGE")
	multiBless("Blessing of Might", "ROGUE")
end


function vf_paladin_tank_rot()
	if not inCombat() then vf_paladin_buff_rot() end

	partyClean()

	--buffSelf("Retribution Aura")

	buffSelf("Righteous Fury")

	buffSelf("Greater Blessing of Sanctuary")
	buffSelf("Seal of Righteousness")
	
	if haveTarget() and targetIsEnemy() then
		attack()
		--cast("Consecration")
		--buffSelf("Holy Shield")
		--cast("Judgement")
		if UnitMana("target") > 0 then cast("Mana Tap") end
	end
end


function vf_paladin_dps_rot()
	if not inCombat() then vf_paladin_buff_rot() end

	--buffSelf("Retribution Aura")
	buffSelf("Righteous Fury")
	buffSelf("Greater Blessing of Might")
	buffSelf("Seal of Command")
	
	if haveTarget() and targetIsEnemy() then
		attack()
		cast("Crusader Strike")
		--if not buffed("Judgement of the Crusader", "target") then
		--	if buffed("Seal of the Crusader") then
		--		cast("Judgement")
		--	else
		--		buffSelf("Seal of the Crusader")
		--	end
		--else
		--	buffSelf("Seal of Righteousness")
		--end
		--cast("Judgement")

		if UnitMana("target") > 0 then cast("Mana Tap") end
	end
end