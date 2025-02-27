module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepBase", package.seeall)

slot0 = class("XugoujiGameStepBase")

function slot0.init(slot0, slot1)
	slot0._stepData = slot1
end

function slot0.start(slot0)
end

function slot0.finish(slot0)
	if XugoujiGameStepController.instance then
		slot1:nextStep()
	end
end

function slot0.dispose(slot0)
	slot0._stepData = nil
end

return slot0
