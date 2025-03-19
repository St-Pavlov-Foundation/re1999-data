module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2InfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2InfoMO")

function slot0.init(slot0, slot1)
	slot0.timeId = slot1.timeId
	slot0.startTime = slot1.startTime / 1000
	slot0.endTime = slot1.endTime / 1000
	slot0.popRule = slot1.popRule
	slot0.layerInfos = GameUtil.rpcInfosToMap(slot1.layerInfos, WeekwalkVer2LayerInfoMO)
	slot0.prevSettle = nil

	if slot1:HasField("prevSettle") then
		slot0.prevSettle = WeekwalkVer2PrevSettleInfoMO.New()

		slot0.prevSettle:init(slot1.prevSettle)
	end

	slot0.isPopSettle = slot0.prevSettle and slot0.prevSettle.show
	slot0.snapshotInfos = GameUtil.rpcInfosToMap(slot1.snapshotInfos or {}, WeekwalkVer2SnapshotInfoMO, "no")
	slot0._layerInfosMap = {}

	for slot5, slot6 in pairs(slot0.layerInfos) do
		slot0._layerInfosMap[slot6:getLayer()] = slot6
	end

	slot0.issueId = lua_weekwalk_ver2_time.configDict[slot0.timeId] and slot2.issueId

	if not slot0.issueId then
		logError("WeekwalkVer2InfoMO weekwalk_ver2_time configDict not find timeId:" .. tostring(slot0.timeId))
	end
end

function slot0.getOptionSkills(slot0)
	if slot0._skillList and slot0._skillList._timeId == slot0.timeId then
		return slot0._skillList
	end

	slot0._skillList = string.splitToNumber(lua_weekwalk_ver2_time.configDict[slot0.timeId].optionalSkills, "#")
	slot0._skillList._timeId = slot0.timeId

	return slot0._skillList
end

function slot0.getHeroGroupSkill(slot0, slot1)
	return slot0.snapshotInfos[slot1] and slot2:getChooseSkillId()
end

function slot0.setHeroGroupSkill(slot0, slot1, slot2)
	if not slot0.snapshotInfos[slot1] then
		slot3 = WeekwalkVer2SnapshotInfoMO.New()
		slot3.no = slot1
		slot0.snapshotInfos[slot1] = slot3
	end

	slot3:setChooseSkillId(slot2)
end

function slot0.isOpen(slot0)
	return slot0.startTime <= ServerTime.now() and slot1 <= slot0.endTime
end

function slot0.allLayerPass(slot0)
	for slot4, slot5 in pairs(slot0.layerInfos) do
		if not slot5.allPass then
			return false
		end
	end

	return true
end

function slot0.setLayerInfo(slot0, slot1)
	slot0.layerInfos[slot1.id]:init(slot1)
end

function slot0.getLayerInfo(slot0, slot1)
	return slot0.layerInfos[slot1]
end

function slot0.getLayerInfoByLayerIndex(slot0, slot1)
	return slot0._layerInfosMap[slot1]
end

function slot0.getNotFinishedMap(slot0)
	for slot4 = WeekWalk_2Enum.MaxLayer, 1, -1 do
		if slot0._layerInfosMap[slot4] and slot5.unlock then
			return slot5, slot4
		end
	end
end

return slot0
