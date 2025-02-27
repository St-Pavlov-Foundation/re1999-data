module("modules.logic.fight.system.work.FightWorkAfterRedealCard", package.seeall)

slot0 = class("FightWorkAfterRedealCard", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() < 5 then
		slot0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)

	slot3 = FightHelper.buildInfoMOs(slot0._actEffectMO.cardInfoList, FightCardInfoMO)

	FightCardModel.instance:coverCard(slot3)
	slot0:com_registTimer(slot0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, FightDataHelper.coverData(FightCardModel.instance:getHandCards()), slot3)
end

return slot0
