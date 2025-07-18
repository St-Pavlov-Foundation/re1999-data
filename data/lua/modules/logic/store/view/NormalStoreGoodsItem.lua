﻿module("modules.logic.store.view.NormalStoreGoodsItem", package.seeall)

local var_0_0 = class("NormalStoreGoodsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNormalBg = gohelper.findChild(arg_1_0.viewGO, "bg")
	arg_1_0._goActBg = gohelper.findChild(arg_1_0.viewGO, "actBg")
	arg_1_0._goActBgEff = gohelper.findChild(arg_1_0.viewGO, "actBg/mask")
	arg_1_0._gogoods = gohelper.findChild(arg_1_0.viewGO, "#go_goods")
	arg_1_0._goicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_goods/#go_icon")
	arg_1_0._goroomiconmask = gohelper.findChild(arg_1_0.viewGO, "#go_goods/#go_roomiconmask")
	arg_1_0._simageroomicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_goods/#go_roomiconmask/#simage_roomicon")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "#go_goods/#go_num")
	arg_1_0._gonumBg = gohelper.findChild(arg_1_0.viewGO, "#go_goods/#go_num/bg")
	arg_1_0._gonumText = gohelper.findChildText(arg_1_0.viewGO, "#go_goods/#go_num/bg/#txt_num")
	arg_1_0._rare = gohelper.findChildImage(arg_1_0.viewGO, "rare")
	arg_1_0._txtmaterialNum = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_materialNum")
	arg_1_0._imagematerial = gohelper.findChildImage(arg_1_0.viewGO, "cost/txt_materialNum/simage_material")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "layout/txt_remain")
	arg_1_0._txtgoodsName = gohelper.findChildText(arg_1_0.viewGO, "layout/txt_goodsName")
	arg_1_0._gosoldout = gohelper.findChild(arg_1_0.viewGO, "go_soldout")
	arg_1_0._golevellimit = gohelper.findChild(arg_1_0.viewGO, "go_levellimit")
	arg_1_0._txtlvlimit = gohelper.findChildText(arg_1_0.viewGO, "go_levellimit/txt")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "go_has")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_line")
	arg_1_0._goitemreddot = gohelper.findChild(arg_1_0.viewGO, "go_itemreddot")
	arg_1_0._godiscount = gohelper.findChild(arg_1_0.viewGO, "go_tag/#go_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "go_tag/#go_discount/#txt_discount")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_materialNum/txt_originalCost")
	arg_1_0._gooffflineTime = gohelper.findChild(arg_1_0.viewGO, "#go_offflineTime")
	arg_1_0._txtoffflineTime = gohelper.findChildText(arg_1_0.viewGO, "#go_offflineTime/#txt_offflineTime")
	arg_1_0._goRefreshTime = gohelper.findChild(arg_1_0.viewGO, "#go_refreshtime")
	arg_1_0._txtRefreshTime = gohelper.findChildText(arg_1_0.viewGO, "#go_refreshtime/#txt_refreshtime")
	arg_1_0._goroomactive = gohelper.findChild(arg_1_0.viewGO, "#go_roomactive")
	arg_1_0._goroomnum = gohelper.findChild(arg_1_0.viewGO, "#go_roomactive/#go_roomnum")
	arg_1_0._goroomticket = gohelper.findChild(arg_1_0.viewGO, "#go_roomactive/#go_tag")
	arg_1_0._txtroomnum = gohelper.findChildText(arg_1_0.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum")
	arg_1_0._simageroomactiveicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum/#simage_roomactiveicon")
	arg_1_0._txtCost2Num = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_yudiNum")
	arg_1_0._imageCost2 = gohelper.findChildImage(arg_1_0.viewGO, "cost/txt_yudiNum/simage_material")
	arg_1_0._goherofull = gohelper.findChild(arg_1_0.viewGO, "go_herofull")
	arg_1_0._goUnique = gohelper.findChild(arg_1_0.viewGO, "#go_unique")
	arg_1_0._goLimit = gohelper.findChild(arg_1_0.viewGO, "go_tag/#go_limit")
	arg_1_0._goActTag = gohelper.findChild(arg_1_0.viewGO, "go_tag/#go_act")
	arg_1_0._goCost = gohelper.findChild(arg_1_0.viewGO, "cost")
	arg_1_0._goPath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._txtPath = gohelper.findChildText(arg_1_0.viewGO, "#go_path/#txt_path")
	arg_1_0._btnPath = gohelper.findChildButton(arg_1_0.viewGO, "#go_path/btn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.jumpClickRoomChildGoods, arg_2_0._onJumpClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.jumpClickRoomChildGoods, arg_3_0._onJumpClick, arg_3_0)
end

function var_0_0._onJumpClick(arg_4_0, arg_4_1)
	if not arg_4_1 or not arg_4_0._mo then
		return
	end

	if arg_4_1 == arg_4_0._mo.goodsId then
		arg_4_0:_onClick()
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._btnGO = gohelper.findChild(arg_5_0.viewGO, "clickArea")
	arg_5_0._btn = gohelper.getClickWithAudio(arg_5_0._btnGO, AudioEnum.UI.Store_Good_Click)

	arg_5_0._btn:AddClickListener(arg_5_0._onClick, arg_5_0)
	arg_5_0._btnPath:AddClickListener(arg_5_0._onClickPath, arg_5_0)

	arg_5_0._soldout = false
	arg_5_0._limitSold = false
	arg_5_0._hascloth = false

	gohelper.setActive(arg_5_0._goline, false)
	gohelper.setActive(arg_5_0._goUnique, false)

	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._imgicon = gohelper.findChildImage(arg_5_0.viewGO, "#go_goods/#go_icon")
	arg_5_0._gonewtag = gohelper.findChild(arg_5_0.viewGO, "go_newtag")

	arg_5_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnHour, arg_5_0.onHourRefresh, arg_5_0)
end

function var_0_0._onClickPath(arg_6_0)
	if not arg_6_0._mo then
		return
	end

	if arg_6_0._mo:getIsJumpGoods() then
		local var_6_0 = arg_6_0._mo.config.jumpId

		GameFacade.jump(var_6_0)
	end
end

function var_0_0._onClick(arg_7_0)
	if arg_7_0._mo:getIsActGoods() then
		arg_7_0:_onActGoodsClick()
	elseif arg_7_0._mo:getIsJumpGoods() then
		arg_7_0:_onJumpGoodsClick()
	else
		arg_7_0:_onNormalGoodsClick()
	end
end

function var_0_0._onJumpGoodsClick(arg_8_0)
	if arg_8_0._hascloth then
		GameFacade.showToast(ToastEnum.NormalStoreGoodsHasCloth)
	elseif arg_8_0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif arg_8_0._limitSold then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)
	else
		MaterialTipController.instance:showMaterialInfo(arg_8_0._itemType, arg_8_0._itemId)
	end
end

function var_0_0._onNormalGoodsClick(arg_9_0)
	if arg_9_0._hascloth then
		local var_9_0 = ItemModel.instance:getItemConfig(arg_9_0._itemType, arg_9_0._itemId)

		if arg_9_0:_isAlreadyHasIgnoreType(var_9_0.subType) and StoreConfig.instance:getGoodsConfig(arg_9_0._mo.goodsId).maxBuyCount - arg_9_0._mo.buyCount > 0 then
			StoreController.instance:openNormalGoodsView(arg_9_0._mo)

			return
		end

		GameFacade.showToast(ToastEnum.NormalStoreGoodsHasCloth)
	elseif arg_9_0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif arg_9_0._limitSold then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)
	elseif not arg_9_0:_isStoreItemUnlock() then
		arg_9_0._mo.lvlimitchapter = arg_9_0.lvlimitchapter
		arg_9_0._mo.lvlimitepisode = arg_9_0.lvlimitepisode
		arg_9_0._mo.isHardChapter = arg_9_0.isHardChapter

		StoreController.instance:openNormalGoodsView(arg_9_0._mo)
	elseif StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_9_0._mo.goodsId) then
		arg_9_0._mo.limitWeekWalkLayer = StoreConfig.instance:getGoodsConfig(arg_9_0._mo.goodsId).needWeekwalkLayer

		StoreController.instance:openNormalGoodsView(arg_9_0._mo)
	else
		StoreController.instance:openNormalGoodsView(arg_9_0._mo)
	end
end

function var_0_0._isStoreItemUnlock(arg_10_0)
	if arg_10_0._mo:getIsActGoods() then
		return true
	end

	local var_10_0 = StoreConfig.instance:getGoodsConfig(arg_10_0._mo.goodsId).needEpisodeId

	if not var_10_0 or var_10_0 == 0 then
		return true
	end

	if var_10_0 == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_10_0)
end

function var_0_0._onActGoodsClick(arg_11_0)
	if not arg_11_0._mo then
		return
	end

	local var_11_0 = arg_11_0._mo:getActGoodsId()
	local var_11_1 = arg_11_0._mo:getBelongStoreId()

	if FurnaceTreasureModel.instance:getGoodsRemainCount(var_11_1, var_11_0) < FurnaceTreasureEnum.DEFAULT_BUY_COUNT then
		GameFacade.showToast(ToastEnum.CurrencyChanged)

		return
	end

	ViewMgr.instance:openView(ViewName.FurnaceTreasureBuyView, {
		goodsId = var_11_0,
		storeId = var_11_1
	})
end

function var_0_0.onHourRefresh(arg_12_0)
	if arg_12_0._mo:getIsActGoods() then
		return
	end

	local var_12_0 = StoreConfig.instance:getGoodsConfig(arg_12_0._mo.goodsId)

	arg_12_0:refreshNextRefreshTime(var_12_0)
end

function var_0_0.getAnimator(arg_13_0)
	return arg_13_0._animator
end

function var_0_0.hideOffflineTime(arg_14_0)
	arg_14_0._hideOffflineTime = true
end

function var_0_0.onUpdateMO(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	arg_15_0._mo = arg_15_1

	local var_15_0 = arg_15_1:getIsActGoods()

	if var_15_0 then
		arg_15_0:refreshActGoods()
	else
		arg_15_0:refreshNormalGoods()
	end

	gohelper.setActive(arg_15_0._goNormalBg, not var_15_0)
	gohelper.setActive(arg_15_0._goActBg, var_15_0)
	gohelper.setActive(arg_15_0._goActTag, var_15_0)
end

var_0_0.AlreadyHasIgnoreType = {
	ItemEnum.SubType.RoomBlockGift,
	ItemEnum.SubType.RoomBlockGiftNew
}

function var_0_0._isAlreadyHasIgnoreType(arg_16_0, arg_16_1)
	return LuaUtil.tableContains(var_0_0.AlreadyHasIgnoreType, arg_16_1)
end

function var_0_0.refreshNormalGoods(arg_17_0)
	local var_17_0 = arg_17_0._mo
	local var_17_1 = arg_17_0:_isStoreItemUnlock()

	gohelper.setActive(arg_17_0._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(var_17_0.goodsId))
	gohelper.setActive(arg_17_0._golevellimit, not var_17_1)

	if not var_17_1 then
		local var_17_2 = StoreConfig.instance:getGoodsConfig(var_17_0.goodsId).needEpisodeId

		if var_17_2 == StoreEnum.Need4RDEpisodeId then
			arg_17_0._txtlvlimit.text = string.format("%s%s", luaLang("level_limit_4RD_unlock"), luaLang("dungeon_unlock"))
		else
			local var_17_3 = DungeonConfig.instance:getEpisodeCO(var_17_2)
			local var_17_4 = DungeonConfig.instance:getChapterCO(var_17_3.chapterId)
			local var_17_5 = "dungeon_main_unlock"

			arg_17_0.isHardChapter = false

			if var_17_4 and var_17_4.type == DungeonEnum.ChapterType.Hard then
				var_17_3 = DungeonConfig.instance:getEpisodeCO(var_17_3.preEpisode)
				var_17_4 = DungeonConfig.instance:getChapterCO(var_17_3.chapterId)
				var_17_5 = "dungeon_main_hard_unlock"
				arg_17_0.isHardChapter = true
			end

			local var_17_6
			local var_17_7
			local var_17_8

			if var_17_3 and var_17_4 then
				var_17_6 = var_17_4.chapterIndex

				local var_17_9

				var_17_7, var_17_9 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_17_4.id, var_17_3.id)

				if type == DungeonEnum.EpisodeType.Sp then
					var_17_6 = "SP"
				end
			end

			arg_17_0._txtlvlimit.text = string.format(luaLang(var_17_5), string.format("%s-%s", var_17_6, var_17_7))
			arg_17_0.lvlimitchapter = var_17_6
			arg_17_0.lvlimitepisode = var_17_7
		end
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(var_17_0.goodsId) then
		gohelper.setActive(arg_17_0._golevellimit, true)

		local var_17_10 = StoreConfig.instance:getGoodsConfig(var_17_0.goodsId).needWeekwalkLayer

		arg_17_0._txtlvlimit.text = string.format(luaLang("dungeon_weekwalk_unlock"), var_17_10)
	end

	local var_17_11 = StoreConfig.instance:getGoodsConfig(var_17_0.goodsId)

	arg_17_0:updateGoodsItemAttribute(var_17_11)

	local var_17_12 = ItemModel.instance:getItemConfig(arg_17_0._itemType, arg_17_0._itemId)

	if string.nilorempty(var_17_0.config.name) == false then
		arg_17_0._txtgoodsName.text = var_17_0.config.name
	elseif var_17_12 then
		arg_17_0._txtgoodsName.text = var_17_12.name
	else
		logError("找不到商品配置: " .. var_17_11.product)
	end

	arg_17_0:_refreshGoods(var_17_11)

	local var_17_13 = var_17_11.cost

	if string.nilorempty(var_17_13) then
		arg_17_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_17_0._imagematerial.gameObject, false)
	else
		local var_17_14 = string.split(var_17_13, "|")
		local var_17_15 = var_17_14[var_17_0.buyCount + 1] or var_17_14[#var_17_14]
		local var_17_16 = string.splitToNumber(var_17_15, "#")
		local var_17_17 = var_17_16[1]
		local var_17_18 = var_17_16[2]

		arg_17_0._costQuantity = var_17_16[3]

		local var_17_19, var_17_20 = ItemModel.instance:getItemConfigAndIcon(var_17_17, var_17_18)
		local var_17_21 = var_17_19.icon
		local var_17_22 = string.format("%s_1", var_17_21)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_17_0._imagematerial, var_17_22)
		gohelper.setActive(arg_17_0._imagematerial.gameObject, true)

		arg_17_0._txtmaterialNum.text = arg_17_0._costQuantity
	end

	local var_17_23 = var_17_11.cost2

	if string.nilorempty(var_17_23) then
		gohelper.setActive(arg_17_0._txtCost2Num.gameObject, false)
		gohelper.setActive(arg_17_0._goline, false)

		arg_17_0._txtmaterialNum.fontSize = 36
		arg_17_0._txtCost2Num.fontSize = 36
	else
		arg_17_0._txtmaterialNum.fontSize = 30
		arg_17_0._txtCost2Num.fontSize = 30

		gohelper.setActive(arg_17_0._txtCost2Num.gameObject, true)
		gohelper.setActive(arg_17_0._goline, true)

		local var_17_24 = string.split(var_17_23, "|")
		local var_17_25 = var_17_24[var_17_0.buyCount + 1] or var_17_24[#var_17_24]
		local var_17_26 = string.splitToNumber(var_17_25, "#")
		local var_17_27 = var_17_26[1]
		local var_17_28 = var_17_26[2]
		local var_17_29 = var_17_26[3]
		local var_17_30, var_17_31 = ItemModel.instance:getItemConfigAndIcon(var_17_27, var_17_28)
		local var_17_32 = var_17_30.icon
		local var_17_33 = string.format("%s_1", var_17_32)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_17_0._imageCost2, var_17_33)

		arg_17_0._txtCost2Num.text = var_17_29
	end

	if arg_17_0._mo.config.jumpId ~= 0 then
		gohelper.setActive(arg_17_0._goCost, false)
		gohelper.setActive(arg_17_0._goline, false)
		gohelper.setActive(arg_17_0._goPath, true)

		if arg_17_0._mo.config.activityId ~= 0 then
			arg_17_0._txtPath.text = luaLang("getGoodsByActivity")
		elseif arg_17_0._mo.config.bindgoodid ~= 0 then
			arg_17_0._txtPath.text = luaLang("getGoodsByBingGoods")
		end
	end

	gohelper.setActive(arg_17_0._godiscount, var_17_0.config.originalCost > 0)

	if var_17_11.cost and var_17_11.cost2 then
		gohelper.setActive(arg_17_0._txtoriginalCost.gameObject, false)
	else
		gohelper.setActive(arg_17_0._txtoriginalCost.gameObject, var_17_0.config.originalCost > 0)
	end

	local var_17_34 = arg_17_0._costQuantity / var_17_0.config.originalCost
	local var_17_35 = math.ceil(var_17_34 * 100)

	arg_17_0._txtdiscount.text = string.format("-%d%%", 100 - var_17_35)
	arg_17_0._txtoriginalCost.text = var_17_0.config.originalCost

	gohelper.setActive(arg_17_0._gooffflineTime, not arg_17_0._hideOffflineTime and var_17_0.offlineTime > 0)

	local var_17_36 = var_17_0.offlineTime - ServerTime.now()

	if var_17_36 > 0 then
		if var_17_36 > 3600 then
			local var_17_37, var_17_38 = TimeUtil.secondToRoughTime(var_17_36)

			arg_17_0._txtoffflineTime.text = formatLuaLang("remain", var_17_37 .. var_17_38)
		else
			arg_17_0._txtoffflineTime.text = luaLang("not_enough_one_hour")
		end
	end

	arg_17_0._soldout = var_17_0:isSoldOut()

	arg_17_0:refreshNextRefreshTime(var_17_11)

	if var_17_0:needShowNew() then
		local var_17_39 = arg_17_0._itemType == MaterialEnum.MaterialType.BlockPackage
		local var_17_40 = arg_17_0._itemType == MaterialEnum.MaterialType.Building

		if not var_17_39 and not var_17_40 then
			gohelper.setActive(arg_17_0._gonewtag, var_17_0:needShowNew())
		end
	end

	local var_17_41 = var_17_11.maxBuyCount - var_17_0.buyCount
	local var_17_42 = StoreConfig.instance:getRemain(var_17_11, var_17_41, var_17_0.offlineTime)

	if string.nilorempty(var_17_42) then
		gohelper.setActive(arg_17_0._txtremain.gameObject, false)
	else
		gohelper.setActive(arg_17_0._txtremain.gameObject, true)

		arg_17_0._txtremain.text = var_17_42
	end

	arg_17_0._hascloth = var_17_0:alreadyHas()

	gohelper.setActive(arg_17_0._gohas, false)
	gohelper.setActive(arg_17_0._gosoldout, false)
	gohelper.setActive(arg_17_0._btnPath.gameObject, not arg_17_0._hascloth)

	if arg_17_0._hascloth then
		if arg_17_0:_isAlreadyHasIgnoreType(var_17_12.subType) and var_17_41 > 0 then
			gohelper.setActive(arg_17_0._gohas, false)
		else
			gohelper.setActive(arg_17_0._gohas, true)
		end
	elseif arg_17_0._soldout then
		gohelper.setActive(arg_17_0._gosoldout, true)
		gohelper.setActive(arg_17_0._goherofull, false)
	end

	arg_17_0:refreshGoUnique()
	arg_17_0:refreshLimitHas()
end

function var_0_0.updateGoodsItemAttribute(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.product
	local var_18_1 = GameUtil.splitString2(var_18_0, true)[1]

	arg_18_0._itemType = var_18_1[1]
	arg_18_0._itemId = var_18_1[2]
	arg_18_0._itemQuantity = var_18_1[3]
	arg_18_0.itemConfig, arg_18_0.itemIcon = ItemModel.instance:getItemConfigAndIcon(arg_18_0._itemType, arg_18_0._itemId, true)
end

function var_0_0.refreshNextRefreshTime(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._soldout and arg_19_1.refreshTime ~= StoreEnum.RefreshTime.Forever

	gohelper.setActive(arg_19_0._goRefreshTime, var_19_0)

	if var_19_0 then
		local var_19_1 = arg_19_0:getEndTimeStamp(arg_19_1) - ServerTime.now()

		if var_19_1 > 0 then
			gohelper.setActive(arg_19_0._goRefreshTime, true)

			if var_19_1 > TimeUtil.OneHourSecond then
				local var_19_2, var_19_3 = TimeUtil.secondToRoughTime(var_19_1)

				arg_19_0._txtRefreshTime.text = formatLuaLang("refresh_remain_time", var_19_2 .. var_19_3)
			else
				arg_19_0._txtRefreshTime.text = luaLang("not_enough_one_hour")
			end
		end
	end
end

function var_0_0.getEndTimeStamp(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return -1
	end

	if arg_20_1.refreshTime == StoreEnum.RefreshTime.Forever then
		return -1
	elseif arg_20_1.refreshTime == StoreEnum.RefreshTime.Day then
		return ServerTime.getToadyEndTimeStamp(true)
	elseif arg_20_1.refreshTime == StoreEnum.RefreshTime.Week then
		return ServerTime.getWeekEndTimeStamp(true)
	elseif arg_20_1.refreshTime == StoreEnum.RefreshTime.Month then
		return ServerTime.getMonthEndTimeStamp(true)
	else
		return -1
	end
end

function var_0_0.refreshLimitHas(arg_21_0)
	if arg_21_0._itemType == MaterialEnum.MaterialType.Equip and not arg_21_0._soldout then
		arg_21_0._limitSold = EquipModel.instance:isLimitAndAlreadyHas(arg_21_0._itemId)

		gohelper.setActive(arg_21_0._golevellimit, arg_21_0._limitSold)

		arg_21_0._txtlvlimit.text = string.format(luaLang("reachUpperLimit"))
	else
		arg_21_0._limitSold = false
	end
end

function var_0_0.refreshActGoods(arg_22_0)
	arg_22_0._soldout = false
	arg_22_0._limitSold = false
	arg_22_0._hascloth = false

	local var_22_0 = arg_22_0._mo
	local var_22_1 = var_22_0:getBelongStoreId()
	local var_22_2 = arg_22_0._mo:getActGoodsId()

	gohelper.setActive(arg_22_0._goitemreddot, false)
	gohelper.setActive(arg_22_0._golevellimit, false)

	local var_22_3 = var_22_0:getIsGreatActGoods()

	gohelper.setActive(arg_22_0._goActBgEff, var_22_3)
	arg_22_0:updateActGoodsItemAttribute(var_22_1, var_22_2)

	local var_22_4 = ItemModel.instance:getItemConfig(arg_22_0._itemType, arg_22_0._itemId)

	arg_22_0._txtgoodsName.text = var_22_4 and var_22_4.name or ""

	arg_22_0:_refreshGoods()

	local var_22_5 = FurnaceTreasureModel.instance:getCostItem(var_22_1)

	if not var_22_5 then
		arg_22_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_22_0._imagematerial.gameObject, false)
	else
		local var_22_6 = MaterialEnum.MaterialType.Currency
		local var_22_7 = FurnaceTreasureConfig.instance:get147GoodsCost(var_22_2)

		if string.nilorempty(var_22_7) then
			arg_22_0._costQuantity = 0
		else
			arg_22_0._costQuantity = string.splitToNumber(var_22_7, "#")[1]
		end

		local var_22_8 = ItemModel.instance:getItemConfigAndIcon(var_22_6, var_22_5).icon
		local var_22_9 = string.format("%s_1", var_22_8)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_22_0._imagematerial, var_22_9)
		gohelper.setActive(arg_22_0._imagematerial.gameObject, true)

		arg_22_0._txtmaterialNum.text = arg_22_0._costQuantity
	end

	gohelper.setActive(arg_22_0._txtCost2Num.gameObject, false)

	arg_22_0._txtmaterialNum.fontSize = 36
	arg_22_0._txtCost2Num.fontSize = 36

	gohelper.setActive(arg_22_0._godiscount, false)
	gohelper.setActive(arg_22_0._txtoriginalCost.gameObject, false)
	gohelper.setActive(arg_22_0._gooffflineTime, false)
	gohelper.setActive(arg_22_0._goRefreshTime, false)
	gohelper.setActive(arg_22_0._gonewtag, false)

	local var_22_10 = FurnaceTreasureModel.instance:getGoodsRemainCount(var_22_1, var_22_2)

	arg_22_0._txtremain.text = string.format("%s:%d", luaLang("store_buylimit_day"), var_22_10)

	gohelper.setActive(arg_22_0._txtremain.gameObject, true)
	gohelper.setActive(arg_22_0._gohas, false)
	gohelper.setActive(arg_22_0._gosoldout, false)
	gohelper.setActive(arg_22_0._goherofull, false)
	arg_22_0:refreshGoUnique()
end

function var_0_0.updateActGoodsItemAttribute(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = FurnaceTreasureModel.instance:getGoodsPoolId(arg_23_1, arg_23_2)

	arg_23_0._itemType, arg_23_0._itemId, arg_23_0._itemQuantity = FurnaceTreasureConfig.instance:getAct147GoodsShowItem(var_23_0)
	arg_23_0.itemConfig, arg_23_0.itemIcon = ItemModel.instance:getItemConfigAndIcon(arg_23_0._itemType, arg_23_0._itemId, true)
end

local var_0_1 = {
	StoreEnum.StoreId.CritterStore
}

function var_0_0._refreshGoods(arg_24_0, arg_24_1)
	local function var_24_0(arg_25_0, arg_25_1)
		recthelper.setSize(arg_24_0._imgicon.transform, arg_25_0, arg_25_1)
	end

	local var_24_1 = 278
	local var_24_2 = 228
	local var_24_3 = 256
	local var_24_4 = 256
	local var_24_5 = false

	if arg_24_0._itemType == MaterialEnum.MaterialType.Equip then
		arg_24_0._goicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_24_0.itemConfig.icon), var_24_0(var_24_1, var_24_2))
	elseif not string.nilorempty(arg_24_0.itemIcon) then
		arg_24_0._goicon:LoadImage(arg_24_0.itemIcon, var_24_0(var_24_3, var_24_4))
	else
		var_24_5 = true
	end

	local var_24_6 = arg_24_0._itemType == MaterialEnum.MaterialType.BlockPackage
	local var_24_7 = arg_24_0._itemType == MaterialEnum.MaterialType.Building

	gohelper.setActive(arg_24_0._goicon.gameObject, not var_24_6 and not var_24_7 and not var_24_5)
	gohelper.setActive(arg_24_0._goroomactive, not LuaUtil.tableContains(var_0_1, arg_24_0._mo.belongStoreId) and (var_24_6 or var_24_7))
	gohelper.setActive(arg_24_0._goroomticket, arg_24_0:checkShowTicket() and not arg_24_0._soldout)
	arg_24_0:refreshRoomItemUI(var_24_6, var_24_7)

	if var_24_6 or var_24_7 then
		UISpriteSetMgr.instance:setRoomSprite(arg_24_0._simageroomactiveicon, "jianshezhi")
	end

	local var_24_8 = 0
	local var_24_9 = arg_24_1 and arg_24_1.product

	if not string.nilorempty(var_24_9) then
		local var_24_10 = GameUtil.splitString2(var_24_9, true)

		for iter_24_0, iter_24_1 in ipairs(var_24_10) do
			if iter_24_1[1] == MaterialEnum.MaterialType.BlockPackage then
				var_24_8 = var_24_8 + RoomConfig.instance:getBlockPackageFullDegree(iter_24_1[2]) * iter_24_1[3]
			elseif iter_24_1[1] == MaterialEnum.MaterialType.Building then
				var_24_8 = var_24_8 + RoomConfig.instance:getBuildingConfig(iter_24_1[2]).buildDegree * iter_24_1[3]
			end
		end
	end

	arg_24_0._txtroomnum.text = var_24_8

	arg_24_0:showStackableNum()
	arg_24_0:_checkHeroFullDuplicateCount()
	arg_24_0:refreshRare()
end

function var_0_0.refreshRare(arg_26_0)
	local var_26_0 = false

	if arg_26_0._mo:getIsActGoods() then
		UISpriteSetMgr.instance:setStoreGoodsSprite(arg_26_0._rare, FurnaceTreasureEnum.RareBgName)

		var_26_0 = true
	elseif arg_26_0.itemConfig then
		UISpriteSetMgr.instance:setStoreGoodsSprite(arg_26_0._rare, "rare" .. arg_26_0.itemConfig.rare)

		var_26_0 = true
	end

	gohelper.setActive(arg_26_0._rare.gameObject, var_26_0)
end

function var_0_0.refreshRoomItemUI(arg_27_0, arg_27_1, arg_27_2)
	gohelper.setActive(arg_27_0._goroomiconmask, arg_27_1 or arg_27_2)

	if arg_27_1 or arg_27_2 then
		local var_27_0 = arg_27_0._mo.config.bigImg

		if string.nilorempty(arg_27_0._mo.config.bigImg) then
			var_27_0 = arg_27_0.itemIcon
		end

		arg_27_0._simageroomicon:LoadImage(var_27_0, function()
			arg_27_0._simageroomicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end
end

function var_0_0.showStackableNum(arg_29_0)
	if not arg_29_0.itemConfig then
		gohelper.setActive(arg_29_0._gonum.gameObject, false)

		return
	end

	if (not arg_29_0.itemConfig.isStackable or arg_29_0.itemConfig.isStackable == 1 or arg_29_0._itemType == MaterialEnum.MaterialType.Equip) and arg_29_0._itemQuantity > 1 then
		gohelper.setActive(arg_29_0._gonum.gameObject, true)

		arg_29_0._gonumText.text = GameUtil.numberDisplay(arg_29_0._itemQuantity)
	else
		gohelper.setActive(arg_29_0._gonum.gameObject, false)
	end
end

function var_0_0._checkHeroFullDuplicateCount(arg_30_0)
	local var_30_0 = false

	if arg_30_0._itemType == MaterialEnum.MaterialType.Hero then
		var_30_0 = CharacterModel.instance:isHeroFullDuplicateCount(arg_30_0._itemId)
	end

	gohelper.setActive(arg_30_0._goherofull, var_30_0)
end

function var_0_0.refreshGoUnique(arg_31_0)
	gohelper.setActive(arg_31_0._goLimit, ItemConfig.instance:isUniqueByCo(arg_31_0._itemType, arg_31_0.itemConfig))
end

function var_0_0.checkShowTicket(arg_32_0)
	if arg_32_0._mo.belongStoreId == StoreEnum.StoreId.OldRoomStore or arg_32_0._mo.belongStoreId == StoreEnum.StoreId.NewRoomStore then
		if arg_32_0._itemType ~= MaterialEnum.MaterialType.BlockPackage and arg_32_0._itemType ~= MaterialEnum.MaterialType.Building then
			return false
		end

		if arg_32_0._mo:getIsJumpGoods() then
			return false
		end

		if arg_32_0.itemConfig.rare <= 3 then
			if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 or ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
				return true
			end
		elseif arg_32_0.itemConfig.rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.onDestroy(arg_33_0)
	if arg_33_0._goicon then
		arg_33_0._goicon:UnLoadImage()

		arg_33_0._goicon = nil
	end

	arg_33_0._simageroomicon:UnLoadImage()
	arg_33_0._btn:RemoveClickListener()
	arg_33_0._btnPath:RemoveClickListener()
end

return var_0_0
