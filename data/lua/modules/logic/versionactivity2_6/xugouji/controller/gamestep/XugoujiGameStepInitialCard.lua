module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepInitialCard", package.seeall)

slot0 = VersionActivity2_6Enum.ActivityId.Xugouji
slot1 = class("XugoujiGameStepInitialCard", XugoujiGameStepBase)

function slot1.start(slot0)
	if Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).readNum > #Activity188Model.instance:getCardsInfoList() then
		slot4 = #slot1 or slot4
	end

	slot0._randomCardIdxs = {}

	for slot8 = 1, slot4 do
		while tabletool.indexOf(slot0._randomCardIdxs, math.random(1, #slot1)) do
			slot9 = math.random(1, #slot1)
		end

		table.insert(slot0._randomCardIdxs, slot9)
	end

	for slot8 = 1, #slot0._randomCardIdxs do
		slot11 = slot1[slot0._randomCardIdxs[slot8]].uid

		Activity188Model.instance:updateCardStatus(slot11, XugoujiEnum.CardStatus.Front)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot11)
	end

	if not Activity188Model.instance:isGameGuideMode() then
		TaskDispatcher.runDelay(slot0._onCardInitailDone, slot0, 2)
	end

	XugoujiController.instance:registerCallback(XugoujiEvent.FinishInitialCardShow, slot0._onCardInitailDone, slot0)
end

function slot1._onCardInitailDone(slot0)
	for slot5 = 1, #slot0._randomCardIdxs do
		slot8 = Activity188Model.instance:getCardsInfoList()[slot0._randomCardIdxs[slot5]].uid

		Activity188Model.instance:updateCardStatus(slot8, XugoujiEnum.CardStatus.Back)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, slot8)
	end

	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	TaskDispatcher.runDelay(slot0.finish, slot0, 1)
end

function slot1.dispose(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.FinishInitialCardShow, slot0._onCardInitailDone, slot0)
	TaskDispatcher.cancelTask(slot0._onCardInitailDone, slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot1
