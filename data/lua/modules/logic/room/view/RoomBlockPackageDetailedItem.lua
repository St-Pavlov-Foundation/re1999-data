module("modules.logic.room.view.RoomBlockPackageDetailedItem", package.seeall)

local var_0_0 = class("RoomBlockPackageDetailedItem", RoomBlockPackageItem)

function var_0_0._onInit(arg_1_0, arg_1_1)
	arg_1_0._itemCanvasGroup = gohelper.findChild(arg_1_1, "item"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._imageIcon = gohelper.findChildSingleImage(arg_1_1, "item/image_icon")
	arg_1_0._gobirthday = gohelper.findChild(arg_1_1, "item/go_birthday")
	arg_1_0._txtbirthName = gohelper.findChildText(arg_1_1, "item/go_birthday/txt_birthName")
end

function var_0_0._onRefreshUI(arg_2_0)
	arg_2_0._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. arg_2_0._packageCfg.icon))

	if arg_2_0._packageCfg.id == RoomBlockPackageEnum.ID.RoleBirthday then
		local var_2_0 = arg_2_0:_getNearBlockName()

		gohelper.setActive(arg_2_0._gobirthday, var_2_0 ~= nil)

		if var_2_0 then
			arg_2_0._txtbirthName.text = var_2_0
		end
	else
		gohelper.setActive(arg_2_0._gobirthday, false)
	end

	local var_2_1 = RoomBlockPackageEnum.RareBigIcon[arg_2_0._packageCfg.rare] or RoomBlockPackageEnum.RareBigIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._imagerare, var_2_1)
end

function var_0_0._getNearBlockName(arg_3_0)
	local var_3_0 = RoomModel.instance:getSpecialBlockInfoList()
	local var_3_1

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = RoomConfig.instance:getBlock(iter_3_1.blockId)

		if var_3_2 and var_3_2.packageId == RoomBlockPackageEnum.ID.RoleBirthday and (var_3_1 == nil or var_3_1.createTime < iter_3_1.createTime) then
			var_3_1 = iter_3_1
		end
	end

	if var_3_1 then
		local var_3_3 = RoomConfig.instance:getSpecialBlockConfig(var_3_1.blockId)

		return var_3_3 and var_3_3.name
	end

	return nil
end

function var_0_0._onSelectUI(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
	arg_5_0._imageIcon:UnLoadImage()
end

return var_0_0
