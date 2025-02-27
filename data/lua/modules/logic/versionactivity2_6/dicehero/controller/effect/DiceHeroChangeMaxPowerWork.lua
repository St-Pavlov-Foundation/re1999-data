module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeMaxPowerWork", package.seeall)

slot0 = class("DiceHeroChangeMaxPowerWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	if not DiceHeroHelper.instance:getEntity(slot0._effectMo.targetId) then
		logError("找不到实体" .. slot2)
	else
		slot3:addMaxPower(slot0._effectMo.effectNum)
	end

	slot0:onDone(true)
end

return slot0
