module("modules.logic.versionactivity2_7.lengzhou6.controller.step.LengZhou6EnemyGenerateSkillStep", package.seeall)

slot0 = class("LengZhou6EnemyGenerateSkillStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEnemySkill)
	LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.poisonSettlement)
	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.EnemySkillRound, LengZhou6GameModel.instance:getEnemy():getAction():calCurResidueCd())
	slot0:onDone(true)
end

return slot0
