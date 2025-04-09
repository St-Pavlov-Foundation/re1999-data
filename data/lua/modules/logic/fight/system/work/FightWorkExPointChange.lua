module("modules.logic.fight.system.work.FightWorkExPointChange", package.seeall)

slot0 = class("FightWorkExPointChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0.actEffectData.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._oldValue = slot0._entityMO and slot0._entityMO.exPoint
end

function slot0.onStart(slot0)
	if not slot0._entityMO then
		slot0:onDone(true)

		return
	end

	slot0._newValue = slot0._entityMO and slot0._entityMO.exPoint

	if slot0._oldValue ~= slot0._newValue then
		FightController.instance:dispatchEvent(FightEvent.OnExPointChange, slot0._entityId, slot0._oldValue, slot0._newValue)

		if FightModel.instance:getVersion() < 1 and slot0._newValue < slot0._oldValue then
			if FightModel.instance:getCurStage() == FightEnum.Stage.StartRound then
				slot0:onDone(true)

				return
			end

			if slot0:_calcRemoveCard() then
				slot0:_removeCard(slot2)

				return
			end
		end
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
		slot0:com_registTimer(slot0._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
		FightController.instance:dispatchEvent(FightEvent.CardRemove, slot1, 1.2 + slot4 * 7 + 3 * slot4 * (slot3 - #slot1), true)
	else
		slot0:com_registTimer(slot0._delayAfterPerformance, slot5 / FightModel.instance:getUISpeed())
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

function slot0._calcRemoveCard(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(FightDataHelper.handCardMgr.handCard) do
		if FightDataHelper.entityMgr:getById(slot7.uid) and FightCardDataHelper.isBigSkill(slot7.skillId) and slot8:getExPoint() < (slot8 and slot8:getUniqueSkillPoint() or 5) then
			table.insert(slot2 or {}, slot6)
		end
	end

	return slot2
end

function slot0.clearWork(slot0)
	if slot0._needRemoveCard and slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
end

return slot0
