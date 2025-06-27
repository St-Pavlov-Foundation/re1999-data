module("modules.logic.commandstation.view.CommandStationEnterView", package.seeall)

local var_0_0 = class("CommandStationEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btnmap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_map")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._gotaskred = gohelper.findChild(arg_1_0.viewGO, "#btn_task/go_reddot")
	arg_1_0._btnactivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_activity")
	arg_1_0._btnplot = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_plot")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#btn_plot/#txt_Name")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#btn_plot/#txt_Name/#txt_Num")
	arg_1_0._gozhuanpan = gohelper.findChild(arg_1_0.viewGO, "#go_zhuanpan")
	arg_1_0._imagezhuanpan = gohelper.findChildImage(arg_1_0.viewGO, "#go_zhuanpan/#image_zhuanpan")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_bottom")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/#txt_ana_en")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._txtmapname = gohelper.findChildText(arg_1_0.viewGO, "#go_map/line/#txt_mapname")
	arg_1_0._txtmapnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_map/#txt_mapnameen")
	arg_1_0._btnwuxiandian = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_wuxiandian")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmap:AddClickListener(arg_2_0._btnmapOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnitemdetailOnClick, arg_2_0)
	arg_2_0._btnactivity:AddClickListener(arg_2_0._btnactivityOnClick, arg_2_0)
	arg_2_0._btnplot:AddClickListener(arg_2_0._btnplotOnClick, arg_2_0)
	arg_2_0._btnwuxiandian:AddClickListener(arg_2_0._btnwuxiandianOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmap:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnactivity:RemoveClickListener()
	arg_3_0._btnplot:RemoveClickListener()
	arg_3_0._btnwuxiandian:RemoveClickListener()
end

function var_0_0._btnplotOnClick(arg_4_0)
	JumpController.instance:jumpTo("4#" .. tostring(arg_4_0._showEpisodeId))
	CommandStationController.StatCommandStationButtonClick(arg_4_0.viewName, "_btnplotOnClick")
end

function var_0_0._btnwuxiandianOnClick(arg_5_0)
	local var_5_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Click)

	arg_5_0:_showDialogue(var_5_0)

	if arg_5_0._uiSpine then
		arg_5_0._uiSpine:play("radio_shake")
		TaskDispatcher.cancelTask(arg_5_0._delayPlayIdleAnim, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._delayPlayIdleAnim, arg_5_0, 1)
	end

	CommandStationController.StatCommandStationButtonClick(arg_5_0.viewName, "_btnwuxiandianOnClick")
end

function var_0_0._delayPlayIdleAnim(arg_6_0)
	arg_6_0:_playIdleAnim()
end

function var_0_0._btnmapOnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_shapan)
	arg_7_0._viewAnimatorPlayer:Play("close1", arg_7_0._animDoneForOpenMap, arg_7_0)
	CommandStationController.StatCommandStationButtonClick(arg_7_0.viewName, "_btnmapOnClick")
end

function var_0_0._animDoneForOpenMap(arg_8_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	module_views_preloader.CommandStationMapViewPreload(function()
		arg_8_0:_openMap()
	end)
end

function var_0_0._openMap(arg_10_0)
	arg_10_0._changeVideoViewLayer = true
	arg_10_0._toMapVedioPath = "videos/commandstation_tomap.mp4"

	local var_10_0 = 3

	UIBlockHelper.instance:startBlock("CommandStationEnterView_openMap", var_10_0)
	VideoController.instance:openFullScreenVideoView(arg_10_0._toMapVedioPath, nil, var_10_0, arg_10_0._onVideoEndForOpenMap, arg_10_0)
end

function var_0_0._delayOpenMapView(arg_11_0)
	CommandStationController.instance:openCommandStationMapView()
end

function var_0_0._onVideoEndForOpenMap(arg_12_0)
	arg_12_0._changeVideoViewLayer = false

	if not ViewMgr.instance:isOpen(ViewName.CommandStationMapView) then
		TaskDispatcher.cancelTask(arg_12_0._delayOpenMapView, arg_12_0)
		CommandStationController.instance:openCommandStationMapView()
	end
end

function var_0_0._btntaskOnClick(arg_13_0)
	arg_13_0._viewAnimatorPlayer:Play("close1", arg_13_0._delayPlayVideo, arg_13_0)
	UIBlockHelper.instance:startBlock("CommandStationEnterView_taskAnim", 0.2)
	CommandStationController.StatCommandStationButtonClick(arg_13_0.viewName, "_btntaskOnClick")
end

function var_0_0._btnitemdetailOnClick(arg_14_0)
	local var_14_0 = CommandStationConfig.instance:getTotalTaskRewards()
	local var_14_1 = CommandStationConfig.instance:getCurVersionId()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1.versionId == var_14_1 and iter_14_1.isBig == 1 then
			local var_14_2 = GameUtil.splitString2(iter_14_1.bonus, true)

			MaterialTipController.instance:showMaterialInfo(var_14_2[1][1], var_14_2[1][2])

			break
		end
	end
end

function var_0_0._delayPlayVideo(arg_15_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tocode_video", true)
	module_views_preloader._startLoad({
		"ui/viewres/commandstation/commandstation_paperview.prefab"
	}, function()
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_handian)
		VideoController.instance:openFullScreenVideoView("videos/commandstation_tocode.mp4", nil, 5, arg_15_0._realOpenPaperView, arg_15_0, ViewName.CommandStationPaperView, true)
	end)
end

function var_0_0._realOpenPaperView(arg_17_0)
	CommandStationController.instance:openCommandStationPaperView()
end

function var_0_0._btnactivityOnClick(arg_18_0)
	if not arg_18_0._constActParamConfig then
		return
	end

	local var_18_0 = arg_18_0._constActParamConfig.value2

	_G[var_18_0].instance:openVersionActivityEnterView()
	CommandStationController.StatCommandStationButtonClick(arg_18_0.viewName, "_btnactivityOnClick")
end

function var_0_0._editableInitView(arg_19_0)
	arg_19_0._viewOpenTime = Time.realtimeSinceStartup
	arg_19_0._goActivityRedDot = gohelper.findChild(arg_19_0.viewGO, "#btn_activity/go_reddot")

	gohelper.setActive(arg_19_0._goActivityRedDot, false)

	arg_19_0._constChapterListConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ChapterList)

	if arg_19_0._constChapterListConfig then
		arg_19_0._chapterList = string.splitToNumber(arg_19_0._constChapterListConfig.value2, "#")
	end

	arg_19_0._constActParamConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ActParam)
	arg_19_0._mapAnimator = arg_19_0._gomap:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_19_0._gomap, false)

	arg_19_0._bottomAnimator = arg_19_0._gobottom:GetComponent(typeof(UnityEngine.Animator))
	arg_19_0._viewAnimatorPlayer = SLFramework.AnimatorPlayer.Get(arg_19_0.viewGO)

	local var_19_0 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND")

	gohelper.addChild(var_19_0, arg_19_0.viewGO)
end

function var_0_0._getLastEpisodeConfig(arg_20_0)
	local var_20_0 = arg_20_0._chapterList

	for iter_20_0 = #var_20_0, 1, -1 do
		local var_20_1 = var_20_0[iter_20_0]
		local var_20_2 = arg_20_0:_getChapterLastEpisodeConfig(var_20_1)

		if var_20_2 then
			return var_20_2
		end
	end

	local var_20_3 = var_20_0[1]

	return DungeonConfig.instance:getChapterEpisodeCOList(var_20_3)[1]
end

function var_0_0._getChapterLastEpisodeConfig(arg_21_0, arg_21_1)
	local var_21_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_21_1)

	for iter_21_0 = #var_21_0, 1, -1 do
		local var_21_1 = var_21_0[iter_21_0]

		if DungeonModel.instance:hasPassLevelAndStory(var_21_1.id) then
			return var_21_1
		end

		if DungeonModel.instance:isFinishElementList(var_21_1) and (var_21_1.preEpisode == 0 or DungeonModel.instance:hasPassLevelAndStory(var_21_1.preEpisode) or DungeonModel.instance:hasPassLevelAndStory(var_21_1.preEpisode2)) then
			return var_21_1
		end
	end
end

function var_0_0._initSpine(arg_22_0)
	arg_22_0._uiSpine = GuiSpine.Create(arg_22_0._btnwuxiandian.gameObject, true)

	local var_22_0 = "command_radio"
	local var_22_1 = ResUrl.getRolesCgStory(var_22_0, "v3a0_command_radio")

	arg_22_0._uiSpine:setResPath(var_22_1, arg_22_0._onSpineLoaded, arg_22_0)
end

function var_0_0._onSpineLoaded(arg_23_0)
	arg_23_0:_playIdleAnim()
end

function var_0_0._playIdleAnim(arg_24_0)
	if arg_24_0._uiSpine then
		arg_24_0._uiSpine:play("radio_cycle", true)
	end
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0._idleConfig = CommandStationConfig.instance:getDialogByType(CommandStationEnum.DialogueType.Idle)

	arg_25_0:_startIdleDialogue()
	arg_25_0:_showEpisodeInfo()
	arg_25_0:_initSpine()
	arg_25_0:_updateActBtn()
	arg_25_0:_checkRed()
	arg_25_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_25_0._onRefreshActivity, arg_25_0)
	arg_25_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_25_0._onUpdateDungeonInfo, arg_25_0)
	arg_25_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_25_0._OnCloseViewFinish, arg_25_0)
	arg_25_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_25_0._OnOpenView, arg_25_0)
	arg_25_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_25_0._OnCloseFullView, arg_25_0, LuaEventSystem.Low)
	arg_25_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_25_0._checkRed, arg_25_0)
	arg_25_0:addEventCb(VideoController.instance, VideoEvent.OnVideoStarted, arg_25_0._onVideoStarted, arg_25_0)
	arg_25_0:addEventCb(VideoController.instance, VideoEvent.OnVideoFirstFrameReady, arg_25_0._onVideoFirstFrameReady, arg_25_0)

	if arg_25_0.viewParam and arg_25_0.viewParam.fromDungeonSectionItem then
		arg_25_0:_resetLayer()
	else
		TaskDispatcher.cancelTask(arg_25_0._openPostProcess, arg_25_0)
		TaskDispatcher.runRepeat(arg_25_0._openPostProcess, arg_25_0, 0)
	end
end

function var_0_0._hideMainScene(arg_26_0)
	local var_26_0 = GameSceneMgr.instance:getCurScene():getSceneContainerGO()

	gohelper.setActive(var_26_0, false)
end

function var_0_0._onVideoStarted(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0._toMapVedioPath then
		TaskDispatcher.cancelTask(arg_27_0._delayHideSelf, arg_27_0)
		TaskDispatcher.runDelay(arg_27_0._delayHideSelf, arg_27_0, 0)
	end
end

function var_0_0._onVideoFirstFrameReady(arg_28_0, arg_28_1)
	if arg_28_1 == arg_28_0._toMapVedioPath then
		TaskDispatcher.cancelTask(arg_28_0._delayHideSelf, arg_28_0)
		TaskDispatcher.runDelay(arg_28_0._delayHideSelf, arg_28_0, 0)
	end
end

function var_0_0._delayHideSelf(arg_29_0)
	arg_29_0.viewContainer:setVisibleInternal(false)
	TaskDispatcher.cancelTask(arg_29_0._delayOpenMapView, arg_29_0)
	TaskDispatcher.runDelay(arg_29_0._delayOpenMapView, arg_29_0, 0.85)
end

function var_0_0._openPostProcess(arg_30_0)
	PostProcessingMgr.instance:setUIActive(true)
end

function var_0_0._resetLayer(arg_31_0)
	local var_31_0 = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.addChild(var_31_0, arg_31_0.viewGO)
end

function var_0_0._checkRed(arg_32_0)
	gohelper.setActive(arg_32_0._gotaskred, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CommandStationPaper))
	gohelper.setActive(arg_32_0._goActivityRedDot, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.VersionActivityEnterRedDot))
end

function var_0_0._OnOpenView(arg_33_0, arg_33_1)
	if arg_33_1 == ViewName.CommandStationMapView or arg_33_1 == ViewName.CommandStationPaperView then
		UIBlockMgrExtend.setNeedCircleMv(true)
		arg_33_0.viewContainer:setVisibleInternal(false)
	end

	if arg_33_0._changeVideoViewLayer and arg_33_1 == ViewName.FullScreenVideoView then
		arg_33_0._changeVideoViewLayer = false

		local var_33_0 = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

		if var_33_0 and not gohelper.isNil(var_33_0.viewGO) then
			local var_33_1 = ViewMgr.instance:getUILayer("HUD")

			gohelper.addChild(var_33_1, var_33_0.viewGO)
		end
	end
end

function var_0_0._OnCloseViewFinish(arg_34_0, arg_34_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_34_0.viewName) then
		return
	end

	if arg_34_1 == ViewName.CommandStationPaperView then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_fanhui)
	end

	if arg_34_1 == ViewName.CommandStationMapView or arg_34_1 == ViewName.DungeonMapView or arg_34_1 == ViewName.CommandStationPaperView then
		arg_34_0.viewContainer:setVisibleInternal(true)
		arg_34_0._viewAnimatorPlayer:Play("open2", arg_34_0._animDone, arg_34_0)
	end
end

function var_0_0.onUpdateParam(arg_35_0)
	arg_35_0.viewContainer:setVisibleInternal(true)
	arg_35_0._viewAnimatorPlayer:Play("open2", arg_35_0._animDone, arg_35_0)
end

function var_0_0._OnCloseFullView(arg_36_0, arg_36_1)
	if arg_36_1 == ViewName.CommandStationMapView or arg_36_1 == ViewName.DungeonMapView then
		arg_36_0.viewContainer:setVisibleInternal(false)
	end
end

function var_0_0._animDone(arg_37_0)
	return
end

function var_0_0._onUpdateDungeonInfo(arg_38_0)
	arg_38_0:_showEpisodeInfo()
end

function var_0_0._onRefreshActivity(arg_39_0)
	arg_39_0:_updateActBtn()
end

function var_0_0._updateActBtn(arg_40_0)
	if not arg_40_0._constActParamConfig then
		return
	end

	local var_40_0 = arg_40_0._constActParamConfig.value
	local var_40_1 = ActivityHelper.getActivityStatus(var_40_0)

	gohelper.setActive(arg_40_0._btnactivity, var_40_1 == ActivityEnum.ActivityStatus.Normal)
end

function var_0_0.onOpenFinish(arg_41_0)
	arg_41_0:_resetLayer()
	PostProcessingMgr.instance:setUIActive(false)
	TaskDispatcher.cancelTask(arg_41_0._openPostProcess, arg_41_0)
	arg_41_0:_showEnterDialogue()
	arg_41_0:_showMap()
end

function var_0_0._showEpisodeInfo(arg_42_0)
	gohelper.setActive(arg_42_0._btnmap, DungeonModel.instance:hasPassLevelAndStory(CommandStationEnum.FirstEpisodeId))

	if not arg_42_0._chapterList then
		return
	end

	local var_42_0 = arg_42_0:_getLastEpisodeConfig()
	local var_42_1 = DungeonConfig.instance:getEpisodeLevelIndex(var_42_0)
	local var_42_2 = DungeonConfig.instance:getChapterCO(var_42_0.chapterId)

	if LuaUtil.containChinese(var_42_0.name) then
		local var_42_3 = LuaUtil.getCharNum(var_42_0.name)
		local var_42_4 = 8

		if var_42_4 < var_42_3 then
			arg_42_0._txtName.text = LuaUtil.subString(var_42_0.name, 1, var_42_4) .. "..."
		else
			arg_42_0._txtName.text = var_42_0.name
		end
	else
		arg_42_0._txtName.text = var_42_0.name
	end

	arg_42_0._txtNum.text = string.format("%s-%s", var_42_2.chapterIndex, var_42_1)
	arg_42_0._showEpisodeId = var_42_0.id
end

function var_0_0._startIdleDialogue(arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._playIdleDialogue, arg_43_0)
	TaskDispatcher.runDelay(arg_43_0._playIdleDialogue, arg_43_0, arg_43_0._idleConfig.time)
end

function var_0_0._playIdleDialogue(arg_44_0)
	local var_44_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Idle)

	arg_44_0:_showDialogue(var_44_0)
end

function var_0_0._showEnterDialogue(arg_45_0)
	local var_45_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Enter)

	arg_45_0:_showDialogue(var_45_0)
end

function var_0_0._showDialogue(arg_46_0, arg_46_1)
	if not arg_46_1 then
		logError("_showDialogue textId is nil")

		return
	end

	local var_46_0 = lua_copost_npc_text.configDict[arg_46_1]

	if not var_46_0 then
		logError(string.format("CommandStationEnterView _showDialogue textId:%s config is nil", arg_46_1))

		return
	end

	TaskDispatcher.cancelTask(arg_46_0._playIdleDialogue, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._hideDialogue, arg_46_0)
	TaskDispatcher.runDelay(arg_46_0._hideDialogue, arg_46_0, 5)
	arg_46_0._bottomAnimator:Play("in", 0, 0)
	gohelper.setActive(arg_46_0._gobottom, true)

	arg_46_0._txtanacn.text = var_46_0.text
	arg_46_0._txtanaen.text = var_46_0.engtext
end

function var_0_0._hideDialogue(arg_47_0)
	arg_47_0._bottomAnimator:Play("out", 0, 0)
	arg_47_0:_startIdleDialogue()
end

function var_0_0._showMap(arg_48_0)
	local var_48_0 = string.format("%s_%s", CommandStationEnum.PrefsKey.NewMapTip, CommandStationConfig.instance:getCurVersionId())

	if CommandStationController.hasOnceActionKey(var_48_0) then
		return
	end

	CommandStationController.setOnceActionKey(var_48_0)

	local var_48_1 = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.VersionName)

	if var_48_1 then
		arg_48_0._txtmapname.text = var_48_1.value3
	end

	gohelper.setActive(arg_48_0._gomap, true)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Story_Map_In)
	arg_48_0._mapAnimator:Play("go_mapname_in")
	TaskDispatcher.cancelTask(arg_48_0._mapOut, arg_48_0)
	TaskDispatcher.runDelay(arg_48_0._mapOut, arg_48_0, 3)
end

function var_0_0._mapOut(arg_49_0)
	arg_49_0._mapAnimator:Play("go_mapname_out")
end

function var_0_0.onClose(arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._hideDialogue, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._playIdleDialogue, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._mapOut, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._openPostProcess, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._delayPlayIdleAnim, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._delayOpenMapView, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._delayHideSelf, arg_50_0)
	CommandStationController.StatCommandStationViewClose(arg_50_0.viewName, Time.realtimeSinceStartup - arg_50_0._viewOpenTime)
	UIBlockMgrExtend.setNeedCircleMv(true)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tocode_video", false)
end

return var_0_0
