module("modules.logic.fight.system.work.FightWorkDistributeCard", package.seeall)

slot0 = class("FightWorkDistributeCard", BaseWork)

function slot0.onConstructor(slot0)
	slot0.skipAutoPlayData = true
end

function slot0.onStart(slot0)
	if not FightDataHelper.roundMgr:getRoundData() then
		slot0:onDone(false)

		return
	end

	FightController.instance:setCurStage(FightEnum.Stage.Distribute)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideDistributePause", FightEvent.OnGuideDistributePause, FightEvent.OnGuideDistributeContinue, slot0._distrubute, slot0)
end

function slot0._distrubute(slot0)
	FightViewPartVisible.set(false, true, false, false, false)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, slot0._done, slot0)
	FightController.instance:dispatchEvent(FightEvent.DistributeCards, FightDataHelper.handCardMgr.beforeCards1, FightDataHelper.handCardMgr.teamACards1)
end

function slot0._done(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, slot0._done, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, slot0._done, slot0)
end

return slot0
