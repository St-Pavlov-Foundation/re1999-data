module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessUpdateDamageStep", package.seeall)

slot0 = class("EliminateChessUpdateDamageStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEliminateDamage)
	LengZhou6EliminateController.instance:resetCurEliminateCount()

	if LengZhou6EliminateController.instance:dispatchShowAssess() ~= nil then
		slot2 = math.max(0, EliminateEnum_2_7.AssessShowTime)
	end

	slot3, slot4 = LengZhou6GameModel.instance:getTotalPlayerSettle()

	if slot3 > 0 then
		slot2 = math.max(slot2, EliminateEnum_2_7.UpdateDamageStepTime)
	end

	if slot2 == 0 then
		slot0:_onDone()
	else
		TaskDispatcher.runDelay(slot0._onDone, slot0, slot2)
	end
end

return slot0
