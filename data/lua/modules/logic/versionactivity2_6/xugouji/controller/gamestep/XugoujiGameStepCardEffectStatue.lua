module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepCardEffectStatue", package.seeall)

slot0 = VersionActivity2_6Enum.ActivityId.Xugouji
slot1 = class("XugoujiGameStepCardEffectStatue", XugoujiGameStepBase)

function slot1.start(slot0)
	Activity188Model.instance:updateCardEffectStatus(slot0._stepData.uid, slot0._stepData.isAdd, slot0._stepData.status)
	slot0:_doCardEffect(slot0._onCardEffectActionDone, slot0)
end

function slot1._doCardEffect(slot0, slot1, slot2)
	if not Activity188Model.instance:getCardInfo(slot0._stepData.uid) then
		slot0.finish()
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.CardEffectStatusUpdated, slot3)
	slot1(slot2)
end

function slot1._onCardEffectActionDone(slot0)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.5)
end

function slot1.finish(slot0)
	uv0.super.finish(slot0)
end

return slot1
