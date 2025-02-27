module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDiceChangeStatusWork", package.seeall)

slot0 = class("DiceHeroDiceChangeStatusWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	if not DiceHeroHelper.instance:getDice(slot0._effectMo.targetId) or not slot2.diceMo then
		logError("骰子uid不存在" .. slot0._effectMo.targetId)

		return slot0:onDone(true)
	end

	slot2.diceMo.status = slot0._effectMo.effectNum

	slot2:refreshLock()
	slot0:onDone(true)
end

return slot0
