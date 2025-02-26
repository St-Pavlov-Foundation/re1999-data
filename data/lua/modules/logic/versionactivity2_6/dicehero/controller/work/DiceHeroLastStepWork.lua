module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroLastStepWork", package.seeall)

slot0 = class("DiceHeroLastStepWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.fight = slot1
end

function slot0.onStart(slot0, slot1)
	DiceHeroFightModel.instance:getGameData():init(slot0.fight)
	slot0:onDone(true)
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.RoundEnd)
end

return slot0
