module("modules.logic.fight.system.work.FightWorkCompareDataAfterPlay", package.seeall)

slot0 = class("FightWorkCompareDataAfterPlay", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._flow = FightWorkFlowSequence.New()

	slot0:_registCompareServer()
	slot0:_registRefreshPerformance()
	slot0._flow:registFinishCallback(slot0._onFlowFinish, slot0)
	slot0._flow:start()
end

function slot0._registCompareServer(slot0)
	slot0._flow:registWork(FightWorkCompareServerEntityData)
end

function slot0._registRefreshPerformance(slot0)
	slot0._flow:registWork(FightWorkRefreshPerformanceEntityData)
	slot0._flow:registWork(FightWorkFunction, slot0.refreshPerformanceData, slot0)
end

function slot0.refreshPerformanceData(slot0)
	FightDataHelper.coverData(FightLocalDataMgr.instance.fieldMgr.param, FightDataMgr.instance.fieldMgr.param)
	FightDataHelper.coverData(FightLocalDataMgr.instance.fieldMgr.fightTaskBox, FightDataMgr.instance.fieldMgr.fightTaskBox)
end

function slot0._onFlowFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:disposeSelf()

		slot0._flow = nil
	end
end

return slot0
