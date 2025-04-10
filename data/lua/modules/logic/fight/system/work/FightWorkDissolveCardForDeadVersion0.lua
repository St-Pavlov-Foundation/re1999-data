module("modules.logic.fight.system.work.FightWorkDissolveCardForDeadVersion0", package.seeall)

slot0 = class("FightWorkDissolveCardForDeadVersion0", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.actEffectData = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5)

	if not FightHelper.getEntity(slot0.actEffectData.targetId) then
		slot0:onDone(true)

		return
	end

	if slot2:getMO() and slot0:_calcRemoveCard(slot1) then
		slot0:_removeCard(slot4)

		return
	end

	slot0:onDone(true)
end

function slot0._removeCard(slot0, slot1)
	slot0._needRemoveCard = true
	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	slot3 = #FightDataHelper.handCardMgr.handCard

	table.sort(slot1, FightWorkCardRemove2.sort)

	for slot7, slot8 in ipairs(slot1) do
		table.remove(slot2, slot8)
	end

	slot4 = 0.033

	if FightCardDataHelper.canCombineCardListForPerformance(slot2) then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
		FightController.instance:dispatchEvent(FightEvent.CardRemove, slot1, 1.2 + slot4 * 7 + 3 * slot4 * (slot3 - #slot1), true)
	else
		TaskDispatcher.runDelay(slot0._delayAfterPerformance, slot0, slot5 / FightModel.instance:getUISpeed())
		FightController.instance:dispatchEvent(FightEvent.CardRemove, slot1)
	end
end

function slot0._onCombineDone(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0._delayAfterPerformance(slot0)
	slot0:onDone(true)
end

function slot0._calcRemoveCard(slot0, slot1)
	slot3 = nil

	for slot7 = #FightDataHelper.handCardMgr.handCard, 1, -1 do
		if slot2[slot7].uid == slot1 then
			table.insert(slot3 or {}, slot7)
		end
	end

	return slot3
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterPerformance, slot0)

	if slot0._needRemoveCard and slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
end

return slot0
