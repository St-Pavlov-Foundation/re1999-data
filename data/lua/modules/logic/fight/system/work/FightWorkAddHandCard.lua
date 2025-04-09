module("modules.logic.fight.system.work.FightWorkAddHandCard", package.seeall)

slot0 = class("FightWorkAddHandCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if FightModel.instance:getVersion() >= 4 then
		slot0:com_registTimer(slot0._delayAfterPerformance, 0.5)
		FightController.instance:dispatchEvent(FightEvent.AddHandCard)
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
