module("modules.logic.fight.system.work.FightWorkSpCardAddContainer", package.seeall)

slot0 = class("FightWorkSpCardAddContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.SPCARDADD] = true,
	[FightEnum.EffectType.CHANGETOTEMPCARD] = true
}

function slot0.onStart(slot0)
	slot3 = slot0:com_registWorkDoneFlowParallel():registWork(FightWorkFlowSequence)

	for slot8, slot9 in ipairs(slot0:getAdjacentSameEffectList(uv0, true)) do
		slot10 = slot9.actEffectData.effectType
		slot11 = FightStepBuilder.ActEffectWorkCls[slot10]

		if slot10 == FightEnum.EffectType.SPCARDADD then
			slot2:registWork(FightWorkFlowSequence):registWork(FightWorkDelayTimer, 0.1 * (0 + 1))
		end

		slot3:registWork(slot11, slot9.fightStepData, slot9.actEffectData)
	end

	slot2:start()
end

function slot0.clearWork(slot0)
end

return slot0
