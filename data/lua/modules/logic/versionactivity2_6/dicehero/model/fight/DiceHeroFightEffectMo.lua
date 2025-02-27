module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightEffectMo", package.seeall)

slot0 = pureTable("DiceHeroFightEffectMo")

function slot0.init(slot0, slot1, slot2)
	slot0.effectType = slot1.effectType
	slot0.fromId = slot1.fromId
	slot0.targetId = slot1.targetId
	slot0.effectNum = tonumber(slot1.effectNum) or 0
	slot0.extraData = slot1.extraData
	slot0.nextFightStep = DiceHeroFightStepMo.New()

	slot0.nextFightStep:init(slot1.nextFightStep)

	slot0.buff = DiceHeroFightBuffMo.New()

	slot0.buff:init(slot1.buff)

	slot0.targetIds = slot1.targetIds
	slot0.skillCards = slot1.skillCards
	slot0.diceBox = slot1.diceBox
	slot0.parent = slot2
end

return slot0
