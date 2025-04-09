module("modules.logic.fight.system.work.FightWorkCreateBloodPool333", package.seeall)

slot0 = class("FightWorkCreateBloodPool333", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = slot0.actEffectData.effectNum
	slot2 = FightDataHelper.teamDataMgr

	slot2:checkBloodPoolExist(slot1)
	slot2[slot1].bloodPool:changeMaxValue(slot0.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnCreate, slot1)
	slot0:onDone(true)
end

return slot0
