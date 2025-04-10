module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessArrange_XYStep", package.seeall)

slot0 = class("EliminateChessArrange_XYStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if slot0._data == nil or #slot0._data < 1 then
		slot0:onDone(true)

		return
	end

	for slot4, slot5 in ipairs(slot0._data) do
		if slot5.viewItem ~= nil then
			LengZhou6EliminateChessItemController.instance:updateChessItem(slot5.x, slot5.y, slot8)
		else
			slot9 = LengZhou6EliminateChessItemController.instance:getChessItem(slot6, slot7)
			slot10 = slot9:getData()
			slot11 = slot10.x
			slot12 = slot10.y

			LengZhou6EliminateChessItemController.instance:updateChessItem(slot6, slot7, LengZhou6EliminateChessItemController.instance:getChessItem(slot11, slot12))
			LengZhou6EliminateChessItemController.instance:updateChessItem(slot11, slot12, slot9)
		end
	end

	slot0:onDone(true)
end

return slot0
