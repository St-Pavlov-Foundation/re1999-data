module("modules.logic.fight.model.data.FightStepData", package.seeall)

slot0 = FightDataClass("FightStepData")

function slot0.onConstructor(slot0, slot1)
	slot0.actType = slot1.actType
	slot0.fromId = slot1.fromId
	slot0.toId = slot1.toId
	slot0.actId = slot1.actId
	slot0.actEffect = slot0:buildActEffect(slot1.actEffect)
	slot0.cardIndex = slot1.cardIndex
	slot0.supportHeroId = slot1.supportHeroId
end

function slot0.buildActEffect(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, FightActEffectData.New(slot7))
	end

	return slot2
end

return slot0
