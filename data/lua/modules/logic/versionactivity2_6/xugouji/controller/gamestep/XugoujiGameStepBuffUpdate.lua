module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepBuffUpdate", package.seeall)

slot0 = class("XugoujiGameStepBuffUpdate", XugoujiGameStepBase)

function slot0.start(slot0)
	slot1 = slot0._stepData.isSelf

	Activity188Model.instance:setBuffs(slot0._stepData.buffs, slot1)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.BuffUpdated, slot1)
	slot0:finish()
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

return slot0
