module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusView", package.seeall)

local var_0_0 = class("V1a6_BossRush_BonusView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gobonus = gohelper.findChild(arg_1_0.viewGO, "#go_bonus")
	arg_1_0._goTab1 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab1")
	arg_1_0._goTab2 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab2")
	arg_1_0._goTab3 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab3")
	arg_1_0._goBlock = gohelper.findChild(arg_1_0.viewGO, "#go_Block")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0._refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_2_0._refreshRedDot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_3_0._refreshRedDot, arg_3_0)
end

function var_0_0._btnOnClick(arg_4_0, arg_4_1)
	arg_4_0:cutTab(arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._tabs = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, 3 do
		local var_5_0 = arg_5_0:getUserDataTb_()
		local var_5_1 = arg_5_0["_goTab" .. iter_5_0]
		local var_5_2 = gohelper.findChild(var_5_1, "#go_UnSelect")
		local var_5_3 = gohelper.findChild(var_5_1, "#go_Selected")
		local var_5_4 = gohelper.findChild(var_5_1, "#go_RedDot")

		var_5_0.go = var_5_1
		var_5_0.goUnSelected = var_5_2
		var_5_0.txtUnSelected = gohelper.findChildText(var_5_2, "txt_Tab")
		var_5_0.goSelected = var_5_3
		var_5_0.txtSelected = gohelper.findChildText(var_5_3, "txt_Tab")
		var_5_0.goRedDot = var_5_4
		var_5_0.btn = gohelper.findChildButtonWithAudio(var_5_1, "#btn")

		var_5_0.btn:AddClickListener(arg_5_0._btnOnClick, arg_5_0, iter_5_0)

		arg_5_0._tabs[iter_5_0] = var_5_0
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._stage = arg_7_0.viewParam.stage
	arg_7_0._selectTab = arg_7_0.viewParam.defaultTab or V1a6_BossRush_BonusModel.instance:getTab()

	arg_7_0:_refreshRedDot()
	arg_7_0:activeTab()
	arg_7_0:_refreshTab()
	arg_7_0:_addRedDot()

	if arg_7_0._selectTab == BossRushEnum.BonusViewTab.AchievementTab then
		V1a6_BossRush_BonusModel.instance:selecAchievementTab(arg_7_0._stage)
	end
end

function var_0_0.onClose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._tabs) do
		iter_8_1.btn:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.openDefaultTab(arg_10_0)
	arg_10_0:selectTab(arg_10_0._selectTab)
	arg_10_0:_refreshRedDot()
end

function var_0_0.cutTab(arg_11_0, arg_11_1)
	if arg_11_0._selectTab and arg_11_0._selectTab == arg_11_1 then
		return
	end

	arg_11_0._selectTab = arg_11_1

	arg_11_0:activeTab()
	arg_11_0:selectTab(arg_11_0._selectTab)
end

function var_0_0.selectTab(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.viewContainer:selectTabView(arg_12_1, arg_12_2)
end

function var_0_0.activeTab(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._tabs) do
		gohelper.setActive(iter_13_1.goUnSelected, iter_13_0 ~= arg_13_0._selectTab)
		gohelper.setActive(iter_13_1.goSelected, iter_13_0 == arg_13_0._selectTab)
	end
end

function var_0_0._addRedDot(arg_14_0)
	local var_14_0 = BossRushModel.instance:getActivityBonus()

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_1 = iter_14_1.Reddot
			local var_14_2 = arg_14_0._tabs[iter_14_0].goRedDot

			if var_14_1 and var_14_2 then
				local var_14_3 = BossRushRedModel.instance:getUId(var_14_1, arg_14_0._stage)

				RedDotController.instance:addRedDot(var_14_2, var_14_1, var_14_3)
			end
		end
	end
end

function var_0_0._refreshRedDot(arg_15_0)
	local var_15_0 = BossRushModel.instance:getActivityBonus()

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = arg_15_0._tabs[iter_15_0].goRedDot

			if var_15_1 and iter_15_1.ListModel and iter_15_1.ListModel.instance.isReddot then
				local var_15_2 = iter_15_1.ListModel.instance:isReddot(arg_15_0._stage, iter_15_0)

				gohelper.setActive(var_15_1, var_15_2)
			end
		end
	end
end

function var_0_0._refreshTab(arg_16_0)
	local var_16_0 = BossRushModel.instance:getActivityBonus()
	local var_16_1 = #var_16_0 > 2 and 326 or 489

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._tabs) do
		recthelper.setWidth(iter_16_1.go.transform, var_16_1)
		gohelper.setActive(iter_16_1.go, iter_16_0 <= #var_16_0)

		local var_16_2 = var_16_0[iter_16_0] and var_16_0[iter_16_0].TabTitle

		if not string.nilorempty(var_16_2) then
			iter_16_1.txtUnSelected.text = luaLang(var_16_2)
			iter_16_1.txtSelected.text = luaLang(var_16_2)
		end
	end
end

return var_0_0
