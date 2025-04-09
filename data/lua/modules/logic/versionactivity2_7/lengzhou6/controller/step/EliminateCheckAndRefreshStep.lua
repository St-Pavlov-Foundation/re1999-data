module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateCheckAndRefreshStep", package.seeall)

slot0 = class("EliminateCheckAndRefreshStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if LocalEliminateChessModel.instance:canEliminate() == nil or #slot1 < 3 then
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ClearEliminateEffect)
		LocalEliminateChessModel.instance:createInitMoveState()
		LengZhou6EliminateController.instance:createInitMoveStepAndUpdatePos()
	end

	slot0:onDone(true)
end

return slot0
