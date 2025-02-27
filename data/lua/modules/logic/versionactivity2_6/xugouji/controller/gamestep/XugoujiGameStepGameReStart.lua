module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepGameReStart", package.seeall)

slot0 = class("XugoujiGameStepGameReStart", XugoujiGameStepBase)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.start(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GameRestartCardDisplay)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.5)
end

function slot0.dispose(slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot0
