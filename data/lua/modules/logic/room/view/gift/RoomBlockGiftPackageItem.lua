module("modules.logic.room.view.gift.RoomBlockGiftPackageItem", package.seeall)

local var_0_0 = class("RoomBlockGiftPackageItem", RoomBlockPackageDetailedItem)

function var_0_0._onInit(arg_1_0, arg_1_1)
	var_0_0.super._onInit(arg_1_0, arg_1_1)
	gohelper.setActive(arg_1_0._gobirthday, false)

	arg_1_0._gohasget = gohelper.findChild(arg_1_1, "item/go_hasget")
	arg_1_0._imagehasgetIcon = gohelper.findChildSingleImage(arg_1_1, "item/go_hasget/image_icon")

	gohelper.setActive(arg_1_0._goempty, false)

	arg_1_0._btnUIlongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._btnItem.gameObject)
	arg_1_0._btnblockselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_select/#btn_check")
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)

	local var_2_0 = {
		1,
		99999
	}

	arg_2_0._btnUIlongPrees:SetLongPressTime(var_2_0)
	arg_2_0._btnUIlongPrees:AddLongPressListener(arg_2_0._onbtnlongPrees, arg_2_0)
	arg_2_0._btnblockselect:AddClickListener(arg_2_0._onbtnlongPrees, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnUIlongPrees:RemoveLongPressListener()
	var_0_0.super.removeEventListeners(arg_3_0)
	arg_3_0._btnblockselect:RemoveClickListener()
end

function var_0_0.setPackageId(arg_4_0, arg_4_1)
	arg_4_0._packageId = arg_4_1
	arg_4_0._packageCfg = RoomConfig.instance:getBlockPackageConfig(arg_4_1) or nil
	arg_4_0._blockNum = arg_4_0._showPackageMO:getBlockNum()
	arg_4_0._isCollocted = arg_4_0._showPackageMO:isCollect()

	arg_4_0:_refreshUI()
end

function var_0_0._refreshUI(arg_5_0)
	if not arg_5_0._packageCfg then
		return
	end

	arg_5_0._txtname.text = arg_5_0._packageCfg.name
	arg_5_0._txtnum.text = arg_5_0._blockNum
	arg_5_0._txtdegree.text = arg_5_0._packageCfg.blockBuildDegree * arg_5_0._blockNum

	gohelper.setActive(arg_5_0._gohasget, arg_5_0._isCollocted)
	gohelper.setActive(arg_5_0._txtnum.gameObject, not arg_5_0._isCollocted)
	gohelper.setActive(arg_5_0._txtdegree.gameObject, not arg_5_0._isCollocted)
	arg_5_0:_onRefreshUI()
end

function var_0_0._onRefreshUI(arg_6_0)
	arg_6_0._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. arg_6_0._packageCfg.icon))

	local var_6_0 = RoomBlockPackageEnum.RareBigIcon[arg_6_0._packageCfg.rare] or RoomBlockPackageEnum.RareBigIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_6_0._imagerare, var_6_0)

	if arg_6_0._showPackageMO:isCollect() then
		arg_6_0._imagehasgetIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. arg_6_0._packageCfg.icon))
	end

	arg_6_0:onSelect()
end

function var_0_0._onbtnlongPrees(arg_7_0)
	local var_7_0 = arg_7_0._showPackageMO.subType
	local var_7_1 = arg_7_0._showPackageMO.id
	local var_7_2 = {
		type = var_7_0,
		id = var_7_1
	}

	MaterialTipController.instance:showMaterialInfoWithData(var_7_0, var_7_1, var_7_2)
end

function var_0_0._btnitemOnClick(arg_8_0)
	if arg_8_0._showPackageMO:isCollect() then
		return
	end

	RoomBlockBuildingGiftModel.instance:onSelect(arg_8_0._showPackageMO)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSelect, arg_8_0._showPackageMO)
end

function var_0_0.onSelect(arg_9_0)
	arg_9_0._isSelect = arg_9_0._showPackageMO.isSelect

	gohelper.setActive(arg_9_0._goselect, arg_9_0._isSelect)
end

function var_0_0.setActive(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._go, arg_10_1)
end

return var_0_0
