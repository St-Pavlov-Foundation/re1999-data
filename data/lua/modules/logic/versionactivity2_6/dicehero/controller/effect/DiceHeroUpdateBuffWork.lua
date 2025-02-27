module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateBuffWork", package.seeall)

slot0 = class("DiceHeroUpdateBuffWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	slot4 = 0

	if not DiceHeroHelper.instance:getEntity(slot0._effectMo.targetId) then
		logError("找不到实体" .. slot2)
	else
		slot3:addOrUpdateBuff(slot0._effectMo.buff)

		if slot0._effectMo.buff.co.visible == 1 and slot3:getHeroMo():isAddLayer(slot0._effectMo.buff) then
			if slot0._effectMo.buff.co.tag == 1 then
				AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_buff)
				slot3:showEffect(1)
			else
				AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_debuff)
				slot3:showEffect(2)
			end

			slot4 = 0.5
		end
	end

	if slot4 > 0 then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, slot4)
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
