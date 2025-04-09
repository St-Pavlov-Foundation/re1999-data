module("modules.logic.fight.system.work.FightWorkEffectCardEffectChange", package.seeall)

slot0 = class("FightWorkEffectCardEffectChange", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	for slot6, slot7 in ipairs(string.splitToNumber(slot0.actEffectData.reserveStr, "#")) do
		if FightDataHelper.handCardMgr.handCard[slot7] then
			FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, slot7)
			FightController.instance:dispatchEvent(FightEvent.CardEffectChange, slot7)
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
