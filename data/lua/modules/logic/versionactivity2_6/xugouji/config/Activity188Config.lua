module("modules.logic.versionactivity2_6.xugouji.config.Activity188Config", package.seeall)

slot0 = class("Activity188Config", BaseConfig)

function slot0.onInit(slot0)
	slot0._episodeCfg = nil
	slot0._gameCfg = nil
	slot0._aiCfg = nil
	slot0._abilityCfg = nil
	slot0._skillCfg = nil
	slot0._taskCfg = nil
	slot0._buffCfg = nil
	slot0._cardCfg = nil
	slot0._constCfg = nil
	slot0._episodeDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity188_episode",
		"activity188_game",
		"activity188_ai",
		"activity188_ability",
		"activity188_skill",
		"activity188_buff",
		"activity188_task",
		"activity188_card",
		"activity188_const"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity188_episode" then
		slot0._episodeCfg = slot2
		slot0._episodeDict = {}

		for slot6, slot7 in ipairs(slot0._episodeCfg.configList) do
			slot0._episodeDict[slot7.activityId] = slot0._episodeDict[slot7.activityId] or {}

			table.insert(slot0._episodeDict[slot7.activityId], slot7)
		end
	elseif slot1 == "activity188_game" then
		slot0._gameCfg = slot2
	elseif slot1 == "activity188_ai" then
		slot0._aiCfg = slot2
	elseif slot1 == "activity188_ability" then
		slot0._abilityCfg = slot2
	elseif slot1 == "activity188_skill" then
		slot0._skillCfg = slot2
	elseif slot1 == "activity188_task" then
		slot0._taskCfg = slot2
	elseif slot1 == "activity188_buff" then
		slot0._buffCfg = slot2
	elseif slot1 == "activity188_card" then
		slot0._cardCfg = slot2
	elseif slot1 == "activity188_const" then
		slot0._constCfg = slot2
	end
end

function slot0.getEpisodeCfgList(slot0, slot1)
	return slot0._episodeDict[slot1] or {}
end

function slot0.getEpisodeCfg(slot0, slot1, slot2)
	if not slot0._episodeDict[slot1] then
		return nil
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8.episodeId == slot2 then
			return slot8
		end
	end
end

function slot0.getEpisodeCfgByEpisodeId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._episodeDict) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11.episodeId == slot1 then
				return slot11
			end
		end
	end
end

function slot0.getEpisodeCfgByPreEpisodeId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._episodeDict) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11.preEpisodeId == slot1 then
				return slot11
			end
		end
	end
end

function slot0.getEventCfg(slot0, slot1, slot2)
	return slot0._eventConfig.configDict[slot1] and slot3[slot2]
end

function slot0.getCardCfg(slot0, slot1, slot2)
	return slot0._cardCfg.configDict[slot1][slot2]
end

function slot0.getCardSkillCfg(slot0, slot1, slot2)
	return slot0._skillCfg.configDict[slot1][slot2]
end

function slot0.getGameCfg(slot0, slot1, slot2)
	return slot0._gameCfg.configDict[slot1] and slot3[slot2]
end

function slot0.getAbilityCfg(slot0, slot1, slot2)
	return slot0._abilityCfg.configDict[slot1][slot2]
end

function slot0.getGameItemListCfg(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in pairs(slot0._itemConfig.configDict[slot1]) do
		if slot2 == nil or slot9.compostType == slot2 then
			slot3[#slot3 + 1] = slot9
		end
	end

	return slot3
end

function slot0.getTaskList(slot0, slot1)
	if slot0._task_list then
		return slot0._task_list
	end

	slot0._task_list = {}

	for slot5, slot6 in pairs(slot0._taskCfg.configDict) do
		if slot1 == slot6.activityId then
			slot0._task_list[#slot0._task_list + 1] = slot6
		end
	end

	return slot0._task_list
end

function slot0.getConstCfg(slot0, slot1, slot2)
	if not slot0._constCfg.configDict[slot1] then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot2 == slot8.id then
			return slot8
		end
	end
end

function slot0.getConstValueCfg(slot0, slot1, slot2)
	if not slot0._constCfg.configDict[slot1] then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot2 == slot8.value1 then
			return slot8
		end
	end
end

function slot0.getBuffCfg(slot0, slot1, slot2)
	return slot0._buffCfg.configDict[slot1] and slot3[slot2]
end

slot0.instance = slot0.New()

return slot0
