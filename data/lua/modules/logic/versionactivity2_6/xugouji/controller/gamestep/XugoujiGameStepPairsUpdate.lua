module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepPairsUpdate", package.seeall)

slot0 = class("XugoujiGameStepPairsUpdate", XugoujiGameStepBase)

function slot0.start(slot0)
	slot1 = slot0._stepData.isSelf

	if slot0._stepData.pairCount == 0 then
		slot0:finish()

		return
	end

	Activity188Model.instance:setPairCount(slot2, slot1)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GotCardPair)
	XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	XugoujiController.instance:openCardInfoView()
end

function slot0.onCloseCardInfoView(slot0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)

	if Activity188Model.instance:getLastCardPair() then
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, slot1[1])
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, slot1[2])
	end

	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, slot0.onCloseCardInfoView, slot0)
	slot0:finish()
end

function slot0.finish(slot0)
	if XugoujiGameStepController.instance then
		-- Nothing
	end

	uv0.super.finish(slot0)
end

return slot0
