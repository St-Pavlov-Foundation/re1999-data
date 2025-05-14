module("modules.logic.room.view.RoomBlockPackageSimpleItem", package.seeall)

local var_0_0 = class("RoomBlockPackageSimpleItem", RoomBlockPackageItem)

function var_0_0._onInit(arg_1_0, arg_1_1)
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "item/go_reddot")
end

function var_0_0._onRefreshUI(arg_2_0)
	local var_2_0 = RoomBlockPackageEnum.RareIcon[arg_2_0._packageCfg.rare] or RoomBlockPackageEnum.RareIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._imagerare, var_2_0)
end

function var_0_0._onSelectUI(arg_3_0)
	recthelper.setAnchorX(arg_3_0._txtname.transform, arg_3_0._isSelect and -175 or -197)
end

return var_0_0
