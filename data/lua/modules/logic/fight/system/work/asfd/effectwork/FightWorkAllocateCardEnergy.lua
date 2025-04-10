module("modules.logic.fight.system.work.asfd.effectwork.FightWorkAllocateCardEnergy", package.seeall)

slot0 = class("FightWorkAllocateCardEnergy", FightEffectBase)

function slot0.onConstructor(slot0)
	slot0.SAFETIME = 3
end

slot0.AllocateEnum = {
	Clear = 0,
	Allocate = 1
}

function slot0.onStart(slot0)
	if slot0.actEffectData.effectNum1 ~= uv0.AllocateEnum.Allocate then
		slot0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.ASFD_AllocateCardEnergyDone, slot0.allocateCardEnergyDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_StartAllocateCardEnergy)
end

slot0.ASFDOpenTime = 0.5

function slot0.allocateCardEnergyDone(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, uv0.ASFDOpenTime / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_AllocateCardEnergyDone, slot0.allocateCardEnergyDone, slot0)
end

return slot0
