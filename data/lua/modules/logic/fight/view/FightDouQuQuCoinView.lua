module("modules.logic.fight.view.FightDouQuQuCoinView", package.seeall)

slot0 = class("FightDouQuQuCoinView", FightBaseView)

function slot0.onInitView(slot0)
	slot0.coinText = gohelper.findChildText(slot0.viewGO, "root/#txt_CoinCnt1")
	slot0.changeText = gohelper.findChildText(slot0.viewGO, "root/#txt_num")
	slot0.addEffect = gohelper.findChild(slot0.viewGO, "root/#add")
	slot0.subEffect = gohelper.findChild(slot0.viewGO, "root/#subtract")

	gohelper.setActive(slot0.addEffect, false)
	gohelper.setActive(slot0.subEffect, false)

	slot0.changeText.text = ""
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.UpdateFightParam, slot0.onUpdateFightParam)
end

function slot0.onUpdateFightParam(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= FightParamData.ParamKey.ACT191_COIN then
		return
	end

	slot0.changeText.text = -slot4

	gohelper.setActive(slot0.subEffect, false)
	gohelper.setActive(slot0.subEffect, true)
	slot0:com_registSingleTimer(slot0.hideEffect, 1)
	slot0:com_scrollNumTween(slot0.coinText, slot2, slot3, 0.5)
end

function slot0.hideEffect(slot0)
	gohelper.setActive(slot0.subEffect, false)

	slot0.changeText.text = ""
end

function slot0.refreshData(slot0)
	slot0.coinText.text = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_COIN]
end

function slot0.onOpen(slot0)
	slot0:refreshData()
end

return slot0
