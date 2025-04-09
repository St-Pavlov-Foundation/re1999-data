module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessChangeStateStep", package.seeall)

slot0 = class("EliminateChessChangeStateStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot3 = slot0._data.fromState

	if LengZhou6EliminateChessItemController.instance:getChessItem(slot0._data.x, slot0._data.y) == nil then
		logError("步骤 ChangeState 棋子：" .. slot1, slot2 .. "不存在")
		slot0:onDone(true)

		return
	end

	slot4:changeState(slot3, slot1, slot2)
	slot0:onDone(true)
end

return slot0
