module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessUpdateGameInfoStep", package.seeall)

slot0 = class("EliminateChessUpdateGameInfoStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateGameInfo)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdatePlayerSkill)
	LocalEliminateChessModel.instance:updateSpEffectCd()
	LengZhou6GameModel.instance:clearTempData()
	LocalEliminateChessModel.instance:roundDataClear()

	if LengZhou6GameModel.instance:gameIsOver() then
		LengZhou6GameController.instance:gameEnd()
	else
		LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh))
	end

	slot0:_onDone()
end

return slot0
