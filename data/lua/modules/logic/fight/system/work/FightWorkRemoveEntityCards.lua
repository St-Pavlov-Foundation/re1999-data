module("modules.logic.fight.system.work.FightWorkRemoveEntityCards", package.seeall)

slot0 = class("FightWorkRemoveEntityCards", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	slot1 = slot0.oldHandCard
	slot2 = #slot1

	for slot7 = #slot1, 1, -1 do
		if slot1[slot7].uid == slot0.actEffectData.targetId then
			slot3 = 0 + 1
		end
	end

	if slot3 > 0 then
		slot4 = 0.033

		if FightModel.instance:getVersion() >= 4 then
			slot0:com_registTimer(slot0._delayAfterPerformance, (1.2 + slot4 * 7 + 3 * slot4 * (slot2 - slot3)) / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.RemoveEntityCards, slot0.actEffectData.targetId)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			slot0:onDone(true)
		end
	else
		slot0:onDone(true)
	end
end

function slot0._delayAfterPerformance(slot0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
