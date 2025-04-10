module("modules.logic.versionactivity2_7.lengzhou6.model.skill.PlayerActiveSkill", package.seeall)

slot0 = class("PlayerActiveSkill", SkillBase)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0._skillParams = {}
	slot0._skillParamCount = 0

	if slot0._effect[1] == "EliminationCross" or slot0._effect[1] == "EliminationRange" then
		slot0._skillParamCount = 2
	end

	slot0._skillType = LengZhou6Enum.SkillType.active
end

function slot0.setParams(slot0, slot1, slot2)
	table.insert(slot0._skillParams, slot1)
	table.insert(slot0._skillParams, slot2)
end

function slot0.clearParams(slot0)
	tabletool.clear(slot0._skillParams)
end

function slot0.paramIsFull(slot0)
	return #slot0._skillParams == slot0._skillParamCount
end

function slot0.execute(slot0)
	if uv0.super.execute(slot0) and slot0:paramIsFull() and LengZhou6EffectUtils.instance:getHandleFunc(slot0._effect[1]) ~= nil then
		if #slot0._skillParams ~= 0 then
			slot3(slot0._skillParams[1], slot0._skillParams[2])
		else
			slot3(slot0._effect)
		end

		slot0:clearParams()
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdatePlayerSkill)
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.FinishReleaseSkill)
		LengZhou6StatHelper.instance:addUseSkillInfo(slot0:getConfigId())
	end
end

return slot0
