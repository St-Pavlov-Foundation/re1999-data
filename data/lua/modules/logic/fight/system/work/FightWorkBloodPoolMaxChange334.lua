module("modules.logic.fight.system.work.FightWorkBloodPoolMaxChange334", package.seeall)

slot0 = class("FightWorkBloodPoolMaxChange334", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = slot0.actEffectData.effectNum
	slot2 = FightDataHelper.teamDataMgr

	slot2:checkBloodPoolExist(slot1)
	slot2[slot1].bloodPool:changeMaxValue(slot0.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.BloodPool_MaxValueChange, slot1)
	slot0:onDone(true)
end

return slot0
