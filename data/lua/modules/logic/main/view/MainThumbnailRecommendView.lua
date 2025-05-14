module("modules.logic.main.view.MainThumbnailRecommendView", package.seeall)

local var_0_0 = class("MainThumbnailRecommendView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_slider")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannercontent")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannerscroll")

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
	arg_4_0._selectItems = {}
	arg_4_0._helpItems = {}

	local var_4_0 = recthelper.getWidth(arg_4_0.viewGO.transform)

	arg_4_0._space = 670
	arg_4_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_4_0._goscroll)

	arg_4_0._scroll:AddDragBeginListener(arg_4_0._onScrollDragBegin, arg_4_0)
	arg_4_0._scroll:AddDragEndListener(arg_4_0._onScrollDragEnd, arg_4_0)

	arg_4_0._viewClick = gohelper.getClick(arg_4_0._goscroll)

	arg_4_0._viewClick:AddClickListener(arg_4_0._onClickView, arg_4_0)
end

function var_0_0._onScrollDragBegin(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._scrollStartPos = arg_5_2.position
end

function var_0_0._onScrollDragEnd(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._scrollStartPos then
		return
	end

	local var_6_0 = arg_6_2.position
	local var_6_1 = var_6_0.x - arg_6_0._scrollStartPos.x
	local var_6_2 = var_6_0.y - arg_6_0._scrollStartPos.y

	arg_6_0._scrollStartPos = nil

	if math.abs(var_6_1) < math.abs(var_6_2) then
		return
	end

	local var_6_3 = arg_6_0:getTargetPageIndex()
	local var_6_4 = var_6_3 <= #arg_6_0._pagesCo
	local var_6_5 = var_6_3 >= 1

	if var_6_1 > 100 and var_6_5 then
		arg_6_0:setTargetPageIndex(var_6_3 - 1, var_6_3)
		arg_6_0:_updateSelectedItem()
		arg_6_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	elseif var_6_1 < -100 and var_6_4 then
		arg_6_0:setTargetPageIndex(var_6_3 + 1, var_6_3)
		arg_6_0:_updateSelectedItem()
		arg_6_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	end

	arg_6_0:_startAutoSwitch()
end

function var_0_0.statRecommendPage(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._pagesCo[arg_7_0:getTargetPageIndex()]

	StatController.instance:track(StatEnum.EventName.ShowRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = arg_7_1,
		[StatEnum.EventProperties.ShowType] = arg_7_2,
		[StatEnum.EventProperties.RecommendPageId] = tostring(var_7_0.id)
	})
end

function var_0_0._startAutoSwitch(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onSwitch, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._onSwitch, arg_8_0, 5)
end

function var_0_0._onSwitch(arg_9_0)
	if #arg_9_0._pagesCo == 1 then
		TaskDispatcher.cancelTask(arg_9_0._onSwitch, arg_9_0)

		return
	end

	local var_9_0 = arg_9_0:getTargetPageIndex()

	arg_9_0:setTargetPageIndex(var_9_0 + 1, var_9_0)
	arg_9_0:_updateSelectedItem()

	if ViewHelper.instance:checkViewOnTheTop(arg_9_0.viewName) then
		arg_9_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Auto)
	end
end

function var_0_0.setTargetPageIndex(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._targetPageIndex = arg_10_1
	arg_10_0._prevTargetPageIndex = arg_10_2
end

function var_0_0.getTargetPageIndex(arg_11_0)
	if arg_11_0._targetPageIndex < 1 then
		return #arg_11_0._pagesCo
	end

	if arg_11_0._targetPageIndex > #arg_11_0._pagesCo then
		return 1
	end

	return arg_11_0._targetPageIndex
end

function var_0_0._onClickView(arg_12_0)
	if arg_12_0._scrollStartPos then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_jump)

	local var_12_0 = arg_12_0._pagesCo[arg_12_0:getTargetPageIndex()]

	if var_12_0 and string.nilorempty(var_12_0.systemJumpCode) == false then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Main,
			[StatEnum.EventProperties.RecommendPageId] = tostring(var_12_0.id),
			[StatEnum.EventProperties.RecommendPageName] = var_12_0.name
		})
		GameFacade.jumpByAdditionParam(var_12_0.systemJumpCode)
	end
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0._checkExpire(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(lua_store_recommend.configList) do
		if iter_14_1.type == 1 and arg_14_0:_inOpenTime(iter_14_1) and arg_14_0:_checkRelations(iter_14_1.relations) then
			local var_14_1 = string.splitToNumber(iter_14_1.systemJumpCode, "#")[1]

			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(iter_14_1.systemJumpCode) or JumpConfig.instance:isOpenJumpId(var_14_1) then
				var_14_0 = var_14_0 + 1
			end
		end
	end

	if var_14_0 ~= arg_14_0._totalPageCount then
		arg_14_0:_clearPages()
		arg_14_0:_initPages()
	end
end

function var_0_0._startCheckExpire(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._checkExpire, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0._checkExpire, arg_15_0, 1)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_16_0._checkExpire, arg_16_0)

	local var_16_0 = arg_16_0:_initPages(true)

	if tabletool.len(var_16_0) > 0 then
		local var_16_1 = {}

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			table.insert(var_16_1, iter_16_0)
		end

		StoreRpc.instance:sendGetStoreInfosRequest(var_16_1)
	end
end

function var_0_0._initPages(arg_17_0, arg_17_1)
	recthelper.setAnchorX(arg_17_0._gocontent.transform, 0)
	arg_17_0:setTargetPageIndex(1)

	local var_17_0 = {}

	arg_17_0._pagesCo = {}
	arg_17_0._totalPageCount = 0

	local var_17_1 = {}
	local var_17_2 = SummonMainModel.getValidPools()

	arg_17_0._openSummonPoolDic = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_2) do
		arg_17_0._openSummonPoolDic[iter_17_1.id] = iter_17_1
	end

	for iter_17_2, iter_17_3 in ipairs(lua_store_recommend.configList) do
		local var_17_3, var_17_4, var_17_5 = arg_17_0:_checkRelations(iter_17_3.relations, nil, arg_17_1)

		if iter_17_3.type == 1 and arg_17_0:_inOpenTime(iter_17_3) and var_17_3 then
			local var_17_6 = string.splitToNumber(iter_17_3.systemJumpCode, "#")[1]

			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(iter_17_3.systemJumpCode) or JumpConfig.instance:isOpenJumpId(var_17_6) then
				table.insert(var_17_0, iter_17_3)

				arg_17_0._totalPageCount = arg_17_0._totalPageCount + 1
			end
		end

		if var_17_5 then
			for iter_17_4, iter_17_5 in pairs(var_17_5) do
				var_17_1[iter_17_4] = true
			end
		end
	end

	local var_17_7 = CommonConfig.instance:getConstNum(ConstEnum.MainThumbnailRecommendItemCount) or 14

	arg_17_0:sortPage(var_17_0)

	for iter_17_6 = 1, var_17_7 do
		if var_17_0[iter_17_6] then
			arg_17_0._pagesCo[#arg_17_0._pagesCo + 1] = var_17_0[iter_17_6]
		end
	end

	arg_17_0:setSelectItem()
	arg_17_0:setContentItem()
	arg_17_0:_startAutoSwitch()
	arg_17_0:_startCheckExpire()
	arg_17_0:_updateSelectedItem()
	arg_17_0:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.First)

	return var_17_1
end

function var_0_0._sort(arg_18_0, arg_18_1)
	return arg_18_0.order < arg_18_1.order
end

function var_0_0.sortPage(arg_19_0, arg_19_1)
	arg_19_0:_cacheConfigGroupData(arg_19_1)
	table.sort(arg_19_1, function(arg_20_0, arg_20_1)
		return arg_19_0:_tabSortGroupFunction(arg_20_0, arg_20_1)
	end)

	arg_19_0._cacheConfigGroupDic = {}
	arg_19_0._cacheConfigOrderDic = {}
end

function var_0_0._cacheConfigGroupData(arg_21_0, arg_21_1)
	arg_21_0._cacheConfigGroupDic = {}
	arg_21_0._cacheConfigOrderDic = {}

	if not arg_21_1 or #arg_21_1 <= 0 then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_0, var_21_1 = StoreHelper.getRecommendStoreGroupAndOrder(iter_21_1, false)

		arg_21_0._cacheConfigGroupDic[iter_21_1.id] = var_21_0
		arg_21_0._cacheConfigOrderDic[iter_21_1.id] = var_21_1
	end
end

function var_0_0._tabSortGroupFunction(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._cacheConfigGroupDic[arg_22_1.id]
	local var_22_1 = arg_22_0._cacheConfigGroupDic[arg_22_2.id]

	if var_22_0 == var_22_1 then
		return arg_22_0._cacheConfigOrderDic[arg_22_1.id] < arg_22_0._cacheConfigOrderDic[arg_22_2.id]
	end

	return var_22_0 < var_22_1
end

function var_0_0._checkRelations(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = GameUtil.splitString2(arg_23_1, true)
	local var_23_1 = false
	local var_23_2 = false
	local var_23_3

	if arg_23_3 then
		var_23_3 = {}
	end

	if string.nilorempty(arg_23_1) == false and var_23_0 and #var_23_0 > 0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_4 = true
			local var_23_5 = iter_23_1[1]
			local var_23_6 = iter_23_1[2]

			if var_23_5 == StoreEnum.RecommendRelationType.Summon then
				if arg_23_0._openSummonPoolDic[var_23_6] == nil then
					var_23_4 = false
				end
			elseif var_23_5 == StoreEnum.RecommendRelationType.PackageStoreGoods then
				local var_23_7 = StoreModel.instance:getGoodsMO(var_23_6)

				if var_23_7 == nil or var_23_7:isSoldOut() then
					var_23_4 = false
				end

				var_23_1 = true
			elseif var_23_5 == StoreEnum.RecommendRelationType.StoreGoods then
				local var_23_8 = StoreModel.instance:getGoodsMO(var_23_6)

				if var_23_8 == nil or var_23_8:isSoldOut() or var_23_8:alreadyHas() then
					var_23_4 = false
				end

				if arg_23_3 then
					local var_23_9 = StoreConfig.instance:getGoodsConfig(var_23_6)

					if var_23_9 then
						var_23_3[var_23_9.storeId] = true
					end
				end
			elseif var_23_5 == StoreEnum.RecommendRelationType.OtherRecommendClose then
				local var_23_10 = lua_store_entrance.configList[var_23_6]
				local var_23_11 = StoreConfig.instance:getStoreRecommendConfig(var_23_6)

				if var_23_11.type == 1 and arg_23_0:_inOpenTime(var_23_11) and arg_23_0:_checkRelations(var_23_11.relations) then
					var_23_4 = false
				end
			end

			var_23_2 = var_23_2 or var_23_4
		end
	else
		var_23_2 = true
	end

	return var_23_2, var_23_1, var_23_3
end

function var_0_0._inOpenTime(arg_24_0, arg_24_1)
	local var_24_0 = ServerTime.now()
	local var_24_1 = string.nilorempty(arg_24_1.onlineTime) and var_24_0 or TimeUtil.stringToTimestamp(arg_24_1.onlineTime) - ServerTime.clientToServerOffset()
	local var_24_2 = string.nilorempty(arg_24_1.offlineTime) and var_24_0 or TimeUtil.stringToTimestamp(arg_24_1.offlineTime) - ServerTime.clientToServerOffset()

	return arg_24_1.isOffline == 0 and var_24_1 <= var_24_0 and var_24_0 <= var_24_2
end

function var_0_0.onOpenFinish(arg_25_0)
	return
end

function var_0_0.setSelectItem(arg_26_0)
	local var_26_0 = arg_26_0.viewContainer:getSetting().otherRes[1]

	for iter_26_0 = 1, #arg_26_0._pagesCo do
		local var_26_1 = arg_26_0:getResInst(var_26_0, arg_26_0._goslider)
		local var_26_2 = MainThumbnailBannerSelectItem.New()

		var_26_2:init({
			go = var_26_1,
			index = iter_26_0,
			config = arg_26_0._pagesCo[iter_26_0],
			pos = arg_26_0:_getPos(iter_26_0)
		})
		var_26_2:updateItem(arg_26_0:getTargetPageIndex(), #arg_26_0._pagesCo)
		table.insert(arg_26_0._selectItems, var_26_2)
	end
end

function var_0_0._getPos(arg_27_0, arg_27_1)
	return 55 * (arg_27_1 - 0.5 * (#arg_27_0._pagesCo + 1))
end

function var_0_0.setContentItem(arg_28_0)
	local var_28_0 = arg_28_0.viewContainer:getSetting().otherRes[2]

	for iter_28_0 = 1, #arg_28_0._pagesCo do
		local var_28_1 = arg_28_0:getResInst(var_28_0, arg_28_0._gocontent)
		local var_28_2 = MainThumbnailBannerContent.New()

		var_28_2:init({
			go = var_28_1,
			index = iter_28_0,
			config = arg_28_0._pagesCo[iter_28_0],
			pos = arg_28_0:_getContentPos(-1)
		})
		var_28_2:updateItem()
		table.insert(arg_28_0._helpItems, var_28_2)
	end
end

function var_0_0._getContentPos(arg_29_0, arg_29_1)
	return arg_29_0._space * (arg_29_1 - 1)
end

function var_0_0._updateSelectedItem(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0._selectItems) do
		iter_30_1:updateItem(arg_30_0:getTargetPageIndex(), #arg_30_0._pagesCo)
	end

	for iter_30_2, iter_30_3 in ipairs(arg_30_0._helpItems) do
		iter_30_3:updateItem(arg_30_0:getTargetPageIndex())
	end

	if not arg_30_0._prevTargetPageIndex then
		arg_30_0:_updateContentPos(arg_30_0:getTargetPageIndex(), arg_30_0:getTargetPageIndex(), true)

		return
	end

	arg_30_0:_updateContentPos(arg_30_0._prevTargetPageIndex, arg_30_0._prevTargetPageIndex, true)
	arg_30_0:_updateContentPos(arg_30_0:getTargetPageIndex(), arg_30_0._targetPageIndex, false)

	if arg_30_0._tweenId then
		ZProj.TweenHelper.KillById(arg_30_0._tweenId)

		arg_30_0._tweenId = nil
	end

	local var_30_0 = (1 - arg_30_0._targetPageIndex) * arg_30_0._space

	arg_30_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_30_0._gocontent.transform, var_30_0, 0.75, arg_30_0._tweenPosFinish, arg_30_0)
end

function var_0_0._updateContentPos(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0._helpItems[arg_31_1]

	recthelper.setAnchorX(var_31_0._go.transform, arg_31_0:_getContentPos(arg_31_2))

	if not arg_31_3 then
		return
	end

	local var_31_1 = (1 - arg_31_2) * arg_31_0._space

	recthelper.setAnchorX(arg_31_0._gocontent.transform, var_31_1)
end

function var_0_0._tweenPosFinish(arg_32_0)
	return
end

function var_0_0.onClose(arg_33_0)
	arg_33_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_33_0._initPages, arg_33_0)
end

function var_0_0._clearPages(arg_34_0)
	if arg_34_0._selectItems then
		for iter_34_0, iter_34_1 in pairs(arg_34_0._selectItems) do
			iter_34_1:destroy()
		end

		arg_34_0._selectItems = {}
	end

	if arg_34_0._helpItems then
		for iter_34_2, iter_34_3 in pairs(arg_34_0._helpItems) do
			iter_34_3:destroy()
		end

		arg_34_0._helpItems = {}
	end

	gohelper.destroyAllChildren(arg_34_0._goslider)
	gohelper.destroyAllChildren(arg_34_0._gocontent)
end

function var_0_0.onDestroyView(arg_35_0)
	arg_35_0:_clearPages()
	arg_35_0._scroll:RemoveDragBeginListener()
	arg_35_0._scroll:RemoveDragEndListener()
	arg_35_0._viewClick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_35_0._onSwitch, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._checkExpire, arg_35_0)
end

return var_0_0
