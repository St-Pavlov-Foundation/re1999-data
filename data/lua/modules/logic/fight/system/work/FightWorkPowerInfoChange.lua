module("modules.logic.fight.system.work.FightWorkPowerInfoChange", package.seeall)

slot0 = class("FightWorkPowerInfoChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.PowerInfoChange, slot0.actEffectData.targetId, slot0.actEffectData.powerInfo.powerId)
	slot0:onDone(true)
end

return slot0
