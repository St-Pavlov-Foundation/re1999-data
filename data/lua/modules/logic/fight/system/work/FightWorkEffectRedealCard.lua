module("modules.logic.fight.system.work.FightWorkEffectRedealCard", package.seeall)

slot0 = class("FightWorkEffectRedealCard", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)
	slot0:_playRedealCardEffect()
end

function slot0._playRedealCardEffect(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)
	slot0:com_registTimer(slot0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, slot0.oldHandCard, FightDataHelper.handCardMgr.handCard)
end

function slot0.clearWork(slot0)
end

return slot0
