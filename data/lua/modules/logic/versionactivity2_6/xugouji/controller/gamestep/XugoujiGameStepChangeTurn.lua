module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepChangeTurn", package.seeall)

slot0 = class("XugoujiGameStepChangeTurn", XugoujiGameStepBase)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji
slot2 = 2
slot3 = 3

function slot0.start(slot0)
	Activity188Model.instance:setTurn(slot0._stepData.isSelf)
	Activity188Model.instance:setCurCardUid(nil)

	if not Activity188Model.instance:isGameGuideMode() then
		slot4 = false

		for slot8, slot9 in ipairs(Activity188Model.instance:getCardsInfoList()) do
			if Activity188Model.instance:getCardItemStatue(slot9.uid) == XugoujiEnum.CardStatus.Front then
				slot4 = true

				break
			end
		end

		if slot4 then
			TaskDispatcher.runDelay(slot0._doChangeTurnAction, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, uv1).value2) or 2)
		else
			TaskDispatcher.runDelay(slot0._doChangeTurnCardsView, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, uv2).value2) or 2)
		end
	else
		XugoujiController.instance:registerCallback(XugoujiEvent.GuideChangeTurn, slot0._onGuideChangeTurn, slot0)
	end
end

function slot0._onGuideChangeTurn(slot0)
	slot0:_doChangeTurnAction()
end

function slot0._doChangeTurnAction(slot0)
	slot0:_filpBackUnActiveCards()
	TaskDispatcher.runDelay(slot0._doChangeTurnCardsView, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, uv1).value2) or 2)
end

function slot0._filpBackUnActiveCards(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.FilpBackUnActiveCard)
end

function slot0._doChangeTurnCardsView(slot0)
	if Activity188Model.instance:isMyTurn() then
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.PlayerOperating)
	else
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.EnemyOperating)
	end

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.changeTurn)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.TurnChanged, slot1 and 1 or 0)

	slot2 = tonumber(Activity188Config.instance:getConstCfg(uv0, uv1).value2)

	TaskDispatcher.runDelay(slot0.finish, slot0, 1)
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.GuideChangeTurn, slot0._onGuideChangeTurn, slot0)
	TaskDispatcher.cancelTask(slot0._doChangeTurnAction, slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot0
