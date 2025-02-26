module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeShieldWork", package.seeall)

slot0 = class("DiceHeroChangeShieldWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	if not DiceHeroHelper.instance:getEntity(slot0._effectMo.targetId) then
		logError("找不到实体" .. slot2)
	else
		slot3:addShield(slot0._effectMo.effectNum)

		if slot0._effectMo.effectNum > 0 then
			slot3:showEffect(3)

			slot0._effectItem = DiceHeroHelper.instance:doEffect(1, slot3:getPos(), nil, string.format("%+d", slot0._effectMo.effectNum))

			TaskDispatcher.runDelay(slot0._delayDone, slot0, 1)

			return
		end
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(slot0._effectItem)

		slot0._effectItem = nil
	end

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
