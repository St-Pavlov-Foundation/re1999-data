module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity3_0DungeonEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/actbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/#txt_time")
	arg_1_0._btnboard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Board")
	arg_1_0._txtpapernum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_Board/#txt_num")
	arg_1_0._goboardreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Board/#go_reddot")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._gonewunlock = gohelper.findChild(arg_1_0.viewGO, "entrance/#go_newunlock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshStoreCurrency, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_2_0._onUpdateDungeonInfo, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshDot, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_2_0.refreshDot, arg_2_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_2_0.refreshPaperCount, arg_2_0)
	arg_2_0._btnboard:AddClickListener(arg_2_0._btnboardOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0._btnFinished:AddClickListener(arg_2_0._btnFinishedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStoreCurrency, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivity, arg_3_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_3_0._onUpdateDungeonInfo, arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_3_0.refreshDot, arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshDot, arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_3_0.refreshDot, arg_3_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_3_0.refreshPaperCount, arg_3_0)
	arg_3_0._btnboard:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnenter:RemoveClickListener()
	arg_3_0._btnFinished:RemoveClickListener()
end

function var_0_0._onUpdateDungeonInfo(arg_4_0)
	if arg_4_0._hasPreviewFlag then
		arg_4_0:refreshPreviewStatus()
	end

	arg_4_0:_updateBg()
end

function var_0_0.onRefreshActivity(arg_5_0, arg_5_1)
	if arg_5_0._hasPreviewFlag then
		arg_5_0:refreshPreviewStatus()
	end

	if arg_5_1 ~= arg_5_0.actId then
		return
	end

	arg_5_0:refreshActivityState()
end

function var_0_0._btnboardOnClick(arg_6_0)
	CommandStationController.instance:openCommandStationPaperView()
end

function var_0_0._btnstoreOnClick(arg_7_0)
	VersionActivity3_0DungeonController.instance:openStoreView()
end

function var_0_0._btnenterOnClick(arg_8_0)
	local var_8_0 = arg_8_0._hasPreviewFlag

	if arg_8_0._hasPreviewFlag then
		local var_8_1 = DungeonMainStoryModel.getKey(PlayerPrefsKey.DungeonPreviewChapter, arg_8_0._chapterId)

		PlayerPrefsHelper.setNumber(var_8_1, 1)
		arg_8_0:refreshPreviewStatus()
	end

	if not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(DungeonMainStoryEnum.Guide.EarlyAccess) then
		DungeonMainStoryModel.instance:setJumpFocusChapterId(arg_8_0._chapterId)
		DungeonController.instance:enterDungeonView(true, true)

		return
	end

	if arg_8_0._chapterId and DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_8_0._chapterId) then
		local var_8_2 = DungeonMainStoryModel.getKey(PlayerPrefsKey.OpenDungeonPreviewChapter, arg_8_0._chapterId)

		if not PlayerPrefsHelper.hasKey(var_8_2) then
			GameFacade.showMessageBox(MessageBoxIdDefine.PreviewChapterOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_8_2, 1)
				VersionActivity3_0DungeonController.instance:openVersionActivityDungeonMapView()
			end, nil, nil)

			return
		end
	end

	VersionActivity3_0DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnFinishedOnClick(arg_10_0)
	return
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._txtstorename = gohelper.findChildText(arg_11_0.viewGO, "entrance/#btn_store/normal/txt_shop")
	arg_11_0._chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()
	arg_11_0.actId = VersionActivity3_0Enum.ActivityId.Dungeon
	arg_11_0.animComp = VersionActivity3_0SubAnimatorComp.get(arg_11_0.viewGO, arg_11_0)
	arg_11_0.goEnter = arg_11_0._btnenter.gameObject
	arg_11_0.goFinish = arg_11_0._btnFinished.gameObject
	arg_11_0.goStore = arg_11_0._btnstore.gameObject
	arg_11_0.actId = VersionActivity3_0Enum.ActivityId.Dungeon
	arg_11_0.actCo = ActivityConfig.instance:getActivityCo(arg_11_0.actId)
	arg_11_0._videoComp = VersionActivityVideoComp.get(gohelper.findChild(arg_11_0.viewGO, "#simage_bg"), arg_11_0)

	arg_11_0:_setDesc()
	arg_11_0:refreshDot()
	RedDotController.instance:addRedDot(arg_11_0._goboardreddot, RedDotEnum.DotNode.CommandStationTask)
	arg_11_0:_updateBg()
end

function var_0_0._updateBg(arg_12_0)
	if DungeonModel.instance:hasPassLevelAndStory(11115) then
		arg_12_0._simagebg:LoadImage("singlebg/v3a0_mainactivity_singlebg/v3a0_enterview_fullbg.png")
	else
		arg_12_0._simagebg:LoadImage("singlebg/v3a0_mainactivity_singlebg/v3a0_enterview_fullbg.png")
	end
end

function var_0_0.refreshDot(arg_13_0)
	RedDotController.instance:addRedDot(arg_13_0._goreddot, RedDotEnum.DotNode.V3a0DungeonEnter)
end

function var_0_0._setDesc(arg_14_0)
	if not arg_14_0.actCo or not arg_14_0._txtdesc then
		return
	end

	arg_14_0._txtdesc.text = arg_14_0.actCo.actDesc
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:refreshUI()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:refreshUI()
	arg_16_0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(arg_16_0.everyMinuteCall, arg_16_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onOpenFinish(arg_17_0)
	arg_17_0._videoPath = langVideoUrl(VersionActivity3_0Enum.EnterLoopVideoName)

	if arg_17_0.viewParam and arg_17_0.viewParam.playVideo and arg_17_0.viewContainer then
		arg_17_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_17_0.onPlayVideoDone, arg_17_0)
		arg_17_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_17_0.onPlayVideoDone, arg_17_0)
		arg_17_0._videoComp:loadMedia(arg_17_0._videoPath)
	else
		arg_17_0._videoComp:play(arg_17_0._videoPath, true)
	end
end

function var_0_0.onPlayVideoDone(arg_18_0)
	arg_18_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_18_0.onPlayVideoDone, arg_18_0)
	arg_18_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_18_0.onPlayVideoDone, arg_18_0)
	arg_18_0._videoComp:play(arg_18_0._videoPath, true)
end

function var_0_0.everyMinuteCall(arg_19_0)
	arg_19_0:refreshUI()
end

function var_0_0.refreshUI(arg_20_0)
	arg_20_0:refreshRemainTime()
	arg_20_0:refreshActivityState()
	arg_20_0:refreshStoreCurrency()
	arg_20_0:refreshPreviewStatus()
	arg_20_0:refreshPaperCount()
end

function var_0_0.refreshPaperCount(arg_21_0)
	local var_21_0 = CommandStationConfig.instance:getPaperList()
	local var_21_1 = 0
	local var_21_2 = 0
	local var_21_3 = CommandStationConfig.instance:getCurVersionId()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.versionId == var_21_3 then
			var_21_2 = iter_21_1.allNum

			break
		end

		var_21_1 = var_21_1 + iter_21_1.allNum
	end

	local var_21_4 = CommandStationConfig.instance:getCurPaperCount() - var_21_1
	local var_21_5 = Mathf.Clamp(var_21_4, 0, var_21_2)

	arg_21_0._txtpapernum.text = string.format("%d/%d", var_21_5, var_21_2)
end

function var_0_0.refreshPreviewStatus(arg_22_0)
	arg_22_0._hasPreviewFlag = arg_22_0._chapterId and DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_22_0._chapterId) and not DungeonMainStoryModel.hasKey(PlayerPrefsKey.DungeonPreviewChapter, arg_22_0._chapterId)

	gohelper.setActive(arg_22_0._gonewunlock, arg_22_0._hasPreviewFlag)
end

function var_0_0.refreshRemainTime(arg_23_0)
	local var_23_0 = ActivityModel.instance:getActivityInfo()[arg_23_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	if var_23_0 > 0 then
		local var_23_1 = TimeUtil.SecondToActivityTimeFormat(var_23_0)

		arg_23_0._txttime.text = var_23_1

		gohelper.setActive(arg_23_0._txttime, true)
	else
		gohelper.setActive(arg_23_0._txttime, false)
	end

	local var_23_2 = ActivityModel.instance:getActivityInfo()[VersionActivity3_0Enum.ActivityId.DungeonStore]

	arg_23_0._txtstorename.text = var_23_2.config.name
	arg_23_0._txtStoreTime.text = var_23_2:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.refreshActivityState(arg_24_0)
	local var_24_0 = ActivityHelper.getActivityStatusAndToast(arg_24_0.actId)
	local var_24_1 = var_24_0 == ActivityEnum.ActivityStatus.Normal

	var_24_1 = var_24_1 or ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.EnterView) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_24_0.goEnter, var_24_1)
	gohelper.setActive(arg_24_0.goFinish, not var_24_1)

	local var_24_2 = var_24_0 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(arg_24_0._gotime, not var_24_2)

	local var_24_3 = ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_24_0.goStore, var_24_3)
end

function var_0_0.refreshStoreCurrency(arg_25_0)
	local var_25_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a0Dungeon)
	local var_25_1 = var_25_0 and var_25_0.quantity or 0

	arg_25_0._txtStoreNum.text = GameUtil.numberDisplay(var_25_1)
end

function var_0_0.onClose(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.everyMinuteCall, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0.animComp:destroy()
	arg_27_0._videoComp:destroy()
end

return var_0_0
