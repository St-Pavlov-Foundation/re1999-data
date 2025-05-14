module("modules.logic.versionactivity2_6.enter.view.subview.VersionActivity2_6RougeEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_6RougeEnterView", BaseView)
local var_0_1 = 103

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_start")
	arg_1_0._btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_reward")
	arg_1_0._goRewardNew = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_reward/#go_new")
	arg_1_0._txtRewardNum = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_reward/#txt_RewardNum")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_locked")
	arg_1_0._txtUnlockedTips = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_locked/#txt_UnLockedTips")
	arg_1_0._btndlc = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_dlc")
	arg_1_0._gostartreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_start/#go_startreddot")
	arg_1_0._goclosetipseffect = gohelper.findChild(arg_1_0.viewGO, "Right/vx_glow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnReward:AddClickListener(arg_2_0._btnRewardOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnLockOnClick, arg_2_0)
	arg_2_0._btndlc:AddClickListener(arg_2_0._btndlcOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_2_0.refreshReward, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinishCallback, arg_2_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_2_0.refreshLock, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnReward:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0._btndlc:RemoveClickListener()
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_3_0.refreshReward, arg_3_0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, arg_3_0.refreshLock, arg_3_0)
end

function var_0_0._btnEnterOnClick(arg_4_0)
	RougeController.instance:openRougeMainView()
end

function var_0_0._btnRewardOnClick(arg_5_0)
	RougeController.instance:openRougeRewardView()
end

function var_0_0._btnLockOnClick(arg_6_0)
	local var_6_0, var_6_1 = OpenHelper.getToastIdAndParam(arg_6_0.config.openId)

	GameFacade.showToastWithTableParam(var_6_0, var_6_1)
end

function var_0_0._btndlcOnClick(arg_7_0)
	if not var_0_1 or var_0_1 == 0 then
		return
	end

	local var_7_0 = {
		dlcId = var_0_1
	}

	ViewMgr.instance:openView(ViewName.RougeDLCTipsView, var_7_0)
	gohelper.setActive(arg_7_0._goclosetipseffect, false)
end

function var_0_0._editableInitView(arg_8_0)
	RougeOutsideController.instance:initDLCReddotInfo()

	arg_8_0.animComp = VersionActivitySubAnimatorComp.get(arg_8_0.viewGO, arg_8_0)

	RedDotController.instance:addRedDot(arg_8_0._gostartreddot, RedDotEnum.DotNode.RougeDLCNew)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(arg_9_0._season)
	arg_9_0.animComp:playOpenAnim()

	arg_9_0.actId = arg_9_0.viewContainer.activityId
	arg_9_0.config = ActivityConfig.instance:getActivityCo(arg_9_0.actId)

	arg_9_0:refreshLock()
	arg_9_0:refreshReward()
	arg_9_0:checkOpenDLCTipsView()
end

function var_0_0.refreshLock(arg_10_0)
	local var_10_0 = arg_10_0.config.openId
	local var_10_1 = var_10_0 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_10_0)

	gohelper.setActive(arg_10_0._btnlock, var_10_1)
	gohelper.setActive(arg_10_0._btnReward.gameObject, not var_10_1)

	if var_10_1 then
		local var_10_2, var_10_3 = OpenHelper.getToastIdAndParam(arg_10_0.config.openId)
		local var_10_4 = ToastConfig.instance:getToastCO(var_10_2).tips
		local var_10_5 = GameUtil.getSubPlaceholderLuaLang(var_10_4, var_10_3)

		arg_10_0._txtUnlockedTips.text = var_10_5
	else
		arg_10_0._txtUnlockedTips.text = ""
	end
end

function var_0_0.refreshReward(arg_11_0)
	arg_11_0._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local var_11_0 = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(arg_11_0._goRewardNew, var_11_0)
end

function var_0_0.checkOpenDLCTipsView(arg_12_0)
	if not var_0_1 or var_0_1 == 0 then
		return
	end

	local var_12_0 = string.format("%s#%s#%s", PlayerPrefsKey.RougePopUpDLCTipsId, PlayerModel.instance:getMyUserId(), var_0_1)

	if string.nilorempty(PlayerPrefsHelper.getString(var_12_0, "")) then
		local var_12_1 = {
			dlcId = var_0_1
		}

		ViewMgr.instance:openView(ViewName.RougeDLCTipsView, var_12_1)
		PlayerPrefsHelper.setString(var_12_0, "true")
	end
end

function var_0_0._onCloseViewFinishCallback(arg_13_0, arg_13_1)
	if arg_13_1 ~= ViewName.RougeDLCTipsView then
		return
	end

	gohelper.setActive(arg_13_0._goclosetipseffect, true)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0.animComp:destroy()
end

return var_0_0
