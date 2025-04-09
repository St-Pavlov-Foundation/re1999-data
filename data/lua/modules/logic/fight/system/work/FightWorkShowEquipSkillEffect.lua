module("modules.logic.fight.system.work.FightWorkShowEquipSkillEffect", package.seeall)

slot0 = class("FightWorkShowEquipSkillEffect", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.fightStepData = slot1
	slot3 = FightDataHelper.roundMgr:getRoundData() and slot2.fightStep
	slot4 = nil

	if slot0.fightStepData.custom_stepIndex then
		slot4 = slot0.fightStepData.custom_stepIndex + 1
	end

	slot0._nextStepData = slot3 and slot3[slot4]
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5)

	if slot0.fightStepData.actType == FightEnum.ActType.SKILL and not FightReplayModel.instance:isReplay() and EquipConfig.instance:isEquipSkill(slot0.fightStepData.actId) then
		if slot0.fightStepData.actEffect and #slot0.fightStepData.actEffect == 1 and slot0.fightStepData.actEffect[1].effectType == FightEnum.EffectType.BUFFADD and slot2.buff and lua_skill_buff.configDict[slot2.buff.buffId] and string.nilorempty(slot3.features) then
			slot0:onDone(true)

			return
		end

		FightController.instance:dispatchEvent(FightEvent.OnFloatEquipEffect, slot0.fightStepData.fromId, slot1)

		if slot0._nextStepData and slot0._nextStepData.fromId == slot0.fightStepData.fromId and FightCardDataHelper.isActiveSkill(slot0._nextStepData.fromId, slot0._nextStepData.actId) then
			TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5 / FightModel.instance:getUISpeed())

			return
		end
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
