module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminatePlayAudioStep", package.seeall)

slot0 = class("EliminatePlayAudioStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if slot0._data == nil then
		slot0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(slot1)
	slot0:onDone(true)
end

return slot0
