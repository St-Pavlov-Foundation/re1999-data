module("modules.logic.room.view.common.RoomStoreGoodsTipViewContainer", package.seeall)

slot0 = class("RoomStoreGoodsTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomStoreGoodsTipView.New())
	table.insert(slot1, RoomStroreGoodsTipViewBanner.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "right/#go_buyContent/scroll_blockpackage"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "right/#go_buyContent/#go_blockInfoItem"
	slot2.cellClass = RoomStoreGoodsTipItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 470
	slot2.cellHeight = 50
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 1.44
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomStoreItemListModel.instance, slot2))
	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 then
		table.insert({
			CurrencyEnum.CurrencyType.FreeDiamondCoupon,
			23
		}, {
			isCurrencySprite = true,
			id = StoreEnum.NormalRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	if ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
		table.insert(slot3, {
			isCurrencySprite = true,
			id = StoreEnum.TopRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	return {
		CurrencyView.New(slot3)
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(ViewName.RoomStoreGoodsTipView, nil, true)
end

return slot0
