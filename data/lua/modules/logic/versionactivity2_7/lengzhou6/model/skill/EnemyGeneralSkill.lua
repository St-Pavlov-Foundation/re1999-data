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

function slot0.getSkillDesc(slot0)
	slot2 = slot0:getConfig().desc

	if slot0._effect[1] == LengZhou6Enum.SkillEffect.Shuffle then
		return slot2
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(slot2, slot0:getTotalValue())
end

function slot0.getTotalValue(slot0)
	if slot0._totalValue == nil then
		slot0._totalValue = slot0:_getTotalValue()
	end

	return slot0._totalValue
end

function slot0._getTotalValue(slot0)
	return (slot0._effect[2] and tonumber(slot0._effect[2]) or 0) + LengZhou6GameModel.instance:getSkillEffectUp(slot0._effect[1])
end

return slot0
