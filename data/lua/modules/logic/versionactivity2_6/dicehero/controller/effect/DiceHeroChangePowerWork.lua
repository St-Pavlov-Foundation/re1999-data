module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangePowerWork", package.seeall)

slot0 = class("DiceHeroChangePowerWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	if not DiceHeroHelper.instance:getEntity(slot0._effectMo.targetId) then
		logError("找不到实体" .. slot2)

		return
	end

	slot0._targetEntity = slot3
	slot0._isFromCard = slot0._effectMo.parent.isByCard
	slot0._targetPos = slot0._targetEntity:getPos(2)

	if slot0._isFromCard and string.nilorempty(slot0._effectMo.extraData) and slot0._effectMo.effectNum > 0 then
		slot0._effectItem = DiceHeroHelper.instance:doEffect(5, DiceHeroHelper.instance:getCard(tonumber(slot0._effectMo.parent.reasonId)):getPos(), slot0._targetPos)

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
		TaskDispatcher.runDelay(slot0.addPower, slot0, 0.5)
	else
		slot0:addPower()
	end
end

function slot0.addPower(slot0)
	slot0._targetEntity:addPower(slot0._effectMo.effectNum)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(slot0._effectItem)

		slot0._effectItem = nil
	end

	TaskDispatcher.cancelTask(slot0.addPower, slot0)
end

return slot0
