-- Bags

function bagSize(i)
	return GetContainerNumSlots(i)
end

function bagSlotOf(itemName)
	local bag, slot = nil
	for bag = 0, 4 do
		for slot = 1, bagSize(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link and strfind(link, itemName) then
				return bag, slot
			end
		end
	end
end

function haveInBags(itemName)
	if bagSlotOf(itemName) then 
		return true 
	end
	return false
end

function useItem(itemName)
	if haveInBags(itemName) then
		UseContainerItem(bagSlotOf(itemName))
		return true
	else
		return false
	end
end


function pickAndDropItemOnTarget(itemName)
	local bag, slot = bagSlotOf(itemName)
	PickupContainerItem(bag, slot)
	DropItemOnUnit("target")
end


-- Skills

function useTradeSkill(skillName)
	for i=1, GetNumTradeSkills() do
		if GetTradeSkillInfo(i) == skillName then
			CloseTradeSkill()
			DoTradeSkill(i)
			break
		end
	end
end