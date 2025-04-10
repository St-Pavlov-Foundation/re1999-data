module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyActionData", package.seeall)

slot0 = class("EnemyActionData")

function slot0.ctor(slot0)
	slot0._round = 0
	slot0._curBehaviorId = 1
	slot0._loopIndex = 1
	slot0._behaviorData = {}
end

function slot0.init(slot0, slot1)
	slot0._config = LengZhou6Config.instance:getEliminateBattleEnemyBehavior(slot1)
	slot0._curBehaviorId = 1

	if slot0._behaviorData == nil then
		slot0._behaviorData = {}
	end

	for slot5 = 1, #slot0._config do
		slot7 = EnemyBehaviorData.New()

		slot7:init(slot0._config[slot5])
		table.insert(slot0._behaviorData, slot7)
	end
end

function slot0.initLoopIndex(slot0, slot1, slot2)
	slot0._startIndex = slot1
	slot0._endIndex = slot2
end

function slot0._haveNeedActionSkill(slot0)
	slot0._round = slot0._round + 1

	if slot0:calCurResidueCd() and slot1 == 0 then
		return true
	end

	return false
end

function slot0.calCurResidueCd(slot0)
	return math.max(slot0:getCurBehaviorCd() - slot0._round, 0)
end

function slot0.getCurBehaviorCd(slot0)
	if slot0._behaviorData[slot0._curBehaviorId] then
		return slot1:cd()
	end

	return 0
end

function slot0.updateCurBehaviorId(slot0)
	slot1 = #slot0._behaviorData

	if slot0._endIndex ~= nil and slot0._loopIndex > 1 then
		slot1 = slot0._endIndex
	end

	if slot0._curBehaviorId == slot1 then
		slot0._loopIndex = slot0._loopIndex + 1
		slot0._curBehaviorId = slot0._startIndex == nil and 1 or slot0._startIndex
	else
		slot0._curBehaviorId = slot0._curBehaviorId + 1
	end
end

function slot0.setCurBehaviorId(slot0, slot1)
	slot0._curBehaviorId = slot1
end

function slot0.getCurBehaviorId(slot0)
	return slot0._curBehaviorId
end

function slot0.getCurRound(slot0)
	return slot0._round
end

function slot0.setCurRound(slot0, slot1)
	slot0._round = slot1
end

function slot0.getCurBehavior(slot0)
	return slot0._behaviorData[slot0._curBehaviorId] or nil
end

function slot0.getSkillList(slot0)
	if slot0:_haveNeedActionSkill() then
		if slot0:getCurBehavior() == nil then
			logError("curBehavior is nil: index " .. slot0._curBehaviorId)

			return nil
		end

		slot0._round = slot0._round - slot2:cd()

		slot0:updateCurBehaviorId()

		return slot2:getSkillList(true)
	end

	return nil
end

return slot0
