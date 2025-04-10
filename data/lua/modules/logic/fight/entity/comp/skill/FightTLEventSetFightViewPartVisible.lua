module("modules.logic.fight.entity.comp.skill.FightTLEventSetFightViewPartVisible", package.seeall)

slot0 = class("FightTLEventSetFightViewPartVisible", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	FightViewPartVisible.setWaitAreaActive(FightTLHelper.getBoolParam(slot3[1]))
end

function slot0.onTrackEnd(slot0)
end

function slot0.onDestructor(slot0)
end

return slot0
