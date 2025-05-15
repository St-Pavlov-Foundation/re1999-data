module("modules.logic.survival.view.SurvivalEnterView", package.seeall)

local var_0_0 = class("SurvivalEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_achievement")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_reward")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#simage_FullBG/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_reward/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._onRewardClick, arg_2_0)
	arg_2_0._btnAchievement:AddClickListener(arg_2_0._btnAchievementOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnAchievement:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)
	RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V2a8Survival)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.config = ActivityConfig.instance:getActivityCo(VersionActivity2_8Enum.ActivityId.Survival)
	arg_5_0._txtDescr.text = arg_5_0.config.actDesc
end

function var_0_0._onEnterClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.SurvivalView)
end

function var_0_0._btnAchievementOnClick(arg_7_0)
	local var_7_0 = arg_7_0.config.achievementJumpId

	JumpController.instance:jump(var_7_0)
end

function var_0_0.everySecondCall(arg_8_0)
	arg_8_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_8Enum.ActivityId.Survival)
end

function var_0_0._onRewardClick(arg_9_0)
	ViewMgr.instance:openView(ViewName.SurvivalShelterRewardView)
end

return var_0_0
