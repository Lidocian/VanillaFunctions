local vf_slave = false

function vf_setSlave()
	vf_slave = true
end

function vf_setMaster()
	vf_slave = false
end

function vf_isSlave()
	return vf_slave
end

function vf_isMaster()
	return not vf_slave
end


function vf_slaveSetup()
	ChangeActionBarPage(2)
	vf_setSlave()

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


-- Combat Modes

vf_extendedRotationEnabled = false

function vf_enableExtendedRotation()
	vf_extendedRotationEnabled = true
end

function vf_disableExtendedRotation()
	vf_extendedRotationEnabled = false
end

vf_superExtendedRotationEnabled = false

function vf_enableSuperExtendedRotation()
	vf_superExtendedRotationEnabled = true
end

function vf_disableSuperExtendedRotation()
	vf_superExtendedRotationEnabled = false
end


-- Utility

function efclear()
	UIErrorsFrame:Clear()
end

function print(message)
	DEFAULT_CHAT_FRAME:AddMessage(message)
end



-- Frame and Events

function vf_onLoad()
	--print("Vanilla Functions Loaded")
end


local vf_frame = CreateFrame("Frame")
local vf_events = {}


function vf_events:ADDON_LOADED(addonName)
	if addonName == "VanillaFunctions" then
		vf_frame:UnregisterEvent("ADDON_LOADED")
		vf_onLoad()
	end
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
	arg6 = arg6 or "nil"
	arg7 = arg7 or "nil"
	arg8 = arg8 or "nil"
	arg9 = arg9 or "nil"
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