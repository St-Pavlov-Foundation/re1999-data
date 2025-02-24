module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepChangeTurn", package.seeall)

slot0 = class("XugoujiGameStepChangeTurn", XugoujiGameStepBase)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji
slot2 = 2
slot3 = 3

function slot0.start(slot0)
	Activity188Model.instance:setTurn(slot0._stepData.isSelf)
	Activity188Model.instance:setCurCardUid(nil)
	TaskDispatcher.runDelay(slot0._doChangeTurnAction, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, uv1).value2) or 2)
end

function slot0._doChangeTurnAction(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.TurnChanged)

	if Activity188Model.instance:isMyTurn() then
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.PlayerOperating)
	else
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.EnemyOperating)
	end

	slot2 = tonumber(Activity188Config.instance:getConstCfg(uv0, uv1).value2)

	TaskDispatcher.runDelay(slot0.finish, slot0, 1)
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

return slot0
