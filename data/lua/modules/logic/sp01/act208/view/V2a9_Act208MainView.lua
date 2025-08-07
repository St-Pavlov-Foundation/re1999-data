module("modules.logic.sp01.act208.view.V2a9_Act208MainView", package.seeall)

local var_0_0 = class("V2a9_Act208MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Title/#simage_Title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Act208Controller.instance, Act208Event.onGetInfo, arg_2_0.refreshState, arg_2_0)
	arg_2_0:addEventCb(Act208Controller.instance, Act208Event.onGetBonus, arg_2_0.refreshState, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Act208Controller.instance, Act208Event.onGetInfo, arg_3_0.refreshState, arg_3_0)
	arg_3_0:removeEventCb(Act208Controller.instance, Act208Event.onGetBonus, arg_3_0.refreshState, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goRewardParent = gohelper.findChild(arg_4_0.viewGO, "Root/reward")

	local var_4_0 = arg_4_0._goRewardParent.transform.childCount

	arg_4_0._rewardItemList = {}

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = arg_4_0._goRewardParent.transform:GetChild(iter_4_0 - 1)
		local var_4_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_1.gameObject, V2a9_Act208RewardItem)

		table.insert(arg_4_0._rewardItemList, var_4_2)
	end
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = arg_6_0.viewParam.actId

	local var_6_0 = Act208Helper.getCurPlatformType()

	Act208Controller.instance:getActInfo(arg_6_0.actId, var_6_0)
	arg_6_0:_checkParent()
	arg_6_0:refreshUI()
end

function var_0_0._checkParent(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	if var_7_0 then
		gohelper.addChild(var_7_0, arg_7_0.viewGO)
	end
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = arg_8_0.actId
	local var_8_1 = Act208Config.instance:getBonusListById(var_8_0)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = arg_8_0._rewardItemList[iter_8_1.id]

		if var_8_2 ~= nil then
			var_8_2:setData(var_8_0, iter_8_1)
		end
	end
end

function var_0_0.refreshState(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= arg_9_0.actId then
		return
	end

	local var_9_0 = Act208Model.instance:getInfo(arg_9_1)

	if not var_9_0 then
		return
	end

	if arg_9_2 ~= nil then
		local var_9_1 = var_9_0.bonusDic[arg_9_2]

		arg_9_0._rewardItemList[arg_9_2]:setState(var_9_1)
	else
		for iter_9_0, iter_9_1 in ipairs(var_9_0.bonusList) do
			arg_9_0._rewardItemList[iter_9_1.id]:setState(iter_9_1)
		end
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
