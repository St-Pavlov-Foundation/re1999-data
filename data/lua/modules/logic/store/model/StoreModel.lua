module("modules.logic.store.model.StoreModel", package.seeall)

local var_0_0 = class("StoreModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._storeMODict = {}
	arg_1_0._chargeStoreDic = {}
	arg_1_0._allPackageDic = {}
	arg_1_0._chargePackageStoreDic = {}
	arg_1_0._versionChargePackageDict = {}
	arg_1_0._onceTimeChargePackageDict = {}
	arg_1_0._recommendPackageList = {}
	arg_1_0._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = arg_1_0._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = arg_1_0._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = arg_1_0._chargePackageStoreDic
	}
	arg_1_0._curPackageStore = StoreEnum.StoreId.NormalPackage
	arg_1_0.monthCardInfo = nil
	arg_1_0._packageStoreRpcLeftNum = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getStoreInfosReply(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.storeInfos

	if var_3_0 and #var_3_0 > 0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			local var_3_1 = StoreMO.New()

			var_3_1:init(iter_3_1)

			arg_3_0._storeMODict[var_3_1.id] = var_3_1

			if StoreConfig.instance:isPackageStore(var_3_1.id) then
				local var_3_2 = arg_3_0:getCurPackageStore()

				if var_3_2 ~= 0 and var_3_2 == var_3_1.id then
					arg_3_0:updatePackageStoreList(var_3_1.id)
				end
			elseif var_3_1.id == StoreEnum.StoreId.Skin then
				StoreClothesGoodsItemListModel.instance:setMOList(var_3_1:getGoodsList())
			end
		end
	end
end

function var_0_0.buyGoodsReply(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._storeMODict[arg_4_1.storeId]

	if var_4_0 then
		var_4_0:buyGoodsReply(arg_4_1.goodsId, arg_4_1.num)
	end
end

function var_0_0.initChargeInfo(arg_5_0, arg_5_1)
	arg_5_0._chargeStoreDic = {}
	arg_5_0._allPackageDic = {}
	arg_5_0._chargePackageStoreDic = {}
	arg_5_0._versionChargePackageDict = {}
	arg_5_0._onceTimeChargePackageDict = {}
	arg_5_0._skinChargeDict = {}
	arg_5_0._recommendPackageList = {}
	arg_5_0._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = arg_5_0._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = arg_5_0._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = arg_5_0._chargePackageStoreDic,
		[StoreEnum.StoreId.RecommendPackage] = arg_5_0._recommendPackageList
	}

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_1 = StoreConfig.instance:getChargeGoodsConfig(iter_5_1.id, true)

		if var_5_1 then
			if var_5_1.belongStoreId == StoreEnum.StoreId.Charge or var_5_1.belongStoreId == StoreEnum.StoreId.PubbleCharge or var_5_1.belongStoreId == StoreEnum.StoreId.GlowCharge then
				local var_5_2 = StoreChargeGoodsMO.New()

				var_5_2:init(StoreEnum.StoreId.Charge, iter_5_1)

				arg_5_0._chargeStoreDic[iter_5_1.id] = var_5_2
			elseif var_5_1.belongStoreId == StoreEnum.StoreId.Skin then
				table.insert(var_5_0, iter_5_1)
			else
				local var_5_3 = StorePackageGoodsMO.New()

				var_5_3:initCharge(var_5_1.belongStoreId, iter_5_1)

				arg_5_0._allPackageDic[iter_5_1.id] = var_5_3

				if var_5_1.belongStoreId == StoreEnum.StoreId.NormalPackage then
					arg_5_0._chargePackageStoreDic[iter_5_1.id] = var_5_3
				elseif var_5_1.belongStoreId == StoreEnum.StoreId.VersionPackage then
					arg_5_0._versionChargePackageDict[iter_5_1.id] = var_5_3
				elseif var_5_1.belongStoreId == StoreEnum.StoreId.OneTimePackage then
					arg_5_0._onceTimeChargePackageDict[iter_5_1.id] = var_5_3
				end
			end
		end
	end

	arg_5_0:_updateSkinChargePackage(var_5_0)
	arg_5_0:updatePackageStoreList(arg_5_0._curPackageStore)
end

function var_0_0._updateSkinChargePackage(arg_6_0, arg_6_1)
	if not arg_6_0._skinChargeDict then
		arg_6_0._skinChargeDict = {}
	end

	arg_6_1 = arg_6_1 or {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0:_addSkinChargePackage(iter_6_1)
	end

	StoreController.instance:dispatchEvent(StoreEvent.SkinChargePackageUpdate)
end

function var_0_0._addSkinChargePackage(arg_7_0, arg_7_1)
	if not arg_7_0._skinChargeDict then
		arg_7_0._skinChargeDict = {}
	end

	local var_7_0 = StoreSkinChargeMo.New()

	var_7_0:init(StoreEnum.StoreId.Skin, arg_7_1)

	arg_7_0._skinChargeDict[arg_7_1.id] = var_7_0
end

function var_0_0.chargeOrderComplete(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._chargeStoreDic[arg_8_1]

	arg_8_0.updateChargeStore = false

	if var_8_0 == nil then
		if arg_8_1 == StoreEnum.LittleMonthCardGoodsId then
			var_8_0 = arg_8_0._allPackageDic[arg_8_1]
		else
			var_8_0 = arg_8_0._chargePackageStoreDic[arg_8_1] or arg_8_0._versionChargePackageDict[arg_8_1] or arg_8_0._onceTimeChargePackageDict[arg_8_1]
		end
	else
		arg_8_0.updateChargeStore = true
	end

	if var_8_0 then
		var_8_0.buyCount = var_8_0.buyCount + 1

		local var_8_1 = var_8_0.config.id

		if var_8_1 == StoreEnum.MonthCardGoodsId or var_8_1 == StoreEnum.LittleMonthCardGoodsId or var_8_1 == StoreEnum.SeasonCardGoodsId then
			ChargeRpc.instance:sendGetMonthCardInfoRequest(arg_8_0.updateGoodsInfo, arg_8_0)
		else
			arg_8_0:updateGoodsInfo()
		end
	end
end

function var_0_0.updateGoodsInfo(arg_9_0)
	if arg_9_0.updateChargeStore then
		local var_9_0 = arg_9_0:getCurChargetStoreId()

		StoreChargeGoodsItemListModel.instance:setMOList(arg_9_0._chargeStoreDic, var_9_0)
	else
		arg_9_0:updatePackageStoreList(arg_9_0._curPackageStore)
	end
end

function var_0_0.getCurChargetStoreId(arg_10_0)
	return arg_10_0._curChargeStoreId or 0
end

function var_0_0.setCurChargeStoreId(arg_11_0, arg_11_1)
	arg_11_0._curChargeStoreId = arg_11_1
end

function var_0_0.setCurPackageStore(arg_12_0, arg_12_1)
	arg_12_0._curPackageStore = arg_12_1
end

function var_0_0.getCurPackageStore(arg_13_0)
	return arg_13_0._curPackageStore or 0
end

function var_0_0.setPackageStoreRpcNum(arg_14_0, arg_14_1)
	arg_14_0._packageStoreRpcLeftNum = arg_14_1
end

function var_0_0.setCurBuyPackageId(arg_15_0, arg_15_1)
	arg_15_0._curBuyPackageId = arg_15_1
end

function var_0_0.getCurBuyPackageId(arg_16_0)
	return arg_16_0._curBuyPackageId
end

function var_0_0.updatePackageStoreList(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 or StoreEnum.StoreId.Package

	arg_17_0._packageStoreRpcLeftNum = arg_17_0._packageStoreRpcLeftNum - 1

	if arg_17_0._packageStoreRpcLeftNum < 1 then
		if not arg_17_1 or arg_17_1 == StoreEnum.StoreId.RecommendPackage then
			local var_17_1 = arg_17_0:getRecommendPackageList(true)

			StorePackageGoodsItemListModel.instance:setMOList(nil, var_17_1)
		else
			local var_17_2 = arg_17_0._packageType2GoodsDict[arg_17_1]

			StorePackageGoodsItemListModel.instance:setMOList(arg_17_0:getStoreMO(var_17_0), var_17_2)
		end

		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end
end

function var_0_0.getStoreMO(arg_18_0, arg_18_1)
	return arg_18_0._storeMODict[arg_18_1]
end

function var_0_0.getGoodsMO(arg_19_0, arg_19_1)
	if arg_19_0._allPackageDic[arg_19_1] then
		return arg_19_0._allPackageDic[arg_19_1]
	else
		for iter_19_0, iter_19_1 in pairs(arg_19_0._storeMODict) do
			local var_19_0 = iter_19_1:getGoodsMO(arg_19_1)

			if var_19_0 then
				return var_19_0
			end
		end
	end
end

function var_0_0.getChargeGoods(arg_20_0)
	return arg_20_0._chargeStoreDic
end

function var_0_0.getChargeGoodsMo(arg_21_0, arg_21_1)
	return arg_21_0._chargeStoreDic[arg_21_1]
end

function var_0_0.isStoreSkinChargePackageValid(arg_22_0, arg_22_1)
	local var_22_0 = false
	local var_22_1 = StoreConfig.instance:getSkinChargeGoodsId(arg_22_1)

	if arg_22_0._skinChargeDict and arg_22_0._skinChargeDict[var_22_1] then
		var_22_0 = true
	end

	return var_22_0
end

function var_0_0.isStoreDecorateGoodsValid(arg_23_0, arg_23_1)
	local var_23_0 = false
	local var_23_1 = StoreConfig.instance:getDecorateGoodsIdById(arg_23_1)

	if arg_23_0:getGoodsMO(var_23_1) then
		var_23_0 = true
	end

	return var_23_0
end

function var_0_0.getRecommendPackageList(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return arg_24_0._recommendPackageList
	end

	arg_24_0._recommendPackageList = {}

	local var_24_0 = CommonConfig.instance:getConstNum(ConstEnum.RecommendStoreCount) or 5

	if var_24_0 == 0 then
		return arg_24_0._recommendPackageList
	end

	local var_24_1 = {}
	local var_24_2 = arg_24_0:getPackageGoodList(StoreEnum.StoreId.VersionPackage)
	local var_24_3 = arg_24_0:getPackageGoodList(StoreEnum.StoreId.OneTimePackage)
	local var_24_4 = arg_24_0:getPackageGoodList(StoreEnum.StoreId.NormalPackage)

	for iter_24_0, iter_24_1 in pairs(var_24_2) do
		var_24_1[#var_24_1 + 1] = iter_24_1
	end

	for iter_24_2, iter_24_3 in pairs(var_24_3) do
		var_24_1[#var_24_1 + 1] = iter_24_3
	end

	for iter_24_4, iter_24_5 in pairs(var_24_4) do
		var_24_1[#var_24_1 + 1] = iter_24_5
	end

	if #var_24_1 > 1 then
		table.sort(var_24_1, arg_24_0._packageSortFunction)
	end

	local var_24_5 = 1

	for iter_24_6 = 1, #var_24_1 do
		local var_24_6 = var_24_1[iter_24_6]

		if arg_24_0:checkShowInRecommand(var_24_6, var_24_6.isChargeGoods) then
			arg_24_0._recommendPackageList[var_24_5] = var_24_6

			if var_24_5 == var_24_0 then
				break
			end

			var_24_5 = var_24_5 + 1
		end
	end

	return arg_24_0._recommendPackageList
end

function var_0_0.isGoodInRecommendList(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getRecommendPackageList(false)

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1.goodsId == arg_25_1 then
			return true
		end
	end
end

function var_0_0.getPackageGoodList(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = arg_26_0._packageType2GoodsDict[arg_26_1]

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		var_26_0[iter_26_1.id] = iter_26_1
	end

	local var_26_2 = arg_26_0:getStoreMO(arg_26_1)

	if var_26_2 then
		local var_26_3 = var_26_2:getGoodsList()

		for iter_26_2, iter_26_3 in pairs(var_26_3) do
			local var_26_4 = StorePackageGoodsMO.New()

			var_26_4:init(arg_26_1, iter_26_3.goodsId, iter_26_3.buyCount, iter_26_3.offlineTime)

			var_26_0[iter_26_3.goodsId] = var_26_4
		end
	end

	return var_26_0
end

function var_0_0.getPackageGoodValidList(arg_27_0, arg_27_1)
	local var_27_0 = {}

	if arg_27_1 == StoreEnum.StoreId.RecommendPackage then
		var_27_0 = arg_27_0:getRecommendPackageList(true)
	else
		local var_27_1 = arg_27_0:getPackageGoodList(arg_27_1)

		for iter_27_0, iter_27_1 in pairs(var_27_1) do
			if arg_27_0:checkValid(iter_27_1, iter_27_1.isChargeGoods) then
				var_27_0[#var_27_0 + 1] = iter_27_1
			end
		end
	end

	return var_27_0
end

function var_0_0.checkValid(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or false

	local var_28_0 = true

	if arg_28_1:isSoldOut() then
		if arg_28_2 and arg_28_1.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			var_28_0 = false
		end

		if arg_28_2 == false and arg_28_1.config.refreshTime == StoreEnum.RefreshTime.Forever then
			var_28_0 = false
		end
	end

	var_28_0 = var_28_0 and arg_28_0:checkPreGoodsId(arg_28_1.config.preGoodsId)

	return var_28_0
end

function var_0_0.checkShowInRecommand(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1.config.notShowInRecommend then
		return false
	end

	if arg_29_1.config.id == StoreEnum.MonthCardGoodsId then
		if not arg_29_0:hasPurchaseMonthCard() then
			return true
		else
			return not var_0_0.instance:IsMonthCardDaysEnough()
		end
	end

	arg_29_2 = arg_29_2 or false

	local var_29_0 = true

	if arg_29_1:isSoldOut() then
		var_29_0 = false
	end

	var_29_0 = var_29_0 and arg_29_0:checkPreGoodsId(arg_29_1.config.preGoodsId)

	return var_29_0
end

function var_0_0.checkPreGoodsId(arg_30_0, arg_30_1)
	if arg_30_1 == 0 then
		return true
	end

	local var_30_0 = arg_30_0:getGoodsMO(arg_30_1)

	return var_30_0 and var_30_0:isSoldOut()
end

function var_0_0.getBuyCount(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0._storeMODict[arg_31_1]

	if not var_31_0 then
		return 0
	end

	return var_31_0:getBuyCount(arg_31_2)
end

function var_0_0.isTabMainRedDotShow(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getAllRedDotInfo()

	if var_32_0 then
		for iter_32_0, iter_32_1 in pairs(var_32_0) do
			local var_32_1
			local var_32_2 = false
			local var_32_3 = arg_32_0:getGoodsMO(iter_32_1.uid)

			if var_32_3 then
				var_32_1 = StoreConfig.instance:getTabConfig(var_32_3.belongStoreId)
			else
				var_32_1 = StoreConfig.instance:getTabConfig(iter_32_1.uid)
				var_32_2 = true
			end

			if var_32_1 then
				local var_32_4 = var_32_1.belongFirstTab

				if var_32_4 == 0 then
					local var_32_5 = var_32_1.belongSecondTab

					if var_32_5 ~= 0 then
						var_32_4 = StoreConfig.instance:getTabConfig(var_32_5).belongFirstTab
					end
				end

				if var_32_4 == 0 then
					var_32_4 = var_32_1.id
				end

				if iter_32_1.value > 0 and arg_32_1 == var_32_4 then
					return true, var_32_2
				end
			end
		end
	end

	return false
end

function var_0_0.isTabFirstRedDotShow(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getAllRedDotInfo()

	if var_33_0 then
		for iter_33_0, iter_33_1 in pairs(var_33_0) do
			local var_33_1 = arg_33_0:getGoodsMO(iter_33_1.uid)

			if var_33_1 then
				local var_33_2 = var_33_1.goodsId
				local var_33_3 = arg_33_1 == StoreEnum.StoreId.RecommendPackage
				local var_33_4 = var_33_1.refreshTime == StoreEnum.ChargeRefreshTime.Month
				local var_33_5 = var_33_1.refreshTime == StoreEnum.ChargeRefreshTime.Week

				if var_33_3 and arg_33_0:isGoodInRecommendList(var_33_2) and not var_33_5 and not var_33_4 then
					return true
				else
					local var_33_6 = StoreConfig.instance:getTabConfig(var_33_1.belongStoreId).belongSecondTab

					if iter_33_1.value > 0 and arg_33_1 == var_33_6 then
						return true
					end
				end
			end

			if iter_33_1.value > 0 and iter_33_1.uid == arg_33_1 then
				return true, true
			end
		end
	end

	return false
end

function var_0_0.isTabSecondRedDotShow(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getAllRedDotInfo()

	if var_34_0 then
		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			local var_34_1 = arg_34_0:getGoodsMO(iter_34_1.uid)

			if var_34_1 and iter_34_1.value > 0 and arg_34_1 == var_34_1.belongStoreId then
				return true
			end
		end
	end

	return false
end

function var_0_0.isPackageStoreTabRedDotShow(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getAllRedDotInfo()

	if var_35_0 then
		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			local var_35_1 = arg_35_0:getGoodsMO(iter_35_1.uid)

			if var_35_1 then
				local var_35_2 = var_35_1.goodsId

				if arg_35_1 == StoreEnum.StoreId.RecommendPackage and arg_35_0:isGoodInRecommendList(var_35_2) then
					return true
				elseif iter_35_1.value > 0 and arg_35_1 == var_35_1.belongStoreId then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.getAllRedDotInfo(arg_36_0)
	local var_36_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab)
	local var_36_1 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)
	local var_36_2 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)
	local var_36_3 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a6FurnaceTreasure)
	local var_36_4 = {}

	if var_36_0 then
		for iter_36_0, iter_36_1 in pairs(var_36_0.infos) do
			table.insert(var_36_4, iter_36_1)
		end
	end

	if var_36_1 then
		for iter_36_2, iter_36_3 in pairs(var_36_1.infos) do
			table.insert(var_36_4, iter_36_3)
		end
	end

	if var_36_2 then
		for iter_36_4, iter_36_5 in pairs(var_36_2.infos) do
			table.insert(var_36_4, iter_36_5)
		end
	end

	if var_36_3 then
		for iter_36_6, iter_36_7 in pairs(var_36_3.infos) do
			table.insert(var_36_4, iter_36_7)
		end
	end

	return var_36_4
end

function var_0_0.isGoodsItemRedDotShow(arg_37_0, arg_37_1)
	local var_37_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab)

	if var_37_0 then
		local var_37_1 = var_37_0.infos

		for iter_37_0, iter_37_1 in pairs(var_37_1) do
			if iter_37_1.uid == arg_37_1 and iter_37_1.value > 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isStoreTabLock(arg_38_0, arg_38_1)
	local var_38_0 = StoreConfig.instance:getStoreConfig(arg_38_1)

	if var_38_0 and var_38_0.needClearStore > 0 then
		local var_38_1 = arg_38_0._storeMODict[var_38_0.needClearStore].goodsInfos

		for iter_38_0, iter_38_1 in pairs(var_38_1) do
			if iter_38_1.goodsId then
				local var_38_2 = StoreConfig.instance:getGoodsConfig(iter_38_1.goodsId)

				if var_38_2 and iter_38_1.buyCount < var_38_2.maxBuyCount then
					return true
				end
			end
		end
	end

	return false
end

var_0_0.ignoreStoreTab = {
	StoreEnum.BossRushStore,
	StoreEnum.TowerStore
}

function var_0_0.checkContainIgnoreStoreTab(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.ignoreStoreTab) do
		if LuaUtil.tableContains(iter_39_1, arg_39_1) then
			return true
		end
	end

	return false
end

function var_0_0.getFirstTabs(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(lua_store_entrance.configList) do
		if not StoreConfig.instance:hasTab(iter_40_1.belongFirstTab) and not StoreConfig.instance:hasTab(iter_40_1.belongSecondTab) then
			local var_40_1 = arg_40_0:checkContainIgnoreStoreTab(iter_40_1.id)

			if iter_40_1.id == StoreEnum.StoreId.DecorateStore and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) == 0 and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.OldDecorateStore) == 0 then
				var_40_1 = true
			end

			if not var_40_1 and (not arg_40_1 or arg_40_0:isTabOpen(iter_40_1.id)) then
				table.insert(var_40_0, iter_40_1)
			end
		end
	end

	if arg_40_2 and #var_40_0 > 1 then
		table.sort(var_40_0, arg_40_0._tabSortFunction)
	end

	return var_40_0
end

function var_0_0.getSecondTabs(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(iter_41_1.belongFirstTab) and iter_41_1.belongFirstTab == arg_41_1 and (not arg_41_2 or arg_41_0:isTabOpen(iter_41_1.id)) then
			table.insert(var_41_0, iter_41_1)
		end
	end

	if arg_41_3 and #var_41_0 > 1 then
		table.sort(var_41_0, arg_41_0._tabSortFunction)
	end

	return var_41_0
end

function var_0_0.getRecommendSecondTabs(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(iter_42_1.belongFirstTab) and iter_42_1.belongFirstTab == arg_42_1 and (not arg_42_2 or arg_42_0:isTabOpen(iter_42_1.id)) then
			table.insert(var_42_0, iter_42_1)
		end
	end

	for iter_42_2, iter_42_3 in ipairs(lua_store_recommend.configList) do
		if iter_42_3.type == 0 then
			table.insert(var_42_0, iter_42_3)
		end
	end

	return var_42_0
end

function var_0_0.getThirdTabs(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(iter_43_1.belongSecondTab) and iter_43_1.belongSecondTab == arg_43_1 and (not arg_43_2 or arg_43_0:isTabOpen(iter_43_1.id)) then
			table.insert(var_43_0, iter_43_1)
		end
	end

	if arg_43_3 and #var_43_0 > 1 then
		table.sort(var_43_0, arg_43_0._tabSortFunction)
	end

	return var_43_0
end

function var_0_0.isTabOpen(arg_44_0, arg_44_1)
	local var_44_0 = StoreConfig.instance:getTabConfig(arg_44_1)

	if var_44_0 then
		if var_44_0.openId and var_44_0.openId ~= 0 and not OpenModel.instance:isFunctionUnlock(var_44_0.openId) then
			return false
		end

		if var_44_0.openHideId and var_44_0.openHideId ~= 0 and OpenModel.instance:isFunctionUnlock(var_44_0.openHideId) then
			return false
		end

		local var_44_1
		local var_44_2

		if not string.nilorempty(var_44_0.openTime) then
			var_44_1 = TimeUtil.stringToTimestamp(var_44_0.openTime)
		end

		if not string.nilorempty(var_44_0.endTime) then
			var_44_2 = TimeUtil.stringToTimestamp(var_44_0.endTime)
		end

		if string.nilorempty(var_44_0.openTime) and string.nilorempty(var_44_0.endTime) then
			-- block empty
		elseif string.nilorempty(var_44_0.endTime) then
			if var_44_1 >= ServerTime.now() then
				return false
			end
		elseif string.nilorempty(var_44_0.openTime) then
			if var_44_2 <= ServerTime.now() then
				return false
			end
		else
			local var_44_3 = var_44_1
			local var_44_4 = var_44_2

			if StoreConfig.instance:getOpenTimeDiff(var_44_3, var_44_4, ServerTime.now()) <= 0 then
				return false
			end
		end

		if var_44_0.storeId == StoreEnum.StoreId.Package and GameFacade.isKOLTest() then
			return false
		end

		if StoreConfig.instance:getTabHierarchy(var_44_0.id) == 2 then
			if var_44_0.storeId and var_44_0.storeId ~= 0 then
				return true
			else
				local var_44_5 = arg_44_0:getThirdTabs(var_44_0.id, true, false)

				if var_44_5 and #var_44_5 > 0 then
					return true
				end
			end
		else
			return true
		end
	end

	return false
end

function var_0_0._tabSortFunction(arg_45_0, arg_45_1)
	return arg_45_0.order > arg_45_1.order
end

function var_0_0._packageSortFunction(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.config
	local var_46_1 = arg_46_1.config

	return var_46_0.order < var_46_1.order
end

function var_0_0.jumpTabIdToSelectTabId(arg_47_0, arg_47_1)
	local var_47_0 = 0
	local var_47_1 = 0
	local var_47_2 = 0
	local var_47_3 = StoreConfig.instance:getTabHierarchy(arg_47_1)

	if var_47_3 == 3 then
		var_47_2 = arg_47_1

		local var_47_4 = StoreConfig.instance:getTabConfig(var_47_2)

		var_47_1 = var_47_4 and var_47_4.belongSecondTab or 0

		local var_47_5 = StoreConfig.instance:getTabConfig(var_47_1)

		var_47_0 = var_47_5 and var_47_5.belongFirstTab or 0
	elseif var_47_3 == 2 then
		var_47_1 = arg_47_1

		local var_47_6 = arg_47_0:getThirdTabs(var_47_1, true, true)

		if var_47_6 and #var_47_6 > 0 then
			var_47_2 = var_47_6[1].id
		end

		local var_47_7 = StoreConfig.instance:getTabConfig(var_47_1)

		var_47_0 = var_47_7 and var_47_7.belongFirstTab or 0
	else
		var_47_0 = arg_47_1

		local var_47_8 = arg_47_0:getSecondTabs(var_47_0, true, true)

		if var_47_0 == StoreEnum.StoreId.Package then
			for iter_47_0 = 1, #var_47_8 do
				if #arg_47_0:getPackageGoodValidList(var_47_8[iter_47_0].id) > 0 then
					var_47_1 = var_47_8[iter_47_0].id

					break
				end
			end

			var_47_2 = 0
		elseif var_47_0 == StoreEnum.StoreId.DecorateStore then
			for iter_47_1 = 1, #var_47_8 do
				if #DecorateStoreModel.instance:getDecorateGoodList(var_47_8[iter_47_1].id) > 0 then
					var_47_1 = var_47_8[iter_47_1].id

					break
				end
			end

			var_47_2 = 0
		elseif var_47_8 and #var_47_8 > 0 then
			var_47_1 = var_47_8[1].id

			local var_47_9 = arg_47_0:getThirdTabs(var_47_1, true, true)

			if var_47_9 and #var_47_9 > 0 then
				var_47_2 = var_47_9[1].id
			end
		else
			var_47_1 = var_47_0
		end
	end

	return var_47_0, var_47_1, var_47_2
end

function var_0_0.jumpTabIdToStoreId(arg_48_0, arg_48_1)
	local var_48_0 = 0
	local var_48_1, var_48_2, var_48_3 = arg_48_0:jumpTabIdToSelectTabId(arg_48_1)
	local var_48_4 = StoreConfig.instance:getTabConfig(var_48_3)
	local var_48_5 = StoreConfig.instance:getTabConfig(var_48_2)
	local var_48_6 = StoreConfig.instance:getTabConfig(var_48_1)
	local var_48_7 = var_48_4 and var_48_4.storeId or 0

	if var_48_7 == 0 then
		var_48_7 = var_48_5 and var_48_5.storeId or 0
	end

	if var_48_7 == 0 then
		var_48_7 = var_48_6 and var_48_6.storeId or 0
	end

	return var_48_7
end

function var_0_0.updateMonthCardInfo(arg_49_0, arg_49_1)
	if arg_49_1 then
		if arg_49_0.monthCardInfo then
			arg_49_0.monthCardInfo:update(arg_49_1)
		else
			arg_49_0.monthCardInfo = StoreMonthCardInfoMO.New()

			arg_49_0.monthCardInfo:init(arg_49_1)
		end
	end
end

function var_0_0.getMonthCardInfo(arg_50_0)
	return arg_50_0.monthCardInfo
end

function var_0_0.hasPurchaseMonthCard(arg_51_0)
	return arg_51_0.monthCardInfo ~= nil
end

function var_0_0.IsMonthCardDaysEnough(arg_52_0)
	local var_52_0 = false

	if arg_52_0:hasPurchaseMonthCard() then
		var_52_0 = arg_52_0:getMonthCardInfo():getRemainDay() > CommonConfig.instance:getConstNum(ConstEnum.MonthCardPurchaseRemindDay)
	end

	return var_52_0
end

function var_0_0.getCostStr(arg_53_0, arg_53_1)
	return "¥", arg_53_1
end

function var_0_0.getCostSymbolAndPrice(arg_54_0, arg_54_1)
	local var_54_0 = StoreConfig.instance:getChargeGoodsConfig(arg_54_1)

	return "¥", var_54_0.price
end

function var_0_0.checkTabShowNewTag(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:getStoreMO(arg_55_1)

	if var_55_0 then
		local var_55_1 = var_55_0:getGoodsList()

		for iter_55_0, iter_55_1 in pairs(var_55_1) do
			if iter_55_1:needShowNew() then
				return true
			end
		end
	end

	return false
end

function var_0_0.setNewRedDotKey(arg_56_0, arg_56_1)
	local var_56_0 = PlayerPrefsKey.StoreViewShowNew .. arg_56_1

	GameUtil.playerPrefsSetStringByUserId(var_56_0, arg_56_1)
end

function var_0_0.checkShowNewRedDot(arg_57_0, arg_57_1)
	local var_57_0 = PlayerPrefsKey.StoreViewShowNew .. arg_57_1

	if GameUtil.playerPrefsGetStringByUserId(var_57_0, nil) then
		return false
	end

	return true
end

function var_0_0.isSkinGoodsCanRepeatBuy(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_1

	if not var_58_0 then
		return false
	end

	local var_58_1 = arg_58_2 == nil

	if arg_58_2 == nil then
		arg_58_2 = string.splitToNumber(var_58_0.config.product, "#")[2]
	end

	local var_58_2 = SkinConfig.instance:getSkinCo(arg_58_2)

	if not var_58_2 then
		return false
	end

	local var_58_3 = var_58_0.config.storeId
	local var_58_4 = var_58_2.unavailableStore

	if not string.nilorempty(var_58_4) then
		local var_58_5 = string.split(var_58_4, "#")

		for iter_58_0, iter_58_1 in ipairs(var_58_5 or {}) do
			if var_58_3 == iter_58_1 then
				return false
			end
		end
	end

	if string.nilorempty(var_58_2.repeatBuyTime) then
		return false
	end

	if ServerTime.now() > TimeUtil.stringToTimestamp(var_58_2.repeatBuyTime) then
		return false
	end

	local var_58_6 = var_58_0:isSoldOut()

	if not var_58_6 and var_58_1 then
		local var_58_7 = StoreConfig.instance:getSkinChargeGoodsId(arg_58_2)

		if var_58_7 then
			local var_58_8 = arg_58_0._skinChargeDict[var_58_7]

			var_58_6 = var_58_8 and var_58_8:isSoldOut()
		end
	end

	return HeroModel.instance:checkHasSkin(arg_58_2) and not var_58_6
end

function var_0_0.isSkinCanShowMessageBox(arg_59_0, arg_59_1)
	if not arg_59_1 then
		return
	end

	local var_59_0 = lua_skin.configDict[arg_59_1]

	if not var_59_0 then
		return
	end

	local var_59_1 = ServerTime.now()

	if not string.nilorempty(var_59_0.repeatBuyTime) and var_59_1 > TimeUtil.stringToTimestamp(var_59_0.repeatBuyTime) then
		return
	end

	local var_59_2 = var_59_0.skinStoreId

	if var_59_2 == 0 then
		return
	end

	local var_59_3 = arg_59_0:getGoodsMO(var_59_2)

	if not var_59_3 then
		return
	end

	local var_59_4 = var_59_3.config
	local var_59_5 = string.nilorempty(var_59_4.onlineTime) and var_59_1 or TimeUtil.stringToTimestamp(var_59_4.onlineTime) - ServerTime.clientToServerOffset()
	local var_59_6 = string.nilorempty(var_59_4.offlineTime) and var_59_1 or TimeUtil.stringToTimestamp(var_59_4.offlineTime) - ServerTime.clientToServerOffset()

	if var_59_4.isOnline and var_59_5 <= var_59_1 and var_59_1 <= var_59_6 and not var_59_3:isSoldOut() then
		local var_59_7 = PlayerPrefsKey.SkinCanShowMessageBox
		local var_59_8 = GameUtil.playerPrefsGetStringByUserId(var_59_7, "")
		local var_59_9 = string.splitToNumber(var_59_8, "#")

		if not (tabletool.indexOf(var_59_9, arg_59_1) ~= nil) then
			table.insert(var_59_9, arg_59_1)
			GameUtil.playerPrefsSetStringByUserId(var_59_7, table.concat(var_59_9, "#"))

			return true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
