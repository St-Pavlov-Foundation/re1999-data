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
	if arg_7_0._preloadLoader then
		arg_7_0._preloadLoader:dispose()

		arg_7_0._preloadLoader = nil
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, arg_7_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_shapan)
	arg_7_0._viewAnimatorPlayer:Play("close1", arg_7_0._animDoneForOpenMap, arg_7_0)
	CommandStationController.StatCommandStationButtonClick(arg_7_0.viewName, "_btnmapOnClick")
end

function var_0_0._animDoneForOpenMap(arg_8_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	module_views_preloader.CommandStationMapViewPreload(function()
		arg_8_0:_preloadDone()
	end)
end

function var_0_0._preloadDone(arg_10_0)
	local var_10_0 = CommandStationMapModel.instance:getCurTimeIdScene()

	if var_10_0 then
		local var_10_1 = var_10_0.scene
		local var_10_2 = "ui/viewres/commandstation/commandstation_mapview.prefab"
		local var_10_3 = MultiAbLoader.New()

		arg_10_0._preloadLoader = var_10_3

		var_10_3:addPath(var_10_1)
		var_10_3:addPath(var_10_2)
		var_10_3:startLoad(function()
			local var_11_0 = var_10_3:getAssetItem(var_10_1)

			if var_11_0 then
				local var_11_1 = var_11_0:GetResource(var_10_1)
				local var_11_2 = gohelper.clone(var_11_1, arg_10_0.viewGO)

				gohelper.setActive(var_11_2, false)
				CommandStationMapModel.instance:setPreloadScene(var_10_3, var_11_2)
			end

			local var_11_3 = var_10_3:getAssetItem(var_10_2)

			if var_11_3 then
				local var_11_4 = var_11_3:GetResource(var_10_2)
				local var_11_5 = ViewMgr.instance:getUILayer("POPUP_TOP")
				local var_11_6 = gohelper.clone(var_11_4, var_11_5, ViewName.CommandStationMapView)

				recthelper.setAnchor(var_11_6.transform, 10000, 10000)
				CommandStationMapModel.instance:setPreloadView(var_11_6)
			end
		end)
	end

	arg_10_0:_openMap()
end

function var_0_0._openMap(arg_12_0)
	arg_12_0._changeVideoViewLayer = true
	arg_12_0._toMapVedioPath = "videos/commandstation_tomap.mp4"

	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tomap", true)

	local var_12_0 = 3

	UIBlockHelper.instance:startBlock("CommandStationEnterView_openMap", var_12_0)
	VideoController.instance:openFullScreenVideoView(arg_12_0._toMapVedioPath, nil, var_12_0, arg_12_0._onVideoEndForOpenMap, arg_12_0, ViewName.CommandStationMapView)
end

function var_0_0._delayOpenMapView(arg_13_0)
	CommandStationController.instance:openCommandStationMapView()
end

function var_0_0._onVideoEndForOpenMap(arg_14_0)
	arg_14_0._changeVideoViewLayer = false

	if not ViewMgr.instance:isOpen(ViewName.CommandStationMapView) then
		TaskDispatcher.cancelTask(arg_14_0._delayOpenMapView, arg_14_0)
		CommandStationController.instance:openCommandStationMapView()
	end
end

function var_0_0._btntaskOnClick(arg_15_0)
	arg_15_0._viewAnimatorPlayer:Play("close1", arg_15_0._delayPlayVideo, arg_15_0)
	UIBlockHelper.instance:startBlock("CommandStationEnterView_taskAnim", 0.2)
	CommandStationController.StatCommandStationButtonClick(arg_15_0.viewName, "_btntaskOnClick")
end

function var_0_0._btnitemdetailOnClick(arg_16_0)
	local var_16_0 = CommandStationConfig.instance:getTotalTaskRewards()
	local var_16_1 = CommandStationConfig.instance:getCurVersionId()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1.versionId == var_16_1 and iter_16_1.isBig == 1 then
			local var_16_2 = GameUtil.splitString2(iter_16_1.bonus, true)

			MaterialTipController.instance:showMaterialInfo(var_16_2[1][1], var_16_2[1][2])

			break
		end
	end
end

function var_0_0._delayPlayVideo(arg_17_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tocode_video", true)
	module_views_preloader._startLoad({
		"ui/viewres/commandstation/commandstation_paperview.prefab"
	}, function()
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_handian)
		VideoController.instance:openFullScreenVideoView("videos/commandstation_tocode.mp4", nil, 5, arg_17_0._realOpenPaperView, arg_17_0, ViewName.CommandStationPaperView, true)
	end)
end

function var_0_0._realOpenPaperView(arg_19_0)
	CommandStationController.instance:openCommandStationPaperView()
end

function var_0_0._btnactivityOnClick(arg_20_0)
	if not arg_20_0._constActParamConfig then
		return
	end

	local var_20_0 = arg_20_0._constActParamConfig.value2

	_G[var_20_0].instance:openVersionActivityEnterView()
	CommandStationController.StatCommandStationButtonClick(arg_20_0.viewName, "_btnactivityOnClick")
end

function var_0_0._editableInitView(arg_21_0)
	arg_21_0._viewOpenTime = Time.realtimeSinceStartup
	arg_21_0._goActivityRedDot = gohelper.findChild(arg_21_0.viewGO, "#btn_activity/go_reddot")

	gohelper.setActive(arg_21_0._goActivityRedDot, false)

	arg_21_0._constChapterListConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ChapterList)

	if arg_21_0._constChapterListConfig then
		arg_21_0._chapterList = string.splitToNumber(arg_21_0._constChapterListConfig.value2, "#")
	end

	arg_21_0._constActParamConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ActParam)
	arg_21_0._mapAnimator = arg_21_0._gomap:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_21_0._gomap, false)

	arg_21_0._bottomAnimator = arg_21_0._gobottom:GetComponent(typeof(UnityEngine.Animator))
	arg_21_0._viewAnimatorPlayer = SLFramework.AnimatorPlayer.Get(arg_21_0.viewGO)

	local var_21_0 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND")

	gohelper.addChild(var_21_0, arg_21_0.viewGO)
end

function var_0_0._getLastEpisodeConfig(arg_22_0)
	local var_22_0 = arg_22_0._chapterList

	for iter_22_0 = #var_22_0, 1, -1 do
		local var_22_1 = var_22_0[iter_22_0]
		local var_22_2 = arg_22_0:_getChapterLastEpisodeConfig(var_22_1)

		if var_22_2 then
			return var_22_2
		end
	end

	local var_22_3 = var_22_0[1]

	return DungeonConfig.instance:getChapterEpisodeCOList(var_22_3)[1]
end

function var_0_0._getChapterLastEpisodeConfig(arg_23_0, arg_23_1)
	local var_23_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_23_1)

	for iter_23_0 = #var_23_0, 1, -1 do
		local var_23_1 = var_23_0[iter_23_0]

		if DungeonModel.instance:hasPassLevelAndStory(var_23_1.id) then
			return var_23_1
		end

		if DungeonModel.instance:isFinishElementList(var_23_1) and (var_23_1.preEpisode == 0 or DungeonModel.instance:hasPassLevelAndStory(var_23_1.preEpisode) or DungeonModel.instance:hasPassLevelAndStory(var_23_1.preEpisode2)) then
			return var_23_1
		end
	end
end

function var_0_0._initSpine(arg_24_0)
	arg_24_0._uiSpine = GuiSpine.Create(arg_24_0._btnwuxiandian.gameObject, true)

	local var_24_0 = "command_radio"
	local var_24_1 = ResUrl.getRolesCgStory(var_24_0, "v3a0_command_radio")

	arg_24_0._uiSpine:setResPath(var_24_1, arg_24_0._onSpineLoaded, arg_24_0)
end

function var_0_0._onSpineLoaded(arg_25_0)
	arg_25_0:_playIdleAnim()
end

function var_0_0._playIdleAnim(arg_26_0)
	if arg_26_0._uiSpine then
		arg_26_0._uiSpine:play("radio_cycle", true)
	end
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0._idleConfig = CommandStationConfig.instance:getDialogByType(CommandStationEnum.DialogueType.Idle)

	arg_27_0:_startIdleDialogue()
	arg_27_0:_showEpisodeInfo()
	arg_27_0:_initSpine()
	arg_27_0:_updateActBtn()
	arg_27_0:_checkRed()
	arg_27_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_27_0._onRefreshActivity, arg_27_0)
	arg_27_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_27_0._onUpdateDungeonInfo, arg_27_0)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_27_0._OnCloseViewFinish, arg_27_0)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_27_0._OnOpenView, arg_27_0)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_27_0._OnCloseFullView, arg_27_0, LuaEventSystem.Low)
	arg_27_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_27_0._checkRed, arg_27_0)
	arg_27_0:addEventCb(VideoController.instance, VideoEvent.OnVideoStarted, arg_27_0._onVideoStarted, arg_27_0)
	arg_27_0:addEventCb(VideoController.instance, VideoEvent.OnVideoFirstFrameReady, arg_27_0._onVideoFirstFrameReady, arg_27_0)

	if arg_27_0.viewParam and arg_27_0.viewParam.fromDungeonSectionItem then
		arg_27_0:_resetLayer()
	else
		TaskDispatcher.cancelTask(arg_27_0._openPostProcess, arg_27_0)
		TaskDispatcher.runRepeat(arg_27_0._openPostProcess, arg_27_0, 0)
	end
end

function var_0_0._hideMainScene(arg_28_0)
	local var_28_0 = GameSceneMgr.instance:getCurScene():getSceneContainerGO()

	gohelper.setActive(var_28_0, false)
end

function var_0_0._onVideoStarted(arg_29_0, arg_29_1)
	if arg_29_1 == arg_29_0._toMapVedioPath then
		TaskDispatcher.cancelTask(arg_29_0._delayHideSelf, arg_29_0)
		TaskDispatcher.runDelay(arg_29_0._delayHideSelf, arg_29_0, 0)
	end
end

function var_0_0._onVideoFirstFrameReady(arg_30_0, arg_30_1)
	if arg_30_1 == arg_30_0._toMapVedioPath then
		TaskDispatcher.cancelTask(arg_30_0._delayHideSelf, arg_30_0)
		TaskDispatcher.runDelay(arg_30_0._delayHideSelf, arg_30_0, 0)
	end
end

function var_0_0._delayHideSelf(arg_31_0)
	arg_31_0.viewContainer:setVisibleInternal(false)
	TaskDispatcher.cancelTask(arg_31_0._delayOpenMapView, arg_31_0)
	TaskDispatcher.runDelay(arg_31_0._delayOpenMapView, arg_31_0, 0.85)
end

function var_0_0._openPostProcess(arg_32_0)
	PostProcessingMgr.instance:setUIActive(true)
end

function var_0_0._resetLayer(arg_33_0)
	local var_33_0 = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.addChild(var_33_0, arg_33_0.viewGO)
end

function var_0_0._checkRed(arg_34_0)
	gohelper.setActive(arg_34_0._gotaskred, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CommandStationPaper))
	gohelper.setActive(arg_34_0._goActivityRedDot, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.VersionActivityEnterRedDot))
end

function var_0_0._OnOpenView(arg_35_0, arg_35_1)
	if arg_35_1 == ViewName.CommandStationMapView or arg_35_1 == ViewName.CommandStationPaperView then
		UIBlockMgrExtend.setNeedCircleMv(true)
		arg_35_0.viewContainer:setVisibleInternal(false)
		GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tomap", false)
	end

	if arg_35_0._changeVideoViewLayer and arg_35_1 == ViewName.FullScreenVideoView then
		arg_35_0._changeVideoViewLayer = false

		local var_35_0 = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

		if var_35_0 and not gohelper.isNil(var_35_0.viewGO) then
			local var_35_1 = ViewMgr.instance:getUILayer("HUD")

			gohelper.addChild(var_35_1, var_35_0.viewGO)
		end
	end
end

function var_0_0._OnCloseViewFinish(arg_36_0, arg_36_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_36_0.viewName) then
		return
	end

	if arg_36_1 == ViewName.CommandStationPaperView then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_fanhui)
	end

	if arg_36_1 == ViewName.CommandStationMapView or arg_36_1 == ViewName.DungeonMapView or arg_36_1 == ViewName.CommandStationPaperView then
		arg_36_0.viewContainer:setVisibleInternal(true)
		arg_36_0._viewAnimatorPlayer:Play("open2", arg_36_0._animDone, arg_36_0)
	end
end

function var_0_0.onUpdateParam(arg_37_0)
	arg_37_0.viewContainer:setVisibleInternal(true)
	arg_37_0._viewAnimatorPlayer:Play("open2", arg_37_0._animDone, arg_37_0)
end

function var_0_0._OnCloseFullView(arg_38_0, arg_38_1)
	if arg_38_1 == ViewName.CommandStationMapView or arg_38_1 == ViewName.DungeonMapView then
		arg_38_0.viewContainer:setVisibleInternal(false)
	end
end

function var_0_0._animDone(arg_39_0)
	return
end

function var_0_0._onUpdateDungeonInfo(arg_40_0)
	arg_40_0:_showEpisodeInfo()
end

function var_0_0._onRefreshActivity(arg_41_0)
	arg_41_0:_updateActBtn()
end

function var_0_0._updateActBtn(arg_42_0)
	if not arg_42_0._constActParamConfig then
		return
	end

	local var_42_0 = arg_42_0._constActParamConfig.value
	local var_42_1 = ActivityHelper.getActivityStatus(var_42_0)

	gohelper.setActive(arg_42_0._btnactivity, var_42_1 == ActivityEnum.ActivityStatus.Normal)
end

function var_0_0.onOpenFinish(arg_43_0)
	arg_43_0:_resetLayer()
	PostProcessingMgr.instance:setUIActive(false)
	TaskDispatcher.cancelTask(arg_43_0._openPostProcess, arg_43_0)
	arg_43_0:_showEnterDialogue()
	arg_43_0:_showMap()
end

function var_0_0._showEpisodeInfo(arg_44_0)
	gohelper.setActive(arg_44_0._btnmap, DungeonModel.instance:hasPassLevelAndStory(CommandStationEnum.FirstEpisodeId))

	if not arg_44_0._chapterList then
		return
	end

	local var_44_0 = arg_44_0:_getLastEpisodeConfig()
	local var_44_1 = DungeonConfig.instance:getEpisodeLevelIndex(var_44_0)
	local var_44_2 = DungeonConfig.instance:getChapterCO(var_44_0.chapterId)

	if LuaUtil.containChinese(var_44_0.name) then
		local var_44_3 = LuaUtil.getCharNum(var_44_0.name)
		local var_44_4 = 8

		if var_44_4 < var_44_3 then
			arg_44_0._txtName.text = LuaUtil.subString(var_44_0.name, 1, var_44_4) .. "..."
		else
			arg_44_0._txtName.text = var_44_0.name
		end
	else
		arg_44_0._txtName.text = var_44_0.name
	end

	arg_44_0._txtNum.text = string.format("%s-%s", var_44_2.chapterIndex, var_44_1)
	arg_44_0._showEpisodeId = var_44_0.id
end

function var_0_0._startIdleDialogue(arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._playIdleDialogue, arg_45_0)
	TaskDispatcher.runDelay(arg_45_0._playIdleDialogue, arg_45_0, arg_45_0._idleConfig.time)
end

function var_0_0._playIdleDialogue(arg_46_0)
	local var_46_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Idle)

	arg_46_0:_showDialogue(var_46_0)
end

function var_0_0._showEnterDialogue(arg_47_0)
	local var_47_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Enter)

	arg_47_0:_showDialogue(var_47_0)
end

function var_0_0._showDialogue(arg_48_0, arg_48_1)
	if not arg_48_1 then
		logError("_showDialogue textId is nil")

		return
	end

	local var_48_0 = lua_copost_npc_text.configDict[arg_48_1]

	if not var_48_0 then
		logError(string.format("CommandStationEnterView _showDialogue textId:%s config is nil", arg_48_1))

		return
	end

	TaskDispatcher.cancelTask(arg_48_0._playIdleDialogue, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._hideDialogue, arg_48_0)
	TaskDispatcher.runDelay(arg_48_0._hideDialogue, arg_48_0, 5)
	arg_48_0._bottomAnimator:Play("in", 0, 0)
	gohelper.setActive(arg_48_0._gobottom, true)

	arg_48_0._txtanacn.text = var_48_0.text
	arg_48_0._txtanaen.text = var_48_0.engtext
end

function var_0_0._hideDialogue(arg_49_0)
	arg_49_0._bottomAnimator:Play("out", 0, 0)
	arg_49_0:_startIdleDialogue()
end

function var_0_0._showMap(arg_50_0)
	local var_50_0 = string.format("%s_%s", CommandStationEnum.PrefsKey.NewMapTip, CommandStationConfig.instance:getCurVersionId())

	if CommandStationController.hasOnceActionKey(var_50_0) then
		return
	end

	CommandStationController.setOnceActionKey(var_50_0)

	local var_50_1 = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.VersionName)

	if var_50_1 then
		arg_50_0._txtmapname.text = var_50_1.value3
	end

	gohelper.setActive(arg_50_0._gomap, true)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Story_Map_In)
	arg_50_0._mapAnimator:Play("go_mapname_in")
	TaskDispatcher.cancelTask(arg_50_0._mapOut, arg_50_0)
	TaskDispatcher.runDelay(arg_50_0._mapOut, arg_50_0, 3)
end

function var_0_0._mapOut(arg_51_0)
	arg_51_0._mapAnimator:Play("go_mapname_out")
end

function var_0_0.onClose(arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._hideDialogue, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._playIdleDialogue, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._mapOut, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._openPostProcess, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._delayPlayIdleAnim, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._delayOpenMapView, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._delayHideSelf, arg_52_0)
	CommandStationController.StatCommandStationViewClose(arg_52_0.viewName, Time.realtimeSinceStartup - arg_52_0._viewOpenTime)
	UIBlockMgrExtend.setNeedCircleMv(true)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tocode_video", false)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tomap", false)
	CommandStationMapModel.instance:setPreloadScene()
	CommandStationMapModel.instance:setPreloadView()
end

function var_0_0.onDestroyView(arg_53_0)
	if arg_53_0._preloadLoader then
		arg_53_0._preloadLoader:dispose()

		arg_53_0._preloadLoader = nil
	end
end

return var_0_0
