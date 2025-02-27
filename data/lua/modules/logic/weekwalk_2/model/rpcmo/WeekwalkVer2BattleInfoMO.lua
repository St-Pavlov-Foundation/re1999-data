module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2BattleInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2BattleInfoMO")

function slot0.init(slot0, slot1)
	slot0.battleId = slot1.battleId
	slot0.status = slot1.status
	slot0.heroGroupSelect = slot1.heroGroupSelect
	slot0.elementId = slot1.elementId
	slot0.cupInfos = GameUtil.rpcInfosToMap(slot1.cupInfos or {}, WeekwalkVer2CupInfoMO, "index")
	slot0.chooseSkillIds = {}

	for slot5, slot6 in ipairs(slot1.chooseSkillIds) do
		table.insert(slot0.chooseSkillIds, slot6)
	end

	slot0.heroIds = {}
	slot0.heroInCDMap = {}

	for slot5, slot6 in ipairs(slot1.heroIds) do
		slot0.heroInCDMap[slot6] = true

		table.insert(slot0.heroIds, slot6)
	end

	slot0.star = slot0.status == WeekWalk_2Enum.BattleStatus.Finished and WeekWalk_2Enum.MaxStar or 0
end

function slot0.getCupMaxResult(slot0)
	for slot5, slot6 in pairs(slot0.cupInfos) do
		if 0 < slot6.result then
			slot1 = slot6.result
		end
	end

	return slot1
end

function slot0.heroInCD(slot0, slot1)
	return slot0.heroInCDMap[slot1]
end

function slot0.getChooseSkillId(slot0)
	return slot0.chooseSkillIds[1]
end

function slot0.setIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.getCupInfo(slot0, slot1)
	return slot0.cupInfos[slot1]
end

return slot0
