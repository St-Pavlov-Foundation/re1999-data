module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeSummon", package.seeall)

slot0 = class("FightTLEventInvokeSummon", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	slot0.summonList = {}

	slot0:getStepDataSummon(slot1)

	if #slot0.summonList < 1 then
		return
	end

	slot4 = slot0:com_registFlowParallel()

	for slot9, slot10 in ipairs(slot0.summonList) do
		slot4:registWork(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.SUMMON], slot10[1], slot10[2])
	end

	slot0:addWork2TimelineFinishWork(slot4)
	slot4:start()
end

function slot0.getStepDataSummon(slot0, slot1)
	if not (slot1 and slot1.actEffect) then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7.effectType == FightEnum.EffectType.SUMMON then
			table.insert(slot0.summonList, {
				slot1,
				slot7
			})
		elseif slot7.effectType == FightEnum.EffectType.FIGHTSTEP then
			slot0:getStepDataSummon(slot7.fightStep)
		end
	end
end

function slot0.onTrackEnd(slot0)
end

function slot0.onDestructor(slot0)
end

function slot0.dispose(slot0)
end

return slot0
