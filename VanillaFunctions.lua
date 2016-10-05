-- Min Settings

function vf_superLow()
	ConsoleExec("SET weatherDensity 0")
	ConsoleExec("m2Faster 1")
	ConsoleExec("ffx 0")
	ConsoleExec("hwPCF 1")
	ConsoleExec("timingmethod 1")
	ConsoleExec("showfootprints 0")
	ConsoleExec("showfootprintparticles 0")
	ConsoleExec("horizonfarclip 1305")
	ConsoleExec("detailDoodadAlpha 0")
	ConsoleExec("groundeffectdist 1")
	ConsoleExec("smallcull 1")
	ConsoleExec("skycloudlod 1")
	ConsoleExec("characterAmbient 1")

	ConsoleExec("overridefarclip 0")
	ConsoleExec("farclip 50")
	ConsoleExec("groundEffectDensity 0")
	ConsoleExec("groundEffectDistance 0")
	ConsoleExec("environmentDetail 0")
	ConsoleExec("particleDensity 10")
	ConsoleExec("shadowMode 0")
	ConsoleExec("shadowlod 0")
	ConsoleExec("showshadow 0")
	ConsoleExec("extshadowquality 0")
	ConsoleExec("waterDetail 0")
	ConsoleExec("reflectionMode 0")
	ConsoleExec("sunShafts 0")
	ConsoleExec("basemip 1")
	ConsoleExec("terrainMipLevel 1")
	ConsoleExec("projectedTextures 0")
	ConsoleExec("weatherDensity 0")
	ConsoleExec("componentTextureLevel 0")
	ConsoleExec("textureFilteringMode 0")
	ConsoleExec("Sound_EnableAllSound 0")
end





-- Utility

function efclear()
	UIErrorsFrame:Clear()
end

function print(message)
	DEFAULT_CHAT_FRAME:AddMessage(message)
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

-- Addon Functions

function vf_onLoad()
	--Print("Varua Functions Loaded")
end


-- Frame and Events

local vf_frame = CreateFrame("Frame")
local vf_events = {}

function vf_events:ADDON_LOADED(addonName)
	if addonName == "VaruaFunctions" then
		vf_frame:UnregisterEvent("ADDON_LOADED")
		vf_onLoad()
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

function vf_events:UNIT_SPELLCAST_START(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo("player")
	--print("SPELLCAST_START: "..spellName)
	vf_casting = true
	vf_castingStarted(spellName, startTime, endTime)
end

function vf_events:UNIT_SPELLCAST_STOP(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_STOP")
	if not channeling() then
		vf_castingStopped()
	end
end

function vf_events:UNIT_SPELLCAST_CHANNEL_START(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo("player")
	--print("SPELLCAST_CHANNEL_START: "..spellName)
	vf_channeling = true
	vf_castingStarted(spellName, startTime, endTime)
end

function vf_events:UNIT_SPELLCAST_CHANNEL_STOP(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_CHANNEL_STOP")
	vf_castingStopped()
end

function vf_events:UNIT_SPELLCAST_DELAYED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo("player")
	vf_currentCastDuration = endTime - vf_currentCastStartTime
	--print("SPELLCAST_DELAYED: "..vf_currentCastDuration)
end

function vf_events:UNIT_SPELLCAST_CHANNEL_UPDATE(unit, spellName, spellRank)
	if unit ~= "player" then return end
	local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo("player")
	vf_currentCastDuration = endTime - vf_currentCastStartTime
	--print("SPELLCAST_CHANNEL_UPDATE: ")2w
end

function vf_events:UNIT_SPELLCAST_FAILED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_FAILED")
	vf_castingStopped()
end

function vf_events:UNIT_SPELLCAST_FAILED_QUIET(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_FAILED_QUIET")
	vf_castingStopped()
end

function vf_events:UNIT_SPELLCAST_INTERRUPTED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("SPELLCAST_INTERRUPTED")
	vf_castingStopped()
end

function vf_events:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, spellRank)
	if unit ~= "player" then return end
	--print("UNIT_SPELLCAST_SUCCEEDED")
	vf_castingStopped()
end

for k, v in pairs(vf_events) do
	vf_frame:RegisterEvent(k)
end

function vf_eventHandler(this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	arg1 = arg1 or "nil"
	arg2 = arg2 or "nil"
	arg3 = arg3 or "nil"
	arg4 = arg4 or "nil"
	arg5 = arg5 or "nil"
	--print(event..", "..arg1..", "..arg2..", "..arg3..", "..arg4..", "..arg5)
	vf_events[event](vf_events, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
end

vf_frame:SetScript("OnEvent", vf_eventHandler)


-- Slash Commands

SLASH_STUCK1 = "/stuck"
SlashCmdList["STUCK"] = Stuck


SLASH_RELOADUI1 = "/reloadui"
SLASH_RELOADUI2 = "/rl"
SlashCmdList["RELOADUI"] = ReloadUI

SLASH_PRINT1 = "/print"
SlashCmdList["PRINT"] = print