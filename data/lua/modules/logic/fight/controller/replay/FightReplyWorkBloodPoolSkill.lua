module("modules.logic.fight.controller.replay.FightReplyWorkBloodPoolSkill", package.seeall)

slot0 = class("FightReplyWorkBloodPoolSkill", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._beginRoundOp = slot1
end

function slot0.onStart(slot0, slot1)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		slot0:onDone(true)

		return
	end

	if not slot0._beginRoundOp then
		return slot0:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, slot0._beginRoundOp.toId)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 3)

	slot3 = FightDataHelper.operationDataMgr:newOperation()

	slot3:playBloodPoolCard(FightHelper.getBloodPoolSkillId())
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot3)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, slot3)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, slot3)
	FightDataHelper.bloodPoolDataMgr:playBloodPoolCard()
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
