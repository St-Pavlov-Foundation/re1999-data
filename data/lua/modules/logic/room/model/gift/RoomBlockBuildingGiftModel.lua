module("modules.logic.room.model.gift.RoomBlockBuildingGiftModel", package.seeall)

local var_0_0 = class("RoomBlockBuildingGiftModel", BaseModel)

function var_0_0.init(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0._selectSubType = nil
	arg_3_0._selectMo = nil
	arg_3_0._themeFilterList = nil

	RoomThemeFilterListModel.instance:clear()
end

function var_0_0.initRoomBlocks(arg_4_0)
	arg_4_0._roomBlocks = {}
	arg_4_0._goodsIds = {}

	local var_4_0 = StoreModel.instance:getStoreMO(StoreEnum.StoreId.OldRoomStore)

	if var_4_0 then
		local var_4_1 = var_4_0:getGoodsList(true)

		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			local var_4_2 = iter_4_1.config.product

			if string.nilorempty(iter_4_1.config.bigImg) then
				local var_4_3 = GameUtil.splitString2(var_4_2, true)

				for iter_4_2, iter_4_3 in pairs(var_4_3) do
					local var_4_4 = ItemModel.instance:getItemConfig(iter_4_3[1], iter_4_3[2])
					local var_4_5 = var_4_4.rare

					if not arg_4_0._roomBlocks[var_4_5] then
						arg_4_0._roomBlocks[var_4_5] = {}
					end

					iter_4_3[3] = 1

					if not arg_4_0:_isContains(iter_4_3, var_4_5) then
						table.insert(arg_4_0._roomBlocks[var_4_5], iter_4_3)
					end

					arg_4_0._goodsIds[var_4_4.id] = iter_4_1.goodsId
				end
			end
		end
	end
end

function var_0_0._isContains(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._roomBlocks or not arg_5_0._roomBlocks[arg_5_2] then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._roomBlocks[arg_5_2]) do
		if arg_5_1[1] == iter_5_1[1] and arg_5_1[2] == iter_5_1[2] then
			return true
		end
	end
end

function var_0_0.getGiftlocks(arg_6_0, arg_6_1)
	arg_6_0:initRoomBlocks()

	local var_6_0 = arg_6_0:getRoomRareBlocks(arg_6_1)

	table.sort(var_6_0, arg_6_0._sortBlocks)

	return var_6_0
end

function var_0_0.getRoomRareBlocks(arg_7_0, arg_7_1)
	if not arg_7_0._roomBlocks then
		arg_7_0:initRoomBlocks()
	end

	local var_7_0 = {}

	for iter_7_0 = arg_7_1, 1, -1 do
		tabletool.addValues(var_7_0, arg_7_0._roomBlocks[iter_7_0])
	end

	return var_7_0
end

function var_0_0._sortBlocks(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0[1]
	local var_8_1 = arg_8_0[2]
	local var_8_2 = arg_8_1[1]
	local var_8_3 = arg_8_1[2]
	local var_8_4 = ItemModel.instance:getItemConfig(var_8_0, var_8_1)
	local var_8_5 = ItemModel.instance:getItemConfig(var_8_2, var_8_3)

	if var_8_4.rare ~= var_8_5.rare then
		return var_8_4.rare > var_8_5.rare
	end

	if var_8_0 ~= var_8_2 then
		return var_8_0 == RoomBlockGiftEnum.SubType[2]
	end

	if var_8_0 == RoomBlockGiftEnum.SubType[2] then
		local var_8_6 = RoomConfig.instance:getBuildingConfig(var_8_1)
		local var_8_7 = RoomConfig.instance:getBuildingConfig(var_8_3)
		local var_8_8 = RoomConfig.instance:getBuildingAreaConfig(var_8_6.areaId)
		local var_8_9 = RoomConfig.instance:getBuildingAreaConfig(var_8_7.areaId)

		if var_8_8.occupy ~= var_8_9.occupy then
			return var_8_8.occupy > var_8_9.occupy
		end
	else
		local var_8_10 = RoomConfig.instance:getBlockListByPackageId(var_8_1)
		local var_8_11 = var_8_10 and #var_8_10 or 0
		local var_8_12 = RoomConfig.instance:getBlockListByPackageId(var_8_3)
		local var_8_13 = var_8_12 and #var_8_12 or 0

		if var_8_4.rare ~= var_8_5.rare then
			return var_8_13 < var_8_11
		end
	end

	return var_8_3 < var_8_1
end

function var_0_0.initRoomRareTypeBlocks(arg_9_0, arg_9_1)
	arg_9_0._isAllColloct = {}

	for iter_9_0, iter_9_1 in pairs(RoomBlockGiftEnum.SubType) do
		local var_9_0 = arg_9_0:getRoomRareBlocks(arg_9_1)

		if not arg_9_0._roomTypeBlockIds then
			arg_9_0._roomTypeBlockIds = {}
		end

		if not arg_9_0._roomTypeBlockIds[arg_9_1] then
			arg_9_0._roomTypeBlockIds[arg_9_1] = {}
		end

		if not arg_9_0._roomTypeBlockIds[arg_9_1][iter_9_1] then
			arg_9_0._roomTypeBlockIds[arg_9_1][iter_9_1] = {}
		end

		if var_9_0 then
			for iter_9_2, iter_9_3 in ipairs(var_9_0) do
				if iter_9_3[1] == iter_9_1 and not LuaUtil.tableContains(arg_9_0._roomTypeBlockIds[arg_9_1][iter_9_1], iter_9_3[2]) then
					table.insert(arg_9_0._roomTypeBlockIds[arg_9_1][iter_9_1], iter_9_3[2])
				end
			end
		end
	end

	local var_9_1 = arg_9_0._roomTypeBlockIds[arg_9_1]

	if var_9_1 then
		for iter_9_4, iter_9_5 in pairs(var_9_1) do
			arg_9_0._isAllColloct[iter_9_4] = arg_9_0:_isAllColloctType(iter_9_4, iter_9_5)
		end
	end
end

function var_0_0.getRoomRareTypeBlocks(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._roomTypeBlockIds or not arg_10_0._roomTypeBlockIds[arg_10_1] then
		return
	end

	return arg_10_0._roomTypeBlockIds[arg_10_1][arg_10_2]
end

function var_0_0.isAllColloct(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(RoomBlockGiftEnum.SubType) do
		if not arg_11_0._isAllColloct[iter_11_1] then
			return false
		end
	end

	return true
end

function var_0_0.isAllColloctBySubType(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1 = arg_12_1 or arg_12_0:getSelectSubType()

	local var_12_0 = arg_12_0._isAllColloct and arg_12_0._isAllColloct[arg_12_1]

	if var_12_0 and arg_12_2 then
		GameFacade.showToast(RoomBlockGiftEnum.SubTypeInfo[arg_12_1].AllColloctToast)
	end

	return var_12_0
end

function var_0_0._isAllColloctType(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		for iter_13_0, iter_13_1 in pairs(arg_13_2) do
			local var_13_0 = ItemModel.instance:getItemQuantity(arg_13_1, iter_13_1)
			local var_13_1 = 1

			if arg_13_1 == RoomBlockGiftEnum.SubType[2] then
				var_13_1 = RoomConfig.instance:getBuildingConfig(iter_13_1).numLimit
			end

			if var_13_0 < var_13_1 then
				return false
			end
		end
	end

	return true
end

function var_0_0.getListModelInstance(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or RoomBlockGiftEnum.SubType[1]

	return RoomBlockGiftEnum.SubTypeInfo[arg_14_1].ListModel.instance
end

function var_0_0.setSelectSubType(arg_15_0, arg_15_1)
	arg_15_0._selectSubType = arg_15_1

	arg_15_0:setThemeList()
	arg_15_0:getListModelInstance(arg_15_1):onModelUpdate()
	arg_15_0:isAllColloctBySubType(arg_15_1, true)
end

function var_0_0.getSelectSubType(arg_16_0)
	return arg_16_0._selectSubType or RoomBlockGiftEnum.SubType[1]
end

function var_0_0.clickSortBlockRare(arg_17_0)
	arg_17_0._sortNumType = RoomBlockGiftEnum.SortType.None

	if not arg_17_0._sortRareType then
		arg_17_0._sortRareType = RoomBlockGiftEnum.SortType.Order

		return arg_17_0._sortRareType
	end

	if arg_17_0._sortRareType == RoomBlockGiftEnum.SortType.Order then
		arg_17_0._sortRareType = RoomBlockGiftEnum.SortType.Reverse
	else
		arg_17_0._sortRareType = RoomBlockGiftEnum.SortType.Order
	end

	return arg_17_0._sortRareType
end

function var_0_0.getSortBlockRare(arg_18_0)
	return arg_18_0._sortRareType
end

function var_0_0.clickSortBlockNum(arg_19_0)
	arg_19_0._sortRareType = RoomBlockGiftEnum.SortType.None

	if not arg_19_0._sortNumType then
		arg_19_0._sortNumType = RoomBlockGiftEnum.SortType.Order

		return arg_19_0._sortNumType
	end

	if arg_19_0._sortNumType == RoomBlockGiftEnum.SortType.Order then
		arg_19_0._sortNumType = RoomBlockGiftEnum.SortType.Reverse
	else
		arg_19_0._sortNumType = RoomBlockGiftEnum.SortType.Order
	end

	return arg_19_0._sortNumType
end

function var_0_0.getSortBlockNum(arg_20_0)
	return arg_20_0._sortNumType
end

function var_0_0.getOpenGiftId(arg_21_0)
	return arg_21_0._giftId
end

function var_0_0.onOpenView(arg_22_0)
	arg_22_0._sortNumType = RoomBlockGiftEnum.SortType.None
	arg_22_0._sortRareType = RoomBlockGiftEnum.SortType.Order

	arg_22_0:initSelect()
	arg_22_0:setThemeList()
	arg_22_0:isAllColloctBySubType(arg_22_0._selectSubType, true)
end

function var_0_0.onCloseView(arg_23_0)
	arg_23_0:saveThemeFilter()
end

function var_0_0.initBlockBuilding(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in pairs(RoomBlockGiftEnum.SubType) do
		arg_24_0:getListModelInstance(iter_24_1):setMoList(arg_24_1)
	end

	arg_24_0._giftId = arg_24_2
end

function var_0_0.initSelect(arg_25_0)
	arg_25_0._selectMo = {}

	for iter_25_0, iter_25_1 in pairs(RoomBlockGiftEnum.SubType) do
		arg_25_0:getListModelInstance(iter_25_1):initSelect()
	end
end

function var_0_0.saveThemeFilter(arg_26_0)
	arg_26_0._themeFilterList = RoomThemeFilterListModel.instance:getSelectIdList()
end

function var_0_0.setThemeList(arg_27_0)
	arg_27_0:saveThemeFilter()

	local var_27_0 = arg_27_0:getListModelInstance(arg_27_0._selectSubType)

	var_27_0:setThemeList()

	if arg_27_0._themeFilterList then
		for iter_27_0, iter_27_1 in ipairs(arg_27_0._themeFilterList) do
			if var_27_0:isHasTheme(iter_27_1) then
				RoomThemeFilterListModel.instance:setSelectById(iter_27_1, true)
			end
		end
	end
end

function var_0_0.onSort(arg_28_0)
	arg_28_0:getListModelInstance(arg_28_0._selectSubType):onSort()
end

function var_0_0.getThemeColloctCount(arg_29_0, arg_29_1)
	local var_29_0 = 0

	if arg_29_1 then
		for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
			if iter_29_1:isCollect() then
				var_29_0 = var_29_0 + 1
			end
		end
	end

	return var_29_0
end

function var_0_0.onSelect(arg_30_0, arg_30_1)
	if not arg_30_0._selectMo then
		arg_30_0._selectMo = {}
	end

	local var_30_0 = arg_30_1.subType
	local var_30_1 = arg_30_1.id
	local var_30_2 = false
	local var_30_3 = arg_30_0:getListModelInstance(arg_30_0._selectSubType)

	if not arg_30_0:isSelect(arg_30_1) then
		arg_30_0._selectMo.subType = var_30_0
		arg_30_0._selectMo.id = var_30_1
		var_30_2 = true
	else
		if arg_30_0._selectMo then
			local var_30_4 = var_30_3:getById(arg_30_0._selectMo.id)

			var_30_3:onSelect(var_30_4, false)
		end

		arg_30_0._selectMo = {}
	end

	var_30_3:onSelect(arg_30_1, var_30_2)

	return var_30_2
end

function var_0_0.isSelect(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.subType
	local var_31_1 = arg_31_1.id

	if not arg_31_0._selectMo then
		return
	end

	return arg_31_0._selectMo.subType == var_31_0 and arg_31_0._selectMo.id == var_31_1
end

function var_0_0.getSelectCount(arg_32_0)
	return arg_32_0._selectMo and arg_32_0._selectMo.id and 1 or 0
end

function var_0_0.getSelectByType(arg_33_0, arg_33_1)
	return arg_33_0._selectMo and arg_33_0._selectMo[arg_33_1]
end

function var_0_0.clearSelect(arg_34_0)
	arg_34_0._selectMo = {}
end

function var_0_0.getMaxSelectCount(arg_35_0)
	return 1
end

function var_0_0.getGoodsIds(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = ItemModel.instance:getItemConfig(arg_36_1, arg_36_2)

	return arg_36_0._goodsIds[var_36_0.id]
end

function var_0_0.getSelectGoodsData(arg_37_0)
	local var_37_0 = {}

	if arg_37_0._selectMo then
		local var_37_1 = arg_37_0._selectMo.subType
		local var_37_2 = arg_37_0._selectMo.id

		if var_37_1 and var_37_2 then
			local var_37_3 = arg_37_0:getGoodsIds(var_37_1, var_37_2)

			if var_37_3 then
				local var_37_4 = {
					quantity = 1,
					materialId = arg_37_0:getOpenGiftId()
				}

				table.insert(var_37_0, {
					data = {
						var_37_4
					},
					goodsId = var_37_3
				})
			end
		end
	end

	return var_37_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
