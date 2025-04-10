module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessCheckStep", package.seeall)

slot0 = class("EliminateChessCheckStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	LengZhou6EliminateController.instance:eliminateCheck(slot0._data)
	slot0:onDone(true)
end

return slot0
