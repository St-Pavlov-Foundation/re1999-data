module("modules.logic.fight.system.work.FightWorkCardAConvertCardB", package.seeall)

slot0 = class("FightWorkCardAConvertCardB", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(2000072)

	if FightModel.instance:getVersion() >= 4 then
		FightController.instance:dispatchEvent(FightEvent.CardAConvertCardB, slot0.actEffectData.effectNum)
		slot0:com_registTimer(slot0._delayAfterPerformance, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
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
