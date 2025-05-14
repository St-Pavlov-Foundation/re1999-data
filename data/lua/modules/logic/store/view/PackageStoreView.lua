module("modules.logic.store.view.PackageStoreView", package.seeall)

local var_0_0 = class("PackageStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "left/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gostorecategoryitem, false)

	arg_4_0._categoryItemContainer = {}
	arg_4_0._horizontalNormalizedPosition = 0
	arg_4_0._scrollprop.horizontalNormalizedPosition = 0

	arg_4_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))
end

function var_0_0._refreshTabs(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0._selectSecondTabId
	local var_5_1 = arg_5_0._selectThirdTabId

	arg_5_0._selectSecondTabId = 0
	arg_5_0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(arg_5_1) then
		arg_5_1 = arg_5_0.viewContainer:getSelectFirstTabId()
	end

	local var_5_2
	local var_5_3

	var_5_3, arg_5_0._selectSecondTabId, arg_5_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_5_1)

	local var_5_4 = StoreConfig.instance:getTabConfig(arg_5_0._selectThirdTabId)
	local var_5_5 = StoreConfig.instance:getTabConfig(arg_5_0._selectSecondTabId)
	local var_5_6 = StoreConfig.instance:getTabConfig(arg_5_0.viewContainer:getSelectFirstTabId())

	if var_5_4 and not string.nilorempty(var_5_4.showCost) then
		arg_5_0.viewContainer:setCurrencyType(var_5_4.showCost)
	elseif var_5_5 and not string.nilorempty(var_5_5.showCost) then
		arg_5_0.viewContainer:setCurrencyType(var_5_5.showCost)
	elseif var_5_6 and not string.nilorempty(var_5_6.showCost) then
		arg_5_0.viewContainer:setCurrencyType(var_5_6.showCost)
	else
		arg_5_0.viewContainer:setCurrencyType(nil)
	end

	if not arg_5_2 and var_5_0 == arg_5_0._selectSecondTabId and var_5_1 == arg_5_0._selectThirdTabId then
		return
	end

	arg_5_0:_refreshAllSecondTabs()
	StoreController.instance:readTab(arg_5_1)
	arg_5_0:_onRefreshRedDot()

	arg_5_0._resetScrollPos = true

	arg_5_0:_refreshGoods(true, arg_5_3)
end

function var_0_0._refreshAllSecondTabs(arg_6_0)
	local var_6_0 = StoreModel.instance:getSecondTabs(arg_6_0._selectFirstTabId, true, true)

	if var_6_0 and #var_6_0 > 0 then
		for iter_6_0 = 1, #var_6_0 do
			arg_6_0:_refreshSecondTabs(iter_6_0, var_6_0[iter_6_0])

			local var_6_1 = StoreModel.instance:getPackageGoodValidList(var_6_0[iter_6_0].id)

			gohelper.setActive(arg_6_0._categoryItemContainer[iter_6_0].go, #var_6_1 > 0)
		end

		for iter_6_1 = #var_6_0 + 1, #arg_6_0._categoryItemContainer do
			gohelper.setActive(arg_6_0._categoryItemContainer[iter_6_1].go, false)
		end
	else
		for iter_6_2 = 1, #arg_6_0._categoryItemContainer do
			gohelper.setActive(arg_6_0._categoryItemContainer[iter_6_2].go, false)
		end
	end
end

function var_0_0._refreshSecondTabs(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._categoryItemContainer[arg_7_1] or arg_7_0:initCategoryItemTable(arg_7_1)

	var_7_0.tabId = arg_7_2.id
	var_7_0.txt_itemcn1.text = arg_7_2.name
	var_7_0.txt_itemcn2.text = arg_7_2.name
	var_7_0.txt_itemen1.text = arg_7_2.nameEn
	var_7_0.txt_itemen2.text = arg_7_2.nameEn

	local var_7_1 = arg_7_0._selectSecondTabId == arg_7_2.id

	gohelper.setActive(var_7_0.go_unselected, not var_7_1)
	gohelper.setActive(var_7_0.go_selected, var_7_1)

	local var_7_2 = StoreModel.instance:getThirdTabs(arg_7_2.id, true, true)

	gohelper.setActive(var_7_0.go_line, var_7_1 and #var_7_2 > 0)

	if var_7_1 and var_7_2 and #var_7_2 > 0 then
		for iter_7_0 = 1, #var_7_2 do
			arg_7_0:_refreshThirdTabs(var_7_0, iter_7_0, var_7_2[iter_7_0])
			gohelper.setActive(var_7_0.childItemContainer[iter_7_0].go, true)
		end

		for iter_7_1 = #var_7_2 + 1, #var_7_0.childItemContainer do
			gohelper.setActive(var_7_0.childItemContainer[iter_7_1].go, false)
		end
	else
		for iter_7_2 = 1, #var_7_0.childItemContainer do
			gohelper.setActive(var_7_0.childItemContainer[iter_7_2].go, false)
		end
	end
end

function var_0_0.initCategoryItemTable(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = gohelper.cloneInPlace(arg_8_0._gostorecategoryitem, "item" .. arg_8_1)
	var_8_0.go_unselected = gohelper.findChild(var_8_0.go, "go_unselected")
	var_8_0.go_selected = gohelper.findChild(var_8_0.go, "go_selected")
	var_8_0.go_line = gohelper.findChild(var_8_0.go, "go_line")
	var_8_0.go_reddot = gohelper.findChild(var_8_0.go, "#go_tabreddot1")
	var_8_0.txt_itemcn1 = gohelper.findChildText(var_8_0.go, "go_unselected/txt_itemcn1")
	var_8_0.txt_itemen1 = gohelper.findChildText(var_8_0.go, "go_unselected/txt_itemen1")
	var_8_0.txt_itemcn2 = gohelper.findChildText(var_8_0.go, "go_selected/txt_itemcn2")
	var_8_0.txt_itemen2 = gohelper.findChildText(var_8_0.go, "go_selected/txt_itemen2")
	var_8_0.go_childcategory = gohelper.findChild(var_8_0.go, "go_childcategory")
	var_8_0.go_childItem = gohelper.findChild(var_8_0.go, "go_childcategory/go_childitem")
	var_8_0.childItemContainer = {}
	var_8_0.btnGO = gohelper.findChild(var_8_0.go, "clickArea")
	var_8_0.btn = gohelper.getClickWithAudio(var_8_0.go, AudioEnum.UI.play_ui_bank_open)
	var_8_0.tabId = 0

	var_8_0.btn:AddClickListener(function(arg_9_0)
		local var_9_0 = arg_9_0.tabId

		arg_8_0:_refreshTabs(var_9_0)
		StoreController.instance:statSwitchStore(var_9_0)
	end, var_8_0)
	table.insert(arg_8_0._categoryItemContainer, var_8_0)
	gohelper.setActive(var_8_0.go_childItem, false)

	return var_8_0
end

function var_0_0._refreshThirdTabs(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1.childItemContainer[arg_10_2]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.go = gohelper.cloneInPlace(arg_10_1.go_childItem, "item" .. arg_10_2)
		var_10_0.go_unselected = gohelper.findChild(var_10_0.go, "go_unselected")
		var_10_0.go_selected = gohelper.findChild(var_10_0.go, "go_selected")
		var_10_0.go_subreddot1 = gohelper.findChild(var_10_0.go, "go_unselected/txt_itemcn1/go_subcatereddot")
		var_10_0.go_subreddot2 = gohelper.findChild(var_10_0.go, "go_selected/txt_itemcn2/go_subcatereddot")
		var_10_0.txt_itemcn1 = gohelper.findChildText(var_10_0.go, "go_unselected/txt_itemcn1")
		var_10_0.txt_itemen1 = gohelper.findChildText(var_10_0.go, "go_unselected/txt_itemen1")
		var_10_0.txt_itemcn2 = gohelper.findChildText(var_10_0.go, "go_selected/txt_itemcn2")
		var_10_0.txt_itemen2 = gohelper.findChildText(var_10_0.go, "go_selected/txt_itemen2")
		var_10_0.btnGO = gohelper.findChild(var_10_0.go, "clickArea")
		var_10_0.btn = gohelper.getClick(var_10_0.btnGO)
		var_10_0.tabId = 0

		var_10_0.btn:AddClickListener(function(arg_11_0)
			local var_11_0 = arg_11_0.tabId

			arg_10_0:_refreshTabs(var_11_0, nil, true)
			StoreController.instance:statSwitchStore(var_11_0)
		end, var_10_0)
		table.insert(arg_10_1.childItemContainer, var_10_0)
	end

	var_10_0.tabId = arg_10_3.id
	var_10_0.txt_itemcn1.text = arg_10_3.name
	var_10_0.txt_itemcn2.text = arg_10_3.name
	var_10_0.txt_itemen1.text = arg_10_3.nameEn
	var_10_0.txt_itemen2.text = arg_10_3.nameEn

	local var_10_1 = arg_10_0._selectThirdTabId == arg_10_3.id

	gohelper.setActive(var_10_0.go_unselected, not var_10_1)
	gohelper.setActive(var_10_0.go_selected, var_10_1)
end

function var_0_0._refreshGoods(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.storeId = 0

	local var_12_0 = StoreConfig.instance:getTabConfig(arg_12_0._selectThirdTabId)

	arg_12_0.storeId = var_12_0 and var_12_0.storeId or 0

	if arg_12_0.storeId == 0 then
		local var_12_1 = StoreConfig.instance:getTabConfig(arg_12_0._selectSecondTabId)

		arg_12_0.storeId = var_12_1 and var_12_1.storeId or 0
	end

	if arg_12_0.storeId == 0 then
		StorePackageGoodsItemListModel.instance:setMOList()
	elseif arg_12_0.storeId == StoreEnum.StoreId.RecommendPackage then
		StoreModel.instance:setCurPackageStore(arg_12_0.storeId)

		local var_12_2 = StoreModel.instance:getRecommendPackageList(true)

		StorePackageGoodsItemListModel.instance:setMOList(nil, var_12_2)
		arg_12_0:updateRecommendPackageList(arg_12_2)
	elseif arg_12_1 then
		StoreModel.instance:setCurPackageStore(arg_12_0.storeId)
		StoreModel.instance:setPackageStoreRpcNum(2)
		StoreRpc.instance:sendGetStoreInfosRequest({
			arg_12_0.storeId
		})
		ChargeRpc.instance:sendGetChargeInfoRequest()
		arg_12_0.viewContainer:playNormalStoreAnimation()
	end
end

function var_0_0._onRefreshRedDot(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._categoryItemContainer) do
		if iter_13_1.tabId == StoreEnum.StoreId.RecommendPackage then
			gohelper.setActive(iter_13_1.go_reddot, StoreModel.instance:isTabFirstRedDotShow(iter_13_1.tabId))
		else
			gohelper.setActive(iter_13_1.go_reddot, StoreModel.instance:isPackageStoreTabRedDotShow(iter_13_1.tabId))
		end

		for iter_13_2, iter_13_3 in pairs(iter_13_1.childItemContainer) do
			gohelper.setActive(iter_13_3.go_subreddot1, StoreModel.instance:isTabSecondRedDotShow(iter_13_3.tabId))
			gohelper.setActive(iter_13_3.go_subreddot2, StoreModel.instance:isTabSecondRedDotShow(iter_13_3.tabId))
		end
	end
end

function var_0_0._beforeUpdatePackageStore(arg_14_0)
	arg_14_0._horizontalNormalizedPosition = arg_14_0._scrollprop.horizontalNormalizedPosition
end

function var_0_0._afterUpdatePackageStore(arg_15_0)
	arg_15_0._scrollprop.horizontalNormalizedPosition = arg_15_0._horizontalNormalizedPosition
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._selectFirstTabId = arg_16_0.viewContainer:getSelectFirstTabId()

	local var_16_0 = arg_16_0.viewContainer:getJumpTabId()
	local var_16_1 = arg_16_0.viewContainer:getJumpGoodsId()

	arg_16_0:_refreshTabs(var_16_0, true, true)
	arg_16_0:addEventCb(StoreController.instance, StoreEvent.BeforeUpdatePackageStore, arg_16_0._beforeUpdatePackageStore, arg_16_0)
	arg_16_0:addEventCb(StoreController.instance, StoreEvent.AfterUpdatePackageStore, arg_16_0._afterUpdatePackageStore, arg_16_0)
	arg_16_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_16_0._updateInfo, arg_16_0)
	arg_16_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_16_0._updateInfo, arg_16_0)
	arg_16_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_16_0._onRefreshRedDot, arg_16_0)
	arg_16_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_16_0.onUpdatePackageGoodsList, arg_16_0)
	arg_16_0:addEventCb(StoreController.instance, StoreEvent.CurPackageListEmpty, arg_16_0.onPackageGoodsListEmpty, arg_16_0)

	if var_16_1 then
		StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(tonumber(var_16_1)))
	end
end

function var_0_0._updateInfo(arg_17_0)
	arg_17_0:_refreshGoods(false)
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.BeforeUpdatePackageStore, arg_18_0._beforeUpdatePackageStore, arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.AfterUpdatePackageStore, arg_18_0._afterUpdatePackageStore, arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_18_0._updateInfo, arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_18_0._updateInfo, arg_18_0)
	arg_18_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_18_0._onRefreshRedDot, arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_18_0.onUpdatePackageGoodsList, arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.CurPackageListEmpty, arg_18_0.onPackageGoodsListEmpty, arg_18_0)
end

function var_0_0.onUpdateParam(arg_19_0)
	arg_19_0._selectFirstTabId = arg_19_0.viewContainer:getSelectFirstTabId()

	local var_19_0 = arg_19_0.viewContainer:getJumpTabId()
	local var_19_1 = arg_19_0.viewContainer:getJumpGoodsId()

	arg_19_0:_refreshTabs(var_19_0)

	if var_19_1 then
		StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(tonumber(var_19_1)))
	end
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0._categoryItemContainer and #arg_20_0._categoryItemContainer > 0 then
		for iter_20_0 = 1, #arg_20_0._categoryItemContainer do
			local var_20_0 = arg_20_0._categoryItemContainer[iter_20_0]

			var_20_0.btn:RemoveClickListener()

			if var_20_0.childItemContainer and #var_20_0.childItemContainer > 0 then
				for iter_20_1 = 1, #var_20_0.childItemContainer do
					var_20_0.childItemContainer[iter_20_1].btn:RemoveClickListener()
				end
			end
		end
	end

	arg_20_0._simagebg:UnLoadImage()
end

function var_0_0.onUpdatePackageGoodsList(arg_21_0)
	arg_21_0:_refreshAllSecondTabs()
	arg_21_0:_onRefreshRedDot()
	arg_21_0:refreshScrollViewPos(false)
end

function var_0_0.updateRecommendPackageList(arg_22_0, arg_22_1)
	local var_22_0 = StoreModel.instance:getCurBuyPackageId()
	local var_22_1 = StorePackageGoodsItemListModel.instance:getList()

	if (not var_22_1 or #var_22_1 == 0) and var_22_0 == nil then
		arg_22_0:_refreshTabs(StoreEnum.StoreId.Package, true)

		return
	end

	arg_22_0:_onRefreshRedDot()
	arg_22_0:refreshScrollViewPos(arg_22_1)
end

function var_0_0.onPackageGoodsListEmpty(arg_23_0)
	arg_23_0:_refreshTabs(StoreEnum.StoreId.Package, true)
end

function var_0_0.refreshScrollViewPos(arg_24_0, arg_24_1)
	local var_24_0 = StoreModel.instance:isPackageStoreTabRedDotShow(arg_24_0._selectSecondTabId)

	if arg_24_1 or var_24_0 then
		local var_24_1 = StorePackageGoodsItemListModel.instance:getList()

		for iter_24_0, iter_24_1 in ipairs(var_24_1) do
			local var_24_2 = iter_24_1.goodsId

			if StoreModel.instance:isGoodsItemRedDotShow(var_24_2) then
				arg_24_0._scrollprop.horizontalNormalizedPosition = (iter_24_0 - 1) / (#var_24_1 - 1)

				return
			end
		end
	end

	if arg_24_0._resetScrollPos then
		arg_24_0._scrollprop.horizontalNormalizedPosition = 0
		arg_24_0._resetScrollPos = false
	end
end

return var_0_0
