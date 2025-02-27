module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDamageWork", package.seeall)

slot0 = class("DiceHeroDamageWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	slot0._isFromCard = slot0._effectMo.parent.isByCard
	slot0._isByHero = DiceHeroFightModel.instance:getGameData().allyHero.uid == slot0._effectMo.fromId
	slot3 = DiceHeroHelper.instance:getEntity(slot0._effectMo.fromId)
	slot4 = DiceHeroHelper.instance:getEntity(slot0._effectMo.targetId)
	slot0._targetPos = slot4:getPos()
	slot0._targetItem = slot4

	if slot0._isByHero and slot0._isFromCard and string.nilorempty(slot0._effectMo.extraData) then
		slot0._effectItem = DiceHeroHelper.instance:doEffect(2, DiceHeroHelper.instance:getCard(tonumber(slot0._effectMo.parent.reasonId)):getPos(), slot0._targetPos)
	else
		slot0._effectItem = DiceHeroHelper.instance:doEffect(slot0._isByHero and 2 or 3, slot3:getPos(), slot0._targetPos)
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
	TaskDispatcher.runDelay(slot0._delayShowDamage, slot0, 0.5)
end

function slot0._delayShowDamage(slot0)
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.OnDamage, slot0._isByHero)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shotimp)
	slot0._targetItem:showEffect(4)
	TaskDispatcher.runDelay(slot0._delayShowNum, slot0, 0.5)
	TaskDispatcher.runDelay(slot0._delayFinish, slot0, 1)
end

function slot0._delayShowNum(slot0)
	slot0._effectItem:initData(1, slot0._targetPos, nil, slot0._effectMo.effectNum)
end

function slot0._delayFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(slot0._effectItem)

		slot0._effectItem = nil
	end

	TaskDispatcher.cancelTask(slot0._delayShowDamage, slot0)
	TaskDispatcher.cancelTask(slot0._delayShowNum, slot0)
	TaskDispatcher.cancelTask(slot0._delayFinish, slot0)
end

return slot0
