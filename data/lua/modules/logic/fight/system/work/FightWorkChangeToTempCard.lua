module("modules.logic.fight.system.work.FightWorkChangeToTempCard", package.seeall)

slot0 = class("FightWorkChangeToTempCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	if #string.splitToNumber(slot0.actEffectData.reserveStr, "#") > 0 then
		for slot6, slot7 in ipairs(slot1) do
			if FightDataHelper.handCardMgr.handCard[slot7] then
				FightController.instance:dispatchEvent(FightEvent.ChangeToTempCard, slot7)
			end
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
