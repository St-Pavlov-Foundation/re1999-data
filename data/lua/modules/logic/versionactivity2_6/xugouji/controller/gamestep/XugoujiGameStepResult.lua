module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepResult", package.seeall)

slot0 = class("XugoujiGameStepResult", XugoujiGameStepBase)

function slot0.start(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GameResult, slot0._stepData)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.5)
end

function slot0.finish(slot0)
	slot1 = XugoujiGameStepController.instance

	uv0.super.finish(slot0)
end

return slot0
