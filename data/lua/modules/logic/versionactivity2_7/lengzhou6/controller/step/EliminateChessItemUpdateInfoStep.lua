module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessItemUpdateInfoStep", package.seeall)

slot0 = class("EliminateChessItemUpdateInfoStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot2 = slot0._data.y

	if slot0._data.x == nil or slot2 == nil then
		slot0:onDone(true)

		return
	end

	slot4 = LengZhou6EliminateChessItemController.instance:getChessItem(slot1, slot2)

	if LocalEliminateChessModel.instance:changeCellId(slot1, slot2, EliminateEnum_2_7.ChessTypeToIndex.stone) ~= nil and slot4 ~= nil then
		slot4:initData(slot3)
	end

	slot0:onDone(true)
end

return slot0
