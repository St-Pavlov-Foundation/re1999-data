module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessRevertStep", package.seeall)

slot0 = class("EliminateChessRevertStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	LengZhou6EliminateController.instance:revertRecord()
	slot0:onDone(true)
end

return slot0
