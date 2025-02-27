module("modules.logic.fight.entity.comp.skill.FightTLEventSetFightViewPartVisible", package.seeall)

slot0 = class("FightTLEventSetFightViewPartVisible")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	FightViewPartVisible.setWaitAreaActive(FightTLHelper.getBoolParam(slot3[1]))
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.onSkillEnd(slot0)
end

function slot0.clear(slot0)
end

function slot0.dispose(slot0)
end

return slot0
