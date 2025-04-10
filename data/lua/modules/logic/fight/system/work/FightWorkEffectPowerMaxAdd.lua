module("modules.logic.fight.system.work.FightWorkEffectPowerMaxAdd", package.seeall)

slot0 = class("FightWorkEffectPowerMaxAdd", FightEffectBase)

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0.actEffectData.targetId) then
		slot0:onDone(true)

		return
	end

	if not slot2:getMO() then
		slot0:onDone(true)

		return
	end

	if slot3:getPowerInfo(slot0.actEffectData.configEffect) then
		FightController.instance:dispatchEvent(FightEvent.PowerMaxChange, slot1, slot4, slot0.actEffectData.effectNum)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
