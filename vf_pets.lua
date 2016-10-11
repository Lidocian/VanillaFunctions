function petHealth()
	return health("pet")
end

function petMana()
	return mana("pet")
end

function havePet()
	return petHealth() > 0
end

function petCasting()
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo("pet")
	return spell	
end

function petAttack()
	if not petCasting() then
		PetAttack()
	end
end