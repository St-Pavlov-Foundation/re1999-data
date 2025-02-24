module("modules.logic.fight.system.work.FightWorkClearMonsterSub322", package.seeall)

slot0 = class("FightWorkClearMonsterSub322", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.ClearMonsterSub)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
