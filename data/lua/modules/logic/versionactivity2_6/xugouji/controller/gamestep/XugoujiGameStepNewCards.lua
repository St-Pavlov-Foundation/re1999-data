module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepNewCards", package.seeall)

slot0 = class("XugoujiGameStepNewCards", XugoujiGameStepBase)

function slot0.start(slot0)
	Activity188Model.instance:clearCardsInfo()
	Activity188Model.instance:updateCardInfo(slot0._stepData.cards)
	Activity188Model.instance:setPairCount(0, true)
	Activity188Model.instance:setPairCount(0, false)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GotNewCardDisplay)
	XugoujiGameStepController.instance:insertStepListClient({
		{
			stepType = XugoujiEnum.GameStepType.UpdateInitialCard
		}
	}, true)
	TaskDispatcher.runDelay(slot0.doNewCardDisplay, slot0, 0.5)
end

function slot0.doNewCardDisplay(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.NewCards)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.5)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot0
