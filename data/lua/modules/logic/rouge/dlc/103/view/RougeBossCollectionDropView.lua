module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropView", package.seeall)

slot0 = class("RougeBossCollectionDropView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskbg")
	slot0._gotitletip = gohelper.findChild(slot0.viewGO, "Title/txt_Tips")
	slot0._scrollView = gohelper.findChildScrollRect(slot0.viewGO, "scroll_view")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._gorefresh = gohelper.findChild(slot0.viewGO, "#go_refresh")
	slot0._txtrefresh = gohelper.findChildText(slot0.viewGO, "#go_refresh/#txt_refresh")
	slot0._gorefreshactivebg = gohelper.findChild(slot0.viewGO, "#go_refresh/#go_activebg")
	slot0._gorefreshdisablebg = gohelper.findChild(slot0.viewGO, "#go_refresh/#go_disablebg")
	slot0._gorougefunctionitem2 = gohelper.findChild(slot0.viewGO, "#go_rougefunctionitem2")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txtselectnum = gohelper.findChildText(slot0.viewGO, "#go_topright/#txt_num")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._btninherit = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#go_rougemapbaseinherit/#btn_inherit")
	slot0._godistortrule = gohelper.findChild(slot0.viewGO, "Left/#go_distortrule")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btninherit:AddClickListener(slot0._btninheritOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btninherit:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		slot0:closeThis()

		return
	end

	if #slot0.selectPosList < 1 then
		return
	end

	slot0:clearSelectCallback()

	slot0.selectCallbackId = RougeRpc.instance:sendRougeSelectDropRequest(slot0.selectPosList, slot0.onReceiveSelect, slot0)
end

function slot0.onReceiveSelect(slot0)
	slot0.refreshCallbackId = nil

	slot0:delayCloseView()
end

function slot0.delayCloseView(slot0)
	UIBlockMgr.instance:startBlock(slot0.viewName)
	TaskDispatcher.cancelTask(slot0._closeView, slot0)
	TaskDispatcher.runDelay(slot0._closeView, slot0, RougeMapEnum.CollectionChangeAnimDuration)
end

function slot0._closeView(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName)
	slot0:closeThis()
end

function slot0.onClickBg(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		return
	end

	slot0:closeThis()
end

function slot0._btninheritOnClick(slot0)
	slot0._isShowMonsterRule = not slot0._isShowMonsterRule

	slot0:refreshInheritBtn()
	RougeController.instance:dispatchEvent(RougeEvent.ShowMonsterRuleDesc, slot0._isShowMonsterRule)
end

function slot0._editableInitView(slot0)
	slot0.bgClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#simage_maskbg")

	slot0.bgClick:AddClickListener(slot0.onClickBg, slot0)

	slot0.viewPortClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "scroll_view/Viewport")

	slot0.viewPortClick:AddClickListener(slot0.onClickBg, slot0)
	slot0._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")

	slot0.txtTips = gohelper.findChildText(slot0.viewGO, "Title/txt_Tips")
	slot0.txtTitle = gohelper.findChildText(slot0.viewGO, "Title/txt_Title")
	slot0.goConfirmBtn = slot0._btnconfirm.gameObject

	gohelper.setActive(slot0._gocollectionitem, false)

	slot0.selectPosList = {}
	slot0.collectionItemList = {}

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectDropChange, slot0.onSelectDropChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.onUpdateMapInfo, slot0)

	slot0.goCollection = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, slot0._gorougefunctionitem2)
	slot0.collectionComp = RougeCollectionComp.Get(slot0.goCollection)

	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.blockEsc)
	slot0:openSubView(RougeMapAttributeComp, nil, slot0._godistortrule)

	slot0._goselectinherit = gohelper.findChild(slot0.viewGO, "layout/#go_rougemapbaseinherit/#btn_inherit/circle/select")
	slot0._isShowMonsterRule = true
end

function slot0.onSelectDropChange(slot0)
	slot0:refreshConfirmBtn()
	slot0:refreshTopRight()
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.initData(slot0)
	slot0.viewEnum = slot0.viewParam.viewEnum
	slot0.collectionList = slot0.viewParam.collectionList
	slot0.monsterRuleList = slot0.viewParam.monsterRuleList

	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		slot0.canSelectCount = slot0.viewParam.canSelectCount
		slot0.dropRandomNum = slot0.viewParam.dropRandomNum
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)
	slot0:initData()
	slot0:refreshUI()
	slot0.collectionComp:onOpen()
end

function slot0.refreshUI(slot0)
	slot0:refreshTitle()
	slot0:refreshCollection()
	slot0:refreshConfirmBtn()
	slot0:refreshRefreshBtn()
	slot0:refreshInheritBtn()
	slot0:refreshTopRight()
end

function slot0.refreshTitle(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		slot0.txtTitle.text = luaLang("rougebosscollectionselectview_txt_title")
		slot0.txtTips.text = string.gsub(luaLang("rougebosscollectionselectview_txt_tips"), "▩1%%s", slot0.canSelectCount)

		gohelper.setActive(slot0._gotitletip, true)
	else
		slot0.txtTips.text = luaLang("rougecollectionselectview_txt_get_Tips")
		slot0.txtTitle.text = luaLang("rougebosscollectionselectview_txt_title")

		gohelper.setActive(slot0._gotitletip, false)
	end
end

function slot0.refreshCollection(slot0)
	slot1 = slot0.collectionList or {}
	slot2 = slot0.monsterRuleList or {}

	for slot6, slot7 in ipairs(slot1) do
		if not slot0.collectionItemList[slot6] then
			slot8 = RougeBossCollectionDropItem.New()

			slot8:init(gohelper.cloneInPlace(slot0._gocollectionitem), slot0)
			slot8:setParentScroll(slot0._scrollView.gameObject)
			table.insert(slot0.collectionItemList, slot8)
		end

		slot8:show()
		slot8:update(slot6, slot7, slot2[slot6], slot0._isShowMonsterRule)
	end

	for slot6 = #slot1 + 1, #slot0.collectionItemList do
		slot0.collectionItemList[slot6]:hide()
	end

	slot0._scrollView.horizontalNormalizedPosition = 0
end

function slot0.refreshConfirmBtn(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		gohelper.setActive(slot0.goConfirmBtn, false)
		gohelper.setActive(slot0._gotips, true)

		return
	end

	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0.goConfirmBtn, slot0.canSelectCount <= #slot0.selectPosList)
end

function slot0.refreshRefreshBtn(slot0)
	slot0.canClickRefresh = false

	if slot0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(slot0._gorefresh, false)

		return
	end

	slot0.canClickRefresh = RougeMapModel.instance:getMonsterRuleRemainCanFreshNum() and slot1 > 0

	gohelper.setActive(slot0._gorefresh, true)
	gohelper.setActive(slot0._gorefreshactivebg, slot0.canClickRefresh)
	gohelper.setActive(slot0._gorefreshdisablebg, not slot0.canClickRefresh)

	slot0._txtrefresh.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougebosscollectionselectview_refresh"), slot1)
end

function slot0.refreshInheritBtn(slot0)
	gohelper.setActive(slot0._goselectinherit, slot0._isShowMonsterRule)
end

function slot0.refreshTopRight(slot0)
	if slot0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(slot0._gotopright, false)

		return
	end

	gohelper.setActive(slot0._gotopright, true)

	slot0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge_drop_select"), #slot0.selectPosList, slot0.canSelectCount)
end

function slot0.selectPos(slot0, slot1)
	if slot0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		return false
	end

	if tabletool.indexOf(slot0.selectPosList, slot1) then
		table.remove(slot0.selectPosList, slot2)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)

		return
	end

	if slot0.canSelectCount > 1 then
		if slot0.canSelectCount <= #slot0.selectPosList then
			return
		end

		table.insert(slot0.selectPosList, slot1)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
	end

	table.remove(slot0.selectPosList)
	table.insert(slot0.selectPosList, slot1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
end

function slot0.isSelect(slot0, slot1)
	return tabletool.indexOf(slot0.selectPosList, slot1)
end

function slot0.onUpdateMapInfo(slot0)
	if not RougeMapModel.instance:getCurInteractiveJson() then
		return
	end

	slot0.collectionList = slot1 and slot1.dropCollectList
	slot0.monsterRuleList = slot1 and slot1.dropCollectMonsterRuleList
	slot0.selectPosList = {}

	slot0:refreshUI()
end

function slot0.clearSelectCallback(slot0)
	if slot0.selectCallbackId then
		RougeRpc.instance:removeCallbackById(slot0.selectCallbackId)

		slot0.selectCallbackId = nil
	end
end

function slot0.clearRefreshCallback(slot0)
	if slot0.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(slot0.refreshCallbackId)

		slot0.refreshCallbackId = nil
	end
end

function slot0.onClose(slot0)
	slot0:clearSelectCallback()
	slot0:clearRefreshCallback()
	slot0.collectionComp:onClose()

	for slot4, slot5 in ipairs(slot0.collectionItemList) do
		slot5:onClose()
	end

	tabletool.clear(slot0.selectPosList)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.collectionItemList) do
		slot5:destroy()
	end

	slot0.collectionItemList = nil

	slot0._simagemaskbg:UnLoadImage()
	slot0.collectionComp:destroy()
	slot0.bgClick:RemoveClickListener()
	slot0.viewPortClick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
