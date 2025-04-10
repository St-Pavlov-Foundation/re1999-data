module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessUpdateDamageStep", package.seeall)

slot0 = class("EliminateChessUpdateDamageStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot0._isRound = slot0._data.isRound

	LengZhou6GameModel.instance:getEnemy():changeHp(-slot0._data.damage)
	LengZhou6GameModel.instance:getPlayer():changeHp(slot0._data.hp)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEliminateDamage)
	LengZhou6EliminateController.instance:resetCurEliminateCount()

	if LengZhou6EliminateController.instance:dispatchShowAssess() ~= nil then
		slot6 = math.max(0, EliminateEnum_2_7.AssessShowTime)
	end

	slot7, slot8 = LengZhou6GameModel.instance:getTotalPlayerSettle()

	if slot7 > 0 then
		slot6 = math.max(slot6, EliminateEnum_2_7.UpdateDamageStepTime)
	end

	if slot6 == 0 then
		slot0:_onDone()
	else
		TaskDispatcher.runDelay(slot0._onDone, slot0, slot6)
	end
end

function slot0._onDone(slot0)
	LengZhou6GameController.instance:_updateRoundAndCD(slot0._isRound)
	uv0.super._onDone(slot0)
end

return slot0
