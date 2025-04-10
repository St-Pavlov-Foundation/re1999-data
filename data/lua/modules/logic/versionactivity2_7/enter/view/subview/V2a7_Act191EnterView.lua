module("modules.logic.versionactivity2_7.enter.view.subview.V2a7_Act191EnterView", package.seeall)

slot0 = class("V2a7_Act191EnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._btnShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Shop")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#btn_Shop/#txt_num")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Enter")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnShop:AddClickListener(slot0._btnShopOnClick, slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnShop:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
end

function slot0._btnShopOnClick(slot0)
	Activity191Controller.instance:openStoreView(VersionActivity2_7Enum.ActivityId.Act191Store)
end

function slot0._btnEnterOnClick(slot0)
	Activity191Controller.instance:openMainView()
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity2_7Enum.ActivityId.Act191
	slot0._txtdesc.text = ActivityConfig.instance:getActivityCo(slot0.actId).actDesc
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
	Activity191Rpc.instance:sendGetAct191InfoRequest(slot0.actId)
	slot0:refreshCurrency()
end

function slot0.everySecondCall(slot0)
	slot0._txttime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.refreshCurrency(slot0)
	slot0._txtnum.text = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act191).quantity
end

return slot0
