module("modules.logic.fight.system.work.FightWorkAddRecordCard", package.seeall)

slot0 = class("FightWorkAddRecordCard", FightEffectBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.ALF_AddRecordCardData, slot0.actEffectData.buff)
	slot0:onDone(true)
end

return slot0
