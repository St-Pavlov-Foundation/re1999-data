module("modules.logic.fight.system.work.asfd.FightWorkASFDContinueDone", package.seeall)

slot0 = class("FightWorkASFDContinueDone", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.fightStepData = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 3)

	if FightHelper.getASFDMgr() then
		slot1:onContinueASFDFlowDone(slot0.fightStepData)
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnDone, slot0.fightStepData and slot0.fightStepData.cardIndex)

	return slot0:onDone(true)
end

function slot0._delayDone(slot0)
	logError("奥术飞弹 Continue Done 超时了")

	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
