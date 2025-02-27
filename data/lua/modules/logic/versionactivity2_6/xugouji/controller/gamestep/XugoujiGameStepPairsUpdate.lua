module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepPairsUpdate", package.seeall)

slot0 = class("XugoujiGameStepPairsUpdate", XugoujiGameStepBase)

function slot0.start(slot0)
	slot1 = slot0._stepData.isSelf

	if slot0._stepData.pairCount == 0 then
		slot0:finish()

		return
	end

	Activity188Model.instance:setPairCount(slot2, slot1)
	TaskDispatcher.runDelay(slot0.doGotPairsView, slot0, 0.5)
end

function slot0.doGotPairsView(slot0)
	slot1, slot2 = Activity188Model.instance:getLastCardPair()

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPair)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.GotActiveCard, {
			slot1,
			slot2
		})
	end

	XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	XugoujiController.instance:openCardInfoView()
end

function slot0.onCloseCardInfoView(slot0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)

	slot1, slot2 = Activity188Model.instance:getLastCardPair()

	if slot1 then
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, slot1)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, slot2)
	end

	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.3)
end

function slot0.dispose(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	TaskDispatcher.cancelTask(slot0.doGotPairsView, slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot0
