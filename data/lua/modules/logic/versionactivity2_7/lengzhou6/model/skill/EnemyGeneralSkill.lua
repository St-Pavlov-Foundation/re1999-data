module("modules.logic.versionactivity2_7.lengzhou6.model.skill.EnemyGeneralSkill", package.seeall)

slot0 = class("EnemyGeneralSkill", SkillBase)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0._skillType = LengZhou6Enum.SkillType.enemyActive
end

function slot0.execute(slot0)
	if uv0.super.execute(slot0) and LengZhou6EffectUtils.instance:getHandleFunc(slot0._effect[1]) ~= nil then
		slot3(slot0._effect, LengZhou6GameModel.instance:getSkillEffectUp(slot0._effect[1]))
	end
end

return slot0
