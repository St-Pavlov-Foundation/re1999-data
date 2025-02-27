module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepHpUpdate", package.seeall)

slot0 = class("XugoujiGameStepHpUpdate", XugoujiGameStepBase)

function slot0.start(slot0)
	Activity188Model.instance:updateHp(slot0._stepData.isSelf, slot0._stepData.hpChange)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HpUpdated)
	slot0:finish()
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot0
