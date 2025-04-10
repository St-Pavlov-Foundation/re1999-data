module("modules.logic.fight.system.work.FightWorkAfterRedealCard", package.seeall)

slot0 = class("FightWorkAfterRedealCard", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.oldCardList = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() < 5 then
		slot0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)
	slot0:com_registTimer(slot0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, slot0.oldCardList, FightDataHelper.handCardMgr.handCard)
end

return slot0
