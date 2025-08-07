module("modules.logic.sp01.act208.view.V2a9_Act208RewardItem", package.seeall)

local var_0_0 = class("V2a9_Act208RewardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._simageItem = gohelper.findChildSingleImage(arg_1_0.go, "#simage_Item")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.go, "image_NumBG/#txt_Num")
	arg_1_0._imageQuality = gohelper.findChildImage(arg_1_0.go, "#img_Quality")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0.state == nil then
		return
	end

	if arg_4_0.state == Act208Enum.BonusState.NotGet or arg_4_0.state == Act208Enum.BonusState.HaveGet then
		if arg_4_0.bonusData == nil then
			logError("bonusData is nil")

			return
		end

		local var_4_0 = arg_4_0.bonusData[1]
		local var_4_1 = arg_4_0.bonusData[2]
		local var_4_2 = arg_4_0.bonusData[3]

		MaterialTipController.instance:showMaterialInfo(var_4_0, var_4_1, false, nil, false)

		return
	end

	Act208Controller.instance:getBonus(arg_4_0.actId, arg_4_0.id)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goCanGet = gohelper.findChild(arg_5_0.go, "go_canget")
	arg_5_0._goReceive = gohelper.findChild(arg_5_0.go, "go_receive")

	gohelper.setActive(arg_5_0._goCanGet, false)
	gohelper.setActive(arg_5_0._goReceive, false)
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.actId = arg_6_1
	arg_6_0.id = arg_6_2.id
	arg_6_0.config = arg_6_2

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = arg_7_0.config
	local var_7_1 = string.splitToNumber(var_7_0.bonus, "#")
	local var_7_2 = var_7_1[1]
	local var_7_3 = var_7_1[2]
	local var_7_4 = var_7_1[3]

	arg_7_0.bonusData = var_7_1

	local var_7_5, var_7_6 = ItemModel.instance:getItemConfigAndIcon(var_7_2, var_7_3, true)

	if var_7_0.isAllBonus == Act208Enum.RewardType.Common then
		arg_7_0._simageItem:LoadImage(var_7_6)

		arg_7_0._txtNum.text = tostring(var_7_4)

		local var_7_7 = var_7_5.rare and var_7_5.rare or 5

		UISpriteSetMgr.instance:setOptionalGiftSprite(arg_7_0._imageQuality, "bg_pinjidi_" .. var_7_7)
	elseif var_7_0.isAllBonus == Act208Enum.RewardType.Final then
		-- block empty
	end
end

function var_0_0.setState(arg_8_0, arg_8_1)
	arg_8_0.state = arg_8_1.status

	gohelper.setActive(arg_8_0._goCanGet, arg_8_1.status == Act208Enum.BonusState.CanGet)
	gohelper.setActive(arg_8_0._goReceive, arg_8_1.status == Act208Enum.BonusState.HaveGet)
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
