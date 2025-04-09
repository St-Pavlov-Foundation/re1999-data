module("modules.logic.fight.system.work.FightParallelPlayNextSkillStep", package.seeall)

slot0 = class("FightParallelPlayNextSkillStep", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.fightStepData = slot1
	slot0.preStepData = slot2
	slot0.fightStepDataList = slot3

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillCheck, slot0._parallelPlayNextSkillCheck, slot0)
end

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0._parallelPlayNextSkillCheck(slot0, slot1)
	if slot1 ~= slot0.preStepData then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot0.preStepData.fromId) then
		return
	end

	if FightCardDataHelper.isBigSkill(slot0.preStepData.actId) then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot0.fightStepData.fromId) then
		return
	end

	if FightCardDataHelper.isBigSkill(slot0.fightStepData.actId) then
		return
	end

	if FightSkillMgr.instance:isEntityPlayingTimeline(slot0.fightStepData.fromId) then
		return
	end

	if slot0.fightStepData.fromId == slot0.preStepData.fromId then
		return
	end

	if FightDataHelper.entityMgr:getById(slot0.fightStepData.fromId).side ~= FightDataHelper.entityMgr:getById(slot0.preStepData.fromId).side then
		return
	end

	if slot0.fightStepDataList then
		for slot10 = (tabletool.indexOf(slot0.fightStepDataList, slot1) or #slot0.fightStepDataList) + 1, #slot0.fightStepDataList do
			if slot0.fightStepDataList[slot10].actType == FightEnum.ActType.EFFECT then
				for slot15, slot16 in ipairs(slot11.actEffect) do
					if slot16.effectType == FightEnum.EffectType.DEAD and slot1.fromId == slot16.targetId then
						return
					end
				end
			end
		end
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, slot0._parallelPlayNextSkillCheck, slot0)

	slot0.fightStepData.isParallelStep = true

	FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillDoneThis, slot1)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, slot0._parallelPlayNextSkillCheck, slot0)
end

return slot0
