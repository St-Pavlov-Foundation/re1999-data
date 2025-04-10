module("modules.logic.versionactivity2_7.act191.view.Act191HeroTipView", package.seeall)

slot0 = class("Act191HeroTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "#go_Root")
	slot0._goTagItem = gohelper.findChild(slot0.viewGO, "#go_Root/#go_TagItem")
	slot0._goSingleHero = gohelper.findChild(slot0.viewGO, "#go_Root/#go_SingleHero")
	slot0._goSingleTagContent = gohelper.findChild(slot0.viewGO, "#go_Root/#go_SingleHero/#go_SingleTagContent")
	slot0._goMultiHero = gohelper.findChild(slot0.viewGO, "#go_Root/#go_MultiHero")
	slot0._goMultiTagContent = gohelper.findChild(slot0.viewGO, "#go_Root/#go_MultiHero/#go_MultiTagContent")
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Root/#btn_Buy")
	slot0._txtBuyCost = gohelper.findChildText(slot0.viewGO, "#go_Root/#btn_Buy/#txt_BuyCost")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnBuy:AddClickListener(slot0._btnBuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnBuy:RemoveClickListener()
end

function slot0._onEscBtnClick(slot0)
	slot0:closeThis()

	if ViewMgr.instance:isOpen(ViewName.Act191InfoView) then
		ViewMgr.instance:closeView(ViewName.Act191InfoView)
	end
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnBuyOnClick(slot0)
	if Activity191Model.instance:getActInfo():getGameInfo().coin < slot0.viewParam.cost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	Activity191Rpc.instance:sendBuyIn191ShopRequest(slot0.actId, slot0.viewParam.index, slot0._buyReply, slot0)
end

function slot0._buyReply(slot0, slot1, slot2)
	if slot2 == 0 then
		GameFacade.showToast(slot0.viewParam.toastId)
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)

	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.characterInfo = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goRoot, Act191CharacterInfo)
	slot0.fetterIconItemList = {}
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose(), slot0.roleCoList[1].name)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._btnClose, not slot0.viewParam.notShowBg)

	if slot0.viewParam.showBuy then
		slot0:refreshCost()
		gohelper.setActive(slot0._btnBuy, true)
	else
		gohelper.setActive(slot0._btnBuy, false)
	end

	if slot0.viewParam.pos then
		recthelper.setAnchor(slot0._goRoot.transform, slot1.x, slot1.y)
	end

	slot0.heroCnt = #slot0.viewParam.heroList
	slot0.roleCoList = {
		Activity191Config.instance:getRoleCo(slot0.viewParam.heroList[1])
	}
	slot2 = slot0.roleCoList[1]

	gohelper.findChildSingleImage(slot0._goSingleHero, "character/heroicon"):LoadImage(Activity191Helper.getHeadIconSmall(slot2))
	UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot0._goSingleHero, "character/rare"), "act174_roleframe_" .. tostring(slot2.quality))
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot0._goSingleHero, "character/career"), "lssx_" .. slot2.career)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot0._goSingleHero, "image_dmgtype"), "dmgtype" .. tostring(slot2.dmgType))

	gohelper.findChildText(slot0._goSingleHero, "name/txt_name").text = slot2.name

	slot0:refreshFetter(slot2)
	slot0.characterInfo:setData(slot2)
	gohelper.setActive(slot0._goSingleHero, true)
	gohelper.setActive(slot0._goMultiHero, false)

	if false then
		slot0.characterItemList = {}

		for slot5 = 1, 3 do
			slot6 = slot0:getUserDataTb_()
			slot6.frame = gohelper.findChild(slot0._goMultiHero, "selectframe/selectframe" .. slot5)
			slot6.go = gohelper.findChild(slot0._goMultiHero, "character" .. slot5)
			slot0.roleCoList[slot5] = Activity191Config.instance:getRoleCo(slot0.viewParam.heroList[slot5])

			if slot0.roleCoList[slot5] then
				slot6.rare = gohelper.findChildImage(slot6.go, "rare")
				slot6.heroIcon = gohelper.findChildSingleImage(slot6.go, "heroicon")
				slot6.career = gohelper.findChildImage(slot6.go, "career")

				slot0:addClickCb(gohelper.findButtonWithAudio(slot6.go), slot0.onClickRole, slot0, slot5)
				UISpriteSetMgr.instance:setAct174Sprite(slot6.rare, "act174_roleframe_" .. tostring(slot8.quality))
				UISpriteSetMgr.instance:setCommonSprite(slot6.career, "lssx_" .. slot8.career)
				slot6.heroIcon:LoadImage(Activity191Helper.getHeadIconSmall(slot8))
			else
				gohelper.setActive(slot6.go, false)
			end

			table.insert(slot0.characterItemList, slot6)
		end

		slot0:onClickRole(1)
		gohelper.setActive(slot0._goSingleHero, false)
		gohelper.setActive(slot0._goMultiHero, true)
	end

	gohelper.setActive(slot0._goTagItem, false)
end

function slot0.onClickRole(slot0, slot1)
	if slot1 == slot0.selectedIndex then
		return
	end

	if not gohelper.isNil(slot0.characterItemList[slot1] and slot2.frame) then
		gohelper.setAsLastSibling(slot3)
	end

	slot0.selectedIndex = slot1
	slot5 = Activity191Config.instance:getRoleCo(slot0.viewParam.heroList[slot1])

	slot0:refreshFetter(slot5, true)
	slot0.characterInfo:setData(slot5)
end

function slot0.refreshCost(slot0)
	if Activity191Model.instance:getActInfo():getGameInfo().coin < slot0.viewParam.cost then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtBuyCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtBuyCost, "#211f1f")
	end

	slot0._txtBuyCost.text = slot1
end

function slot0.refreshFetter(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.fetterIconItemList) do
		gohelper.setActive(slot7.go, false)
	end

	for slot7, slot8 in ipairs(string.split(slot1.tag, "#")) do
		if not slot0.fetterIconItemList[slot7] then
			slot0.fetterIconItemList[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goTagItem, slot0._goSingleTagContent), Act191FetterIconItem)
		end

		slot9:setData(slot8)
		slot9:setExtraParam({
			fromView = slot0.viewName
		})

		if slot0.viewParam.preview then
			slot9:setPreview()
		end

		gohelper.addChild(slot2 and slot0._goMultiTagContent or slot0._goSingleTagContent, slot9.go)
		gohelper.setActive(slot9.go, true)
	end
end

return slot0
