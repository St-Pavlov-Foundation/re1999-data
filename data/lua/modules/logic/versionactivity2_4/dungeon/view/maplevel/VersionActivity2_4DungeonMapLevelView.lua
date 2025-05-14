module("modules.logic.versionactivity2_4.dungeon.view.maplevel.VersionActivity2_4DungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity2_4DungeonMapLevelView", BaseView)
local var_0_1 = 0.4
local var_0_2 = 2.7

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goVersionActivity = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity")
	arg_1_0.animator = arg_1_0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.goVersionActivity)
	arg_1_0.animationEventWrap = arg_1_0.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._simageactivitynormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	arg_1_0._simageactivityhardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	arg_1_0._txtmapName = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	arg_1_0._txtmapNameEn = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	arg_1_0._txtmapNum = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	arg_1_0._txtmapChapterIndex = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	arg_1_0._imagestar1 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	arg_1_0._imagestar2 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch")
	arg_1_0._gotype1 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	arg_1_0._gotype2 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	arg_1_0._gotype3 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	arg_1_0._gotype0 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	arg_1_0._gorecommend = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_recommend")
	arg_1_0._txtrecommendlv = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	arg_1_0._txtactivitydesc = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	arg_1_0._btnactivityreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	arg_1_0._gonorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_norewards")
	arg_1_0.startBtnAnimator = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/startBtn"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnnormalStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	arg_1_0._txtusepowernormal = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	arg_1_0._txtnorstarttext = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	arg_1_0._txtnorstarttexten = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	arg_1_0._btnhardStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	arg_1_0._txtusepowerhard = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	arg_1_0._btnlockStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	arg_1_0._simagepower = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	arg_1_0._btnreplayStory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_righttop")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_4SudokuController.instance, VersionActivity2_4DungeonEvent.SudokuCompleted, arg_2_0._onSudokuCompleted, arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
	arg_2_0._btnactivityreward:AddClickListener(arg_2_0._btnactivityrewardOnClick, arg_2_0)
	arg_2_0._btnnormalStart:AddClickListener(arg_2_0._btnnormalStartOnClick, arg_2_0)
	arg_2_0._btnhardStart:AddClickListener(arg_2_0._btnhardStartOnClick, arg_2_0)
	arg_2_0._btnlockStart:AddClickListener(arg_2_0._btnlockStartOnClick, arg_2_0)
	arg_2_0._btnreplayStory:AddClickListener(arg_2_0._btnreplayStoryOnClick, arg_2_0)
	arg_2_0.animationEventWrap:AddEventListener("refresh", arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_4SudokuController.instance, VersionActivity2_4DungeonEvent.SudokuCompleted, arg_3_0._onSudokuCompleted, arg_3_0)
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
	arg_3_0._btnactivityreward:RemoveClickListener()
	arg_3_0._btnnormalStart:RemoveClickListener()
	arg_3_0._btnhardStart:RemoveClickListener()
	arg_3_0._btnlockStart:RemoveClickListener()
	arg_3_0._btnreplayStory:RemoveClickListener()
	arg_3_0.animationEventWrap:RemoveAllEventListener()
end

function var_0_0._onCurrencyChange(arg_4_0, arg_4_1)
	if not arg_4_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_4_0:refreshCostPower()
end

function var_0_0._onSudokuCompleted(arg_5_0)
	if arg_5_0.showEpisodeCo.id ~= VersionActivity2_4Enum.SudokuEpisodeId then
		return
	end

	DungeonRpc.instance:sendEndDungeonRequest(false)

	if not StoryModel.instance:isStoryFinished(arg_5_0.showEpisodeCo.afterStory) then
		arg_5_0:playSudokuAfterStory(arg_5_0.showEpisodeCo.afterStory)

		return
	end
end

function var_0_0._btnleftarrowOnClick(arg_6_0)
	if arg_6_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_6_0.mode2EpisodeDict == 1 or arg_6_0.modeIndex <= 1 then
		return
	end

	arg_6_0.modeIndex = arg_6_0.modeIndex - 1

	arg_6_0:refreshUIByMode(arg_6_0.modeList[arg_6_0.modeIndex])
end

function var_0_0._btnrightarrowOnClick(arg_7_0)
	if arg_7_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_7_0.mode2EpisodeDict == 1 or arg_7_0.modeIndex >= #arg_7_0.modeList then
		return
	end

	arg_7_0.modeIndex = arg_7_0.modeIndex + 1

	arg_7_0:refreshUIByMode(arg_7_0.modeList[arg_7_0.modeIndex])
end

function var_0_0.refreshUIByMode(arg_8_0, arg_8_1)
	if arg_8_0.mode == arg_8_1 then
		return
	end

	arg_8_0.animator:Play(UIAnimationName.Switch, 0, 0)

	arg_8_0.mode = arg_8_1
	arg_8_0.showEpisodeCo = arg_8_0.mode2EpisodeDict[arg_8_0.mode]
	arg_8_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_8_0.showEpisodeCo.id)

	if not arg_8_0.showEpisodeMo then
		arg_8_0.showEpisodeMo = UserDungeonMO.New()

		arg_8_0.showEpisodeMo:initFromManual(arg_8_0.showEpisodeCo.chapterId, arg_8_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0._btnactivityrewardOnClick(arg_9_0)
	DungeonController.instance:openDungeonRewardView(arg_9_0.showEpisodeCo)
end

function var_0_0._btnnormalStartOnClick(arg_10_0)
	if arg_10_0.modeCanFight then
		arg_10_0:startBattle()
	else
		arg_10_0:_btnlockStartOnClick()
	end
end

function var_0_0._btnhardStartOnClick(arg_11_0)
	arg_11_0:startBattle()
end

function var_0_0.startBattle(arg_12_0)
	if arg_12_0.showEpisodeCo.id == VersionActivity2_4Enum.SudokuEpisodeId then
		arg_12_0:_playStoryAndOpenSudoku(arg_12_0.showEpisodeCo.beforeStory)

		return
	elseif arg_12_0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or arg_12_0.showEpisodeCo.beforeStory == 0 then
			arg_12_0:_playSkipMainStory()
		else
			arg_12_0:_playMainStory()
		end

		return
	end

	if arg_12_0.isSpecialEpisode then
		arg_12_0.lastEpisodeSelectModeDict[tostring(arg_12_0.specialEpisodeId)] = arg_12_0.mode

		local var_12_0 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
		local var_12_1 = cjson.encode(arg_12_0.lastEpisodeSelectModeDict)

		VersionActivity2_4DungeonController.instance:savePlayerPrefs(var_12_0, var_12_1)
	end

	if DungeonModel.instance:hasPassLevelAndStory(arg_12_0.showEpisodeCo.id) then
		arg_12_0:_enterFight()

		return
	end

	if arg_12_0.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(arg_12_0.showEpisodeCo.beforeStory) then
			arg_12_0:_playStoryAndEnterFight(arg_12_0.showEpisodeCo.beforeStory)

			return
		end

		if arg_12_0.showEpisodeMo.star <= DungeonEnum.StarType.None then
			arg_12_0:_enterFight()

			return
		end

		if arg_12_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_12_0.showEpisodeCo.afterStory) then
			arg_12_0:playAfterStory(arg_12_0.showEpisodeCo.afterStory)

			return
		end
	end

	arg_12_0:_enterFight()
end

function var_0_0._playSkipMainStory(arg_13_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_13_0.showEpisodeCo.chapterId, arg_13_0.showEpisodeCo.id)
	arg_13_0:onStoryFinished()
end

function var_0_0._playMainStory(arg_14_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_14_0.showEpisodeCo.chapterId, arg_14_0.showEpisodeCo.id)

	local var_14_0 = {}

	var_14_0.mark = true
	var_14_0.episodeId = arg_14_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_14_0.showEpisodeCo.beforeStory, var_14_0, arg_14_0.onStoryFinished, arg_14_0)
end

function var_0_0.onStoryFinished(arg_15_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_15_0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	arg_15_0:closeThis()
end

function var_0_0._playStoryAndEnterFight(arg_16_0, arg_16_1)
	if StoryModel.instance:isStoryFinished(arg_16_1) then
		arg_16_0:_enterFight()

		return
	end

	local var_16_0 = {}

	var_16_0.mark = true
	var_16_0.episodeId = arg_16_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_16_1, var_16_0, arg_16_0._enterFight, arg_16_0)
end

function var_0_0._enterFight(arg_17_0)
	DungeonFightController.instance:enterFight(arg_17_0.showEpisodeCo.chapterId, arg_17_0.showEpisodeCo.id, 1)
end

function var_0_0.playAfterStory(arg_18_0, arg_18_1)
	local var_18_0 = {}

	var_18_0.mark = true
	var_18_0.episodeId = arg_18_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_18_1, var_18_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_18_0:closeThis()
	end, arg_18_0)
end

function var_0_0._playStoryAndOpenSudoku(arg_20_0, arg_20_1)
	DungeonRpc.instance:sendStartDungeonRequest(arg_20_0.showEpisodeCo.chapterId, arg_20_0.showEpisodeCo.id)

	if StoryModel.instance:isStoryFinished(arg_20_1) then
		arg_20_0:_openSudokuView()

		return
	end

	local var_20_0 = {}

	var_20_0.mark = true
	var_20_0.episodeId = arg_20_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_20_1, var_20_0, arg_20_0._openSudokuView, arg_20_0)
end

function var_0_0._openSudokuView(arg_21_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_21_0.showEpisodeCo.id)
	VersionActivity2_4SudokuController.instance:openSudokuView()
end

function var_0_0.playSudokuAfterStory(arg_22_0, arg_22_1)
	local var_22_0 = {}

	var_22_0.mark = true
	var_22_0.episodeId = arg_22_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_22_1, var_22_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_22_0:closeThis()
	end, arg_22_0)
end

function var_0_0._btnlockStartOnClick(arg_24_0)
	local var_24_0 = arg_24_0:getPreModeName()

	GameFacade.showToast(ToastEnum.VersionActivityCanFight, var_24_0)
end

function var_0_0.getPreModeName(arg_25_0)
	local var_25_0 = arg_25_0.modeIndex - 1
	local var_25_1 = arg_25_0.modeList[var_25_0]

	if not var_25_1 then
		logWarn("not modeIndex mode : " .. var_25_0)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_25_1])
end

function var_0_0._btnreplayStoryOnClick(arg_26_0)
	if not arg_26_0.storyIdList or #arg_26_0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(arg_26_0.storyIdList)

	local var_26_0 = {}

	var_26_0.isLeiMiTeActivityStory = true

	StoryController.instance:resetStoryParam(var_26_0)
end

function var_0_0._editableInitView(arg_27_0)
	arg_27_0.rewardItems = {}

	gohelper.setActive(arg_27_0._goactivityrewarditem, false)
	gohelper.setActive(arg_27_0._gonormaleye, false)
	gohelper.setActive(arg_27_0._gohardeye, false)

	arg_27_0.lockTypeAnimator = arg_27_0._gotype0:GetComponent(typeof(UnityEngine.Animator))
	arg_27_0.txtLockType = gohelper.findChildText(arg_27_0._gotype0, "txt")
	arg_27_0.lockTypeIconGo = gohelper.findChild(arg_27_0._gotype0, "txt/icon")
	arg_27_0.leftArrowLight = gohelper.findChild(arg_27_0._btnleftarrow.gameObject, "left_arrow")
	arg_27_0.leftArrowDisable = gohelper.findChild(arg_27_0._btnleftarrow.gameObject, "left_arrow_disable")
	arg_27_0.rightArrowLight = gohelper.findChild(arg_27_0._btnrightarrow.gameObject, "right_arrow")
	arg_27_0.rightArrowDisable = gohelper.findChild(arg_27_0._btnrightarrow.gameObject, "right_arrow_disable")

	arg_27_0:initLocalEpisodeMode()
end

function var_0_0.initLocalEpisodeMode(arg_28_0)
	local var_28_0 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_28_1 = VersionActivity2_4DungeonController.instance:getPlayerPrefs(var_28_0, "")

	arg_28_0.unlockedEpisodeModeDict = VersionActivity2_4DungeonController.instance:loadDictFromStr(var_28_1)

	local var_28_2 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
	local var_28_3 = VersionActivity2_4DungeonController.instance:getPlayerPrefs(var_28_2, "")

	arg_28_0.lastEpisodeSelectModeDict = VersionActivity2_4DungeonController.instance:loadDictFromStr(var_28_3)
end

function var_0_0.onUpdateParam(arg_29_0)
	arg_29_0:onOpen()
	arg_29_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onOpen(arg_30_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	arg_30_0:initViewParam()
	arg_30_0:initMode()
	arg_30_0:markSelectEpisode()
	arg_30_0:refreshStoryIdList()
	arg_30_0:refreshBg()
	arg_30_0:refreshUI()
	arg_30_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.initViewParam(arg_31_0)
	arg_31_0.originEpisodeId = arg_31_0.viewParam.episodeId
	arg_31_0.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(arg_31_0.originEpisodeId)
	arg_31_0.isFromJump = arg_31_0.viewParam.isJump
	arg_31_0.index = VersionActivity2_4DungeonConfig.instance:getEpisodeIndex(arg_31_0.originEpisodeId)

	arg_31_0.viewContainer:setOpenedEpisodeId(arg_31_0.originEpisodeId)

	arg_31_0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(arg_31_0.originEpisodeId)
	arg_31_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_31_0.originEpisodeId)
end

function var_0_0.initMode(arg_32_0)
	arg_32_0.mode = ActivityConfig.instance:getChapterIdMode(arg_32_0.originEpisodeConfig.chapterId)
	arg_32_0.modeIndex = 1

	if arg_32_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	arg_32_0.modeList = {
		VersionActivityDungeonBaseEnum.DungeonMode.Story,
		VersionActivityDungeonBaseEnum.DungeonMode.Story2,
		VersionActivityDungeonBaseEnum.DungeonMode.Story3
	}

	local var_32_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_32_0.originEpisodeConfig)

	arg_32_0.mode2EpisodeDict = {}

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_1 = ActivityConfig.instance:getChapterIdMode(iter_32_1.chapterId)

		arg_32_0.mode2EpisodeDict[var_32_1] = iter_32_1
	end

	arg_32_0.isSpecialEpisode = #var_32_0 > 1
	arg_32_0.specialEpisodeId = var_32_0[1].id

	if not arg_32_0.isSpecialEpisode then
		return
	end

	if arg_32_0.isFromJump then
		arg_32_0:checkNeedPlayModeUnLockAnimation()
	else
		local var_32_2

		for iter_32_2 = #var_32_0, 1, -1 do
			local var_32_3 = var_32_0[iter_32_2]

			if DungeonModel.instance:hasPassLevelAndStory(var_32_3.preEpisode) then
				arg_32_0.mode = arg_32_0.modeList[iter_32_2]

				break
			end
		end

		arg_32_0:checkNeedPlayModeUnLockAnimation()

		if not arg_32_0.needPlayUnlockModeAnimation then
			arg_32_0.mode = arg_32_0.lastEpisodeSelectModeDict[tostring(arg_32_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
		end
	end

	for iter_32_3, iter_32_4 in ipairs(arg_32_0.modeList) do
		if iter_32_4 == arg_32_0.mode then
			arg_32_0.modeIndex = iter_32_3

			break
		end
	end

	arg_32_0.showEpisodeCo = arg_32_0.mode2EpisodeDict[arg_32_0.mode]
	arg_32_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_32_0.showEpisodeCo.id)

	if not arg_32_0.showEpisodeMo then
		arg_32_0.showEpisodeMo = UserDungeonMO.New()

		arg_32_0.showEpisodeMo:initFromManual(arg_32_0.showEpisodeCo.chapterId, arg_32_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0.checkNeedPlayModeUnLockAnimation(arg_33_0)
	local var_33_0 = arg_33_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story

	if arg_33_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or arg_33_0.mode == var_33_0 then
		arg_33_0.needPlayUnlockModeAnimation = false
	else
		arg_33_0.needPlayUnlockModeAnimation = (arg_33_0.unlockedEpisodeModeDict[tostring(arg_33_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story) < arg_33_0.mode
	end
end

function var_0_0.markSelectEpisode(arg_34_0)
	if arg_34_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Normal then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(arg_34_0.originEpisodeConfig.chapterId, arg_34_0.originEpisodeId)
	end
end

function var_0_0.refreshStoryIdList(arg_35_0)
	local var_35_0 = arg_35_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story
	local var_35_1 = arg_35_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if arg_35_0.showEpisodeCo.id == VersionActivity2_4Enum.SudokuEpisodeId then
		arg_35_0.storyIdList = {}

		local var_35_2 = arg_35_0.originEpisodeConfig.beforeStory

		if var_35_2 > 0 and StoryModel.instance:isStoryHasPlayed(var_35_2) then
			table.insert(arg_35_0.storyIdList, var_35_2)
		end

		local var_35_3 = arg_35_0.originEpisodeConfig.afterStory

		if var_35_3 > 0 and StoryModel.instance:isStoryHasPlayed(var_35_3) then
			table.insert(arg_35_0.storyIdList, var_35_3)
		end
	elseif var_35_0 or var_35_1 then
		arg_35_0.storyIdList = nil

		return
	else
		local var_35_4 = arg_35_0.originEpisodeConfig
		local var_35_5 = VersionActivityDungeonBaseEnum.DungeonMode.Story
		local var_35_6 = arg_35_0.mode2EpisodeDict and arg_35_0.mode2EpisodeDict[var_35_5]

		if var_35_6 then
			var_35_4 = var_35_6
		end

		arg_35_0.storyIdList = {}

		local var_35_7 = var_35_4.beforeStory

		if var_35_7 > 0 and StoryModel.instance:isStoryHasPlayed(var_35_7) then
			table.insert(arg_35_0.storyIdList, var_35_7)
		end

		local var_35_8 = var_35_4.afterStory

		if var_35_8 > 0 and StoryModel.instance:isStoryHasPlayed(var_35_8) then
			table.insert(arg_35_0.storyIdList, var_35_8)
		end
	end
end

function var_0_0.refreshBg(arg_36_0)
	gohelper.setActive(arg_36_0._simageactivitynormalbg.gameObject, arg_36_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_36_0._simageactivityhardbg.gameObject, arg_36_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function var_0_0.refreshUI(arg_37_0)
	arg_37_0:refreshModeCanFight()
	arg_37_0:refreshEpisodeTextInfo()
	arg_37_0:refreshStar()
	arg_37_0:refreshMode()
	arg_37_0:refreshArrow()
	arg_37_0:refreshReward()
	arg_37_0:refreshStartBtn()
	arg_37_0:refreshEye()

	if arg_37_0.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(arg_37_0.playModeUnlockAnimation, arg_37_0, var_0_1)
	end
end

function var_0_0.refreshModeCanFight(arg_38_0)
	if arg_38_0.showEpisodeCo.preEpisode == 0 then
		arg_38_0.modeCanFight = true

		return
	end

	arg_38_0.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(arg_38_0.showEpisodeCo.preEpisode)
end

function var_0_0.refreshEpisodeTextInfo(arg_39_0)
	local var_39_0 = DungeonConfig.instance:getChapterCO(arg_39_0.showEpisodeCo.chapterId)
	local var_39_1

	if var_39_0.id == VersionActivity2_4DungeonEnum.DungeonChapterId.Story then
		var_39_1 = arg_39_0.showEpisodeCo
	else
		var_39_1 = VersionActivity2_4DungeonConfig.instance:getStoryEpisodeCo(arg_39_0.showEpisodeCo.id)
	end

	arg_39_0._txtmapName.text = arg_39_0:buildEpisodeName(var_39_1)

	local var_39_2 = arg_39_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	arg_39_0._txtmapNameEn.text = arg_39_0:buildColorText(var_39_1.name_En, var_39_2)
	arg_39_0._txtmapNum.text = arg_39_0:buildColorText(string.format("%02d", arg_39_0.index), var_39_2)
	arg_39_0._txtmapChapterIndex.text = arg_39_0:buildColorText(var_39_0.chapterIndex .. " .", var_39_2)
	arg_39_0._txtactivitydesc.text = var_39_1.desc

	local var_39_3 = DungeonHelper.getEpisodeRecommendLevel(arg_39_0.showEpisodeCo.id)

	gohelper.setActive(arg_39_0._gorecommend, var_39_3 > 0)

	if var_39_3 > 0 then
		arg_39_0._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(var_39_3)
	end
end

function var_0_0.buildEpisodeName(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.name
	local var_40_1 = GameUtil.utf8sub(var_40_0, 1, 1)
	local var_40_2 = ""
	local var_40_3 = GameUtil.utf8len(var_40_0)

	if var_40_3 > 1 then
		var_40_2 = GameUtil.utf8sub(var_40_0, 2, var_40_3 - 1)
	end

	local var_40_4 = arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	return arg_40_0:buildColorText(string.format("<size=112>%s</size>%s", var_40_1, var_40_2), var_40_4)
end

function var_0_0.buildColorText(arg_41_0, arg_41_1, arg_41_2)
	return string.format("<color=%s>%s</color>", arg_41_2, arg_41_1)
end

function var_0_0.refreshStar(arg_42_0)
	local var_42_0 = arg_42_0.showEpisodeCo.id
	local var_42_1 = var_42_0 and DungeonModel.instance:hasPassLevelAndStory(var_42_0)
	local var_42_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_42_0)

	arg_42_0:setStarImage(arg_42_0._imagestar1, var_42_1, var_42_0)

	if string.nilorempty(var_42_2) then
		gohelper.setActive(arg_42_0._imagestar2.gameObject, false)
	else
		gohelper.setActive(arg_42_0._imagestar2.gameObject, true)
		arg_42_0:setStarImage(arg_42_0._imagestar2, var_42_1 and arg_42_0.showEpisodeMo.star >= DungeonEnum.StarType.Advanced, var_42_0)
	end
end

function var_0_0.setStarImage(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = DungeonConfig.instance:getEpisodeCO(arg_43_3)
	local var_43_1 = VersionActivity2_4DungeonEnum.EpisodeStarType[var_43_0.chapterId]

	if arg_43_2 then
		local var_43_2 = var_43_1.light

		UISpriteSetMgr.instance:setV2a4DungeonSprite(arg_43_1, var_43_2)
	else
		local var_43_3 = var_43_1.empty

		UISpriteSetMgr.instance:setV2a4DungeonSprite(arg_43_1, var_43_3)
	end
end

function var_0_0.refreshMode(arg_44_0)
	gohelper.setActive(arg_44_0._gotype1, arg_44_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_44_0._gotype2, arg_44_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(arg_44_0._gotype3, arg_44_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(arg_44_0._gotype4, arg_44_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local var_44_0 = not arg_44_0.modeCanFight or arg_44_0.needPlayUnlockModeAnimation

	gohelper.setActive(arg_44_0._gotype0, var_44_0)

	if var_44_0 then
		arg_44_0.lockTypeAnimator.enabled = true
		arg_44_0.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[arg_44_0.mode])

		if arg_44_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_44_0.txtLockType, "#757563")
		elseif arg_44_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_44_0.txtLockType, "#757563")
		end
	end

	gohelper.setActive(arg_44_0.lockTypeIconGo, var_44_0)
end

function var_0_0.refreshArrow(arg_45_0)
	local var_45_0 = arg_45_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and arg_45_0.isSpecialEpisode

	gohelper.setActive(arg_45_0._btnleftarrow.gameObject, var_45_0)
	gohelper.setActive(arg_45_0._btnrightarrow.gameObject, var_45_0)

	if var_45_0 then
		gohelper.setActive(arg_45_0.leftArrowLight, arg_45_0.modeIndex ~= 1)
		gohelper.setActive(arg_45_0.leftArrowDisable, arg_45_0.modeIndex == 1)

		local var_45_1 = #arg_45_0.modeList == arg_45_0.modeIndex

		gohelper.setActive(arg_45_0.rightArrowLight, not var_45_1)
		gohelper.setActive(arg_45_0.rightArrowDisable, var_45_1)
	end
end

function var_0_0.refreshReward(arg_46_0)
	local var_46_0 = {}
	local var_46_1 = 0
	local var_46_2 = 0

	if arg_46_0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_46_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_46_0.showEpisodeCo.id))

		var_46_2 = #var_46_0
	end

	if arg_46_0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_46_0, DungeonModel.instance:getEpisodeFirstBonus(arg_46_0.showEpisodeCo.id))

		var_46_1 = #var_46_0
	end

	tabletool.addValues(var_46_0, DungeonModel.instance:getEpisodeReward(arg_46_0.showEpisodeCo.id))
	tabletool.addValues(var_46_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_46_0.showEpisodeCo.id))

	local var_46_3 = #var_46_0

	gohelper.setActive(arg_46_0._gorewards, var_46_3 > 0)
	gohelper.setActive(arg_46_0._gonorewards, var_46_3 == 0)

	if var_46_3 == 0 then
		return
	end

	local var_46_4 = math.min(#var_46_0, 3)
	local var_46_5
	local var_46_6

	for iter_46_0 = 1, var_46_4 do
		local var_46_7 = arg_46_0.rewardItems[iter_46_0]

		if not var_46_7 then
			var_46_7 = arg_46_0:getUserDataTb_()
			var_46_7.go = gohelper.cloneInPlace(arg_46_0._goactivityrewarditem, "item" .. iter_46_0)
			var_46_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_46_7.go, "itemicon"))
			var_46_7.gonormal = gohelper.findChild(var_46_7.go, "rare/#go_rare1")
			var_46_7.gofirst = gohelper.findChild(var_46_7.go, "rare/#go_rare2")
			var_46_7.goadvance = gohelper.findChild(var_46_7.go, "rare/#go_rare3")
			var_46_7.gofirsthard = gohelper.findChild(var_46_7.go, "rare/#go_rare4")
			var_46_7.txtnormal = gohelper.findChildText(var_46_7.go, "rare/#go_rare1/txt")

			table.insert(arg_46_0.rewardItems, var_46_7)
		end

		local var_46_8 = var_46_0[iter_46_0]

		gohelper.setActive(var_46_7.gonormal, false)
		gohelper.setActive(var_46_7.gofirst, false)
		gohelper.setActive(var_46_7.goadvance, false)
		gohelper.setActive(var_46_7.gofirsthard, false)

		local var_46_9
		local var_46_10
		local var_46_11 = var_46_8[3]
		local var_46_12 = true

		if arg_46_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
			var_46_9 = var_46_7.gofirsthard
			var_46_10 = var_46_7.goadvance
		else
			var_46_9 = var_46_7.gofirst
			var_46_10 = var_46_7.goadvance
		end

		if iter_46_0 <= var_46_2 then
			gohelper.setActive(var_46_10, true)
		elseif iter_46_0 <= var_46_1 then
			gohelper.setActive(var_46_9, true)
		else
			gohelper.setActive(var_46_7.gonormal, true)

			local var_46_13 = var_46_8[3]

			var_46_12 = true

			if var_46_8.tagType then
				var_46_13 = var_46_8.tagType
				var_46_12 = var_46_11 ~= 0
			elseif #var_46_8 >= 4 then
				var_46_11 = var_46_8[4]
			else
				var_46_12 = false
			end

			var_46_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_46_13)
		end

		var_46_7.iconItem:setMOValue(var_46_8[1], var_46_8[2], var_46_11, nil, true)
		var_46_7.iconItem:setCountFontSize(40)
		var_46_7.iconItem:setHideLvAndBreakFlag(true)
		var_46_7.iconItem:hideEquipLvAndBreak(true)
		var_46_7.iconItem:isShowCount(var_46_12)
		gohelper.setActive(var_46_7.go, true)
	end

	for iter_46_1 = var_46_4 + 1, #arg_46_0.rewardItems do
		gohelper.setActive(arg_46_0.rewardItems[iter_46_1].go, false)
	end
end

function var_0_0.refreshStartBtn(arg_47_0)
	arg_47_0:refreshCostPower()

	local var_47_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_47_1 = ResUrl.getCurrencyItemIcon(var_47_0.icon .. "_btn")

	arg_47_0._simagepower:LoadImage(var_47_1)

	local var_47_2 = arg_47_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
	local var_47_3 = not var_47_2

	gohelper.setActive(arg_47_0._btnnormalStart.gameObject, arg_47_0.modeCanFight and var_47_3)
	gohelper.setActive(arg_47_0._btnhardStart.gameObject, var_47_2)
	gohelper.setActive(arg_47_0._btnlockStart.gameObject, not arg_47_0.modeCanFight or arg_47_0.needPlayUnlockModeAnimation)

	local var_47_4 = arg_47_0.storyIdList and #arg_47_0.storyIdList > 0
	local var_47_5 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_47_6 = arg_47_0.mode2EpisodeDict and arg_47_0.mode2EpisodeDict[var_47_5]
	local var_47_7 = var_47_6 and var_47_6.id or arg_47_0.originEpisodeConfig.id
	local var_47_8 = DungeonModel.instance:hasPassLevelAndStory(var_47_7)

	gohelper.setActive(arg_47_0._btnreplayStory.gameObject, var_47_8 and var_47_4)

	if var_47_2 then
		return
	end

	if arg_47_0.modeCanFight then
		local var_47_9 = DungeonModel.instance:hasPassLevel(arg_47_0.showEpisodeCo.id)
		local var_47_10 = StoryModel.instance:isStoryFinished(arg_47_0.showEpisodeCo.afterStory)

		if var_47_9 and arg_47_0.showEpisodeCo.afterStory > 0 and not var_47_10 then
			arg_47_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

			recthelper.setAnchorX(arg_47_0._txtnorstarttext.gameObject.transform, 0)
			recthelper.setAnchorX(arg_47_0._txtnorstarttexten.gameObject.transform, 0)
			gohelper.setActive(arg_47_0._txtusepowernormal.gameObject, false)
			gohelper.setActive(arg_47_0._simagepower.gameObject, false)
		else
			arg_47_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

			recthelper.setAnchorX(arg_47_0._txtnorstarttext.gameObject.transform, 121)
			recthelper.setAnchorX(arg_47_0._txtnorstarttexten.gameObject.transform, 121)
			gohelper.setActive(arg_47_0._txtusepowernormal.gameObject, true)
			gohelper.setActive(arg_47_0._simagepower.gameObject, true)
		end
	else
		gohelper.setActive(arg_47_0._simagepower.gameObject, false)
		gohelper.setActive(arg_47_0._txtusepowernormal.gameObject, false)
	end
end

function var_0_0.refreshCostPower(arg_48_0)
	local var_48_0 = 0

	if not string.nilorempty(arg_48_0.showEpisodeCo.cost) then
		var_48_0 = string.splitToNumber(arg_48_0.showEpisodeCo.cost, "#")[3]
	end

	arg_48_0._txtusepowernormal.text = "-" .. var_48_0
	arg_48_0._txtusepowerhard.text = "-" .. var_48_0

	if var_48_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_48_0._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_48_0._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_48_0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_48_0._txtusepowerhard, "#C44945")
	end
end

function var_0_0.refreshEye(arg_49_0)
	if not (arg_49_0.originEpisodeConfig.displayMark == 1) then
		gohelper.setActive(arg_49_0._gonormaleye, false)
		gohelper.setActive(arg_49_0._gohardeye, false)

		return
	end

	local var_49_0 = arg_49_0.originEpisodeConfig.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(arg_49_0._gonormaleye, not var_49_0)
	gohelper.setActive(arg_49_0._gohardeye, var_49_0)
end

function var_0_0.playModeUnlockAnimation(arg_50_0)
	if not arg_50_0.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	arg_50_0:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_4DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(arg_50_0.onModeUnlockAnimationPlayDone, arg_50_0, var_0_2)
end

function var_0_0._playModeUnLockAnimation(arg_51_0, arg_51_1)
	arg_51_0.lockTypeAnimator.enabled = true

	arg_51_0.lockTypeAnimator:Play(arg_51_1)
	arg_51_0.startBtnAnimator:Play(arg_51_1)
end

function var_0_0.onModeUnlockAnimationPlayDone(arg_52_0)
	arg_52_0:_playModeUnLockAnimation(UIAnimationName.Idle)

	arg_52_0.unlockedEpisodeModeDict[tostring(arg_52_0.specialEpisodeId)] = arg_52_0.mode

	local var_52_0 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_52_1 = cjson.encode(arg_52_0.unlockedEpisodeModeDict)

	VersionActivity2_4DungeonController.instance:savePlayerPrefs(var_52_0, var_52_1)

	arg_52_0.needPlayUnlockModeAnimation = false

	arg_52_0:refreshMode()
	arg_52_0:refreshStartBtn()
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
end

function var_0_0.onClose(arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0.playModeUnlockAnimation, arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0.onModeUnlockAnimationPlayDone, arg_53_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_54_0)
	arg_54_0.rewardItems = nil

	arg_54_0._simagepower:UnLoadImage()
end

return var_0_0
