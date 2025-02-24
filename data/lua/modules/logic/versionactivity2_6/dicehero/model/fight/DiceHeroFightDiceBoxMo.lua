module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightDiceBoxMo", package.seeall)

slot0 = pureTable("DiceHeroFightDiceBoxMo")

function slot0.init(slot0, slot1)
	slot0.capacity = slot1.capacity
	slot0.dices = {}
	slot0.dicesByUid = slot0.dicesByUid or {}

	for slot5, slot6 in ipairs(slot1.dices) do
		slot0.dices[slot5] = slot0.dicesByUid[slot6.uid] or DiceHeroFightDiceMo.New()

		slot0.dices[slot5]:init(slot6, slot5)

		slot0.dicesByUid[slot6.uid] = slot0.dices[slot5]
	end

	slot0.resetTimes = slot1.resetTimes
	slot0.maxResetTimes = slot1.maxResetTimes
end

function slot0.getDiceMoByUid(slot0, slot1)
	return slot0.dicesByUid[slot1]
end

return slot0
