module("modules.logic.versionactivity2_5.challenge.view.store.Act183StoreEntry", package.seeall)

slot0 = class("Act183StoreEntry", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_click")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "root/#txt_Num")
	slot0._gostoretips = gohelper.findChild(slot0.viewGO, "root/#go_storetips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstore:RemoveClickListener()
end

function slot0._btnstoreOnClick(slot0)
	Act183Controller.instance:openAct183StoreView()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshStoreTag, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.refreshStoreTag, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, slot0.refreshStoreTag, slot0)

	slot0._actId = Act183Model.instance:getActivityId()
end

function slot0.onOpen(slot0)
	slot0:refreshCurrency()
	slot0:refreshStoreTag()
end

function slot0.refreshCurrency(slot0)
	slot0._txtNum.text = V1a6_BossRush_StoreModel.instance:getCurrencyCount(slot0._actId) or 0
end

function slot0.refreshStoreTag(slot0)
	gohelper.setActive(slot0._gostoretips, V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore())
end

return slot0
