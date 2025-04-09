module("modules.logic.versionactivity2_7.lengzhou6.model.skill.GeneralSkill", package.seeall)

slot0 = class("GeneralSkill", SkillBase)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0._skillType = LengZhou6Enum.SkillType.passive
end

function slot0.execute(slot0)
	if uv0.super.execute(slot0) and slot0._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() and LengZhou6EffectUtils.instance:getHandleFunc(slot0._effect[1]) ~= nil then
		slot3(slot0._effect)
	end
end

return slot0
