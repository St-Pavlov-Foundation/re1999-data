﻿-- chunkname: @modules/logic/store/controller/StoreEvent.lua

module("modules.logic.store.controller.StoreEvent", package.seeall)

local StoreEvent = _M

StoreEvent.StoreInfoChanged = GameUtil.getEventId()
StoreEvent.GoodsModelChanged = GameUtil.getEventId()
StoreEvent.MonthCardInfoChanged = GameUtil.getEventId()
StoreEvent.UpdatePackageStore = GameUtil.getEventId()
StoreEvent.BeforeUpdatePackageStore = GameUtil.getEventId()
StoreEvent.AfterUpdatePackageStore = GameUtil.getEventId()
StoreEvent.OpenRoomStoreNode = GameUtil.getEventId()
StoreEvent.SaveVerticalScrollPixel = GameUtil.getEventId()
StoreEvent.SetVisibleInternal = GameUtil.getEventId()
StoreEvent.SetAutoToNextPage = GameUtil.getEventId()
StoreEvent.OnSwitchSpine = GameUtil.getEventId()
StoreEvent.CheckSkinViewEmpty = GameUtil.getEventId()
StoreEvent.SkinChargePackageUpdate = GameUtil.getEventId()
StoreEvent.CurPackageListEmpty = GameUtil.getEventId()
StoreEvent.OnSwitchTab = GameUtil.getEventId()
StoreEvent.jumpClickRoomChildGoods = GameUtil.getEventId()
StoreEvent.DragSkinListBegin = GameUtil.getEventId()
StoreEvent.DraggingSkinList = GameUtil.getEventId()
StoreEvent.DragSkinListEnd = GameUtil.getEventId()
StoreEvent.DecorateGoodItemClick = GameUtil.getEventId()
StoreEvent.PlayShowStoreAnim = GameUtil.getEventId()
StoreEvent.PlayHideStoreAnim = GameUtil.getEventId()
StoreEvent.SkinGoodsItemChanged = GameUtil.getEventId()
StoreEvent.SkinPreviewChanged = GameUtil.getEventId()
StoreEvent.OnPlaySkinVideo = GameUtil.getEventId()
StoreEvent.StopRecommendViewAuto = GameUtil.getEventId()
StoreEvent.DecorateSkinSelectItemClick = GameUtil.getEventId()
StoreEvent.DecorateStoreSkinSelectItemClick = GameUtil.getEventId()

return StoreEvent
