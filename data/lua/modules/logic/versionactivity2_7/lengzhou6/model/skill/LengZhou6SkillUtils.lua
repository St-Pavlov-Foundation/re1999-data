module("modules.logic.versionactivity2_7.lengzhou6.model.skill.LengZhou6SkillUtils", package.seeall)

slot0 = class("LengZhou6SkillUtils")
slot1 = {}
slot2 = 0

function slot0.createSkill(slot0)
	if LengZhou6Config.instance:getEliminateBattleSkill(slot0) == nil then
		logError("skillConfig is nil, configId = " .. slot0)

		return nil
	end

	slot2 = nil

	if uv0[slot0] == nil then
		if slot1.type == LengZhou6Enum.SkillType.enemyActive then
			slot2 = EnemyGeneralSkill.New()
		end

		if slot1.type == LengZhou6Enum.SkillType.active then
			slot2 = PlayerActiveSkill.New()
		end

		if slot1.type == LengZhou6Enum.SkillType.passive then
			slot2 = GeneralSkill.New()
		end
	else
		slot2 = uv0[slot0].New()
	end

	slot2:init(uv1, slot0)

	uv1 = uv1 + 1

	return slot2
end

slot0.instance = slot0.New()

return slot0
