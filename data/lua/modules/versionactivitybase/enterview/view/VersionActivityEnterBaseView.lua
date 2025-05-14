module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseView", package.seeall)

local var_0_0 = class("VersionActivityEnterBaseView", BaseView)

var_0_0.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_time")
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnReplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
end

var_0_0.ActUnlockAnimationDuration = 2

function var_0_0._btnReplayOnClick(arg_4_0)
	local var_4_0 = ActivityModel.instance:getActMO(arg_4_0.actId)
	local var_4_1 = var_4_0 and var_4_0.config and var_4_0.config.storyId

	if not var_4_1 then
		logError(string.format("act id %s dot config story id", var_4_1))

		return
	end

	local var_4_2 = {}

	var_4_2.isVersionActivityPV = true

	StoryController.instance:playStory(var_4_1, var_4_2)
end

function var_0_0.defaultCheckActivityCanClick(arg_5_0, arg_5_1)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(arg_5_1.actId)

	if var_5_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_5_1 then
			GameFacade.showToastWithTableParam(var_5_1, var_5_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return true
end

function var_0_0._activityBtnOnClick(arg_6_0, arg_6_1)
	if arg_6_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not (arg_6_0["checkActivityCanClickFunc" .. arg_6_1.index] or arg_6_0.defaultCheckActivityCanClick)(arg_6_0, arg_6_1) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	local var_6_0 = arg_6_0["onClickActivity" .. arg_6_1.index]

	if var_6_0 then
		var_6_0(arg_6_0, arg_6_1.actId)
	end

	ActivityEnterMgr.instance:enterActivity(arg_6_1.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_6_1.actId
	})
end

function var_0_0.initActivityItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.index = arg_7_1
	var_7_0.actId = arg_7_2
	var_7_0.rootGo = arg_7_3

	local var_7_1 = ActivityConfig.instance:getActivityCo(arg_7_2)

	var_7_0.openId = var_7_1 and var_7_1.openId
	var_7_0.redDotId = var_7_1 and var_7_1.redDotId
	var_7_0.animator = var_7_0.rootGo:GetComponent(typeof(UnityEngine.Animator))
	var_7_0.goNormal = gohelper.findChild(arg_7_3, "normal")
	var_7_0.goNormalAnimator = var_7_0.goNormal:GetComponent(typeof(UnityEngine.Animator))

	if var_7_0.goNormalAnimator then
		var_7_0.goNormalAnimator.enabled = false
	end

	var_7_0.goNormalCanvas = var_7_0.goNormal:GetComponent(typeof(UnityEngine.CanvasGroup))

	local var_7_2 = VersionActivityEnum.EnterViewNormalAnimationPath[arg_7_2]

	if var_7_2 then
		local var_7_3 = gohelper.findChild(arg_7_3, var_7_2)

		if var_7_3 then
			var_7_0.normalAnimation = var_7_3:GetComponent(typeof(UnityEngine.Animation))
		end
	end

	var_7_0.txtActivityName = gohelper.findChildText(arg_7_3, "normal/txt_Activity")
	var_7_0.goLockContainer = gohelper.findChild(arg_7_3, "lockContainer")
	var_7_0.txtLockGo = gohelper.findChild(arg_7_3, "lockContainer/lock")
	var_7_0.txtLock = gohelper.findChildText(arg_7_3, "lockContainer/lock/txt_lock")
	var_7_0.goRedPoint = gohelper.findChild(arg_7_3, "redpoint")
	var_7_0.goRedPointTag = gohelper.findChild(arg_7_3, "tag")
	var_7_0.goRedPointTagNewAct = gohelper.findChild(arg_7_3, "tag/new_act")
	var_7_0.goRedPointTagNewEpisode = gohelper.findChild(arg_7_3, "tag/new_episode")
	var_7_0.goTime = gohelper.findChild(arg_7_3, "timeContainer")
	var_7_0.txtTime = gohelper.findChildText(arg_7_3, "timeContainer/time")
	var_7_0.txtRemainTime = gohelper.findChildText(arg_7_3, "timeContainer/TimeBG/remain_time")
	var_7_0.click = SLFramework.UGUI.ButtonWrap.Get(arg_7_3)

	var_7_0.click:AddClickListener(arg_7_0._activityBtnOnClick, arg_7_0, var_7_0)
	gohelper.setActive(var_7_0.goRedPointTag, true)
	gohelper.setActive(var_7_0.goRedPointTagNewAct, false)
	gohelper.setActive(var_7_0.goRedPointTagNewEpisode, false)

	var_7_0.redPointTagAnimator = var_7_0.goRedPointTag and var_7_0.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return var_7_0
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0.activityGoContainerList = {}
	arg_8_0.activityItemList = {}
	arg_8_0.playedNewActTagAnimationIdList = nil

	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_8_0.checkNeedRefreshUI, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0.checkNeedRefreshUI, arg_8_0)
	arg_8_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_8_0.refreshAllNewActOpenTagUI, arg_8_0)
	arg_8_0:addEventCb(NavigateMgr.instance, NavigateEvent.BeforeClickHome, arg_8_0.beforeClickHome, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.everyMinuteCall, arg_8_0, TimeUtil.OneMinuteSecond)
	arg_8_0:playBgm()
end

function var_0_0.beforeClickHome(arg_9_0)
	arg_9_0.clickedHome = true
end

function var_0_0.checkNeedRefreshUI(arg_10_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_10_0.viewName) then
		return
	end

	if arg_10_0.clickedHome then
		return
	end

	arg_10_0:refreshUI()
	ActivityStageHelper.recordActivityStage(arg_10_0.activityIdList)
end

function var_0_0.initViewParam(arg_11_0)
	arg_11_0.actId = arg_11_0.viewParam.actId
	arg_11_0.skipOpenAnim = arg_11_0.viewParam.skipOpenAnim
	arg_11_0.activityIdList = arg_11_0.viewParam.activityIdList
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:initViewParam()
	arg_12_0:refreshUI()
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.onOpening = true

	arg_13_0:initViewParam()
	arg_13_0:initActivityNode()
	arg_13_0:initActivityItemList()
	arg_13_0:refreshUI()
	arg_13_0:playOpenAnimation()
end

function var_0_0.initActivityNode(arg_14_0)
	local var_14_0

	for iter_14_0 = 1, #arg_14_0.activityIdList do
		local var_14_1 = arg_14_0.activityGoContainerList[iter_14_0]

		if not var_14_1 then
			var_14_1 = gohelper.findChild(arg_14_0.viewGO, "entrance/activityContainer" .. iter_14_0)

			if gohelper.isNil(var_14_1) then
				logError("not found container node : entrance/activityContainer" .. iter_14_0)
			end

			table.insert(arg_14_0.activityGoContainerList, var_14_1)
		end

		gohelper.setActive(var_14_1, true)
	end

	for iter_14_1 = #arg_14_0.activityIdList + 1, #arg_14_0.activityGoContainerList do
		gohelper.setActive(arg_14_0.activityGoContainerList[iter_14_1], false)
	end
end

function var_0_0.initActivityItemList(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.activityIdList do
		table.insert(arg_15_0.activityItemList, arg_15_0:initActivityItem(iter_15_0, arg_15_0.activityIdList[iter_15_0], arg_15_0.activityGoContainerList[iter_15_0]))
	end
end

function var_0_0.getVersionActivityItems(arg_16_0, arg_16_1)
	local var_16_0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.activityItemList) do
		if iter_16_1.actId == arg_16_1 then
			var_16_0 = var_16_0 or {}

			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0.playOpenAnimation(arg_17_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(arg_17_0.viewName .. "playOpenAnimation")

	if arg_17_0.skipOpenAnim then
		arg_17_0.animator:Play(UIAnimationName.Idle)
		TaskDispatcher.runDelay(arg_17_0.onOpenAnimationDone, arg_17_0, 0.5)
	else
		AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_open)
		arg_17_0.animator:Play(UIAnimationName.Open)
		TaskDispatcher.runDelay(arg_17_0.onOpenAnimationDone, arg_17_0, 2.167)
	end
end

function var_0_0.refreshUI(arg_18_0)
	arg_18_0:refreshCenterActUI()
	arg_18_0:refreshActivityUI()
end

function var_0_0.refreshCenterActUI(arg_19_0)
	local var_19_0 = ActivityModel.instance:getActivityInfo()[arg_19_0.actId]

	if arg_19_0._txttime then
		arg_19_0._txttime.text = var_19_0:getStartTimeStr() .. " ~ " .. var_19_0:getEndTimeStr()
	end
end

function var_0_0.refreshActivityUI(arg_20_0)
	arg_20_0.playedActTagAudio = false
	arg_20_0.playedActUnlockAudio = false

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.activityItemList) do
		arg_20_0:refreshActivityItem(iter_20_1)
	end
end

function var_0_0._setCanvasGroupAlpha(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 then
		arg_21_1.alpha = arg_21_2
	end
end

function var_0_0.defaultBeforePlayActUnlockAnimation(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_1.goTime, false)
	gohelper.setActive(arg_22_1.goLockContainer, true)
	arg_22_0:_setCanvasGroupAlpha(arg_22_1.goNormalCanvas, 0.5)

	if arg_22_1.txtLockGo then
		gohelper.setActive(arg_22_1.txtLockGo, false)
	end
end

function var_0_0.refreshActivityItem(arg_23_0, arg_23_1)
	if arg_23_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local var_23_0 = ActivityHelper.getActivityStatus(arg_23_1.actId)

	logNormal("act id : " .. arg_23_1.actId .. ", status : " .. var_23_0)

	local var_23_1 = var_23_0 == ActivityEnum.ActivityStatus.Normal
	local var_23_2 = ActivityModel.instance:getActivityInfo()[arg_23_1.actId]

	if arg_23_1.normalAnimation then
		arg_23_1.normalAnimation.enabled = var_23_1
	end

	if var_23_1 and not VersionActivityBaseController.instance:isPlayedUnlockAnimation(arg_23_1.actId) then
		arg_23_1.lockAnimator = arg_23_1.goLockContainer and arg_23_1.goLockContainer:GetComponent(typeof(UnityEngine.Animator))

		if not arg_23_1.lockAnimator then
			arg_23_0:refreshLockUI(arg_23_1, var_23_0)
		else
			(arg_23_0["beforePlayActUnlockAnimationActivity" .. arg_23_1.index] or arg_23_0.defaultBeforePlayActUnlockAnimation)(arg_23_0, arg_23_1)
			arg_23_0:playActUnlockAnimation(arg_23_1)
		end
	else
		arg_23_0:refreshLockUI(arg_23_1, var_23_0)
	end

	if arg_23_1.animator then
		if var_23_0 == ActivityEnum.ActivityStatus.Normal then
			arg_23_1.animator:Play(UIAnimationName.Loop)
		else
			arg_23_1.animator:Play(UIAnimationName.Idle)
		end
	end

	if arg_23_1.txtTime then
		arg_23_1.txtTime.text = var_23_2:getStartTimeStr() .. "~" .. var_23_2:getEndTimeStr()
	end

	if arg_23_1.txtRemainTime then
		if var_23_0 == ActivityEnum.ActivityStatus.Normal then
			arg_23_1.txtRemainTime.text = string.format(luaLang("remain"), var_23_2:getRemainTimeStr2ByEndTime())
		else
			arg_23_1.txtRemainTime.text = ""
		end
	end

	if arg_23_1.txtActivityName then
		arg_23_1.txtActivityName.text = var_23_2.config.name
	end

	if var_23_1 and arg_23_1.redDotId and arg_23_1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_23_1.goRedPoint, arg_23_1.redDotId)
	end

	gohelper.setActive(arg_23_1.goRedPointTag, var_23_1)
	gohelper.setActive(arg_23_1.goRedPointTagNewAct, false)
	gohelper.setActive(arg_23_1.goRedPointTagNewEpisode, false)

	arg_23_1.showTag = nil

	if var_23_1 then
		if not ActivityEnterMgr.instance:isEnteredActivity(arg_23_1.actId) then
			arg_23_1.showTag = var_0_0.ShowActTagEnum.ShowNewAct

			arg_23_0:playActTagAnimation(arg_23_1)
		elseif var_23_2:isNewStageOpen() then
			arg_23_1.showTag = var_0_0.ShowActTagEnum.ShowNewStage

			arg_23_0:playActTagAnimation(arg_23_1)
		end
	end

	local var_23_3 = arg_23_0["onRefreshActivity" .. arg_23_1.index]

	if var_23_3 then
		var_23_3(arg_23_0, arg_23_1)
	end
end

function var_0_0.refreshLockUI(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 == ActivityEnum.ActivityStatus.Normal
	local var_24_1 = ActivityModel.instance:getActivityInfo()[arg_24_1.actId]

	gohelper.setActive(arg_24_1.goLockContainer, not var_24_0)
	arg_24_0:_setCanvasGroupAlpha(arg_24_1.goNormalCanvas, not var_24_0 and 0.5 or 1)
	gohelper.setActive(arg_24_1.txtLockGo, not var_24_0)
	gohelper.setActive(arg_24_1.goTime, var_24_0)

	if not var_24_0 and arg_24_1.txtLock then
		local var_24_2

		if arg_24_2 == ActivityEnum.ActivityStatus.NotOpen then
			var_24_2 = string.format(luaLang("test_task_unlock_time"), var_24_1:getRemainTimeStr2ByOpenTime())
		elseif arg_24_2 == ActivityEnum.ActivityStatus.Expired then
			var_24_2 = luaLang("p_activityenter_finish")
		elseif arg_24_2 == ActivityEnum.ActivityStatus.NotUnlock then
			var_24_2 = luaLang("p_versionactivitytripenter_lock")
		elseif arg_24_2 == ActivityEnum.ActivityStatus.NotOnLine then
			var_24_2 = luaLang("p_activityenter_finish")
		elseif arg_24_2 == ActivityEnum.ActivityStatus.None then
			var_24_2 = luaLang("p_activityenter_finish")
		end

		arg_24_1.txtLock.text = var_24_2
	end
end

function var_0_0.refreshAllNewActOpenTagUI(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.activityItemList) do
		local var_25_0 = ActivityHelper.getActivityStatus(iter_25_1.actId) == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(iter_25_1.goRedPointTag, var_25_0)
		gohelper.setActive(iter_25_1.goRedPointTagNewAct, var_25_0 and not ActivityEnterMgr.instance:isEnteredActivity(iter_25_1.actId))
	end
end

function var_0_0.isPlayedActTagAnimation(arg_26_0, arg_26_1)
	if not arg_26_0.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(arg_26_0.playedNewActTagAnimationIdList, arg_26_1)
end

function var_0_0.playActTagAnimation(arg_27_0, arg_27_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_27_0.viewName) then
		return
	end

	if arg_27_0.onOpening or arg_27_0.playingUnlockAnimation then
		arg_27_0.needPlayNewActTagActIdList = arg_27_0.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(arg_27_0.needPlayNewActTagActIdList, arg_27_1.actId) then
			table.insert(arg_27_0.needPlayNewActTagActIdList, arg_27_1.actId)
		end
	else
		arg_27_0:_playActTagAnimation(arg_27_1)
	end
end

function var_0_0._playActTagAnimations(arg_28_0, arg_28_1)
	if not arg_28_1 then
		return
	end

	for iter_28_0, iter_28_1 in pairs(arg_28_1) do
		arg_28_0:_playActTagAnimation(iter_28_1)
	end
end

function var_0_0._playActTagAnimation(arg_29_0, arg_29_1)
	if arg_29_1.showTag == var_0_0.ShowActTagEnum.ShowNewAct then
		gohelper.setActive(arg_29_1.goRedPointTagNewAct, true)
	elseif arg_29_1.showTag == var_0_0.ShowActTagEnum.ShowNewStage then
		gohelper.setActive(arg_29_1.goRedPointTagNewEpisode, true)
	end

	arg_29_0.playedNewActTagAnimationIdList = arg_29_0.playedNewActTagAnimationIdList or {}

	if not arg_29_1.redPointTagAnimator then
		table.insert(arg_29_0.playedNewActTagAnimationIdList, arg_29_1.actId)

		return
	end

	if not arg_29_0:isPlayedActTagAnimation(arg_29_1.actId) then
		arg_29_1.redPointTagAnimator:Play(UIAnimationName.Open)
		table.insert(arg_29_0.playedNewActTagAnimationIdList, arg_29_1.actId)

		if not arg_29_0.playedActTagAudio and not arg_29_0.onOpening then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			arg_29_0.playedActTagAudio = true
		end
	end
end

function var_0_0.playActUnlockAnimation(arg_30_0, arg_30_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_30_0.viewName) then
		return
	end

	if arg_30_0.onOpening then
		arg_30_0.needPlayUnlockAnimationActIdList = arg_30_0.needPlayUnlockAnimationActIdList or {}

		if not tabletool.indexOf(arg_30_0.needPlayUnlockAnimationActIdList, arg_30_1.actId) then
			table.insert(arg_30_0.needPlayUnlockAnimationActIdList, arg_30_1.actId)
		end
	else
		arg_30_0:_playActUnlockAnimation(arg_30_1)
	end
end

function var_0_0._playActUnlockAnimations(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		arg_31_0:_playActUnlockAnimation(iter_31_1)
	end
end

function var_0_0._playActUnlockAnimation(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(arg_32_1.actId)

	if arg_32_1.lockAnimator then
		if arg_32_1.goNormalAnimator then
			arg_32_1.goNormalAnimator.enabled = true
		end

		arg_32_1.lockAnimator:Play(UIAnimationName.Open, 0, 0)
		arg_32_0:playTimeUnlock(arg_32_1)

		if not arg_32_0.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_unlock)

			arg_32_0.playedActUnlockAudio = true
		end

		arg_32_0.playingUnlockAnimation = true

		TaskDispatcher.runDelay(arg_32_0.playUnlockAnimationDone, arg_32_0, var_0_0.ActUnlockAnimationDuration)
	end
end

function var_0_0.playTimeUnlock(arg_33_0, arg_33_1)
	arg_33_1.timeAnimator = arg_33_1.goTime and arg_33_1.goTime:GetComponent(typeof(UnityEngine.Animator))

	if arg_33_1.timeAnimator then
		arg_33_0.needPlayTimeUnlockList = arg_33_0.needPlayTimeUnlockList or {}

		if not tabletool.indexOf(arg_33_0.needPlayTimeUnlockList, arg_33_1) then
			table.insert(arg_33_0.needPlayTimeUnlockList, arg_33_1)
		end
	end
end

function var_0_0.playAllTimeUnlockAnimation(arg_34_0)
	if arg_34_0.needPlayTimeUnlockList then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0.needPlayTimeUnlockList) do
			if iter_34_1.timeAnimator then
				gohelper.setActive(iter_34_1.goTime, true)
				iter_34_1.timeAnimator:Play(UIAnimationName.Open, 0, 0)
			end
		end
	end
end

function var_0_0.playUnlockAnimationDone(arg_35_0)
	arg_35_0.playingUnlockAnimation = false

	arg_35_0:playAllTimeUnlockAnimation()
	arg_35_0:playAllNewTagAnimation()
end

function var_0_0.onOpenAnimationDone(arg_36_0)
	UIBlockMgr.instance:endBlock(arg_36_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if not ViewHelper.instance:checkViewOnTheTop(arg_36_0.viewName) then
		arg_36_0.onOpening = false

		return
	end

	if arg_36_0.needPlayUnlockAnimationActIdList then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0.needPlayUnlockAnimationActIdList) do
			arg_36_0:_playActUnlockAnimations(arg_36_0:getVersionActivityItems(iter_36_1))
		end

		arg_36_0.needPlayUnlockAnimationActIdList = nil
	end

	if not arg_36_0.playingUnlockAnimation then
		arg_36_0:playAllNewTagAnimation()
	end

	arg_36_0.onOpening = false
end

function var_0_0.playAllNewTagAnimation(arg_37_0)
	if arg_37_0.needPlayNewActTagActIdList then
		for iter_37_0, iter_37_1 in ipairs(arg_37_0.needPlayNewActTagActIdList) do
			arg_37_0:_playActTagAnimations(arg_37_0:getVersionActivityItems(iter_37_1))
		end

		arg_37_0.needPlayNewActTagActIdList = nil
	end
end

function var_0_0.everyMinuteCall(arg_38_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_38_0.viewName) then
		return
	end

	arg_38_0:refreshUI()
end

function var_0_0.onClose(arg_39_0)
	UIBlockMgr.instance:endBlock(arg_39_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_39_0:stopBgm()
	TaskDispatcher.cancelTask(arg_39_0.everyMinuteCall, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0.onOpenAnimationDone, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0.playUnlockAnimationDone, arg_39_0)
end

function var_0_0.onDestroyView(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.activityItemList) do
		iter_40_1.click:RemoveClickListener()
	end
end

function var_0_0.playBgm(arg_41_0)
	return
end

function var_0_0.stopBgm(arg_42_0)
	return
end

return var_0_0
