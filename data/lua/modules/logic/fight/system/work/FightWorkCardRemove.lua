module("modules.logic.fight.system.work.FightWorkCardRemove", package.seeall)

slot0 = class("FightWorkCardRemove", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.oldCardList = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if #string.splitToNumber(slot0.actEffectData.reserveStr, "#") > 0 then
		table.sort(slot1, FightWorkCardRemove2.sort)

		slot3 = FightCardDataHelper.calcRemoveCardTime(slot0.oldCardList, slot1)

		for slot7, slot8 in ipairs(slot1) do
			table.remove(slot2, slot8)
		end

		if FightModel.instance:getVersion() >= 4 then
			slot0:com_registTimer(slot0._delayAfterPerformance, slot3 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove, slot1)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			slot0:onDone(true)
		end

		return
	end

	slot0:onDone(true)
end

function slot0._onCombineDone(slot0)
	slot0:onDone(true)
end

function slot0._delayAfterPerformance(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)

	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
