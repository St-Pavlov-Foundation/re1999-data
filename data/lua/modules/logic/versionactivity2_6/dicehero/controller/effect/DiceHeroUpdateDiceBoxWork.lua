module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateDiceBoxWork", package.seeall)

slot0 = class("DiceHeroUpdateDiceBoxWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	DiceHeroFightModel.instance:getGameData().diceBox:init(slot0._effectMo.diceBox)
	slot0:onDone(true)
end

return slot0
