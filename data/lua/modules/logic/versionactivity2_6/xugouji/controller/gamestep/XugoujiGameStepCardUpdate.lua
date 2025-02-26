module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepCardUpdate", package.seeall)

slot0 = VersionActivity2_6Enum.ActivityId.Xugouji
slot1 = class("XugoujiGameStepCardUpdate", XugoujiGameStepBase)

function slot1.start(slot0)
	slot1 = slot0._stepData.uid
	slot6 = Activity188Model.instance:getLastCardStatus()
	slot7 = Activity188Model.instance:getLastCardId()
	slot8 = Activity188Model.instance:getLastCardUid()

	Activity188Model.instance:updateCardStatus(slot1, slot0._stepData.status)

	if Activity188Config.instance:getCardCfg(uv0, Activity188Model.instance:getCardInfo(slot1).id).type == 2 then
		if slot2 == XugoujiEnum.CardStatus.Front then
			XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
			XugoujiController.instance:openCardInfoView()
		else
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, slot0._stepData.uid)
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
			TaskDispatcher.runDelay(slot0.finish, slot0, 0.25)
		end
	else
		if Activity188Model.instance:isMyTurn() then
			if Activity188Model.instance:getGameViewState() ~= XugoujiEnum.GameViewState.PlayerOperaDisplay then
				XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
			end
		elseif Activity188Model.instance:getGameViewState() ~= XugoujiEnum.GameViewState.EnemyOperaDisplay then
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
		end

		TaskDispatcher.runDelay(slot0.finish, slot0, 0.25)
	end
end

function slot1._onCardActionDone(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
	slot0:finish()
end

function slot1.onCloseCardInfoView(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	slot0:finish()
end

function slot1.finish(slot0)
	uv0.super.finish(slot0)
end

return slot1
