module("modules.logic.fight.system.work.FightWorkPolarizationLevel", package.seeall)

slot0 = class("FightWorkPolarizationLevel", FightEffectBase)

function slot0.onStart(slot0)
	FightRoundSequence.roundTempData.PolarizationLevel = FightRoundSequence.roundTempData.PolarizationLevel or {}
	FightRoundSequence.roundTempData.PolarizationLevel[slot0.actEffectData.configEffect] = slot0.actEffectData

	FightController.instance:dispatchEvent(FightEvent.PolarizationLevel, slot0.actEffectData.effectNum)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
