module("modules.logic.room.view.RoomBlockPackageDetailedItem", package.seeall)

slot0 = class("RoomBlockPackageDetailedItem", RoomBlockPackageItem)

function slot0._onInit(slot0, slot1)
	slot0._itemCanvasGroup = gohelper.findChild(slot1, "item"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._imageIcon = gohelper.findChildSingleImage(slot1, "item/image_icon")
	slot0._gobirthday = gohelper.findChild(slot1, "item/go_birthday")
	slot0._txtbirthName = gohelper.findChildText(slot1, "item/go_birthday/txt_birthName")
end

function slot0._onRefreshUI(slot0)
	slot0._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. slot0._packageCfg.icon))

	if slot0._packageCfg.id == RoomBlockPackageEnum.ID.RoleBirthday then
		gohelper.setActive(slot0._gobirthday, slot0:_getNearBlockName() ~= nil)

		if slot1 then
			slot0._txtbirthName.text = slot1
		end
	else
		gohelper.setActive(slot0._gobirthday, false)
	end

	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, RoomBlockPackageEnum.RareBigIcon[slot0._packageCfg.rare] or RoomBlockPackageEnum.RareBigIcon[1])
end

function slot0._getNearBlockName(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(RoomModel.instance:getSpecialBlockInfoList()) do
		if RoomConfig.instance:getBlock(slot7.blockId) and slot8.packageId == RoomBlockPackageEnum.ID.RoleBirthday and (slot2 == nil or slot2.createTime < slot7.createTime) then
			slot2 = slot7
		end
	end

	if slot2 then
		return RoomConfig.instance:getSpecialBlockConfig(slot2.blockId) and slot3.name
	end

	return nil
end

function slot0._onSelectUI(slot0)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0._imageIcon:UnLoadImage()
end

return slot0
