module("modules.logic.store.controller.StoreController", package.seeall)

local var_0_0 = class("StoreController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._lastViewStoreId = 0
	arg_1_0._viewTime = nil
	arg_1_0._tabTime = nil
	arg_1_0._lastViewGoodsId = 0
	arg_1_0._goodsTime = nil
end

function var_0_0.onInitFinish(arg_2_0)
	arg_2_0._lastViewStoreId = 0
	arg_2_0._viewTime = nil
	arg_2_0._tabTime = nil
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0.enteredRecommendStoreIdList = nil
end

function var_0_0.checkAndOpenStoreView(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		arg_5_0:openStoreView(arg_5_1, arg_5_2)

		var_5_0 = true
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end

	return var_5_0
end

function var_0_0.openStoreView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {
		jumpTab = arg_6_1,
		jumpGoodsId = arg_6_2,
		isFocus = arg_6_3
	}

	ViewMgr.instance:openView(ViewName.StoreView, var_6_0)
end

function var_0_0.openNormalGoodsView(arg_7_0, arg_7_1)
	if arg_7_1.belongStoreId == StoreEnum.StoreId.NewRoomStore or arg_7_1.belongStoreId == StoreEnum.StoreId.OldRoomStore then
		if arg_7_0:isRoomBlockGift(arg_7_1) then
			ViewMgr.instance:openView(ViewName.RoomBlockGiftStoreGoodsView, arg_7_1)
		else
			RoomController.instance:openStoreGoodsTipView(arg_7_1)
		end
	else
		ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, arg_7_1)
	end
end

function var_0_0.isRoomBlockGift(arg_8_0, arg_8_1)
	if string.nilorempty(arg_8_1.config.product) then
		return
	end

	local var_8_0 = GameUtil.splitString2(arg_8_1.config.product, true)
	local var_8_1 = var_8_0[1][1]
	local var_8_2 = var_8_0[1][2]
	local var_8_3 = ItemModel.instance:getItemConfig(var_8_1, var_8_2)

	return var_8_3.subType == ItemEnum.SubType.RoomBlockGift or var_8_3.subType == ItemEnum.SubType.RoomBlockGiftNew
end

function var_0_0.openChargeGoodsView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.ChargeStoreGoodsView, arg_9_1)
end

function var_0_0.openPackageStoreGoodsView(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.config.type

	if var_10_0 == StoreEnum.StoreChargeType.Optional then
		ViewMgr.instance:openView(ViewName.OptionalChargeView, arg_10_1)
	elseif var_10_0 == StoreEnum.StoreChargeType.LinkGiftGoods then
		ViewMgr.instance:openView(ViewName.StoreLinkGiftGoodsView, arg_10_1)
	elseif var_10_0 == StoreEnum.StoreChargeType.NationalGift then
		local var_10_1 = {
			goodMo = arg_10_1
		}

		NationalGiftController.instance:openNationalGiftBuyTipView(var_10_1)
	else
		ViewMgr.instance:openView(ViewName.PackageStoreGoodsView, arg_10_1)
	end
end

function var_0_0.openDecorateStoreGoodsView(arg_11_0, arg_11_1)
	local var_11_0 = string.splitToNumber(arg_11_1.config.product, "#")

	if ItemModel.instance:getItemConfig(var_11_0[1], var_11_0[2]).subType == ItemEnum.SubType.PlayerBg then
		local var_11_1 = {
			goodsMo = arg_11_1
		}

		ViewMgr.instance:openView(ViewName.DecorateStoreGoodsBuyView, var_11_1)
	else
		ViewMgr.instance:openView(ViewName.DecorateStoreGoodsView, arg_11_1)
	end
end

function var_0_0.openSummonStoreGoodsView(arg_12_0, arg_12_1)
	if arg_12_1.belongStoreId == StoreEnum.StoreId.RoomStore then
		RoomController.instance:openStoreGoodsTipView(arg_12_1)
	else
		ViewMgr.instance:openView(ViewName.SummonStoreGoodsView, arg_12_1)
	end
end

function var_0_0.buyGoods(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	StoreRpc.instance:sendBuyGoodsRequest(arg_13_1.belongStoreId, arg_13_1.goodsId, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
end

function var_0_0.forceReadTab(arg_14_0, arg_14_1)
	local var_14_0 = StoreModel.instance:jumpTabIdToStoreId(arg_14_1)

	arg_14_0:_readTab(var_14_0)
end

function var_0_0.readTab(arg_15_0, arg_15_1)
	local var_15_0 = StoreModel.instance:jumpTabIdToStoreId(arg_15_1)

	if var_15_0 == arg_15_0._lastViewStoreId then
		return
	end

	arg_15_0:_readTab(var_15_0)
end

function var_0_0._readTab(arg_16_0, arg_16_1)
	local var_16_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)

	if var_16_0 then
		local var_16_1 = var_16_0.infos
		local var_16_2 = {}

		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			local var_16_3 = StoreModel.instance:getGoodsMO(iter_16_1.uid)

			if var_16_3 and arg_16_1 == var_16_3.belongStoreId then
				table.insert(var_16_2, iter_16_1.uid)
			end
		end

		if #var_16_2 > 0 then
			StoreRpc.instance:sendReadStoreNewRequest(var_16_2)
		end
	end

	local var_16_4 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)

	if var_16_4 then
		local var_16_5 = var_16_4.infos
		local var_16_6 = {}

		for iter_16_2, iter_16_3 in pairs(var_16_5) do
			local var_16_7 = StoreModel.instance:getGoodsMO(iter_16_3.uid)

			if var_16_7 and arg_16_1 == var_16_7.belongStoreId then
				table.insert(var_16_6, iter_16_3.uid)
			end
		end

		if #var_16_6 > 0 then
			if not StoreConfig.instance:isPackageStore(arg_16_1) then
				ChargeRpc.instance:sendReadChargeNewRequest(var_16_6)
			else
				local var_16_8 = {}

				for iter_16_4, iter_16_5 in pairs(var_16_6) do
					local var_16_9 = StoreModel.instance:getGoodsMO(iter_16_5)
					local var_16_10 = ServerTime.now()

					if not (var_16_10 >= var_16_9.newStartTime and var_16_10 <= var_16_9.newEndTime) then
						table.insert(var_16_8, iter_16_5)
					end
				end

				ChargeRpc.instance:sendReadChargeNewRequest(var_16_8)
			end
		end
	end
end

function var_0_0.statSwitchStore(arg_17_0, arg_17_1)
	local var_17_0 = StoreModel.instance:jumpTabIdToStoreId(arg_17_1)

	if var_17_0 == arg_17_0._lastViewStoreId then
		return
	end

	if not arg_17_0._viewTime then
		StatController.instance:track(StatEnum.EventName.StoreEnter, {
			[StatEnum.EventProperties.StoreId] = tostring(var_17_0)
		})

		arg_17_0._viewTime = ServerTime.now()
	else
		local var_17_1 = 0

		if arg_17_0._tabTime then
			var_17_1 = ServerTime.now() - arg_17_0._tabTime
		end

		StatController.instance:track(StatEnum.EventName.SwitchStore, {
			[StatEnum.EventProperties.BeforeStoreId] = tostring(arg_17_0._lastViewStoreId),
			[StatEnum.EventProperties.AfterStoreId] = tostring(var_17_0),
			[StatEnum.EventProperties.Time] = var_17_1
		})
	end

	arg_17_0._tabTime = ServerTime.now()
	arg_17_0._lastViewStoreId = var_17_0
end

function var_0_0.statExitStore(arg_18_0)
	local var_18_0 = 0

	if arg_18_0._viewTime then
		var_18_0 = ServerTime.now() - arg_18_0._viewTime
	end

	StatController.instance:track(StatEnum.EventName.StoreExit, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_18_0._lastViewStoreId),
		[StatEnum.EventProperties.Time] = var_18_0
	})

	arg_18_0._lastViewStoreId = 0
	arg_18_0._viewTime = nil
	arg_18_0._tabTime = nil
end

function var_0_0.statOpenGoods(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_2 then
		return
	end

	if ChargePushStatController.instance:statClick(arg_19_2.id) then
		return
	end

	arg_19_0._lastViewGoodsId = arg_19_2.id
	arg_19_0._goodsTime = ServerTime.now()

	local var_19_0 = arg_19_2.product
	local var_19_1 = string.split(var_19_0, "#")
	local var_19_2 = tonumber(var_19_1[1])
	local var_19_3 = tonumber(var_19_1[2])
	local var_19_4 = tonumber(var_19_1[3])
	local var_19_5 = ItemModel.instance:getItemConfig(var_19_2, var_19_3)

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_19_1),
		[StatEnum.EventProperties.GoodsId] = arg_19_2.id,
		[StatEnum.EventProperties.MaterialName] = var_19_5 and var_19_5.name or "",
		[StatEnum.EventProperties.MaterialNum] = var_19_4
	})
end

function var_0_0.statOpenChargeGoods(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_2 then
		return
	end

	if ChargePushStatController.instance:statClick(arg_20_2.id) then
		return
	end

	arg_20_0._lastViewGoodsId = arg_20_2.id
	arg_20_0._goodsTime = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_20_1),
		[StatEnum.EventProperties.GoodsId] = arg_20_2.id,
		[StatEnum.EventProperties.MaterialName] = arg_20_2 and arg_20_2.name or "",
		[StatEnum.EventProperties.MaterialNum] = 1
	})
end

function var_0_0.statCloseGoods(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	if arg_21_0._lastViewGoodsId ~= arg_21_1.id then
		return
	end

	local var_21_0 = 0

	if arg_21_0._goodsTime then
		local var_21_1 = ServerTime.now() - arg_21_0._goodsTime
	end

	arg_21_0._lastViewGoodsId = 0
end

function var_0_0.recordExchangeSkinDiamond(arg_22_0, arg_22_1)
	arg_22_0.exchangeDiamondQuantity = arg_22_1
end

function var_0_0.statBuyGoods(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	arg_23_5 = arg_23_5 or 1

	local var_23_0 = StoreConfig.instance:getGoodsConfig(arg_23_2)
	local var_23_1 = var_23_0.product
	local var_23_2

	if arg_23_1 == StoreEnum.StoreId.RoomStore then
		var_23_1 = arg_23_0.roomStoreCanBuyGoodsStr
		var_23_2 = arg_23_0:_itemsMultipleWithBuyCount(arg_23_0.recordCostItem, arg_23_3, arg_23_4)
	elseif arg_23_1 == StoreEnum.StoreId.Skin and arg_23_0.exchangeDiamondQuantity and arg_23_0.exchangeDiamondQuantity > 0 then
		local var_23_3 = string.splitToNumber(var_23_0.cost, "#")
		local var_23_4 = var_23_3[1]
		local var_23_5 = var_23_3[2]
		local var_23_6 = var_23_3[3]
		local var_23_7 = {
			type = MaterialEnum.MaterialType.Currency,
			id = CurrencyEnum.CurrencyType.Diamond,
			quantity = arg_23_0.exchangeDiamondQuantity
		}
		local var_23_8 = {
			type = var_23_4,
			id = var_23_5,
			quantity = var_23_6 - arg_23_0.exchangeDiamondQuantity
		}

		var_23_2 = arg_23_0:_generateItemListJson({
			var_23_7,
			var_23_8
		})
		arg_23_0.exchangeDiamondQuantity = 0
	else
		var_23_2 = arg_23_0:_itemsMultipleWithBuyCount(var_23_0.cost, arg_23_3, arg_23_4)
	end

	local var_23_9 = arg_23_0:_itemsMultiple(var_23_1, arg_23_3)

	StatController.instance:track(StatEnum.EventName.ServerBuyGoods, {
		[StatEnum.EventProperties.ServerStoreId] = tostring(arg_23_1),
		[StatEnum.EventProperties.ServerCost] = var_23_2,
		[StatEnum.EventProperties.ServerGoodsId] = var_23_0.id,
		[StatEnum.EventProperties.ServerBuyCount] = arg_23_3,
		[StatEnum.EventProperties.ServerGainMaterial] = var_23_9
	})
end

function var_0_0.statVersionActivityBuyGoods(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = ActivityStoreConfig.instance:getStoreConfig(arg_24_1, arg_24_2)
	local var_24_1 = arg_24_0:_itemsMultipleWithBuyCount(var_24_0.cost, arg_24_3, arg_24_4)
	local var_24_2 = arg_24_0:_itemsMultiple(var_24_0.product, arg_24_3)

	StatController.instance:track(StatEnum.EventName.ServerBuyGoods, {
		[StatEnum.EventProperties.ServerStoreId] = tostring(arg_24_1),
		[StatEnum.EventProperties.ServerCost] = var_24_1,
		[StatEnum.EventProperties.ServerGoodsId] = arg_24_2,
		[StatEnum.EventProperties.ServerBuyCount] = arg_24_3,
		[StatEnum.EventProperties.ServerGainMaterial] = var_24_2
	})
end

function var_0_0.recordRoomStoreCurrentCanBuyGoods(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = StoreConfig.instance:getGoodsConfig(arg_25_1)

	if arg_25_2 == 1 then
		arg_25_0.recordCostItem = var_25_0.cost
	elseif arg_25_2 == 2 then
		arg_25_0.recordCostItem = var_25_0.cost2
	else
		arg_25_0.recordCostItem = var_25_0.cost
	end

	arg_25_0.roomStoreCanBuyGoodsStr = var_25_0.product

	local var_25_1 = string.split(var_25_0.product, "|")

	if #var_25_1 > 1 then
		local var_25_2 = string.split(arg_25_0.recordCostItem, "#")
		local var_25_3 = {}

		var_25_2[3] = arg_25_3

		for iter_25_0, iter_25_1 in ipairs(var_25_1) do
			local var_25_4 = string.splitToNumber(iter_25_1, "#")
			local var_25_5 = ItemModel.instance:getItemQuantity(var_25_4[1], var_25_4[2])
			local var_25_6 = ItemModel.instance:getItemConfig(var_25_4[1], var_25_4[2])
			local var_25_7 = var_25_6 and var_25_6.numLimit or 1

			if var_25_7 == 0 or var_25_5 < var_25_7 then
				table.insert(var_25_3, string.format("%s#%s#%s", var_25_4[1], var_25_4[2], var_25_7 - var_25_5))
			end
		end

		arg_25_0.recordCostItem = table.concat(var_25_2, "#")
		arg_25_0.roomStoreCanBuyGoodsStr = table.concat(var_25_3, "|")
	end
end

function var_0_0._itemsMultiple(arg_26_0, arg_26_1, arg_26_2)
	if string.nilorempty(arg_26_1) or arg_26_2 <= 0 then
		return {}
	end

	local var_26_0 = GameUtil.splitString2(arg_26_1, true)
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_2 = {
			type = iter_26_1[1],
			id = iter_26_1[2],
			quantity = iter_26_1[3] * arg_26_2
		}

		table.insert(var_26_1, var_26_2)
	end

	return arg_26_0:_generateItemListJson(var_26_1)
end

function var_0_0._itemsMultipleWithBuyCount(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if string.nilorempty(arg_27_1) or arg_27_2 <= 0 then
		return {}
	end

	local var_27_0 = {}
	local var_27_1 = string.split(arg_27_1, "|")

	for iter_27_0 = arg_27_3 + 1, arg_27_3 + arg_27_2 do
		local var_27_2 = var_27_1[iter_27_0] or var_27_1[#var_27_1]
		local var_27_3 = string.splitToNumber(var_27_2, "#")

		if iter_27_0 >= #var_27_1 then
			table.insert(var_27_0, {
				type = var_27_3[1],
				id = var_27_3[2],
				quantity = var_27_3[3] * (arg_27_3 + arg_27_2 - iter_27_0 + 1)
			})

			break
		else
			table.insert(var_27_0, {
				type = var_27_3[1],
				id = var_27_3[2],
				quantity = var_27_3[3]
			})
		end
	end

	if #var_27_0 <= 0 then
		return {}
	end

	local var_27_4 = {}

	for iter_27_1, iter_27_2 in ipairs(var_27_0) do
		var_27_4[iter_27_2.type] = var_27_4[iter_27_2.type] or {}
		var_27_4[iter_27_2.type][iter_27_2.id] = (var_27_4[iter_27_2.type][iter_27_2.id] or 0) + iter_27_2.quantity
	end

	local var_27_5 = {}

	for iter_27_3, iter_27_4 in pairs(var_27_4) do
		for iter_27_5, iter_27_6 in pairs(iter_27_4) do
			table.insert(var_27_5, {
				type = iter_27_3,
				id = iter_27_5,
				quantity = iter_27_6
			})
		end
	end

	return arg_27_0:_generateItemListJson(var_27_5)
end

function var_0_0._generateItemListJson(arg_28_0, arg_28_1)
	if not arg_28_1 or #arg_28_1 <= 0 then
		return {}
	end

	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		local var_28_1 = ItemModel.instance:getItemConfig(iter_28_1.type, iter_28_1.id)

		table.insert(var_28_0, {
			materialname = var_28_1 and var_28_1.name or "",
			materialtype = iter_28_1.type,
			materialnum = iter_28_1.quantity
		})
	end

	return var_28_0
end

function var_0_0.isNeedShowRedDotNewTag(arg_29_0, arg_29_1)
	return arg_29_1 and arg_29_1.type == 0 and not string.nilorempty(arg_29_1.onlineTime)
end

function var_0_0.initEnteredRecommendStoreList(arg_30_0)
	local var_30_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()
	local var_30_1 = PlayerPrefsHelper.getString(var_30_0, "")

	if string.nilorempty(var_30_1) then
		arg_30_0.enteredRecommendStoreIdList = {}

		return
	end

	arg_30_0.enteredRecommendStoreIdList = string.splitToNumber(var_30_1, ";")
end

function var_0_0.enterRecommendStore(arg_31_0, arg_31_1)
	if not arg_31_0.enteredRecommendStoreIdList then
		arg_31_0:initEnteredRecommendStoreList()
	end

	if tabletool.indexOf(arg_31_0.enteredRecommendStoreIdList, arg_31_1) then
		return
	end

	table.insert(arg_31_0.enteredRecommendStoreIdList, arg_31_1)
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)

	local var_31_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()

	PlayerPrefsHelper.setString(var_31_0, table.concat(arg_31_0.enteredRecommendStoreIdList, ";"))
end

function var_0_0.isEnteredRecommendStore(arg_32_0, arg_32_1)
	if not arg_32_0.enteredRecommendStoreIdList then
		arg_32_0:initEnteredRecommendStoreList()
	end

	return tabletool.indexOf(arg_32_0.enteredRecommendStoreIdList, arg_32_1)
end

function var_0_0.getRecommendStoreTime(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return
	end

	local var_33_0 = string.nilorempty(arg_33_1.showOnlineTime) and arg_33_1.onlineTime or arg_33_1.showOnlineTime
	local var_33_1 = string.nilorempty(arg_33_1.showOfflineTime) and arg_33_1.offlineTime or arg_33_1.showOfflineTime
	local var_33_2 = TimeUtil.stringToTimestamp(var_33_0) + ServerTime.clientToServerOffset()
	local var_33_3 = TimeUtil.stringToTimestamp(var_33_1) + ServerTime.clientToServerOffset()
	local var_33_4 = tonumber(os.date("%m", var_33_2))
	local var_33_5 = tonumber(os.date("%d", var_33_2))
	local var_33_6 = tonumber(os.date("%H", var_33_2))
	local var_33_7 = string.format("%02d", tonumber(os.date("%M", var_33_2)))
	local var_33_8 = tonumber(os.date("%m", var_33_3))
	local var_33_9 = tonumber(os.date("%d", var_33_3))
	local var_33_10 = tonumber(os.date("%H", var_33_3))
	local var_33_11 = string.format("%02d", tonumber(os.date("%M", var_33_3)))

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime"), {
		var_33_4,
		var_33_5,
		var_33_6,
		var_33_7,
		var_33_8,
		var_33_9,
		var_33_10,
		var_33_11
	})
end

function var_0_0.onUseItemInStore(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return
	end

	if arg_34_1.entry and arg_34_1.entry[1].materialId and (arg_34_1.entry[1].materialId == StoreEnum.NormalRoomTicket or arg_34_1.entry[1].materialId == StoreEnum.TopRoomTicket) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		var_0_0.instance:dispatchEvent(StoreEvent.GoodsModelChanged, tonumber(arg_34_1.targetId))
	end
end

function var_0_0.statOnClickPowerPotion(arg_35_0, arg_35_1)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotion, {
		[StatEnum.EventProperties.WindowName] = arg_35_1
	})
end

function var_0_0.statOnClickPowerPotionJump(arg_36_0, arg_36_1, arg_36_2)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotionJump, {
		[StatEnum.EventProperties.WindowName] = arg_36_1,
		[StatEnum.EventProperties.JumpName] = arg_36_2
	})
end

function var_0_0.needHideHome(arg_37_0)
	if arg_37_0._needHideBackHomeViews == nil then
		arg_37_0._needHideBackHomeViews = {
			ViewName.SummonResultView,
			ViewName.SummonADView
		}
	end

	for iter_37_0 = 1, #arg_37_0._needHideBackHomeViews do
		if ViewMgr.instance:isOpen(arg_37_0._needHideBackHomeViews[iter_37_0]) then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
