module("modules.logic.fight.system.work.FightWorkPlayAroundDownRank", package.seeall)

slot0 = class("FightWorkPlayAroundDownRank", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	if FightPlayCardModel.instance:getUsedCards()[slot0.actEffectData.effectNum] then
		slot3:init(slot0.actEffectData.cardInfo)
		slot0:com_sendFightEvent(FightEvent.PlayCardAroundDownRank, slot1, slot3.skillId)
	end

	slot0:com_registTimer(slot0._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
end

return slot0
