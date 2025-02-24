module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDiceBoxFullWork", package.seeall)

slot0 = class("DiceHeroDiceBoxFullWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	GameFacade.showToast(ToastEnum.DiceHeroDiceBoxFull)
	slot0:onDone(true)
end

return slot0
