module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6GameController", package.seeall)

slot0 = class("LengZhou6GameController", BaseController)

function slot0.onInit(slot0)
end

function slot0.enterEpisodeId(slot0, slot1)
	slot0:enterLevel(12702, slot1)
end

function slot0.enterLevel(slot0, slot1, slot2)
	if LengZhou6Config.instance:getEpisodeConfig(slot1, slot2).eliminateLevelId ~= 0 then
		LengZhou6StatHelper.instance:enterGame()
		LengZhou6GameModel.instance:enterLevel(slot3)
		LengZhou6EliminateController.instance:enterLevel(slot4)
		ViewMgr.instance:openView(ViewName.LengZhou6GameView)
	end
end

function slot0.restartLevel(slot0, slot1, slot2)
	if LengZhou6Config.instance:getEpisodeConfig(slot1, slot2).eliminateLevelId ~= 0 then
		LengZhou6StatHelper.instance:enterGame()
		LengZhou6GameModel.instance:enterLevel(slot3)
		LengZhou6EliminateController.instance:enterLevel(slot4)
		slot0:dispatchEvent(LengZhou6Event.GameReStart)
	end
end

function slot0.gameUpdateRound(slot0, slot1)
	slot0:_damageAndHpSettle(slot1)
end

function slot0._damageAndHpSettle(slot0, slot1)
	for slot6 = 1, LengZhou6GameModel.instance:getEnemySettleCount() do
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackBefore)

		slot7, slot8 = LengZhou6GameModel.instance:getTotalPlayerSettle()

		LengZhou6GameModel.instance:getEnemy():changeHp(-slot7)
		LengZhou6GameModel.instance:getPlayer():changeHp(slot8)
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackAfter)
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackComplete)
	end

	LengZhou6GameModel.instance:resetEnemySettleCount()
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateDamage))
	slot0:_updateRoundAndCD(slot1)
end

function slot0._updateRoundAndCD(slot0, slot1)
	if slot1 then
		LengZhou6GameModel.instance:changeRound(-1)
		LengZhou6GameModel.instance:getPlayer():updateActiveSkillCD()
	end

	if LengZhou6GameModel.instance:gameIsOver() then
		return
	end

	slot0:_enemySkillRelease(slot1)
end

function slot0._enemySkillRelease(slot0, slot1)
	if slot1 then
		slot3, slot4 = LengZhou6GameModel.instance:getEnemy():getAllCanUseSkillId()

		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.enemyCheckInterval)
		slot0:dispatchEvent(LengZhou6Event.EnemySkillRound, slot4)

		if slot3 == nil then
			LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.poisonSettlement)

			return
		end

		for slot8 = 1, #slot3 do
			LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.LengZhou6EnemyReleaseSkillStep, slot3[slot8]))
		end

		LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.LengZhou6EnemyGenerateSkillStep))
	end
end

function slot0.playerSettle(slot0)
	LengZhou6GameModel.instance:playerSettle()
end

function slot0.gameEnd(slot0)
	slot2 = LengZhou6GameModel.instance:playerIsWin()

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite and slot2 then
		if LengZhou6GameModel.instance:canSelectSkill() then
			LengZhou6GameModel.instance:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectSkill)
		else
			LengZhou6GameModel.instance:enterNextLayer()
		end

		return
	end

	slot0:dispatchEvent(LengZhou6Event.GameEnd, slot2)
	ViewMgr.instance:openView(ViewName.LengZhou6GameResult)
end

function slot0.levelGame(slot0, slot1)
	slot3 = LengZhou6GameModel.instance:getEnemy()

	if LengZhou6GameModel.instance:getPlayer() and slot3 then
		LengZhou6StatHelper.instance:setPlayerAndEnemyHp(slot2:getHp(), slot3:getHp())
	end

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite or LengZhou6GameModel.instance:playerIsWin() then
		slot6 = nil

		if slot5 == LengZhou6Enum.BattleModel.infinite then
			slot6 = LengZhou6GameModel.instance:getRecordServerData():getRecordData()

			if LengZhou6GameModel.instance:getCurRound() <= 0 or LengZhou6GameModel.instance:getPlayer():getHp() <= 0 then
				slot6 = ""
			end
		end

		if not LengZhou6Enum.enterGM then
			LengZhou6Controller.instance:finishLevel(LengZhou6Model.instance:getCurEpisodeId(), slot6)
		end
	end

	LengZhou6StatHelper.instance:sendGameExit()

	if slot1 then
		ViewMgr.instance:closeView(ViewName.LengZhou6GameView)
		LengZhou6EliminateController.instance:clear()
	end

	LengZhou6GameModel.instance:clear()
end

slot0.instance = slot0.New()

return slot0
