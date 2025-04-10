module("modules.logic.versionactivity2_7.lengzhou6.controller.step.LengZhou6EnemyReleaseSkillStep", package.seeall)

slot0 = class("LengZhou6EnemyReleaseSkillStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data

	if LengZhou6GameModel.instance:getEnemy() == nil or slot1 == nil then
		slot0:onDone(true)

		return
	end

	slot3 = slot1._id

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UseEnemySkill, slot3)
	slot2:useSkill(slot3)
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnemyUseSkill, slot1:getConfigId())

	if slot1:getEffect()[1] == LengZhou6Enum.SkillEffect.DealsDamage or slot4 == LengZhou6Enum.SkillEffect.Heal then
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEnemyEffect, slot4)
		TaskDispatcher.runDelay(slot0._onDone, slot0, LengZhou6Enum.EnemySkillTime)

		return
	else
		TaskDispatcher.runDelay(slot0._onDone, slot0, LengZhou6Enum.EnemySkillTime_2)
	end
end

return slot0
