module("modules.logic.fight.system.work.FightWorkRemoveMonsterSub325", package.seeall)

slot0 = class("FightWorkRemoveMonsterSub325", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.RefreshMonsterSubCount)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
