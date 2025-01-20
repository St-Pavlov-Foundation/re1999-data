module("modules.logic.room.view.RoomBlockPackageSimpleItem", package.seeall)

slot0 = class("RoomBlockPackageSimpleItem", RoomBlockPackageItem)

function slot0._onInit(slot0, slot1)
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "item/go_reddot")
end

function slot0._onRefreshUI(slot0)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, RoomBlockPackageEnum.RareIcon[slot0._packageCfg.rare] or RoomBlockPackageEnum.RareIcon[1])
end

function slot0._onSelectUI(slot0)
	recthelper.setAnchorX(slot0._txtname.transform, slot0._isSelect and -175 or -197)
end

return slot0
