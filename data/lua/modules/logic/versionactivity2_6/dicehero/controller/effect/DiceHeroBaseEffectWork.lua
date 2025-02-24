module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroBaseEffectWork", package.seeall)

slot0 = class("DiceHeroBaseEffectWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._effectMo = slot1
end

function slot0.onStart(slot0, slot1)
	slot0:onDone(true)
end

return slot0
