module("modules.logic.fight.system.work.FightWorkStepSkill", package.seeall)

slot0 = class("FightWorkStepSkill", BaseWork)
slot1 = 1
slot2 = 0.01
slot3 = 0

function slot0.ctor(slot0, slot1)
	slot0.fightStepData = slot1
	slot0._id = uv0
	uv0 = uv0 + 1
end

function slot0.onStart(slot0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0)

	slot0._attacker = FightHelper.getEntity(slot0.fightStepData.fromId)

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 20)

	if not slot0._attacker then
		slot0:onDone(true)

		return
	end

	slot0._skillId = slot0.fightStepData.actId

	if string.nilorempty(FightConfig.instance:getSkinSkillTimeline(slot0._attacker:getMO() and slot1.skin, slot0._skillId)) then
		slot0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, slot0._onBeforeDestroyEntity, slot0)
	slot0:_canPlaySkill()
end

function slot0._canPlaySkill(slot0)
	uv0.needWaitBeforeSkill = nil

	FightController.instance:dispatchEvent(FightEvent.BeforeSkillDialog, slot0._skillId)

	if uv0.needWaitBeforeSkill then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
		FightController.instance:registerCallback(FightEvent.DialogContinueSkill, slot0._canPlaySkill2, slot0)
	else
		slot0:_canPlaySkill2()
	end
end

function slot0._canPlaySkill2(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 20)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, slot0._canPlaySkill2, slot0)

	if FightModel.instance:getVersion() >= 1 then
		if FightHelper.isPlayerCardSkill(slot0.fightStepData) then
			if FightPlayCardModel.instance:getCurIndex() < slot0.fightStepData.cardIndex - 1 then
				FightController.instance:dispatchEvent(FightEvent.InvalidPreUsedCard, slot0.fightStepData.cardIndex)
				TaskDispatcher.runDelay(slot0._delayAfterDissolveCard, slot0, 1 / FightModel.instance:getUISpeed())

				return
			end

			FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, slot0._attacker, slot0._skillId, slot0.fightStepData)
		end

		slot0:_playSkill(slot0._skillId)
	else
		slot5 = FightPlayCardModel.instance:getClientLeftSkillOpList() and slot4[#slot4]

		if not slot0.fightStepData.editorPlaySkill and (slot0._attacker:isMySide() and FightCardDataHelper.isActiveSkill(slot0.fightStepData.fromId, slot0._skillId) or slot5 and slot0._skillId == slot5.skillId) then
			if uv0 + uv1 - Time.realtimeSinceStartup > 0 then
				TaskDispatcher.runDelay(slot0._toPlaySkill, slot0, slot7)
			else
				slot0:_toPlaySkill()
			end
		else
			slot0:_playSkill(slot0._skillId)
		end
	end
end

function slot0._delayAfterDissolveCard(slot0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, slot0._attacker, slot0._skillId, slot0.fightStepData)
	slot0:_playSkill(slot0._skillId)
end

function slot0._delayPlaySkill(slot0)
	slot0:_playSkill(slot0._skillId)
end

function slot0._toPlaySkill(slot0)
	FightController.instance:registerCallback(FightEvent.ToPlaySkill, slot0._playSkill, slot0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, slot0._attacker, slot0._skillId, slot0.fightStepData)
end

function slot0._playSkill(slot0, slot1)
	if slot1 ~= slot0.fightStepData.actId then
		slot0:onDone(true)

		return
	end

	if slot0.fightStepData.fromId == "0" or slot0._attacker then
		FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, slot0._playSkill, slot0)

		if slot0._attacker.skill:registPlaySkillWork(slot0._skillId, slot0.fightStepData) then
			slot2:registFinishCallback(slot0.onWorkTimelineFinish, slot0)
			TaskDispatcher.cancelTask(slot0._delayDone, slot0)
			slot2:start()
		else
			slot0:onDone(true)
		end
	else
		logError("attacker entity not exist, can't play skill " .. slot0._skillId)
		slot0:onDone(true)
	end
end

function slot0.onWorkTimelineFinish(slot0)
	if slot0.status ~= WorkStatus.Done then
		slot0:_removeEvents()

		uv0 = Time.realtimeSinceStartup
		uv1.needStopSkillEnd = nil

		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillNP)
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillP)

		if uv1.needStopSkillEnd then
			TaskDispatcher.cancelTask(slot0._delayDone, slot0)
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
		elseif FightModel.instance:getVersion() >= 1 then
			if FightHelper.isPlayerCardSkill(slot0.fightStepData) then
				TaskDispatcher.runDelay(slot0._delayAfterSkillEnd, slot0, 0.3 / FightModel.instance:getUISpeed())
			else
				slot0:onDone(true)
			end
		else
			slot0:onDone(true)
		end
	end
end

function slot0._delayAfterSkillEnd(slot0)
	slot0:onDone(true)
end

function slot0._onFightDialogEnd(slot0)
	slot0:onDone(true)
end

function slot0._forceEndSkillStep(slot0, slot1)
	if slot1 == slot0.fightStepData then
		slot0:_removeEvents()
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	logError("skill play timeout, skillId = " .. slot0._skillId)
	slot0:_removeEvents()
	FightController.instance:dispatchEvent(FightEvent.FightWorkStepSkillTimeout, slot0.fightStepData)
end

function slot0._removeEvents(slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterDissolveCard, slot0)
	TaskDispatcher.cancelTask(slot0._delayPlaySkill, slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterSkillEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._toPlaySkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, slot0._playSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, slot0._canPlaySkill2, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, slot0._onBeforeDestroyEntity, slot0)
end

function slot0._onBeforeDestroyEntity(slot0, slot1)
	if slot0._attacker and slot0._attacker.id == slot1.id then
		slot0:onDone(true)
	end
end

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)

	if slot0._attacker and slot0._attacker.skill then
		slot0._attacker.skill:stopSkill()
	end
end

function slot0.onResume(slot0)
	logError("skill step can't resume")
end

function slot0.clearWork(slot0)
	slot0:_removeEvents()
end

return slot0
