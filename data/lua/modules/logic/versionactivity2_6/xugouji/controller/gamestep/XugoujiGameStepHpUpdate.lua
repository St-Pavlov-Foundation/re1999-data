module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepHpUpdate", package.seeall)

slot0 = class("XugoujiGameStepHpUpdate", XugoujiGameStepBase)

function slot0.start(slot0)
	Activity188Model.instance:updateHp(slot0._stepData.isSelf, slot0._stepData.hpChange)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HpUpdated)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.5)
end

function slot0.finish(slot0)
	if XugoujiGameStepController.instance then
		-- Nothing
	end

	uv0.super.finish(slot0)
end

return slot0
