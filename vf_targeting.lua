function clearTargetIfNotAggroed()
	if not targetInCombat() then
		ClearTarget()
	end
end

function targetEnemyIcon(icon)
	local ticon = nil
	local safety = 0
	while ticon ~= icon and safety < 20 do
		TargetNearestEnemy()
		ticon = GetRaidTargetIndex("target")
		safety = safety + 1
	end
	return ticon == icon
end

function targetFriendIcon(icon)
	local ticon = nil
	local safety = 0
	while ticon ~= icon and safety < 20 do
		TargetNearestFriend()
		ticon = GetRaidTargetIndex("target")
		safety = safety + 1
	end	
	return ticon == icon
end

function haveTarget()
	return UnitName("target") ~= nil and UnitName("target") ~= ""
end

function target(unit)
	TargetUnit(unit)
end

function targetLast()
	TargetLastTarget()
end

function targetIsEnemy()
	return not targetIsFriend()--UnitIsEnemy("target", "player")
end

function targetIsFriend()
	return UnitIsFriend("target", "player")
end