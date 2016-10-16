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

function useTrinket1()
	UseInventoryItem(13)
end

function useTrinket2()
	UseInventoryItem(14)
end

function useTrinkets()
	UseInventoryItem(13)
	UseInventoryItem(14)
end

local vf_landMountSpells = {"Summon Warhorse", "Summon Felsteed"}
local vf_landMountItems = {"Brown Skeletal Horse", "Gray Kodo", "Black Hawkstrider"}
local vf_flyingMountSpells = {}
local vf_flyingMountItems = {"Tawny Windrider", "Blue Windrider", "Green Windrider"}

function mount()
	if IsOutdoors() then
		for i=1, table.getn(vf_flyingMountSpells) do
			cast(vf_flyingMountSpells[i])
		end
		for i=1, table.getn(vf_flyingMountItems) do
			useItem(vf_flyingMountItems[i])
		end
		for i=1, table.getn(vf_landMountSpells) do
			cast(vf_landMountSpells[i])
		end
		for i=1, table.getn(vf_landMountItems) do
			useItem(vf_landMountItems[i])
		end
	end
	efclear()
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