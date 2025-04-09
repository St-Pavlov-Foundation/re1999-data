module("modules.logic.fight.system.work.FightWorkAddSpHandCard320", package.seeall)

slot0 = class("FightWorkAddSpHandCard320", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
	FightController.instance:dispatchEvent(FightEvent.SpCardAdd, #FightDataHelper.handCardMgr.handCard)
	slot0:com_registTimer(slot0._delayAfterPerformance, 0.7 / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
