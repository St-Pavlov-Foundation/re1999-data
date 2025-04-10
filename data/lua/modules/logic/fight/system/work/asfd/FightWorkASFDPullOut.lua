module("modules.logic.fight.system.work.asfd.FightWorkASFDPullOut", package.seeall)

slot0 = class("FightWorkASFDPullOut", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.fightStepData = slot1
end

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_PullOut, slot0.fightStepData)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.3)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._delayDone(slot0)
	return slot0:onDone(true)
end

return slot0
