vf_focustarget = ""
function setFocus()
	vf_focustarget = UnitName("target")
end

function getFocus()
	if not vf_focustarget then return 0 end
	return vf_focustarget
end

function assistFocus()
	if not vf_focustarget then return 0 end
	ClearTarget()
	AssistUnit(vf_focustarget)
end

function followFocus()
	if not vf_focustarget then return 0 end
	FollowUnit(vf_focustarget)
end

function targetFocus()
	if not vf_focustarget then return 0 end
	TargetUnit(vf_focustarget)
end