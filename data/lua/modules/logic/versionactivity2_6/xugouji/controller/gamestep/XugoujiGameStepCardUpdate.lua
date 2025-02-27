module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepCardUpdate", package.seeall)

slot0 = VersionActivity2_6Enum.ActivityId.Xugouji
slot1 = class("XugoujiGameStepCardUpdate", XugoujiGameStepBase)

function slot1.start(slot0)
	if Activity188Config.instance:getCardCfg(uv0, Activity188Model.instance:getCardInfo(slot0._stepData.uid).id).type ~= 2 and slot3.statue ~= XugoujiEnum.CardStatus.Disappear and slot0._stepData.status == XugoujiEnum.CardStatus.Disappear then
		Activity188Model.instance:addOpenedCard(slot1)
	elseif slot5.type == 2 and slot2 == XugoujiEnum.CardStatus.Front then
		Activity188Model.instance:addOpenedCard(slot1)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPair)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.GotActiveCard, {
			slot1,
			-1
		})
	end

	Activity188Model.instance:updateCardStatus(slot1, slot2)

	if slot5.type == 2 then
		if slot2 == XugoujiEnum.CardStatus.Front then
			if slot1 == Activity188Model.instance:getLastCardInfoUId() then
				slot0:finish()
			else
				Activity188Model.instance:setLastCardInfoUId(slot1)
				XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
				XugoujiController.instance:openCardInfoView(nil)
			end
		else
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, slot0._stepData.uid)
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
			TaskDispatcher.runDelay(slot0.finish, slot0, 0.25)
		end
	elseif Activity188Model.instance:isMyTurn() then
		if Activity188Model.instance:getGameViewState() == XugoujiEnum.GameViewState.PlayerOperaDisplay then
			if slot2 ~= XugoujiEnum.CardStatus.Disappear and slot2 ~= XugoujiEnum.CardStatus.Back then
				XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
			end
		else
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
		end

		slot0:finish()
	elseif Activity188Model.instance:getGameViewState() == XugoujiEnum.GameViewState.EnemyOperaDisplay then
		if slot2 ~= XugoujiEnum.CardStatus.Disappear and slot2 ~= XugoujiEnum.CardStatus.Back then
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
		end

		slot0:finish()
	else
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot0._stepData.uid)
		TaskDispatcher.runDelay(slot0.finish, slot0, 0.5)
	end
end

function slot1.onCloseCardInfoView(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.3)
end

function slot1.finish(slot0)
	uv0.super.finish(slot0)
end

function slot1.dispose(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot1
