module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroActionWork", package.seeall)

slot0 = class("DiceHeroActionWork", BaseWork)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._stepMo = slot1
end

function slot0.onStart(slot0, slot1)
	if slot0._stepMo.actionType == 1 and slot0._stepMo.isByCard then
		DiceHeroHelper.instance:getCard(tonumber(slot0._stepMo.reasonId)):doHitAnim()
	elseif DiceHeroHelper.instance:getEntity(slot0._stepMo.fromId) then
		slot2:playHitAnim()
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardrelease)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 1)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
