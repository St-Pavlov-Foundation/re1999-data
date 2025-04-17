module("modules.logic.versionactivity2_7.act191.view.Act191MainView", package.seeall)

slot0 = class("Act191MainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetitleeff = gohelper.findChildSingleImage(slot0.viewGO, "simage_title/#simage_titleeff")
	slot0._btnBadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_achieve/scroll_achieve/#btn_Badge")
	slot0._btnRule = gohelper.findChildButtonWithAudio(slot0.viewGO, "rule/#btn_Rule")
	slot0._btnEndGame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_EndGame")
	slot0._btnShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_Shop")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "layout/#btn_Shop/#txt_num")
	slot0._goProgress = gohelper.findChild(slot0.viewGO, "layout/#go_Progress")
	slot0._goHp = gohelper.findChild(slot0.viewGO, "layout/#go_Progress/#go_Hp")
	slot0._imageHpPercent = gohelper.findChildImage(slot0.viewGO, "layout/#go_Progress/#go_Hp/bg/#image_HpPercent")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "layout/#go_Progress/#txt_Round")
	slot0._btnEnterGame = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_EnterGame")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnBadge:AddClickListener(slot0._btnBadgeOnClick, slot0)
	slot0._btnRule:AddClickListener(slot0._btnRuleOnClick, slot0)
	slot0._btnEndGame:AddClickListener(slot0._btnEndGameOnClick, slot0)
	slot0._btnShop:AddClickListener(slot0._btnShopOnClick, slot0)
	slot0._btnEnterGame:AddClickListener(slot0._btnEnterGameOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBadge:RemoveClickListener()
	slot0._btnRule:RemoveClickListener()
	slot0._btnEndGame:RemoveClickListener()
	slot0._btnShop:RemoveClickListener()
	slot0._btnEnterGame:RemoveClickListener()
end

function slot0._btnBadgeOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Act191BadgeView)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnBadgeOnClick")
end

function slot0._btnRuleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Act191InfoView)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnRuleOnClick")
end

function slot0._btnEndGameOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndGameConfirm, MsgBoxEnum.BoxType.Yes_No, slot0.endGame, nil, , slot0)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnEndGameOnClick")
end

function slot0.endGame(slot0)
	Activity191Rpc.instance:sendEndAct191GameRequest(slot0.actId)
end

function slot0._btnShopOnClick(slot0)
	Activity191Controller.instance:openStoreView(VersionActivity2_7Enum.ActivityId.Act191Store)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnShopOnClick")
end

function slot0._btnEnterGameOnClick(slot0)
	Activity191Controller.instance:nextStep()
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnEnterGameOnClick")
end

function slot0._editableInitView(slot0)
	slot0.badgeGoParent = gohelper.findChild(slot0.viewGO, "go_achieve/scroll_achieve/viewport/content")
	slot0.badgeGo = gohelper.findChild(slot0.viewGO, "go_achieve/scroll_achieve/viewport/content/go_achievementicon")
	slot0.actId = Activity191Model.instance:getCurActId()
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateBadgeMo, slot0.refreshBadge, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.EndGame, slot0.checkGameEndInfo, slot0)
	slot0:refreshUI()

	if slot0.viewParam and slot0.viewParam.exitFromFight and not Activity191Controller.instance:checkOpenGetView() then
		slot0:_btnEnterGameOnClick()
	end
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.refreshUI(slot0)
	slot0.actInfo = Activity191Model.instance:getActInfo()

	gohelper.setActive(slot0._btnEndGame, slot0.actInfo:getGameInfo().state ~= Activity191Enum.GameState.None)
	slot0:initRule()
	slot0:refreshBadge()
	slot0:refreshCurrency()
end

function slot0.initRule(slot0)
	slot3 = {}

	for slot7 = 3, 1, -1 do
		slot3[#slot3 + 1] = slot1[#Activity191Config.instance:getShowRoleCoList() + 1 - slot7]
	end

	for slot7, slot8 in ipairs(slot3) do
		slot9 = gohelper.findChild(slot0.viewGO, "rule/role/" .. slot7)

		gohelper.findChildSingleImage(slot9, "heroicon"):LoadImage(Activity191Helper.getHeadIconSmall(slot8))
		UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot9, "rare"), "act174_roleframe_" .. tostring(slot8.quality))
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot9, "career"), "lssx_" .. tostring(slot8.career))
	end
end

function slot0.refreshCurrency(slot0)
	slot0._txtnum.text = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act191).quantity
end

function slot0.refreshBadge(slot0)
	slot0.badgeItemDic = {}

	gohelper.CreateObjList(slot0, slot0._onSetBadgeItem, slot0.actInfo:getBadgeMoList(), slot0.badgeGoParent, slot0.badgeGo)
end

function slot0._onSetBadgeItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot5 = slot2.id
	slot4.simageIcon = gohelper.findChildSingleImage(slot1, "root/image_icon")
	slot4.txtNum = gohelper.findChildText(slot1, "root/txt_num")
	slot0.badgeItemDic[slot5] = slot4

	slot0:refreshBadgeItem(slot5, slot2)
end

function slot0.refreshBadgeItem(slot0, slot1, slot2)
	slot3 = slot0.badgeItemDic[slot1]

	slot3.simageIcon:LoadImage(ResUrl.getAct174BadgeIcon(slot2.config.icon, slot2:getState()))

	slot3.txtNum.text = slot2.count
end

function slot0.checkGameEndInfo(slot0)
	if slot0.actInfo:getGameEndInfo() then
		if Activity191Model.instance:getActInfo():getGameInfo().curNode ~= 0 and slot2.curStage ~= 0 then
			Activity191Controller.instance:openSettlementView()
		end

		slot0:refreshUI()

		return true
	end
end

return slot0
