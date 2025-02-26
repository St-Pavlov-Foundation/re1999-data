module("modules.logic.fight.system.work.FightWorkRefreshPerformanceTaskData", package.seeall)

slot0 = class("FightWorkRefreshPerformanceTaskData", FightWorkItem)

function slot0.onStart(slot0, slot1)
	FightDataHelper.coverData(FightLocalDataMgr.instance.fieldMgr.fightTaskBox, FightDataMgr.instance.fieldMgr.fightTaskBox)
	slot0:onDone(true)
end

return slot0
