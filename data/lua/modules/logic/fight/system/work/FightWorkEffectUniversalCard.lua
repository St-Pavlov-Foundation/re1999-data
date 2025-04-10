module("modules.logic.fight.system.work.FightWorkEffectUniversalCard", package.seeall)

slot0 = class("FightWorkEffectUniversalCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)
	FightController.instance:dispatchEvent(FightEvent.UniversalAppear)
	slot0:com_registTimer(slot0._delayDone, 1.3 / FightModel.instance:getUISpeed())
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
