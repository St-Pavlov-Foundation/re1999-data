module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeLookBack", package.seeall)

slot0 = class("FightTLEventInvokeLookBack", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	if not (slot1 and slot1.actEffect) then
		return
	end

	slot5 = {}
	slot6 = false

	for slot10, slot11 in ipairs(slot4) do
		if slot11.effectType == FightEnum.EffectType.SAVEFIGHTRECORDSTART then
			slot6 = true
		elseif slot11.effectType == FightEnum.EffectType.SAVEFIGHTRECORDEND then
			break
		elseif slot6 then
			table.insert(slot5, slot11)
		end
	end

	if #slot5 < 1 then
		return
	end

	slot7 = slot0:com_registFlowParallel()

	for slot11, slot12 in ipairs(slot5) do
		if FightStepBuilder.ActEffectWorkCls[slot12.effectType] then
			slot7:registWork(slot13, slot1, slot12)
		end
	end

	slot0:addWork2TimelineFinishWork(slot7)
	slot7:start()
end

function slot0.onTrackEnd(slot0)
end

function slot0.onDestructor(slot0)
end

return slot0
