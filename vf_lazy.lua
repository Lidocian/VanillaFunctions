local ctrltime = 0
local alttime = 0
local shift_time = 0
local ctrlalttime = 0
local ctrlshifttime = 0
local altshifttime = 0
local greenrolltime = 0

local WHITE = "|cffffffff"
local RED = "|cffff0000"
local GREEN = "|cff00ff00"
local BLUE = "|cff00eeee"

local QuestRecord = {}
local ActiveQuest = {}
local AvailableQuest = {}


local Original_SelectGossipActiveQuest = SelectGossipActiveQuest
local Original_SelectGossipAvailableQuest = SelectGossipAvailableQuest
local Original_SelectActiveQuest = SelectActiveQuest
local Original_SelectAvailableQuest = SelectAvailableQuest




















-- Frame and Events

function vf_lazy_onLoad()
	SelectGossipActiveQuest = LazyPig_SelectGossipActiveQuest;
	SelectGossipAvailableQuest = LazyPig_SelectGossipAvailableQuest;
	SelectActiveQuest = LazyPig_SelectActiveQuest;
	SelectAvailableQuest = LazyPig_SelectAvailableQuest;
end


local vf_lazy_frame = CreateFrame("Frame")
local vf_lazy_events = {}


function vf_lazy_events:ADDON_LOADED(addonName)
	if addonName == "VanillaFunctions" then
		vf_lazy_frame:UnregisterEvent("ADDON_LOADED")
		vf_lazy_onLoad()
	end
end

function vf_lazy_events:QUEST_DETAIL()
	if vf_isSlave() then
		AcceptQuest()
	end
end

function vf_lazy_events:QUEST_ACCEPT_CONFIRM()
	if vf_isSlave() then
		AcceptQuest()
	end
end

function vf_lazy_events:PARTY_INVITE_REQUEST()
	if vf_isSlave() then
		AcceptGroup()
		StaticPopup_Hide("PARTY_INVITE")
	end
end

function vf_lazy_events:RESURRECT_REQUEST()	
	AcceptResurrect()
	StaticPopup_Hide("RESURRECT_NO_TIMER")
	StaticPopup_Hide("RESURRECT_NO_SICKNESS")
	StaticPopup_Hide("RESURRECT")
end

function vf_lazy_events:QUEST_GREETING()
	ActiveQuest = {}
	AvailableQuest = {}
	for i=1, GetNumActiveQuests() do
		ActiveQuest[i] = GetActiveTitle(i).." "..GetActiveLevel(i)
	end
	for i=1, GetNumAvailableQuests() do
		AvailableQuest[i] = GetAvailableTitle(i).." "..GetAvailableLevel(i)
	end	

	LazyPig_ReplyQuest(event);
end

function vf_lazy_events:GOSSIP_SHOW()
	local GossipOptions = {};
	local dsc = nil
	local gossipnr = nil
	local gossipbreak = nil
	local processgossip = IsShiftKeyDown()
	
	dsc,GossipOptions[1],_,GossipOptions[2],_,GossipOptions[3],_,GossipOptions[4],_,GossipOptions[5] = GetGossipOptions()	

	ActiveQuest = LazyPig_ProcessQuests(GetGossipActiveQuests())
	AvailableQuest = LazyPig_ProcessQuests(GetGossipAvailableQuests())
	
	if QuestRecord["qnpc"] ~= UnitName("target") then
		QuestRecord["index"] = 0
		QuestRecord["qnpc"] = UnitName("target")
	end
	
	if table.getn(AvailableQuest) ~= 0 or table.getn(ActiveQuest) ~= 0 then 
		gossipbreak = true 
	end
	
	--DEFAULT_CHAT_FRAME:AddMessage("gossip: "..table.getn(GossipOptions))
	--DEFAULT_CHAT_FRAME:AddMessage("active: "..table.getn(ActiveQuest))
	--DEFAULT_CHAT_FRAME:AddMessage("available: "..table.getn(AvailableQuest))
	
	for i=1, getn(GossipOptions) do
		if GossipOptions[i] == "binder" then
			local bind = GetBindLocation();
			--if not (bind == GetSubZoneText() or bind == GetZoneText() or bind == GetRealZoneText() or bind == GetMinimapZoneText()) then
			if bind ~= GetSubZoneText() then
				--DEFAULT_CHAT_FRAME:AddMessage(bind)
				--DEFAULT_CHAT_FRAME:AddMessage(GetSubZoneText())
				gossipbreak = true
			end	
		elseif gossipnr then
			gossipbreak = true
		elseif (GossipOptions[i] == "trainer" or GossipOptions[i] == "vendor" and processgossip or GossipOptions[i] == "battlemaster" and (LPCONFIG.QBG or processgossip) or GossipOptions[i] == "gossip" and (IsAltKeyDown() or IsShiftKeyDown() or string.find(dsc, "Teleport me to the Molten Core") and processgossip)) then
			gossipnr = i
		elseif GossipOptions[i] == "taxi" and processgossip then	
			gossipnr = i
			LazyPig_Dismount();	
		end
	end
	
	if not gossipbreak and gossipnr then
		SelectGossipOption(gossipnr);
	else
		LazyPig_ReplyQuest(event);
	end
end

function vf_lazy_events:QUEST_PROGRESS()
	LazyPig_ReplyQuest(event)
end

function vf_lazy_events:QUEST_COMPLETE()
	LazyPig_ReplyQuest(event)
end


for k, v in pairs(vf_lazy_events) do
	vf_lazy_frame:RegisterEvent(k)
end

function vf_lazy_eventHandler(this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	vf_lazy_events[event](vf_events, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
end

vf_lazy_frame:SetScript("OnEvent", vf_lazy_eventHandler)























function vf_lazy_update()
	local current_time = GetTime();
	local shiftstatus = IsShiftKeyDown();
	local ctrlstatus = IsControlKeyDown();
	local altstatus = IsAltKeyDown();
	
	if shiftstatus then
		shift_time = current_time
	elseif altstatus and not ctrlstatus and current_time > alttime then
		alttime = current_time + 0.75
	elseif not altstatus and ctrlstatus and current_time > ctrltime then
		ctrltime = current_time + 0.75
	elseif not altstatus and not ctrlstatus or altstatus and ctrlstatus then 
		ctrltime = 0
		alttime = 0
	end	
	if ctrlstatus and not shiftstatus and altstatus and current_time > ctrlalttime then
		ctrlalttime = current_time + 0.75
	elseif ctrlstatus and shiftstatus and not altstatus and current_time > ctrlshifttime then
		ctrlshifttime = current_time + 0.75
	elseif not ctrlstatus and shiftstatus and altstatus and current_time > altshifttime then
		altshifttime = current_time + 0.75
	elseif ctrlstatus and shiftstatus and altstatus then
		ctrlshifttime = 0
		ctrlalttime = 0
		altshifttime = 0
	end

	if shiftstatus or altstatus then
		if QuestFrameDetailPanel:IsVisible() then
			AcceptQuest();
		end
	elseif QuestRecord["details"] and not shiftstatus then
		LazyPig_RecordQuest();
	end
end


vf_lazy_frame:SetScript("OnUpdate", vf_lazy_update)
























function inviteAoe()
	LazyPigMultibox_AOEInvite()
end

function inviteFriends()
	LazyPigMultibox_InviteFriends()
end

function disband()
	if UnitInRaid("player") then
		for i = 1, 40 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if (rank ~= 2) then
				UninviteUnit("raid"..i)
			end
		end
	else
		for i = 1, GetNumPartyMembers() do
			UninviteUnit("party"..i)
		end
	end
end

function LazyPigMultibox_PlayerInGrp(name)
	local InRaid = UnitInRaid("player")
	local PLAYER = "player"
	local PET = ""
	local group = nil
	local NumMembers = nil
	local counter = nil
	local u = nil

	if InRaid then
		NumMembers = GetNumRaidMembers()
		counter = 1
		group = "raid"
	else
		NumMembers = GetNumPartyMembers()
		counter = 0
		group = "party"
	end

	while counter <= NumMembers do
		if counter == 0 then
			u = PLAYER
		else
			u = group..""..counter
		end
		if UnitName(u) == name then
			return true
		end
		counter = counter + 1
	end
	return false
end

function LazyPigMultibox_InviteGuildMates()
	SetGuildRosterShowOffline(0);
	SetGuildRosterSelection(0);
	GetGuildRosterInfo(0);
	
	local playerName = UnitName("player");
	local numGuildMembers = GetNumGuildMembers();
	for i = 1, numGuildMembers, 1 do
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
		if ( name ~= playerName and online ) then
			if not LazyPigMultibox_PlayerInGrp(name) then
				InviteUnit(name);
			end	
		end
	end
end

function LazyPigMultibox_InviteFriends()
	for i = 1, GetNumFriends() do
		local name, level, class, area, connected, status, note = GetFriendInfo(i)
		if connected then
			if name and not LazyPigMultibox_PlayerInGrp(name) then
				InviteUnit(name);
			end	
		end
	end
end

function LazyPigMultibox_AOEInvite()
	local Names = {}
	for i=0,30 do
		if UnitExists("target") and UnitIsPlayer("target") and not UnitIsUnit("player","target") then
			local name = GetUnitName("target")
			if not LazyPigMultibox_PlayerInGrp(name) and not Names[name] then
				Names[name] = true
				InviteUnit(name)
			end	
		end
		TargetNearestFriend()
	end
	ClearTarget()
end























function LazyPig_ProcessQuests(...)
	local quest = {}
	if arg then
		for i = 1, table.getn(arg), 2 do
			local count, title, level = i, arg[i], arg[i+1]
			if count > 1 then count = (count+1)/2 end
			quest[count] = title.." "..level
		end
	end
	return quest
end

function LazyPig_PrepareQuestAutoPickup()
	if IsAltKeyDown() then
		GossipFrameCloseButton:Click();
		ClearTarget();
	end	
end

function LazyPig_SelectGossipActiveQuest(index, norecord)
	if not ActiveQuest[index] then 
		--DEFAULT_CHAT_FRAME:AddMessage("LazyPig_SelectGossipActiveQuest Error");
	elseif not norecord then
		LazyPig_RecordQuest(ActiveQuest[index])
	end
	Original_SelectGossipActiveQuest(index);
end

function LazyPig_SelectGossipAvailableQuest(index, norecord)
	if not AvailableQuest[index] then 
		--DEFAULT_CHAT_FRAME:AddMessage("LazyPig_SelectGossipAvailableQuest Error");
	elseif not norecord then
		LazyPig_RecordQuest(AvailableQuest[index])
	end
	Original_SelectGossipAvailableQuest(index);
end

function LazyPig_SelectActiveQuest(index, norecord)
	if not ActiveQuest[index] then 
		--DEFAULT_CHAT_FRAME:AddMessage("LazyPig_SelectActiveQuest Error");
	elseif not norecord then
		LazyPig_RecordQuest(ActiveQuest[index])
	end
	Original_SelectActiveQuest(index);
end

function LazyPig_SelectAvailableQuest(index, norecord)
	if not AvailableQuest[index] then 
		--DEFAULT_CHAT_FRAME:AddMessage("LazyPig_SelectAvailableQuest Error");
	elseif not norecord then
		LazyPig_RecordQuest(AvailableQuest[index])
	end
	Original_SelectAvailableQuest(index);
end

function LazyPig_FixQuest(quest, annouce)
	if not QuestRecord["details"] then
		annouce = true
	end
	if UnitLevel("player") == 60 then	
		if string.find(quest, "Fight for Warsong Gulch") then
			QuestRecord["details"] = "Fight for Warsong Gulch 60"
		elseif string.find(quest, "Battle of Warsong Gulch") then
			QuestRecord["details"] = "Battle of Warsong Gulch 60"	
		elseif string.find(quest, "Claiming Arathi Basin") then
			QuestRecord["details"] = "Claiming Arathi Basin 60"	
		elseif string.find(quest, "Conquering Arathi Basin") then
			QuestRecord["details"] = "Conquering Arathi Basin 60"
		end
	end
	if QuestRecord["details"] and annouce then 
		UIErrorsFrame:Clear();
		UIErrorsFrame:AddMessage("Recording: "..QuestRecord["details"])
	end
end

function LazyPig_RecordQuest(qdetails)
	if IsShiftKeyDown() and qdetails then
		if QuestRecord["details"] ~= qdetails then
			QuestRecord["details"] = qdetails
		end	
		LazyPig_FixQuest(QuestRecord["details"], true)
	elseif not IsShiftKeyDown() and QuestRecord["details"] then
		QuestRecord["details"] = nil
	end
	QuestRecord["progress"] = true
end

function LazyPig_ReplyQuest(event)
	if IsShiftKeyDown() or IsAltKeyDown() then
		if QuestRecord["details"] then
			UIErrorsFrame:Clear();
			UIErrorsFrame:AddMessage("Replaying: "..QuestRecord["details"])
		end
		
		if event == "GOSSIP_SHOW" then
			if QuestRecord["details"] then
				for blockindex,blockmatch in pairs(ActiveQuest) do
					if blockmatch == QuestRecord["details"] then
						Original_SelectGossipActiveQuest(blockindex)
						return
					end
				end
				for blockindex,blockmatch in pairs(AvailableQuest) do
					if blockmatch == QuestRecord["details"] then
						Original_SelectGossipAvailableQuest(blockindex)
						return
					end
				end
			elseif table.getn(ActiveQuest) == 0 and table.getn(AvailableQuest) == 1 or IsAltKeyDown() and table.getn(AvailableQuest) > 0 then
				LazyPig_SelectGossipAvailableQuest(1, true)
			elseif table.getn(ActiveQuest) == 1 and table.getn(AvailableQuest) == 0 or IsAltKeyDown() and table.getn(ActiveQuest) > 0 then
				local nr = table.getn(ActiveQuest)
				if QuestRecord["progress"] and (nr - QuestRecord["index"]) > 0 then
					--DEFAULT_CHAT_FRAME:AddMessage("++quest dec nr - "..nr.." index - "..QuestRecord["index"])
					QuestRecord["index"] = QuestRecord["index"] + 1
					nr = nr - QuestRecord["index"]
				end
				LazyPig_SelectGossipActiveQuest(nr, true)	
			end
		elseif event == "QUEST_GREETING" then
			if QuestRecord["details"] then
				for blockindex,blockmatch in pairs(ActiveQuest) do
					if blockmatch == QuestRecord["details"] then
						Original_SelectActiveQuest(blockindex)
						return
					end
				end
				for blockindex,blockmatch in pairs(AvailableQuest) do
					if blockmatch == QuestRecord["details"] then
						Original_SelectAvailableQuest(blockindex)
						return
					end
				end
			elseif table.getn(ActiveQuest) == 0 and table.getn(AvailableQuest) == 1 or IsAltKeyDown() and table.getn(AvailableQuest) > 0 then
				LazyPig_SelectAvailableQuest(1, true)
			elseif table.getn(ActiveQuest) == 1 and table.getn(AvailableQuest) == 0 or IsAltKeyDown() and table.getn(ActiveQuest) > 0 then
				local nr = table.getn(ActiveQuest)
				if QuestRecord["progress"] and (nr - QuestRecord["index"]) > 0 then
					--DEFAULT_CHAT_FRAME:AddMessage("--quest dec nr - "..nr.." index - "..QuestRecord["index"])
					QuestRecord["index"] = QuestRecord["index"] + 1
					nr = nr - QuestRecord["index"]
				end
				LazyPig_SelectActiveQuest(nr, true)
			end
	
		elseif event == "QUEST_PROGRESS" then
			CompleteQuest()
		elseif event == "QUEST_COMPLETE" and GetNumQuestChoices() == 0 then
			GetQuestReward(0)
		end	
	end
end