module("modules.logic.fight.model.data.FightTempDataMgr", package.seeall)

slot0 = FightDataClass("FightTempDataMgr", FightDataMgrBase)

function slot0.onConstructor(slot0)
	slot0.hasNextWave = false
end

function slot0.onCancelOperation(slot0)
end

function slot0.onStageChanged(slot0)
end

return slot0
