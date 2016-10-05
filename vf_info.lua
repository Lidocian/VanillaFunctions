
function mapZone()
	return GetRealZoneText()
end

function class(unit)
	local unit = unit or "player"
	local localizedClass, englishClass = UnitClass(unit)
	return englishClass
end

function inCombat(unit)
	local unit = unit or "player"
	return UnitAffectingCombat(unit)
end

function targetInCombat()
	return inCombat("target")
end

function health(unit)
	local unit = unit or "player"
	return UnitHealth(unit)
end

function healthMax(unit)
	local unit = unit or "player"
	return UnitHealthMax(unit)
end

function healthDeficit(unit)
	local unit = unit or "player"
	return UnitHealthMax(unit) - UnitHealth(unit)
end

function healthPct(unit)
	local unit = unit or "player"
	return UnitHealth(unit) / UnitHealthMax(unit)
end

function mana(unit)
	local unit = unit or "player"
	return UnitMana(unit)
end

function manaMax(unit)
	local unit = unit or "player"
	return UnitManaMax(unit)
end

function manaDeficit(unit)
	local unit = unit or "player"
	return UnitManaMax(unit) - UnitMana(unit)
end

function manaPct(unit)
	local unit = unit or "player"
	return UnitMana(unit) / UnitManaMax(unit)
end

function rage(unit)
	return mana(unit)
end

function energy(unit)
	return mana(unit)
end

function comboPoints()
	return GetComboPoints() 
end

function dead(unit)
	local unit = unit or "player"
	return UnitIsDeadOrGhost(unit) or not (health(unit) > 0)
end

function onGrid(unit)
	local unit = unit or "player"
	return UnitIsVisible(unit)
end

function haveAggro()
	return UnitName("targettarget") == UnitName("player")
end