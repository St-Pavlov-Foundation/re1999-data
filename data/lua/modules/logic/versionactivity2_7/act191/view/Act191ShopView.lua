module("modules.logic.versionactivity2_7.act191.view.Act191ShopView", package.seeall)

slot0 = class("Act191ShopView", BaseView)

function slot0.onInitView(slot0)
	slot0._goNodeList = gohelper.findChild(slot0.viewGO, "#go_NodeList")
	slot0._btnFreshShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/shopRoot/#btn_FreshShop")
	slot0._txtFreshCost = gohelper.findChildText(slot0.viewGO, "Middle/shopRoot/#btn_FreshShop/#txt_FreshCost")
	slot0._goFreeFresh = gohelper.findChild(slot0.viewGO, "Middle/shopRoot/#btn_FreshShop/#go_FreeFresh")
	slot0._goShopItem = gohelper.findChild(slot0.viewGO, "Middle/shopRoot/#go_ShopItem")
	slot0._goShopLevel = gohelper.findChild(slot0.viewGO, "Middle/shopRoot/#go_ShopLevel")
	slot0._txtShopLevel = gohelper.findChildText(slot0.viewGO, "Middle/shopRoot/#go_ShopLevel/#txt_ShopLevel")
	slot0._btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/shopRoot/#go_ShopLevel/#btn_Detail")
	slot0._goDetail = gohelper.findChild(slot0.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail")
	slot0._btnCloseDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail/#btn_CloseDetail")
	slot0._txtDetail = gohelper.findChildText(slot0.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail/go_scroll/viewport/content/#txt_Detail")
	slot0._btnNext = gohelper.findChildButtonWithAudio(slot0.viewGO, "Bottom/#btn_Next")
	slot0._goTeam = gohelper.findChild(slot0.viewGO, "Bottom/#go_Team")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._txtCoin = gohelper.findChildText(slot0.viewGO, "go_topright/Coin/#txt_Coin")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "go_topright/Score/#txt_Score")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnFreshShop:AddClickListener(slot0._btnFreshShopOnClick, slot0)
	slot0._btnDetail:AddClickListener(slot0._btnDetailOnClick, slot0)
	slot0._btnCloseDetail:AddClickListener(slot0._btnCloseDetailOnClick, slot0)
	slot0._btnNext:AddClickListener(slot0._btnNextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnFreshShop:RemoveClickListener()
	slot0._btnDetail:RemoveClickListener()
	slot0._btnCloseDetail:RemoveClickListener()
	slot0._btnNext:RemoveClickListener()
end

function slot0._btnCloseDetailOnClick(slot0)
	gohelper.setActive(slot0._goDetail, false)
end

function slot0._btnDetailOnClick(slot0)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnDetailOnClick")
	gohelper.setAsLastSibling(slot0._goShopLevel)
	gohelper.setActive(slot0._goDetail, true)
end

function slot0._btnFreshShopOnClick(slot0)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnFreshShopOnClick")

	if slot0.gameInfo.coin < slot0:getFreshShopCost() then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	for slot4, slot5 in ipairs(slot0.shopItemList) do
		slot5:playFreshAnim()
	end

	TaskDispatcher.runDelay(slot0.delayFresh, slot0, 0.16)
end

function slot0.delayFresh(slot0)
	Activity191Rpc.instance:sendFresh191ShopRequest(slot0.actId, slot0._updateInfo, slot0)
end

function slot0._btnNextOnClick(slot0)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnNextOnClick")

	slot0.isLeaving = true

	Activity191Rpc.instance:sendLeave191ShopRequest(slot0.actId, slot0.onLeaveShop, slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goShopItem, false)

	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0.nodeDetailMo = slot0.gameInfo:getNodeDetailMo()
	slot1 = nil

	if tabletool.indexOf(Activity191Enum.TagShopField, slot0.nodeDetailMo.type) then
		slot1 = lua_activity191_const.configDict[Activity191Enum.ConstKey.TagShopFreshCost].value
		slot0.freshLimit = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.TagShopFreshLimit].value)
	else
		slot1 = lua_activity191_const.configDict[Activity191Enum.ConstKey.ShopFreshCost].value
	end

	slot0.freshCostList = GameUtil.splitString2(slot1, true)
	slot0.shopItemList = {}
	slot0.animBtnFresh = slot0._btnFreshShop.gameObject:GetComponent(gohelper.Type_Animator)

	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.NodeListItem, slot0._goNodeList), Act191NodeListItem, slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_unfold)

	slot0.teamComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.TeamComp, slot0._goTeam), Act191TeamComp, slot0)
end

function slot0._updateInfo(slot0)
	if slot0.isLeaving then
		return
	end

	slot0.nodeDetailMo = slot0.gameInfo:getNodeDetailMo()

	slot0:refreshShop()
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, slot0._updateInfo, slot0)

	if slot0.nodeDetailMo.type == Activity191Enum.NodeType.CollectionShop then
		slot0.teamComp:onClickSwitch(true)
	end

	slot0:refreshUI()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.refreshUI(slot0)
	slot0.shopConfig = lua_activity191_shop.configDict[slot0.actId][slot0.nodeDetailMo.shopId]
	slot0._txtShopLevel.text = slot0.shopConfig.name
	slot0._txtDetail.text = slot0.shopConfig.desc
	slot0._txtScore.text = slot0.gameInfo.score

	slot0:refreshShop()
end

function slot0.refreshShop(slot0)
	if slot0.freshLimit and slot0.freshLimit <= slot0.nodeDetailMo.shopFreshNum then
		gohelper.setActive(slot0._btnFreshShop, false)
	else
		gohelper.setActive(slot0._btnFreshShop, true)
		slot0.animBtnFresh:Play(slot0:getFreshShopCost() == 0 and "first" or "idle", 0, 0)

		slot0._txtFreshCost.text = slot1
	end

	slot0._txtCoin.text = slot0.gameInfo.coin

	for slot4 = 1, 6 do
		if slot0.nodeDetailMo.shopPosMap[tostring(slot4)] then
			(slot0.shopItemList[slot4] or slot0:createShopItem(slot4)):setData(slot5, tabletool.indexOf(slot0.nodeDetailMo.boughtSet, slot4))
		end
	end
end

function slot0.createShopItem(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goShopItem, "shopItem" .. slot1), Act191ShopItem, slot0)

	slot3:setIndex(slot1)

	slot0.shopItemList[slot1] = slot3

	return slot3
end

function slot0.onLeaveShop(slot0, slot1, slot2)
	if slot2 == 0 then
		Activity191Controller.instance:nextStep()
		ViewMgr.instance:closeView(slot0.viewName)
	end
end

function slot0.getFreshShopCost(slot0)
	for slot5 = #slot0.freshCostList, 1, -1 do
		if slot0.freshCostList[slot5][1] <= slot0.nodeDetailMo.shopFreshNum + 1 then
			return slot6[2]
		end
	end
end

return slot0
