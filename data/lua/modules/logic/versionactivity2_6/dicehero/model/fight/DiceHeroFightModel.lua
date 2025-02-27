module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightModel", package.seeall)

slot0 = class("DiceHeroFightModel", BaseModel)

function slot0.onInit(slot0)
	slot0.finishResult = DiceHeroEnum.GameStatu.None
	slot0.tempRoundEnd = false
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.setGameData(slot0, slot1)
	if not slot0._gameData then
		slot0._gameData = DiceHeroFightData.New(slot1)
	else
		slot0._gameData:init(slot1)
	end

	slot0._gameData.initHp = slot0._gameData.allyHero and slot0._gameData.allyHero.hp or 0
end

function slot0.getGameData(slot0)
	return slot0._gameData
end

slot0.instance = slot0.New()

return slot0
