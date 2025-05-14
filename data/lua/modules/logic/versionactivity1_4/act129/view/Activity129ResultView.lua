module("modules.logic.versionactivity1_4.act129.view.Activity129ResultView", package.seeall)

local var_0_0 = class("Activity129ResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.viewGO, "#go_Result")
	arg_1_0.bigList = arg_1_0:createList(gohelper.findChild(arg_1_0.goRewards, "#go_BigList"))
	arg_1_0.smallList = arg_1_0:createList(gohelper.findChild(arg_1_0.goRewards, "#go_SmallList"))
	arg_1_0.rewardItems = {}
	arg_1_0.click = gohelper.findChildClick(arg_1_0.goRewards, "click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.click:AddClickListener(arg_2_0.onClick, arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, arg_2_0.showReward, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onOnCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.click:RemoveClickListener()
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, arg_3_0.showReward, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onOnCloseViewFinish, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onOnCloseViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.RoomBlockPackageGetView then
		RoomController.instance:checkThemeCollerctFullReward()
	end
end

function var_0_0.onClick(arg_6_0)
	gohelper.setActive(arg_6_0.goRewards, false)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnLotteryEnd)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam.actId
end

function var_0_0.showReward(arg_8_0, arg_8_1)
	if not arg_8_1 then
		gohelper.setActive(arg_8_0.goRewards, false)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_all)
	gohelper.setActive(arg_8_0.goRewards, true)
	gohelper.setActive(arg_8_0.bigList.go, false)
	gohelper.setActive(arg_8_0.smallList.go, false)

	local var_8_0 = #arg_8_1
	local var_8_1 = var_8_0 > 8 and arg_8_0.bigList or arg_8_0.smallList

	gohelper.setActive(var_8_1.go, true)

	for iter_8_0 = 1, math.max(var_8_0, #arg_8_0.rewardItems) do
		local var_8_2 = arg_8_0.rewardItems[iter_8_0]

		if not var_8_2 then
			var_8_2 = IconMgr.instance:getCommonPropItemIcon(var_8_1.goContent)
			arg_8_0.rewardItems[iter_8_0] = var_8_2
		end

		local var_8_3 = arg_8_1[iter_8_0]

		if var_8_3 then
			gohelper.addChild(var_8_1.goContent, var_8_2.go)
			gohelper.setAsLastSibling(var_8_2.go)
			gohelper.setActive(var_8_2.go, true)
			var_8_2:setMOValue(var_8_3[1], var_8_3[2], var_8_3[3], nil, true)
			var_8_2:isShowEffect(true)
		else
			gohelper.setActive(var_8_2.go, false)
		end
	end

	local var_8_4 = {}

	for iter_8_1, iter_8_2 in ipairs(arg_8_1) do
		if iter_8_2[1] == MaterialEnum.MaterialType.Building or iter_8_2[1] == MaterialEnum.MaterialType.BlockPackage then
			local var_8_5 = MaterialDataMO.New()

			var_8_5:initValue(iter_8_2[1], iter_8_2[2], 1, 0)
			table.insert(var_8_4, var_8_5)
		end
	end

	if #var_8_4 > 0 then
		RoomController.instance:popUpRoomBlockPackageView(var_8_4)
	end
end

function var_0_0.createList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = arg_9_1
	var_9_0.title1 = gohelper.findChild(arg_9_1, "image_SmallTitle1")
	var_9_0.title2 = gohelper.findChild(arg_9_1, "image_SmallTitle2")
	var_9_0.goContent = gohelper.findChild(arg_9_1, "#scroll_GetRewardList/Viewport/Content")

	return var_9_0
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
