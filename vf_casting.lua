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


-- Casting

local vf_casting = false
function casting()
	return vf_casting
end

local vf_channeling = false
function channeling()
	return vf_channeling
end

function castingOrChanneling()
	return vf_casting or vf_channeling
end

local vf_currentCastSpellName = ""
function currentCastSpellName()
	return vf_currentCastSpellName
end

local vf_currentCastDuration = 0
function currentCastDuration()
	return vf_currentCastDuration
end

local vf_currentCastStartTime = 0
function currentCastStartTime()
	return vf_currentCastStartTime
end

local vf_currentCastEndTime = 0
function currentCastEndTime()
	return vf_currentCastEndTime
end

function currentCastTimeRemaining()
	local currentTime = GetTime()*1000
	return vf_currentCastStartTime + vf_currentCastDuration - currentTime
end


-- Frame and Events


function vf_casting_onLoad()
	-- Empty
end


local vf_casting_frame = CreateFrame("Frame")
local vf_casting_events = {}

function vf_casting_events:ADDON_LOADED(addonName)
	if addonName == "VanillaFunctions" then
		vf_casting_frame:UnregisterEvent("ADDON_LOADED")
		vf_casting_onLoad()
	end
end

function vf_castingStarted(spellName, startTime, endTime)
	vf_currentCastSpellName = spellName
	vf_currentCastStartTime = startTime
	vf_currentCastEndTime = endTime
	vf_currentCastDuration = endTime - startTime
end

function vf_castingStopped()
	vf_casting = false
	vf_channeling = false
	vf_currentCastSpellName = ""
	vf_currentCastDuration = 0
	vf_currentCastStartTime = 0
	vf_currentCastEndTime = 0
end

function vf_casting_events:UNIT_SPELLCAST_START(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo("player")
	--print("SPELLCAST_START: "..spellName)
	vf_casting = true
	vf_castingStarted(spellName, startTime, endTime)
end

function vf_casting_events:UNIT_SPELLCAST_STOP(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_STOP")
	if not channeling() then
		vf_castingStopped()
	end
end

function vf_casting_events:UNIT_SPELLCAST_CHANNEL_START(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo("player")
	--print("SPELLCAST_CHANNEL_START: "..spellName)
	vf_channeling = true
	vf_castingStarted(spellName, startTime, endTime)
end

function vf_casting_events:UNIT_SPELLCAST_CHANNEL_STOP(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_CHANNEL_STOP")
	vf_castingStopped()
end

function vf_casting_events:UNIT_SPELLCAST_DELAYED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo("player")
	vf_currentCastDuration = endTime - vf_currentCastStartTime
	--print("SPELLCAST_DELAYED: "..vf_currentCastDuration)
end

function vf_casting_events:UNIT_SPELLCAST_CHANNEL_UPDATE(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo("player")
	vf_currentCastDuration = endTime - vf_currentCastStartTime
	--print("SPELLCAST_CHANNEL_UPDATE: ")2w
end

function vf_casting_events:UNIT_SPELLCAST_FAILED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_FAILED")
	vf_castingStopped()
end

function vf_casting_events:UNIT_SPELLCAST_FAILED_QUIET(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_FAILED_QUIET")
	vf_castingStopped()
end

function vf_casting_events:UNIT_SPELLCAST_INTERRUPTED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_INTERRUPTED")
	vf_castingStopped()
end

function vf_casting_events:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("UNIT_SPELLCAST_SUCCEEDED")
	vf_castingStopped()
end

for k, v in pairs(vf_casting_events) do
	vf_casting_frame:RegisterEvent(k)
end

function vf_casting_eventHandler(this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	vf_casting_events[event](vf_casting_events, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
end

vf_casting_frame:SetScript("OnEvent", vf_casting_eventHandler)