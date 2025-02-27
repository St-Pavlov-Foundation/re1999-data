module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepResult", package.seeall)

slot0 = class("XugoujiGameStepResult", XugoujiGameStepBase)

function slot0.start(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GameResult, slot0._stepData)
	XugoujiGameStepController.instance:disposeAllStep()
end

return slot0
