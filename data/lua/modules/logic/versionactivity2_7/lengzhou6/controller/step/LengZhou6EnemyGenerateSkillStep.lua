module("modules.logic.versionactivity2_7.lengzhou6.controller.step.LengZhou6EnemyGenerateSkillStep", package.seeall)

slot0 = class("LengZhou6EnemyGenerateSkillStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEnemySkill)

	slot3 = LengZhou6GameModel.instance:getEnemy():getAction():calCurResidueCd()
	slot4 = 0

	if LengZhou6GameModel.instance:getEnemy():havePoisonBuff() then
		slot4 = LengZhou6Enum.EnemyBuffEffectShowTime
	end

	LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.poisonSettlement)
	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.EnemySkillRound, slot3)

	if slot4 ~= 0 then
		TaskDispatcher.runDelay(slot0._onDone, slot0, slot4)
	else
		slot0:onDone(true)
	end
end

return slot0
