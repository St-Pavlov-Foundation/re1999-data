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
	slot0._btnNextTeam = gohelper.findChildButtonWithAudio(slot0.viewGO, "Bottom/team/#btn_NextTeam")
	slot0._btnLastTeam = gohelper.findChildButtonWithAudio(slot0.viewGO, "Bottom/team/#btn_LastTeam")
	slot0._goHeroItem = gohelper.findChild(slot0.viewGO, "Bottom/team/#go_HeroItem")
	slot0._goMainHero = gohelper.findChild(slot0.viewGO, "Bottom/team/#go_MainHero")
	slot0._goSubHero = gohelper.findChild(slot0.viewGO, "Bottom/team/#go_SubHero")
	slot0._scrolltag = gohelper.findChildScrollRect(slot0.viewGO, "Bottom/#scroll_tag")
	slot0._goFetterContent = gohelper.findChild(slot0.viewGO, "Bottom/#scroll_tag/Viewport/#go_FetterContent")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._txtCoin = gohelper.findChildText(slot0.viewGO, "go_topright/Coin/#txt_Coin")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnFreshShop:AddClickListener(slot0._btnFreshShopOnClick, slot0)
	slot0._btnDetail:AddClickListener(slot0._btnDetailOnClick, slot0)
	slot0._btnCloseDetail:AddClickListener(slot0._btnCloseDetailOnClick, slot0)
	slot0._btnNext:AddClickListener(slot0._btnNextOnClick, slot0)
	slot0._btnNextTeam:AddClickListener(slot0._btnNextTeamOnClick, slot0)
	slot0._btnLastTeam:AddClickListener(slot0._btnLastTeamOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnFreshShop:RemoveClickListener()
	slot0._btnDetail:RemoveClickListener()
	slot0._btnCloseDetail:RemoveClickListener()
	slot0._btnNext:RemoveClickListener()
	slot0._btnNextTeam:RemoveClickListener()
	slot0._btnLastTeam:RemoveClickListener()
end

function slot0._onEscBtnClick(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
	slot0:closeThis()
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
	Activity191Rpc.instance:sendFresh191ShopRequest(slot0.actId, slot0.onUpdateGameInfo, slot0)
end

function slot0._btnNextTeamOnClick(slot0)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnNextTeamOnClick")

	if slot0.curTeamIndex + 1 >= 5 then
		return
	end

	slot0.gameInfo:setCurTeamIndex(slot0.curTeamIndex + 1)
end

function slot0._btnLastTeamOnClick(slot0)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnLastTeamOnClick")

	if slot0.curTeamIndex - 1 <= 0 then
		return
	end

	slot0.gameInfo:setCurTeamIndex(slot0.curTeamIndex - 1)
end

function slot0._btnNextOnClick(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnNextOnClick")

	slot0.isLeaving = true

	Activity191Rpc.instance:sendLeave191ShopRequest(slot0.actId, slot0.onLeaveShop, slot0)
end

function slot0._editableInitView(slot0)
	slot5 = slot0

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot5)
	gohelper.setActive(slot0._goShopItem, false)

	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.freshCostList = GameUtil.splitString2(lua_activity191_const.configDict[Activity191Enum.ConstKey.ShopFreshCost].value, true)
	slot0.shopItemList = {}
	slot0.heroItemList = {}

	for slot5 = 1, 8 do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goHeroItem, slot5 <= 4 and slot0._goMainHero or slot0._goSubHero, "heroItem" .. slot5), Act191ShopHeroItem, slot0)

		slot8:setIndex(slot5)

		slot0.heroItemList[slot5] = slot8
	end

	gohelper.setActive(slot0._goHeroItem, false)

	slot0.animTeam = gohelper.findChild(slot0.viewGO, "Bottom/team"):GetComponent(gohelper.Type_Animator)
	slot0.animBtnFresh = slot0._btnFreshShop.gameObject:GetComponent(gohelper.Type_Animator)
	slot0.fetterItemList = {}
end

function slot0.onUpdateGameInfo(slot0)
	if slot0.isLeaving then
		return
	end

	slot0.nodeDetailMo = slot0.gameInfo:getNodeDetailMo()

	slot0:refreshShop()
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, slot0.onUpdateGameInfo, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.SwitchCurTeam, slot0.onSwitchTeam, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, slot0.refreshTeam, slot0)

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0.nodeDetailMo = slot0.viewParam

	slot0:refreshUI()
	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.NodeListItem, slot0._goNodeList), Act191NodeListItem)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTeam, slot0)
end

function slot0.refreshUI(slot0)
	slot0.shopConfig = lua_activity191_shop.configDict[slot0.actId][slot0.nodeDetailMo.shopId]
	slot0._txtShopLevel.text = slot0.shopConfig.name
	slot0._txtDetail.text = slot0.shopConfig.desc

	slot0:refreshShop()
	slot0:refreshTeam()
end

function slot0.refreshShop(slot0)
	slot0._txtCoin.text = slot0.gameInfo.coin

	slot0.animBtnFresh:Play(slot0:getFreshShopCost() == 0 and "first" or "idle", 0, 0)

	slot0._txtFreshCost.text = slot1

	for slot6, slot7 in pairs(slot0.nodeDetailMo.shopPosMap) do
		(slot0.shopItemList[tonumber(slot6)] or slot0:createShopItem(slot8)):setData(slot7, tabletool.indexOf(slot0.nodeDetailMo.boughtSet, slot8))
	end
end

function slot0.refreshTeam(slot0)
	slot0.curTeamIndex = slot0.gameInfo.curTeamIndex

	ZProj.UGUIHelper.SetGrayscale(slot0._btnNextTeam.gameObject, slot0.curTeamIndex > 3)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnLastTeam.gameObject, slot0.curTeamIndex < 2)

	for slot5, slot6 in ipairs(slot0.heroItemList) do
		slot7, slot8 = nil

		if slot5 <= 4 then
			slot7 = slot0.gameInfo:getTeamInfo().battleHeroInfo
			slot8 = slot5
		else
			slot7 = slot1.subHeroInfo
			slot8 = slot5 - 4
		end

		if Activity191Helper.matchKeyInArray(slot7, "index", slot8) then
			slot6:setData(slot9.heroId)
		else
			slot6:setData()
		end
	end

	slot0:refreshFetter()
end

function slot0.refreshFetter(slot0)
	for slot4, slot5 in ipairs(slot0.fetterItemList) do
		gohelper.setActive(slot5.go, false)
	end

	for slot6, slot7 in ipairs(Activity191Helper.getActiveFetterInfoList(slot0.gameInfo:getTeamFetterCntDic())) do
		if not slot0.fetterItemList[slot6] then
			slot0.fetterItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.FetterItem, slot0._goFetterContent), Act191FetterItem)
		end

		slot8:setData(slot7.config, slot7.count)
		gohelper.setActive(slot8.go, true)
		slot8:setExtraParam({
			fromView = slot0.viewName,
			index = slot6
		})
	end

	slot0._scrolltag.horizontalNormalizedPosition = 0
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
		slot0:closeThis()
	end
end

function slot0.getFreshShopCost(slot0)
	for slot5 = #slot0.freshCostList, 1, -1 do
		if slot0.freshCostList[slot5][1] <= slot0.nodeDetailMo.shopFreshNum + 1 then
			return slot6[2]
		end
	end
end

function slot0.onSwitchTeam(slot0)
	slot0.animTeam:Play(slot0.curTeamIndex < slot0.gameInfo.curTeamIndex and "switch_right" or "switch_left", 0, 0)
	TaskDispatcher.runDelay(slot0.refreshTeam, slot0, 0.16)
end

return slot0
