module("modules.logic.fight.system.work.FightWorkAddUseCardContainer", package.seeall)

slot0 = class("FightWorkAddUseCardContainer", FightStepEffectFlow)
slot0.IndexList = {}

function slot0.onStart(slot0)
	slot1 = slot0:getAdjacentSameEffectList(nil, false)

	slot0:customPlayEffectData(slot1)
	tabletool.clear(uv0.IndexList)

	slot3 = 0.5

	for slot7, slot8 in ipairs(slot1) do
		if slot8.effect.effectNum - 1 > #FightPlayCardModel.instance:getUsedCards() then
			slot10 = #slot11 + 1
		end

		table.insert(slot2, slot10)
		FightPlayCardModel.instance:addUseCard(slot10, slot9.cardInfo, slot9.effectNum1)

		if FightHeroALFComp.ALFSkillDict[slot9.effectNum1] then
			slot3 = 1.8
		end
	end

	FightController.instance:dispatchEvent(FightEvent.AddUseCard, slot2)
	FightController.instance:dispatchEvent(FightEvent.AfterAddUseCardContainer, slot0._fightStepMO)
	slot0:com_registTimer(slot0._delayAfterPerformance, slot3 / FightModel.instance:getUISpeed())
end

function slot0.customPlayEffectData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		FightDataHelper.playEffectData(slot6.effect)
	end
end

function slot0.clearWork(slot0)
end

return slot0
