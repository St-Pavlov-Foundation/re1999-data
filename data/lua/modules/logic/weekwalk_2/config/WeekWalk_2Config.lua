module("modules.logic.weekwalk_2.config.WeekWalk_2Config", package.seeall)

slot0 = class("WeekWalk_2Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"weekwalk_ver2",
		"weekwalk_ver2_const",
		"task_weekwalk_ver2",
		"weekwalk_ver2_scene",
		"weekwalk_ver2_element",
		"weekwalk_ver2_cup",
		"weekwalk_ver2_skill",
		"weekwalk_ver2_time",
		"task_weekwalk_ver2",
		"weekwalk_ver2_element_res"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "task_weekwalk_ver2" then
		slot0:_initWeekWalkTask()

		return
	end

	if slot1 == "weekwalk_ver2_cup" then
		slot0:_initWeekWalkCup()

		return
	end
end

function slot0._initWeekWalkCup(slot0)
	slot0._cupInfoMap = {}

	for slot4, slot5 in ipairs(lua_weekwalk_ver2_cup.configList) do
		slot0._cupInfoMap[slot5.layerId] = slot0._cupInfoMap[slot5.layerId] or {}
		slot6[slot5.fightType] = slot0._cupInfoMap[slot5.layerId][slot5.fightType] or {}

		table.insert(slot6[slot5.fightType], slot5)
	end
end

function slot0.getCupTask(slot0, slot1, slot2)
	return slot0._cupInfoMap[slot1] and slot3[slot2]
end

function slot0.getWeekWalkTaskList(slot0, slot1)
	return slot0._taskTypeList[slot1]
end

function slot0._initWeekWalkTask(slot0)
	slot0._taskRewardList = {}
	slot0._taskTypeList = {}

	for slot4, slot5 in ipairs(lua_task_weekwalk_ver2.configList) do
		slot6 = slot0._taskTypeList[slot5.minTypeId] or {}

		table.insert(slot6, slot5)

		slot0._taskTypeList[slot5.minTypeId] = slot6

		slot0:_initTaskReward(slot5)
	end
end

function slot0._initTaskReward(slot0, slot1)
	slot2 = nil

	if not ((slot1.listenerType ~= "WeekwalkVer2SeasonCup" or tonumber(slot1.listenerParam)) and tonumber(slot1.layerId)) then
		return
	end

	slot0._taskRewardList[slot2] = slot0._taskRewardList[slot2] or {}

	for slot8 = 1, #string.split(slot1.bonus, "|") do
		if string.splitToNumber(slot4[slot8], "#")[1] == MaterialEnum.MaterialType.Currency and slot9[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			slot0._taskRewardList[slot2][slot1.id] = slot9[3]
		end
	end
end

function slot0.getWeekWalkRewardList(slot0, slot1)
	return slot0._taskRewardList[slot1]
end

slot0.instance = slot0.New()

return slot0
