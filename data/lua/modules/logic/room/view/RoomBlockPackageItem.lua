module("modules.logic.room.view.RoomBlockPackageItem", package.seeall)

local var_0_0 = class("RoomBlockPackageItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._go = arg_4_0.viewGO
	arg_4_0._goitem = gohelper.findChild(arg_4_0.viewGO, "item")
	arg_4_0._txtnum = gohelper.findChildText(arg_4_0.viewGO, "item/txt_num")
	arg_4_0._txtdegree = gohelper.findChildText(arg_4_0.viewGO, "item/txt_degree")
	arg_4_0._imagerare = gohelper.findChildImage(arg_4_0.viewGO, "item/image_rare")
	arg_4_0._txtname = gohelper.findChildText(arg_4_0.viewGO, "item/txt_name")
	arg_4_0._goreddot = gohelper.findChild(arg_4_0.viewGO, "item/txt_name/go_reddot")
	arg_4_0._goselect = gohelper.findChild(arg_4_0.viewGO, "go_select")
	arg_4_0._btnItem = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "item")
	arg_4_0._goempty = gohelper.findChild(arg_4_0.viewGO, "item/go_empty")
	arg_4_0._simagedegree = gohelper.findChildImage(arg_4_0.viewGO, "item/txt_degree/icon")

	arg_4_0._btnItem:AddClickListener(arg_4_0._btnitemOnClick, arg_4_0)
	UISpriteSetMgr.instance:setRoomSprite(arg_4_0._simagedegree, "jianshezhi")
	arg_4_0:_onInit(arg_4_0.viewGO)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._btnItem:RemoveClickListener()
end

function var_0_0._btnitemOnClick(arg_6_0)
	RoomHelper.hideBlockPackageReddot(arg_6_0._packageId)
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlockPackage, arg_6_0._packageId)
end

function var_0_0.getGO(arg_7_0)
	return arg_7_0._go
end

function var_0_0.setShowIcon(arg_8_0, arg_8_1)
	arg_8_0._isShowIcon = arg_8_1
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	arg_9_0._isSelect = arg_9_1

	gohelper.setActive(arg_9_0._goselect, arg_9_1)
	arg_9_0:_onSelectUI()
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._showPackageMO = arg_10_1

	arg_10_0:setPackageId(arg_10_1.id)
end

function var_0_0.getPackageId(arg_11_0)
	return arg_11_0._packageId
end

function var_0_0.setPackageId(arg_12_0, arg_12_1)
	arg_12_0._packageId = arg_12_1
	arg_12_0._packageCfg = RoomConfig.instance:getBlockPackageConfig(arg_12_1) or nil
	arg_12_0._packageMO = RoomInventoryBlockModel.instance:getPackageMOById(arg_12_1)
	arg_12_0._blockNum = arg_12_0._packageMO and arg_12_0._packageMO:getUnUseCount() or 0

	RedDotController.instance:addRedDot(arg_12_0._goreddot, RedDotEnum.DotNode.RoomBlockPackage, arg_12_0._packageId)
	arg_12_0:_refreshUI()
end

function var_0_0._refreshUI(arg_13_0)
	if not arg_13_0._packageCfg then
		return
	end

	arg_13_0._txtname.text = arg_13_0._packageCfg.name
	arg_13_0._txtnum.text = arg_13_0._blockNum
	arg_13_0._txtdegree.text = arg_13_0._packageCfg.blockBuildDegree * arg_13_0._blockNum

	gohelper.setActive(arg_13_0._goempty, arg_13_0._blockNum == 0)
	gohelper.setActive(arg_13_0._txtnum.gameObject, arg_13_0._blockNum > 0)
	gohelper.setActive(arg_13_0._txtdegree.gameObject, arg_13_0._blockNum > 0)
	arg_13_0:_onRefreshUI()
end

function var_0_0.onDestroy(arg_14_0)
	return
end

function var_0_0._onInit(arg_15_0, arg_15_1)
	return
end

function var_0_0._onRefreshUI(arg_16_0)
	return
end

function var_0_0._onSelectUI(arg_17_0)
	return
end

return var_0_0
