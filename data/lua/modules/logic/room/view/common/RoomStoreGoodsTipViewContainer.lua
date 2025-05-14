module("modules.logic.room.view.common.RoomStoreGoodsTipViewContainer", package.seeall)

local var_0_0 = class("RoomStoreGoodsTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomStoreGoodsTipView.New())
	table.insert(var_1_0, RoomStroreGoodsTipViewBanner.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "right/#go_buyContent/scroll_blockpackage"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "right/#go_buyContent/#go_blockInfoItem"
	var_1_1.cellClass = RoomStoreGoodsTipItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 470
	var_1_1.cellHeight = 50
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 1.44
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(RoomStoreItemListModel.instance, var_1_1))
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = CurrencyEnum.CurrencyType
	local var_2_1 = {
		var_2_0.FreeDiamondCoupon,
		23
	}

	if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 then
		table.insert(var_2_1, {
			isCurrencySprite = true,
			id = StoreEnum.NormalRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	if ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
		table.insert(var_2_1, {
			isCurrencySprite = true,
			id = StoreEnum.TopRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	return {
		CurrencyView.New(var_2_1)
	}
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	ViewMgr.instance:closeView(ViewName.RoomStoreGoodsTipView, nil, true)
end

return var_0_0
