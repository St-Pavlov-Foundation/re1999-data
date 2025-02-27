module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2LayerInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2LayerInfoMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.sceneId = slot1.sceneId
	slot0.allPass = slot1.allPass
	slot0.finished = slot1.finished
	slot0.unlock = slot1.unlock
	slot0.showFinished = slot1.showFinished
	slot0.battleInfos, slot0.battleInfoElementMap = GameUtil.rpcInfosToListAndMap(slot1.battleInfos, WeekwalkVer2BattleInfoMO, "elementId")
	slot5 = "index"
	slot0.elementInfos = GameUtil.rpcInfosToMap(slot1.elementInfos, WeekwalkVer2ElementInfoMO, slot5)
	slot0.battleIds = {}
	slot0.battleIndex = {}

	for slot5, slot6 in pairs(slot0.elementInfos) do
		slot7 = slot0:getBattleInfoByIndex(slot6.index)

		slot7:setIndex(slot6.index)

		slot0.battleIds[slot6.index] = slot7.battleId
		slot0.battleIndex[slot7.battleId] = slot6.index
	end

	table.sort(slot0.battleInfos, function (slot0, slot1)
		return (uv0.battleIndex[slot0.battleId] or 0) < (uv0.battleIndex[slot1.battleId] or 0)
	end)

	slot0.config = lua_weekwalk_ver2.configDict[slot0.id]
	slot0.sceneConfig = lua_weekwalk_ver2_scene.configDict[slot0.config.sceneId]
end

function slot0.getBattleInfo(slot0, slot1)
	return slot0:getBattleInfoByIndex(slot1)
end

function slot0.getBattleInfoByIndex(slot0, slot1)
	slot3 = slot0.elementInfos[slot1] and slot2.elementId

	return slot3 and slot0.battleInfoElementMap[slot3]
end

function slot0.getBattleInfoByBattleId(slot0, slot1)
	for slot5, slot6 in pairs(slot0.battleInfos) do
		if slot6.battleId == slot1 then
			return slot6
		end
	end
end

function slot0.getLayer(slot0)
	return slot0.config.layer
end

function slot0.getChooseSkillNum(slot0)
	return slot0.config.chooseSkillNum
end

function slot0.getHasStarIndex(slot0)
	for slot4 = #slot0.battleInfos, 1, -1 do
		if slot0.battleInfos[slot4].star > 0 then
			return slot4
		end
	end

	return 0
end

function slot0.heroInCD(slot0, slot1)
	for slot5, slot6 in pairs(slot0.battleInfos) do
		if slot6:heroInCD(slot1) then
			return true
		end
	end
end

return slot0
