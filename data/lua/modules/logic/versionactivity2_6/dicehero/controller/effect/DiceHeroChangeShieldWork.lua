module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeShieldWork", package.seeall)

slot0 = class("DiceHeroChangeShieldWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	if not DiceHeroHelper.instance:getEntity(slot0._effectMo.targetId) then
		logError("找不到实体" .. slot2)
		slot0:onDone(true)

		return
	end

	slot0._targetEntity = slot3
	slot0._isFromCard = slot0._effectMo.parent.isByCard
	slot0._targetPos = slot0._targetEntity:getPos(1)

	if slot0._isFromCard and string.nilorempty(slot0._effectMo.extraData) and slot0._effectMo.effectNum > 0 then
		slot0._effectItem = DiceHeroHelper.instance:doEffect(6, DiceHeroHelper.instance:getCard(tonumber(slot0._effectMo.parent.reasonId)):getPos(), slot0._targetPos)

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
		TaskDispatcher.runDelay(slot0.showEffectNum, slot0, 0.5)
	else
		slot0:showEffectNum()
	end
end

function slot0.showEffectNum(slot0)
	slot0._targetEntity:addShield(slot0._effectMo.effectNum)

	if slot0._effectMo.effectNum > 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_defense)
		slot0._targetEntity:showEffect(3)

		if slot0._effectItem then
			slot0._effectItem:initData(4, slot0._targetPos, nil, string.format("%+d", slot0._effectMo.effectNum))
		else
			slot0._effectItem = DiceHeroHelper.instance:doEffect(4, slot0._targetPos, nil, string.format("%+d", slot0._effectMo.effectNum))
		end

		TaskDispatcher.runDelay(slot0._delayDone, slot0, 1)
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	slot0._targetEntity = nil

	if slot0._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(slot0._effectItem)

		slot0._effectItem = nil
	end

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0.showEffectNum, slot0)
end

return slot0
