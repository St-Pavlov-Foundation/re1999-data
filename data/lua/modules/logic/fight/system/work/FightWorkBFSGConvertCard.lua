module("modules.logic.fight.system.work.FightWorkBFSGConvertCard", package.seeall)

slot0 = class("FightWorkBFSGConvertCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	if FightDataHelper.handCardMgr.handCard[slot0.actEffectData.effectNum] then
		FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, slot2)
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
