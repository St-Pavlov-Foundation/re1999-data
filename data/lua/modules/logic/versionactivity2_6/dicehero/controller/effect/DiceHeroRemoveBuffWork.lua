module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroRemoveBuffWork", package.seeall)

slot0 = class("DiceHeroRemoveBuffWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	if not DiceHeroHelper.instance:getEntity(slot0._effectMo.fromId) then
		logError("找不到实体" .. slot2)
	else
		slot3:removeBuff(slot0._effectMo.targetId)
	end

	slot0:onDone(true)
end

return slot0
