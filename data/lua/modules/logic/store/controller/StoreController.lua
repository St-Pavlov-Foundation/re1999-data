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

function var_0_0.openStoreView(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		jumpTab = arg_6_1,
		jumpGoodsId = arg_6_2
	}

	ViewMgr.instance:openView(ViewName.StoreView, var_6_0)
end

function var_0_0.openNormalGoodsView(arg_7_0, arg_7_1)
	if arg_7_1.belongStoreId == StoreEnum.StoreId.NewRoomStore or arg_7_1.belongStoreId == StoreEnum.StoreId.OldRoomStore then
		RoomController.instance:openStoreGoodsTipView(arg_7_1)
	else
		ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, arg_7_1)
	end
end

function var_0_0.openChargeGoodsView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.ChargeStoreGoodsView, arg_8_1)
end

function var_0_0.openPackageStoreGoodsView(arg_9_0, arg_9_1)
	if arg_9_1.config.type == StoreEnum.StoreChargeType.Optional then
		ViewMgr.instance:openView(ViewName.OptionalChargeView, arg_9_1)
	else
		ViewMgr.instance:openView(ViewName.PackageStoreGoodsView, arg_9_1)
	end
end

function var_0_0.openDecorateStoreGoodsView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.DecorateStoreGoodsView, arg_10_1)
end

function var_0_0.openSummonStoreGoodsView(arg_11_0, arg_11_1)
	if arg_11_1.belongStoreId == StoreEnum.StoreId.RoomStore then
		RoomController.instance:openStoreGoodsTipView(arg_11_1)
	else
		ViewMgr.instance:openView(ViewName.SummonStoreGoodsView, arg_11_1)
	end
end

function var_0_0.buyGoods(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	StoreRpc.instance:sendBuyGoodsRequest(arg_12_1.belongStoreId, arg_12_1.goodsId, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
end

function var_0_0.forceReadTab(arg_13_0, arg_13_1)
	local var_13_0 = StoreModel.instance:jumpTabIdToStoreId(arg_13_1)

	arg_13_0:_readTab(var_13_0)
end

function var_0_0.readTab(arg_14_0, arg_14_1)
	local var_14_0 = StoreModel.instance:jumpTabIdToStoreId(arg_14_1)

	if var_14_0 == arg_14_0._lastViewStoreId then
		return
	end

	arg_14_0:_readTab(var_14_0)
end

function var_0_0._readTab(arg_15_0, arg_15_1)
	local var_15_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)

	if var_15_0 then
		local var_15_1 = var_15_0.infos
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in pairs(var_15_1) do
			local var_15_3 = StoreModel.instance:getGoodsMO(iter_15_1.uid)

			if var_15_3 and arg_15_1 == var_15_3.belongStoreId then
				table.insert(var_15_2, iter_15_1.uid)
			end
		end

		if #var_15_2 > 0 then
			StoreRpc.instance:sendReadStoreNewRequest(var_15_2)
		end
	end

	local var_15_4 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)

	if var_15_4 then
		local var_15_5 = var_15_4.infos
		local var_15_6 = {}

		for iter_15_2, iter_15_3 in pairs(var_15_5) do
			local var_15_7 = StoreModel.instance:getGoodsMO(iter_15_3.uid)

			if var_15_7 and arg_15_1 == var_15_7.belongStoreId then
				table.insert(var_15_6, iter_15_3.uid)
			end
		end

		if #var_15_6 > 0 then
			if not StoreConfig.instance:isPackageStore(arg_15_1) then
				ChargeRpc.instance:sendReadChargeNewRequest(var_15_6)
			else
				local var_15_8 = {}

				for iter_15_4, iter_15_5 in pairs(var_15_6) do
					local var_15_9 = StoreModel.instance:getGoodsMO(iter_15_5)
					local var_15_10 = ServerTime.now()

					if not (var_15_10 >= var_15_9.newStartTime and var_15_10 <= var_15_9.newEndTime) then
						table.insert(var_15_8, iter_15_5)
					end
				end

				ChargeRpc.instance:sendReadChargeNewRequest(var_15_8)
			end
		end
	end
end

function var_0_0.statSwitchStore(arg_16_0, arg_16_1)
	local var_16_0 = StoreModel.instance:jumpTabIdToStoreId(arg_16_1)

	if var_16_0 == arg_16_0._lastViewStoreId then
		return
	end

	if not arg_16_0._viewTime then
		StatController.instance:track(StatEnum.EventName.StoreEnter, {
			[StatEnum.EventProperties.StoreId] = tostring(var_16_0)
		})

		arg_16_0._viewTime = ServerTime.now()
	else
		local var_16_1 = 0

		if arg_16_0._tabTime then
			var_16_1 = ServerTime.now() - arg_16_0._tabTime
		end

		StatController.instance:track(StatEnum.EventName.SwitchStore, {
			[StatEnum.EventProperties.BeforeStoreId] = tostring(arg_16_0._lastViewStoreId),
			[StatEnum.EventProperties.AfterStoreId] = tostring(var_16_0),
			[StatEnum.EventProperties.Time] = var_16_1
		})
	end

	arg_16_0._tabTime = ServerTime.now()
	arg_16_0._lastViewStoreId = var_16_0
end

function var_0_0.statExitStore(arg_17_0)
	local var_17_0 = 0

	if arg_17_0._viewTime then
		var_17_0 = ServerTime.now() - arg_17_0._viewTime
	end

	StatController.instance:track(StatEnum.EventName.StoreExit, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_17_0._lastViewStoreId),
		[StatEnum.EventProperties.Time] = var_17_0
	})

	arg_17_0._lastViewStoreId = 0
	arg_17_0._viewTime = nil
	arg_17_0._tabTime = nil
end

function var_0_0.statOpenGoods(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_2 then
		return
	end

	arg_18_0._lastViewGoodsId = arg_18_2.id
	arg_18_0._goodsTime = ServerTime.now()

	local var_18_0 = arg_18_2.product
	local var_18_1 = string.split(var_18_0, "#")
	local var_18_2 = tonumber(var_18_1[1])
	local var_18_3 = tonumber(var_18_1[2])
	local var_18_4 = tonumber(var_18_1[3])
	local var_18_5 = ItemModel.instance:getItemConfig(var_18_2, var_18_3)

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_18_1),
		[StatEnum.EventProperties.GoodsId] = arg_18_2.id,
		[StatEnum.EventProperties.MaterialName] = var_18_5 and var_18_5.name or "",
		[StatEnum.EventProperties.MaterialNum] = var_18_4
	})
end

function var_0_0.statOpenChargeGoods(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_2 then
		return
	end

	arg_19_0._lastViewGoodsId = arg_19_2.id
	arg_19_0._goodsTime = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_19_1),
		[StatEnum.EventProperties.GoodsId] = arg_19_2.id,
		[StatEnum.EventProperties.MaterialName] = arg_19_2 and arg_19_2.name or "",
		[StatEnum.EventProperties.MaterialNum] = 1
	})
end

function var_0_0.statCloseGoods(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return
	end

	if arg_20_0._lastViewGoodsId ~= arg_20_1.id then
		logError("打开和关闭时商品不一致， 不应该发生")

		return
	end

	local var_20_0 = 0

	if arg_20_0._goodsTime then
		local var_20_1 = ServerTime.now() - arg_20_0._goodsTime
	end

	arg_20_0._lastViewGoodsId = 0
end

function var_0_0.recordExchangeSkinDiamond(arg_21_0, arg_21_1)
	arg_21_0.exchangeDiamondQuantity = arg_21_1
end

function var_0_0.statBuyGoods(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	arg_22_5 = arg_22_5 or 1

	local var_22_0 = StoreConfig.instance:getGoodsConfig(arg_22_2)
	local var_22_1 = var_22_0.product
	local var_22_2

	if arg_22_1 == StoreEnum.StoreId.RoomStore then
		var_22_1 = arg_22_0.roomStoreCanBuyGoodsStr
		var_22_2 = arg_22_0:_itemsMultipleWithBuyCount(arg_22_0.recordCostItem, arg_22_3, arg_22_4)
	elseif arg_22_1 == StoreEnum.StoreId.Skin and arg_22_0.exchangeDiamondQuantity and arg_22_0.exchangeDiamondQuantity > 0 then
		local var_22_3 = string.splitToNumber(var_22_0.cost, "#")
		local var_22_4 = var_22_3[1]
		local var_22_5 = var_22_3[2]
		local var_22_6 = var_22_3[3]
		local var_22_7 = {
			type = MaterialEnum.MaterialType.Currency,
			id = CurrencyEnum.CurrencyType.Diamond,
			quantity = arg_22_0.exchangeDiamondQuantity
		}
		local var_22_8 = {
			type = var_22_4,
			id = var_22_5,
			quantity = var_22_6 - arg_22_0.exchangeDiamondQuantity
		}

		var_22_2 = arg_22_0:_generateItemListJson({
			var_22_7,
			var_22_8
		})
		arg_22_0.exchangeDiamondQuantity = 0
	else
		var_22_2 = arg_22_0:_itemsMultipleWithBuyCount(var_22_0.cost, arg_22_3, arg_22_4)
	end

	local var_22_9 = arg_22_0:_itemsMultiple(var_22_1, arg_22_3)

	StatController.instance:track(StatEnum.EventName.ServerBuyGoods, {
		[StatEnum.EventProperties.ServerStoreId] = tostring(arg_22_1),
		[StatEnum.EventProperties.ServerCost] = var_22_2,
		[StatEnum.EventProperties.ServerGoodsId] = var_22_0.id,
		[StatEnum.EventProperties.ServerBuyCount] = arg_22_3,
		[StatEnum.EventProperties.ServerGainMaterial] = var_22_9
	})
end

function var_0_0.statVersionActivityBuyGoods(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = ActivityStoreConfig.instance:getStoreConfig(arg_23_1, arg_23_2)
	local var_23_1 = arg_23_0:_itemsMultipleWithBuyCount(var_23_0.cost, arg_23_3, arg_23_4)
	local var_23_2 = arg_23_0:_itemsMultiple(var_23_0.product, arg_23_3)

	StatController.instance:track(StatEnum.EventName.ServerBuyGoods, {
		[StatEnum.EventProperties.ServerStoreId] = tostring(arg_23_1),
		[StatEnum.EventProperties.ServerCost] = var_23_1,
		[StatEnum.EventProperties.ServerGoodsId] = arg_23_2,
		[StatEnum.EventProperties.ServerBuyCount] = arg_23_3,
		[StatEnum.EventProperties.ServerGainMaterial] = var_23_2
	})
end

function var_0_0.recordRoomStoreCurrentCanBuyGoods(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = StoreConfig.instance:getGoodsConfig(arg_24_1)

	if arg_24_2 == 1 then
		arg_24_0.recordCostItem = var_24_0.cost
	elseif arg_24_2 == 2 then
		arg_24_0.recordCostItem = var_24_0.cost2
	else
		arg_24_0.recordCostItem = var_24_0.cost
	end

	arg_24_0.roomStoreCanBuyGoodsStr = var_24_0.product

	local var_24_1 = string.split(var_24_0.product, "|")

	if #var_24_1 > 1 then
		local var_24_2 = string.split(arg_24_0.recordCostItem, "#")
		local var_24_3 = {}

		var_24_2[3] = arg_24_3

		for iter_24_0, iter_24_1 in ipairs(var_24_1) do
			local var_24_4 = string.splitToNumber(iter_24_1, "#")
			local var_24_5 = ItemModel.instance:getItemQuantity(var_24_4[1], var_24_4[2])
			local var_24_6 = ItemModel.instance:getItemConfig(var_24_4[1], var_24_4[2])
			local var_24_7 = var_24_6 and var_24_6.numLimit or 1

			if var_24_7 == 0 or var_24_5 < var_24_7 then
				table.insert(var_24_3, string.format("%s#%s#%s", var_24_4[1], var_24_4[2], var_24_7 - var_24_5))
			end
		end

		arg_24_0.recordCostItem = table.concat(var_24_2, "#")
		arg_24_0.roomStoreCanBuyGoodsStr = table.concat(var_24_3, "|")
	end
end

function var_0_0._itemsMultiple(arg_25_0, arg_25_1, arg_25_2)
	if string.nilorempty(arg_25_1) or arg_25_2 <= 0 then
		return {}
	end

	local var_25_0 = GameUtil.splitString2(arg_25_1, true)
	local var_25_1 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		local var_25_2 = {
			type = iter_25_1[1],
			id = iter_25_1[2],
			quantity = iter_25_1[3] * arg_25_2
		}

		table.insert(var_25_1, var_25_2)
	end

	return arg_25_0:_generateItemListJson(var_25_1)
end

function var_0_0._itemsMultipleWithBuyCount(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if string.nilorempty(arg_26_1) or arg_26_2 <= 0 then
		return {}
	end

	local var_26_0 = {}
	local var_26_1 = string.split(arg_26_1, "|")

	for iter_26_0 = arg_26_3 + 1, arg_26_3 + arg_26_2 do
		local var_26_2 = var_26_1[iter_26_0] or var_26_1[#var_26_1]
		local var_26_3 = string.splitToNumber(var_26_2, "#")

		if iter_26_0 >= #var_26_1 then
			table.insert(var_26_0, {
				type = var_26_3[1],
				id = var_26_3[2],
				quantity = var_26_3[3] * (arg_26_3 + arg_26_2 - iter_26_0 + 1)
			})

			break
		else
			table.insert(var_26_0, {
				type = var_26_3[1],
				id = var_26_3[2],
				quantity = var_26_3[3]
			})
		end
	end

	if #var_26_0 <= 0 then
		return {}
	end

	local var_26_4 = {}

	for iter_26_1, iter_26_2 in ipairs(var_26_0) do
		var_26_4[iter_26_2.type] = var_26_4[iter_26_2.type] or {}
		var_26_4[iter_26_2.type][iter_26_2.id] = (var_26_4[iter_26_2.type][iter_26_2.id] or 0) + iter_26_2.quantity
	end

	local var_26_5 = {}

	for iter_26_3, iter_26_4 in pairs(var_26_4) do
		for iter_26_5, iter_26_6 in pairs(iter_26_4) do
			table.insert(var_26_5, {
				type = iter_26_3,
				id = iter_26_5,
				quantity = iter_26_6
			})
		end
	end

	return arg_26_0:_generateItemListJson(var_26_5)
end

function var_0_0._generateItemListJson(arg_27_0, arg_27_1)
	if not arg_27_1 or #arg_27_1 <= 0 then
		return {}
	end

	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		local var_27_1 = ItemModel.instance:getItemConfig(iter_27_1.type, iter_27_1.id)

		table.insert(var_27_0, {
			materialname = var_27_1 and var_27_1.name or "",
			materialtype = iter_27_1.type,
			materialnum = iter_27_1.quantity
		})
	end

	return var_27_0
end

function var_0_0.isNeedShowRedDotNewTag(arg_28_0, arg_28_1)
	return arg_28_1 and arg_28_1.type == 0 and not string.nilorempty(arg_28_1.onlineTime)
end

function var_0_0.initEnteredRecommendStoreList(arg_29_0)
	local var_29_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()
	local var_29_1 = PlayerPrefsHelper.getString(var_29_0, "")

	if string.nilorempty(var_29_1) then
		arg_29_0.enteredRecommendStoreIdList = {}

		return
	end

	arg_29_0.enteredRecommendStoreIdList = string.splitToNumber(var_29_1, ";")
end

function var_0_0.enterRecommendStore(arg_30_0, arg_30_1)
	if not arg_30_0.enteredRecommendStoreIdList then
		arg_30_0:initEnteredRecommendStoreList()
	end

	if tabletool.indexOf(arg_30_0.enteredRecommendStoreIdList, arg_30_1) then
		return
	end

	table.insert(arg_30_0.enteredRecommendStoreIdList, arg_30_1)
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)

	local var_30_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()

	PlayerPrefsHelper.setString(var_30_0, table.concat(arg_30_0.enteredRecommendStoreIdList, ";"))
end

function var_0_0.isEnteredRecommendStore(arg_31_0, arg_31_1)
	if not arg_31_0.enteredRecommendStoreIdList then
		arg_31_0:initEnteredRecommendStoreList()
	end

	return tabletool.indexOf(arg_31_0.enteredRecommendStoreIdList, arg_31_1)
end

function var_0_0.getRecommendStoreTime(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return
	end

	local var_32_0 = string.nilorempty(arg_32_1.showOnlineTime) and arg_32_1.onlineTime or arg_32_1.showOnlineTime
	local var_32_1 = string.nilorempty(arg_32_1.showOfflineTime) and arg_32_1.offlineTime or arg_32_1.showOfflineTime
	local var_32_2 = TimeUtil.stringToTimestamp(var_32_0) + ServerTime.clientToServerOffset()
	local var_32_3 = TimeUtil.stringToTimestamp(var_32_1) + ServerTime.clientToServerOffset()
	local var_32_4 = tonumber(os.date("%m", var_32_2))
	local var_32_5 = tonumber(os.date("%d", var_32_2))
	local var_32_6 = tonumber(os.date("%H", var_32_2))
	local var_32_7 = string.format("%02d", tonumber(os.date("%M", var_32_2)))
	local var_32_8 = tonumber(os.date("%m", var_32_3))
	local var_32_9 = tonumber(os.date("%d", var_32_3))
	local var_32_10 = tonumber(os.date("%H", var_32_3))
	local var_32_11 = string.format("%02d", tonumber(os.date("%M", var_32_3)))

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime"), {
		var_32_4,
		var_32_5,
		var_32_6,
		var_32_7,
		var_32_8,
		var_32_9,
		var_32_10,
		var_32_11
	})
end

function var_0_0.onUseItemInStore(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return
	end

	if arg_33_1.entry and arg_33_1.entry[1].materialId and (arg_33_1.entry[1].materialId == StoreEnum.NormalRoomTicket or arg_33_1.entry[1].materialId == StoreEnum.TopRoomTicket) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		var_0_0.instance:dispatchEvent(StoreEvent.GoodsModelChanged, tonumber(arg_33_1.targetId))
	end
end

function var_0_0.statOnClickPowerPotion(arg_34_0, arg_34_1)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotion, {
		[StatEnum.EventProperties.WindowName] = arg_34_1
	})
end

function var_0_0.statOnClickPowerPotionJump(arg_35_0, arg_35_1, arg_35_2)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotionJump, {
		[StatEnum.EventProperties.WindowName] = arg_35_1,
		[StatEnum.EventProperties.JumpName] = arg_35_2
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
