module("modules.logic.fight.model.data.FightRoundData", package.seeall)

slot0 = FightDataClass("FightRoundData")

function slot0.onConstructor(slot0, slot1)
	slot0.fightStep = slot0:buildFightStep(slot1.fightStep)
	slot0.actPoint = slot1.actPoint
	slot0.isFinish = slot1.isFinish
	slot0.moveNum = slot1.moveNum
	slot0.power = slot1.power
	slot0.useCardList = {}

	for slot5, slot6 in ipairs(slot1.useCardList) do
		table.insert(slot0.useCardList, slot6)
	end

	slot0.curRound = slot1.curRound
	slot0.lastChangeHeroUid = slot1.lastChangeHeroUid
end

function slot0.buildFightStep(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, FightStepData.New(slot7))
	end

	return slot2
end

return slot0
