function sayChat(message)
	SendChatMessage(message, "SAY")
end

function yellChat(message)
	SendChatMessage(message, "YELL")
end

function raidChat(message)
	SendChatMessage(message, "RAID")
end

function guildChat(message)
	SendChatMessage(message, "GUILD")
end

function whisperChat(message, player)
	SendChatMessage(message, "WHISPER", nil, player)
end

function doQuests()

	for i = 1, GetNumAvailableQuests() do
		SelectGossipAvailableQuest(i)
		AcceptQuest()
	end

	for i = 1, GetNumActiveQuests() do
		SelectGossipActiveQuest(i)
		--GetProgressText()
		CompleteQuest()
		GetQuestReward()
	end
	--CloseGossip()
end