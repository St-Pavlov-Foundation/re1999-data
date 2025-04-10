module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessDieEffectStep", package.seeall)

slot0 = class("EliminateChessDieEffectStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot3 = slot0._data.skillEffect
	slot0.chess = LengZhou6EliminateChessItemController.instance:getChessItem(slot0._data.x, slot0._data.y)

	if slot0.chess == nil then
		logWarn("步骤 DieEffect 棋子：" .. slot1, slot2 .. "不存在")
		slot0:onDone(true)

		return
	end

	slot0.chess:toDie(EliminateEnum.AniTime.Die, slot3)
	LengZhou6EliminateChessItemController.instance:updateChessItem(slot1, slot2, nil)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateEnum_2_7.DieStepTime)
end

return slot0
