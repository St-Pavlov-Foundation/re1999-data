module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroLastStepWork", package.seeall)

slot0 = class("DiceHeroLastStepWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.fight = slot1
end

function slot0.onStart(slot0, slot1)
	DiceHeroFightModel.instance:getGameData():init(slot0.fight)

	DiceHeroFightModel.instance.tempRoundEnd = true

	slot0:onDone(true)

	if DiceHeroFightModel.instance.finishResult == DiceHeroEnum.GameStatu.None then
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.RoundEnd)
	end

	DiceHeroFightModel.instance.tempRoundEnd = false
end

return slot0
