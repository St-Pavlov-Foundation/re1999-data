module("modules.logic.fight.entity.comp.skill.FightTimelineTrackItem", package.seeall)

slot0 = class("FightTimelineTrackItem", FightBaseClass)

function slot0.onConstructor(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1
	slot0.type = slot2
	slot0.binder = slot3
	slot0.timelineItem = slot4
end

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
end

function slot0.onTrackEnd(slot0)
end

function slot0.addWork2TimelineFinishWork(slot0, slot1)
	slot0.timelineItem:addWork2FinishWork(slot1)
end

function slot0.onDestructor(slot0)
end

return slot0
