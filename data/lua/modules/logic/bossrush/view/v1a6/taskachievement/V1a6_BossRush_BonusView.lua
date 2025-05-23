﻿module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusView", package.seeall)

local var_0_0 = class("V1a6_BossRush_BonusView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gobonus = gohelper.findChild(arg_1_0.viewGO, "#go_bonus")
	arg_1_0._goTab3 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab3")
	arg_1_0._goUnSelect3 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab3/#go_UnSelect3")
	arg_1_0._goSelected3 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab3/#go_Selected3")
	arg_1_0._goRedDot3 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab3/#go_RedDot3")
	arg_1_0._btn3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tab/#go_Tab3/#btn_3")
	arg_1_0._goTab1 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab1")
	arg_1_0._goUnSelected1 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab1/#go_UnSelected1")
	arg_1_0._goSelected1 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab1/#go_Selected1")
	arg_1_0._goRedDot1 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab1/#go_RedDot1")
	arg_1_0._btn1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tab/#go_Tab1/#btn_1")
	arg_1_0._goTab2 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab2")
	arg_1_0._goUnSelect2 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab2/#go_UnSelect2")
	arg_1_0._goSelected2 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab2/#go_Selected2")
	arg_1_0._goRedDot2 = gohelper.findChild(arg_1_0.viewGO, "Tab/#go_Tab2/#go_RedDot2")
	arg_1_0._btn2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tab/#go_Tab2/#btn_2")
	arg_1_0._goBlock = gohelper.findChild(arg_1_0.viewGO, "#go_Block")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn3:AddClickListener(arg_2_0._btn3OnClick, arg_2_0)
	arg_2_0._btn1:AddClickListener(arg_2_0._btn1OnClick, arg_2_0)
	arg_2_0._btn2:AddClickListener(arg_2_0._btn2OnClick, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0._refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_2_0._refreshRedDot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn3:RemoveClickListener()
	arg_3_0._btn1:RemoveClickListener()
	arg_3_0._btn2:RemoveClickListener()
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_3_0._refreshRedDot, arg_3_0)
end

function var_0_0._btn1OnClick(arg_4_0)
	arg_4_0:cutTab(BossRushEnum.BonusViewTab.AchievementTab)
end

function var_0_0._btn2OnClick(arg_5_0)
	arg_5_0:cutTab(BossRushEnum.BonusViewTab.ScheduleTab)
end

function var_0_0._btn3OnClick(arg_6_0)
	arg_6_0:cutTab(BossRushEnum.BonusViewTab.SpecialScheduleTab)
end

function var_0_0._btnOnClick(arg_7_0)
	return
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._stage = arg_10_0.viewParam.stage
	arg_10_0._selectTab = BossRushModel.instance:isSpecialActivity() and BossRushEnum.BonusViewTab.SpecialScheduleTab or BossRushEnum.BonusViewTab.AchievementTab

	arg_10_0:activeTab()
	arg_10_0:_refreshTab()
	arg_10_0:_addRedDot()
	BossRushController.instance:sendGetTaskInfoRequest(arg_10_0.openDefaultTab, arg_10_0)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

function var_0_0.openDefaultTab(arg_13_0)
	arg_13_0:selectTab(arg_13_0._selectTab)
	arg_13_0:_refreshRedDot()
end

function var_0_0.cutTab(arg_14_0, arg_14_1)
	if arg_14_0._selectTab and arg_14_0._selectTab == arg_14_1 then
		return
	end

	arg_14_0._selectTab = arg_14_1

	arg_14_0:activeTab()
	arg_14_0:selectTab(arg_14_0._selectTab)
end

function var_0_0.selectTab(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.viewContainer:selectTabView(arg_15_1, arg_15_2)
end

function var_0_0.activeTab(arg_16_0)
	gohelper.setActive(arg_16_0._goUnSelected1, arg_16_0._selectTab ~= BossRushEnum.BonusViewTab.AchievementTab)
	gohelper.setActive(arg_16_0._goSelected1, arg_16_0._selectTab == BossRushEnum.BonusViewTab.AchievementTab)
	gohelper.setActive(arg_16_0._goUnSelect2, arg_16_0._selectTab ~= BossRushEnum.BonusViewTab.ScheduleTab)
	gohelper.setActive(arg_16_0._goSelected2, arg_16_0._selectTab == BossRushEnum.BonusViewTab.ScheduleTab)
	gohelper.setActive(arg_16_0._goUnSelect3, arg_16_0._selectTab ~= BossRushEnum.BonusViewTab.SpecialScheduleTab)
	gohelper.setActive(arg_16_0._goSelected3, arg_16_0._selectTab == BossRushEnum.BonusViewTab.SpecialScheduleTab)
end

function var_0_0._addRedDot(arg_17_0)
	local var_17_0 = RedDotEnum.DotNode.BossRushBossSchedule
	local var_17_1 = BossRushRedModel.instance:getUId(var_17_0, arg_17_0._stage)

	RedDotController.instance:addRedDot(arg_17_0._goRedDot2, var_17_0, var_17_1)

	local var_17_2 = RedDotEnum.DotNode.BossRushBossAchievement
	local var_17_3 = BossRushRedModel.instance:getUId(var_17_2, arg_17_0._stage)

	RedDotController.instance:addRedDot(arg_17_0._goRedDot1, var_17_2, var_17_3)
	RedDotController.instance:addRedDot(arg_17_0._goRedDot3, var_17_2, var_17_3)
end

function var_0_0._refreshRedDot(arg_18_0)
	local var_18_0 = V1a4_BossRush_ScoreTaskAchievementListModel.instance:isReddot(arg_18_0._stage)
	local var_18_1 = V2a1_BossRush_SpecialScheduleViewListModel.instance:isReddot(arg_18_0._stage)

	gohelper.setActive(arg_18_0._goRedDot1, var_18_0)
	gohelper.setActive(arg_18_0._goRedDot3, var_18_1)
end

function var_0_0._refreshTab(arg_19_0)
	local var_19_0 = BossRushModel.instance:isSpecialActivity()

	gohelper.setActive(arg_19_0._goTab3, var_19_0)

	local var_19_1 = var_19_0 and 326 or 489

	recthelper.setWidth(arg_19_0._goTab1.transform, var_19_1)
	recthelper.setWidth(arg_19_0._goTab2.transform, var_19_1)
	recthelper.setWidth(arg_19_0._goTab3.transform, var_19_1)
end

return var_0_0
