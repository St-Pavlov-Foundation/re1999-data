module("modules.logic.fight.system.work.asfd.effectwork.FightWorkChangeCardEnergy", package.seeall)

slot0 = class("FightWorkChangeCardEnergy", FightEffectBase)

function slot0.onConstructor(slot0)
	slot0.SAFETIME = 1.5
end

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_OnChangeCardEnergy, FightStrUtil.instance:getSplitString2Cache(slot0.actEffectData.reserveStr, true))
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 1 / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
