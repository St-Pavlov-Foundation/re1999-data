module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepNewCards", package.seeall)

slot0 = class("XugoujiGameStepNewCards", XugoujiGameStepBase)

function slot0.start(slot0)
	Activity188Model.instance:clearCardsInfo()
	Activity188Model.instance:updateCardInfo(slot0._stepData.cards)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.NewCards)
	TaskDispatcher.runDelay(slot0.finish, slot0, 1)
end

function slot0.finish(slot0)
	if XugoujiGameStepController.instance then
		-- Nothing
	end

	uv0.super.finish(slot0)
end

return slot0
