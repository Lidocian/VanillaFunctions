function cast(spell, rank)
	if spellReady(spell) and not castingOrChanneling() then
		if rank then
			CastSpellByName(spell.."(Rank "..rank..")")
		else
			CastSpellByName(spell)
		end
	end
end

function castEnemyIcon(spell, icon)
	if targetEnemyIcon(icon) then
		cast(spell)
	end
end

function castFriendIcon(spell, icon)	
	if targetFriendIcon(icon) then
		cast(spell)
	end
end

function castOnUnit(spell, rank, unit)
	if rank == 0 then rank = nil end
	unit = unit or "player"
	
	if UnitExists(unit) then
		target(unit)
		cast(spell, rank)
		if unit ~= "target" then
			TargetLastTarget()
		end
	end
end

function buffUnit(buff, unit)
	unit = unit or "player"
	if UnitExists(unit) and not buffed(buff, unit) then
		target(unit)
		cast(buff)
		if unit ~= "target" then
			TargetLastTarget()
		end
	end
end

function buffSelf(buff)
	buffUnit(buff, "player")
end

function buffTarget(buff)
	buffUnit(buff, "target")
end

function debuffTarget(debuff)
	buffTarget(debuff)
end