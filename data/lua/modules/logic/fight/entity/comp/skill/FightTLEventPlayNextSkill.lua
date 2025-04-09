module("modules.logic.fight.entity.comp.skill.FightTLEventPlayNextSkill", package.seeall)

slot0 = class("FightTLEventPlayNextSkill", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	if FightModel.instance:canParallelSkill(slot1) then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillCheck, slot1)
	end
end

return slot0
