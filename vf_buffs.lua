function buffStacks(buff, unit)
	unit = unit or "player"

	local name, rank, iconTexture, count, debuffType, duration, timeLeft
	local debuffType

	local iBuff

	iBuff = 1
	name, rank, iconTexture, count, duration, timeLeft = UnitBuff(unit, iBuff)
	while name ~= nil and name ~= buff do
		iBuff = iBuff + 1
		name, rank, iconTexture, count, duration, timeLeft = UnitBuff(unit, iBuff)
	end
	if name == buff then
		return count
	end

	iBuff = 1
	name, rank, iconTexture, count, debuffType, duration, timeLeft  =  UnitDebuff(unit, iBuff)
	while name ~= nil and name ~= buff do
		iBuff = iBuff + 1
		name, rank, iconTexture, count, debuffType, duration, timeLeft = UnitDebuff(unit, iBuff)
	end
	if name == buff then
		return count
	end

	return 0
end


function buffed(buff, unit)
	unit = unit or "player"
	return buffStacks(buff, unit) > 0
end