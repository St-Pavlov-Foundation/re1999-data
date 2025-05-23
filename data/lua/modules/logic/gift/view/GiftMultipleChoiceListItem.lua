﻿module("modules.logic.gift.view.GiftMultipleChoiceListItem", package.seeall)

local var_0_0 = class("GiftMultipleChoiceListItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._itemPos = gohelper.findChild(arg_1_1, "itemPos")
	arg_1_0._name = gohelper.findChildText(arg_1_1, "name")
	arg_1_0._choose = gohelper.findChild(arg_1_1, "mask")
	arg_1_0._clickGO = gohelper.findChild(arg_1_1, "click")
	arg_1_0._goneed = gohelper.findChild(arg_1_1, "#go_needtag")
	arg_1_0._clickitem = gohelper.getClick(arg_1_0._clickGO)
	arg_1_0._longclickItem = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._clickGO)

	arg_1_0._longclickItem:SetLongPressTime({
		0.5,
		99999
	})
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._clickitem:AddClickListener(arg_2_0._onClickItem, arg_2_0)
	arg_2_0._longclickItem:AddLongPressListener(arg_2_0._onLongClickItem, arg_2_0)
	GiftController.instance:registerCallback(GiftEvent.MultipleChoice, arg_2_0._refreshItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._clickitem:RemoveClickListener()
	arg_3_0._longclickItem:RemoveLongPressListener()
	GiftController.instance:unregisterCallback(GiftEvent.MultipleChoice, arg_3_0._refreshItem, arg_3_0)
end

function var_0_0._refreshItem(arg_4_0)
	gohelper.setActive(arg_4_0._choose, arg_4_0._mo.index == GiftModel.instance:getMultipleChoiceIndex())
end

function var_0_0._onClickItem(arg_5_0)
	gohelper.setActive(arg_5_0._choose, true)
	GiftModel.instance:setMultipleChoiceIndex(arg_5_0._mo.index)
	GiftModel.instance:setMultipleChoiceId(arg_5_0._mo.materilId)
	GiftController.instance:dispatchEvent(GiftEvent.MultipleChoice)
end

function var_0_0._onLongClickItem(arg_6_0)
	MaterialTipController.instance:showMaterialInfo(arg_6_0._mo.materilType, arg_6_0._mo.materilId)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	local var_7_0, var_7_1 = ItemModel.instance:getItemConfigAndIcon(arg_7_0._mo.materilType, arg_7_0._mo.materilId)

	if arg_7_0._mo.materilType == MaterialEnum.MaterialType.Equip then
		arg_7_0._itemIcon = IconMgr.instance:getCommonEquipIcon(arg_7_0._itemPos)

		arg_7_0._itemIcon:setMOValue(arg_7_0._mo.materilType, arg_7_0._mo.materilId, arg_7_0._mo.quantity, nil, true)
		arg_7_0._itemIcon:hideLv(true)
	else
		arg_7_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_7_0._itemPos)

		arg_7_0._itemIcon:setMOValue(arg_7_0._mo.materilType, arg_7_0._mo.materilId, arg_7_0._mo.quantity, nil, true)
	end

	arg_7_0._name.text = var_7_0.name

	gohelper.setActive(arg_7_0._goneed, GiftModel.instance:isGiftNeed(arg_7_0._mo.materilId))
	arg_7_0:_refreshItem()
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
