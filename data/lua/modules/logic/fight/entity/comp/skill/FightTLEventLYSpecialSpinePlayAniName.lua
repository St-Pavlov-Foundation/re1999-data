module("modules.logic.fight.entity.comp.skill.FightTLEventLYSpecialSpinePlayAniName", package.seeall)

slot0 = class("FightTLEventLYSpecialSpinePlayAniName", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	FightController.instance:dispatchEvent(FightEvent.TimelineLYSpecialSpinePlayAniName, slot3[1])
end

function slot0.onTrackEnd(slot0)
end

function slot0.onDestructor(slot0)
end

return slot0
