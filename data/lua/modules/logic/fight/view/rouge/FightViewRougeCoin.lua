module("modules.logic.fight.view.rouge.FightViewRougeCoin", package.seeall)

slot0 = class("FightViewRougeCoin", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._coinText = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._addCoinEffect = gohelper.findChild(slot0.viewGO, "obtain")
	slot0._minCoinEffect = gohelper.findChild(slot0.viewGO, "without")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, slot0._onResonanceLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, slot0._onPolarizationLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, slot0._onRougeCoinChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginFight, slot0._onRespBeginFight, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onRespBeginFight(slot0)
	slot0:_refreshCoin()
end

function slot0._onResonanceLevel(slot0)
	slot0:_refreshCoin()
end

function slot0._onPolarizationLevel(slot0)
	slot0:_refreshCoin()
end

function slot0._cancelCoinTimer(slot0)
	TaskDispatcher.cancelTask(slot0._hideCoinEffect, slot0)
end

function slot0._hideCoinEffect(slot0)
	gohelper.setActive(slot0._addCoinEffect, false)
	gohelper.setActive(slot0._minCoinEffect, false)
end

function slot0._onRougeCoinChange(slot0, slot1)
	slot0:_cancelCoinTimer()
	slot0:_refreshCoin()
	TaskDispatcher.runDelay(slot0._hideCoinEffect, slot0, 0.6)

	if slot1 > 0 then
		gohelper.setActive(slot0._addCoinEffect, true)
		gohelper.setActive(slot0._minCoinEffect, false)
	else
		gohelper.setActive(slot0._addCoinEffect, false)
		gohelper.setActive(slot0._minCoinEffect, true)
	end
end

function slot0.onOpen(slot0)
	slot0:_refreshCoin()
end

function slot0._refreshData(slot0)
	slot0:_refreshCoin()
end

function slot0._refreshCoin(slot0)
	slot2 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Rouge

	gohelper.setActive(slot0.viewGO, slot2)

	slot0._coinText.text = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)

	if slot2 then
		FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeCoin)
	else
		FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeCoin)
	end
end

function slot0.onClose(slot0)
	slot0:_cancelCoinTimer()
end

function slot0.onDestroyView(slot0)
end

return slot0
