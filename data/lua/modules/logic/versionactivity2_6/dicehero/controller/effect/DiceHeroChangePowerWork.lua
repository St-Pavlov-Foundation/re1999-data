module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangePowerWork", package.seeall)

slot0 = class("DiceHeroChangePowerWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	if not DiceHeroHelper.instance:getEntity(slot0._effectMo.targetId) then
		logError("找不到实体" .. slot2)
	else
		slot3:addPower(slot0._effectMo.effectNum)
	end

	slot0:onDone(true)
end

return slot0
