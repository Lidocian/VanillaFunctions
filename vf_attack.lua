-- Melee and Weapons
vf_attack_slot_cache = 0
function vf_findAttackSlot()
	if vf_attack_slot_cache == 0 then
		for AtkSlot = 1,132 do
			if IsAttackAction(AtkSlot) then
				vf_attack_slot_cache = AtkSlot
				return
			end
		end
	end
end

function attacking()
	vf_findAttackSlot()
	return IsCurrentAction(vf_attack_slot_cache)
end

function attack()
	vf_findAttackSlot()
	if not IsCurrentAction(vf_attack_slot_cache) then
		UseAction(vf_attack_slot_cache)
	end
end