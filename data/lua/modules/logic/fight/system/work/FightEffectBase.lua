module("modules.logic.fight.system.work.FightEffectBase", package.seeall)

slot0 = class("FightEffectBase", FightWorkItem)

function slot0.onConstructor(slot0)
	slot0.skipAutoPlayData = false
end

function slot0.onAwake(slot0, slot1, slot2)
	uv0.super.onAwake(slot0, slot1, slot2)

	slot0.fightStepData = slot1
	slot0.actEffectData = slot2
end

function slot0._fightWorkSafeTimer(slot0)
	if slot0.fightStepData then
		logError(string.format("战斗保底 fightwork ondone, className = %s , 步骤类型:%s, actId:%s", slot0.__cname, slot0.fightStepData.actType, slot0.fightStepData.actId))
	end

	slot0:onDone(false)
end

function slot0.start(slot0, slot1)
	if slot0.actEffectData then
		if slot0.actEffectData:isDone() then
			slot0:onDone(true)

			return
		else
			xpcall(slot0.beforePlayEffectData, __G__TRACKBACK__, slot0)

			if not slot0.skipAutoPlayData then
				slot0:playEffectData()
			end
		end
	end

	return uv0.super.start(slot0, slot1)
end

function slot0.getEffectData(slot0)
	return slot0.actEffectData
end

function slot0.beforeStart(slot0)
	if slot0.actEffectData then
		FightController.instance:dispatchEvent(FightEvent.InvokeFightWorkEffectType, slot0.actEffectData.effectType)
	end

	FightSkillBehaviorMgr.instance:playSkillEffectBehavior(slot0.fightStepData, slot0.actEffectData)
end

function slot0.playEffectData(slot0)
	FightDataHelper.playEffectData(slot0.actEffectData)
end

function slot0.beforePlayEffectData(slot0)
end

function slot0.beforeClearWork(slot0)
end

function slot0.getAdjacentSameEffectList(slot0, slot1, slot2)
	slot3 = {}

	table.insert(slot3, {
		actEffectData = slot0.actEffectData,
		fightStepData = slot0.fightStepData
	})
	xpcall(slot0.detectAdjacentSameEffect, __G__TRACKBACK__, slot0, slot3, slot1, slot2)

	return slot3
end

function slot0.detectAdjacentSameEffect(slot0, slot1, slot2, slot3)
	slot4 = slot0.actEffectData.nextActEffectData

	while slot4 do
		slot5 = slot4.effectType

		if slot2 and slot2[slot5] then
			if not slot4:isDone() then
				table.insert(slot1, {
					actEffectData = slot4,
					fightStepData = slot0.fightStepData
				})
			end

			if slot5 == FightEnum.EffectType.FIGHTSTEP then
				slot4 = slot4.fightStepNextActEffectData
			else
				slot4 = slot4.nextActEffectData
			end
		elseif slot5 == slot0.actEffectData.effectType then
			if not slot4:isDone() then
				table.insert(slot1, {
					actEffectData = slot4,
					fightStepData = slot0.fightStepData
				})
			end

			slot4 = slot4.nextActEffectData
		elseif slot5 == FightEnum.EffectType.FIGHTSTEP then
			slot4 = slot4.nextActEffectData
		else
			return slot1
		end
	end

	if slot3 then
		if not FightDataHelper.roundMgr:getRoundData() then
			logError("找不到roundData")

			return slot1
		end

		slot6 = slot5.fightStep

		if not slot0.fightStepData.custom_stepIndex then
			return slot1
		end

		slot8 = slot6[slot0.fightStepData.custom_stepIndex + 1]

		while slot8 do
			if FightHelper.isTimelineStep(slot8) then
				return slot1
			end

			if #slot8.actEffect == 0 then
				slot8 = slot6[slot7 + 1]
			elseif slot0:addSameEffectDetectNextStep(slot1, slot2, slot8) then
				slot8 = slot6[slot7 + 1]
			else
				return slot1
			end
		end
	end

	return slot1
end

function slot0.addSameEffectDetectNextStep(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot3.actEffect) do
		if slot2 and slot2[slot8.effectType] then
			if not slot8:isDone() then
				table.insert(slot1, {
					actEffectData = slot8,
					fightStepData = slot3
				})
			end
		elseif slot8.effectType == slot0.actEffectData.effectType then
			if not slot8:isDone() then
				table.insert(slot1, {
					actEffectData = slot8,
					fightStepData = slot3
				})
			end
		elseif slot8.effectType == FightEnum.EffectType.FIGHTSTEP then
			if not slot0:addSameEffectDetectNextStep(slot1, slot2, slot8.fightStep) then
				return false
			end
		else
			return false
		end
	end

	return true
end

return slot0
