module("modules.logic.fight.system.work.FightWorkAct174UseCard", package.seeall)

slot0 = class("FightWorkAct174UseCard", FightEffectBase)

function slot0.onConstructor(slot0)
	slot0.skipAutoPlayData = true
end

function slot0.onStart(slot0)
	slot0:com_registTimer(slot0._delayAfterPerformance, 5)
	slot0:com_registFightEvent(FightEvent.PlayCardOver, slot0._onPlayCardOver)
	FightViewPartVisible.set(false, true, true, false, false)
	slot0:com_sendFightEvent(FightEvent.PlayHandCard, slot0.actEffectData.effectNum)
end

function slot0._onPlayCardOver(slot0)
	slot0:com_sendFightEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

return slot0
