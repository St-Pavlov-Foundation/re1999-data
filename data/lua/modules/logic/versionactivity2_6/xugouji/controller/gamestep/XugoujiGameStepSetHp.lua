module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepSetHp", package.seeall)

slot0 = class("XugoujiGameStepSetHp", XugoujiGameStepBase)

function slot0.start(slot0)
	slot0:finish()
end

function slot0.finish(slot0)
	Activity188Model.instance:setHp(slot0.originData.hp)
	XugoujiController.instance:dispatchEvent(Va3ChessEvent.CurrentHpUpdate)
	uv0.super.finish(slot0)
end

return slot0
