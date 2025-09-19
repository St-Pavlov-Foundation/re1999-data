module("modules.logic.dungeon.controller.DungeonController", package.seeall)

local var_0_0 = class("DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:registerCallback(DungeonEvent.OnFocusEpisode, arg_3_0._onFocusEpisode, arg_3_0)
	arg_3_0:registerCallback(DungeonEvent.OnSetResScrollPos, arg_3_0._onSetResScrollPos, arg_3_0)
	arg_3_0:registerCallback(DungeonEvent.OnGuideUnlockNewChapter, arg_3_0._onGuideUnlockNewChapter, arg_3_0)
	arg_3_0:registerCallback(DungeonEvent.OnGuideFocusNormalChapter, arg_3_0._onGuideFocusNormalChapter, arg_3_0)
	arg_3_0:registerCallback(DungeonEvent.OnHideCircleMv, arg_3_0._onHideCircleMv, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_3_0._pushEndFight, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, arg_3_0._onOpenFullViewFinish, arg_3_0, LuaEventSystem.Low)
end

function var_0_0._onOpenFullViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 ~= ViewName.StoryBackgroundView then
		return
	end

	local var_4_0 = ViewMgr.instance:getContainer(ViewName.DungeonMapLevelView)

	if not var_4_0 then
		return
	end

	if var_4_0._isVisible then
		local var_4_1 = ""
		local var_4_2 = ViewMgr.instance:getOpenViewNameList()

		for iter_4_0 = #var_4_2, 1, -1 do
			local var_4_3 = var_4_2[iter_4_0]

			var_4_1 = string.format("%s#%s", var_4_1, var_4_3)

			if arg_4_1 == var_4_3 then
				break
			end
		end

		logError(string.format("剧情没有隐藏副本界面 list:%s", var_4_1))
	end

	arg_4_0:_hideView(ViewName.DungeonMapLevelView)
	arg_4_0:_hideView(ViewName.DungeonMapView)
	arg_4_0:_hideView(ViewName.DungeonView)
	arg_4_0:_hideView(ViewName.MainView)
end

function var_0_0._hideView(arg_5_0, arg_5_1)
	local var_5_0 = ViewMgr.instance:getContainer(arg_5_1)

	if var_5_0 then
		var_5_0:setVisibleInternal(false)
	end
end

function var_0_0._pushEndFight(arg_6_0)
	local var_6_0 = FightModel.instance:getRecordMO()

	if not var_6_0 or var_6_0.fightResult == FightEnum.FightResult.Succ then
		return
	end

	local var_6_1 = FightModel.instance:getFightParam()
	local var_6_2 = var_6_1 and var_6_1.episodeId
	local var_6_3 = var_6_2 and lua_episode.configDict[var_6_2]

	if not var_6_3 then
		return
	end

	if DungeonConfig.instance:getChapterCO(var_6_3.chapterId).type ~= DungeonEnum.ChapterType.Normal then
		return
	end

	if DungeonModel.instance:hasPassLevel(var_6_2) then
		return
	end

	local var_6_4 = PlayerPrefsKey.DungeonFailure .. PlayerModel.instance:getPlayinfo().userId .. var_6_2
	local var_6_5 = PlayerPrefsHelper.getNumber(var_6_4, 0)

	PlayerPrefsHelper.setNumber(var_6_4, var_6_5 + 1)
end

function var_0_0.reInit(arg_7_0)
	return
end

function var_0_0.OnOpenNormalMapView(arg_8_0)
	var_0_0.instance:dispatchEvent(DungeonEvent.OnOpenNormalMapView)
end

function var_0_0._onDailyRefresh(arg_9_0)
	DungeonRpc.instance:sendGetDungeonRequest()
end

function var_0_0._onHideCircleMv(arg_10_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function var_0_0._onGuideFocusNormalChapter(arg_11_0, arg_11_1)
	local var_11_0 = tonumber(arg_11_1)

	if var_11_0 then
		DungeonMainStoryModel.instance:saveClickChapterId(var_11_0)
	end
end

function var_0_0._onGuideUnlockNewChapter(arg_12_0, arg_12_1)
	arg_12_1 = tonumber(arg_12_1)

	if arg_12_1 ~= 101 then
		DungeonModel.instance.unlockNewChapterId = arg_12_1
		DungeonModel.instance.chapterTriggerNewChapter = false

		return
	end

	local var_12_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ChapterUnlockEffect)

	if not string.nilorempty(var_12_0) then
		TaskDispatcher.runDelay(function()
			var_0_0.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
		end, nil, 0)

		return
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ChapterUnlockEffect, "1")

	DungeonModel.instance.chapterTriggerNewChapter = true
	DungeonModel.instance.unlockNewChapterId = arg_12_1
end

function var_0_0._onSetResScrollPos(arg_14_0, arg_14_1)
	DungeonModel.instance.resScrollPosX = arg_14_1
end

function var_0_0._onFocusEpisode(arg_15_0, arg_15_1)
	DungeonModel.instance:setLastSendEpisodeId(tonumber(arg_15_1))
end

function var_0_0.enterDungeonView(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 then
		DungeonModel.instance:initModel()
	end

	local var_16_0 = {
		fromMainView = arg_16_2
	}

	return arg_16_0:openDungeonView(var_16_0, false)
end

function var_0_0.jumpDungeon(arg_17_0, arg_17_1)
	local var_17_0 = {}

	if not arg_17_1 then
		return var_17_0
	end

	local var_17_1 = arg_17_1.chapterType
	local var_17_2 = arg_17_1.chapterId
	local var_17_3 = arg_17_1.episodeId

	DungeonModel.instance.lastSendEpisodeId = var_17_3

	if not var_17_1 then
		return var_17_0
	end

	local var_17_4

	if var_17_1 == DungeonEnum.ChapterType.Hard then
		local var_17_5 = DungeonConfig.instance:getEpisodeCO(var_17_3)

		if not var_17_5 then
			logError("不能直接跳困难章节,可以配合困难关卡跳转")

			return var_17_0
		end

		local var_17_6 = DungeonConfig.instance:getEpisodeCO(var_17_5.preEpisode)

		if not var_17_6 then
			return var_17_0
		end

		var_17_1, var_17_2, var_17_3 = DungeonConfig.instance:getChapterCO(var_17_6.chapterId).type, var_17_6.chapterId, var_17_6.id
		var_17_4 = true
	end

	if var_17_1 == DungeonEnum.ChapterType.Newbie then
		logError("不能跳新手章节")

		return var_17_0
	end

	DungeonModel.instance:changeCategory(var_17_1)

	if not DungeonConfig.instance:getChapterCO(var_17_2) then
		table.insert(var_17_0, ViewName.DungeonView)
		arg_17_0:openDungeonView(nil)

		return var_17_0
	end

	if DungeonModel.instance:chapterIsLock(var_17_2) then
		table.insert(var_17_0, ViewName.DungeonView)
		arg_17_0:openDungeonView(nil)

		return var_17_0
	end

	local var_17_7 = {
		chapterId = var_17_2,
		episodeId = var_17_3
	}

	table.insert(var_17_0, arg_17_0:getDungeonChapterViewName(var_17_2))

	local var_17_8 = var_17_3 and DungeonConfig.instance:getEpisodeCO(var_17_3)

	if not var_17_8 then
		arg_17_0:openDungeonChapterView(var_17_7)

		return var_17_0
	end

	DungeonModel.instance.curLookChapterId = var_17_2

	local var_17_9 = arg_17_0:jumpChapterAndLevel(var_17_2, var_17_8, var_17_7, var_17_4, arg_17_1.isNoShowMapLevel)

	if var_17_9 then
		table.insert(var_17_0, var_17_9)
	end

	return var_17_0
end

function var_0_0.jumpChapterAndLevel(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = arg_18_0:generateLevelViewParam(arg_18_2, arg_18_4, true)
	local var_18_1 = {}
	local var_18_2 = {}

	arg_18_3 = arg_18_3 or {}
	arg_18_3.notOpenHelp = true
	DungeonModel.instance.jumpEpisodeId = arg_18_3.episodeId

	function var_18_2.openFunction()
		arg_18_0:openDungeonChapterView(arg_18_3, true)
	end

	var_18_2.waitOpenViewName = arg_18_0:getDungeonChapterViewName(arg_18_1)

	table.insert(var_18_1, var_18_2)

	if not arg_18_5 then
		local var_18_3 = {
			openFunction = function()
				arg_18_0:generateLevelViewParam(arg_18_2, arg_18_4)
			end
		}

		table.insert(var_18_1, var_18_3)
	end

	module_views_preloader.DungeonChapterAndLevelView(function()
		OpenMultiView.openView(var_18_1)
	end, arg_18_1, var_18_0)

	return var_18_0
end

function var_0_0.generateLevelViewParam(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0
	local var_22_1 = DungeonModel.instance:getEpisodeInfo(arg_22_1.id) or nil

	if not var_22_1 then
		return var_22_0
	end

	local var_22_2, var_22_3 = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)
	local var_22_4 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(DungeonModel.instance.curLookChapterId, arg_22_1.id)

	return (arg_22_0:enterLevelView({
		arg_22_1,
		var_22_1,
		var_22_2,
		var_22_4,
		arg_22_2,
		true
	}, arg_22_3))
end

function var_0_0.enterLevelView(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0
	local var_23_1 = arg_23_1[1]

	if not var_23_1 then
		logError("找不到配置")

		return var_23_0
	end

	if DungeonModel.isBattleEpisode(var_23_1) then
		if not arg_23_2 then
			var_0_0.instance:openDungeonLevelView(arg_23_1)
		end

		var_23_0 = arg_23_0:getDungeonLevelViewName(var_23_1.chapterId)
	elseif var_23_1.type == DungeonEnum.EpisodeType.Story then
		if not arg_23_2 then
			var_0_0.instance:openDungeonLevelView(arg_23_1)
		end

		var_23_0 = arg_23_0:getDungeonLevelViewName(var_23_1.chapterId)
	elseif var_23_1.type == DungeonEnum.EpisodeType.Decrypt and (arg_23_2 or true) then
		var_23_0 = ViewName.DungeonPuzzleChangeColorView
	end

	return var_23_0
end

function var_0_0.canJumpDungeonType(arg_24_0, arg_24_1)
	local var_24_0 = true
	local var_24_1 = DungeonEnum.ChapterType.Normal

	if arg_24_1 == JumpEnum.DungeonChapterType.Gold then
		var_24_1 = DungeonEnum.ChapterType.Gold
		var_24_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon)
	elseif arg_24_1 == JumpEnum.DungeonChapterType.Resource then
		var_24_1 = DungeonEnum.ChapterType.Break
		var_24_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon)
	elseif arg_24_1 == JumpEnum.DungeonChapterType.WeekWalk then
		var_24_1 = DungeonEnum.ChapterType.WeekWalk
		var_24_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk)
	elseif arg_24_1 == JumpEnum.DungeonChapterType.Explore then
		var_24_1 = DungeonEnum.ChapterType.Explore
		var_24_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore)
	end

	if var_24_0 and DungeonModel.instance:getChapterListOpenTimeValid(var_24_1) then
		return true
	end

	return false
end

function var_0_0.canJumpDungeonChapter(arg_25_0, arg_25_1)
	local var_25_0 = DungeonConfig.instance:getChapterCO(arg_25_1)

	if not var_25_0 then
		return false
	end

	local var_25_1 = var_25_0.type
	local var_25_2 = JumpEnum.DungeonChapterType.Story
	local var_25_3 = true

	if var_25_1 == DungeonEnum.ChapterType.Gold or var_25_1 == DungeonEnum.ChapterType.Exp or var_25_1 == DungeonEnum.ChapterType.Equip then
		var_25_2 = JumpEnum.DungeonChapterType.Gold

		if var_25_1 == DungeonEnum.ChapterType.Gold then
			var_25_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)
		elseif var_25_1 == DungeonEnum.ChapterType.Exp then
			var_25_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)
		elseif var_25_1 == DungeonEnum.ChapterType.Equip then
			var_25_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)
		elseif var_25_1 == DungeonEnum.ChapterType.Buildings then
			var_25_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)
		end
	elseif var_25_1 == DungeonEnum.ChapterType.Break then
		var_25_2 = JumpEnum.DungeonChapterType.Resource
	end

	if arg_25_0:canJumpDungeonType(var_25_2) and var_25_3 and not DungeonModel.instance:chapterIsLock(arg_25_1) and DungeonModel.instance:getChapterOpenTimeValid(var_25_0) then
		return true
	end

	return false
end

function var_0_0.openDungeonEquipEntryView(arg_26_0, arg_26_1, arg_26_2)
	ViewMgr.instance:openView(ViewName.DungeonEquipEntryView, arg_26_1, arg_26_2)

	return ViewName.DungeonEquipEntryView
end

function var_0_0.openDungeonView(arg_27_0, arg_27_1, arg_27_2)
	ViewMgr.instance:openView(ViewName.DungeonView, arg_27_1, arg_27_2)

	return ViewName.DungeonView
end

function var_0_0.openDungeonMapTaskView(arg_28_0, arg_28_1, arg_28_2)
	ViewMgr.instance:openView(ViewName.DungeonMapTaskView, arg_28_1, arg_28_2)

	return ViewName.DungeonMapTaskView
end

function var_0_0.openDungeonChapterView(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 and arg_29_1.chapterId then
		DungeonModel.instance.curLookChapterId = arg_29_1.chapterId
	end

	local var_29_0 = DungeonConfig.instance:getChapterCO(arg_29_1.chapterId)

	if var_29_0.type == DungeonEnum.ChapterType.WeekWalk then
		WeekWalkController.instance:openWeekWalkView(arg_29_1, arg_29_2)

		return ViewName.WeekWalkView
	elseif var_29_0.type == DungeonEnum.ChapterType.WeekWalk_2 then
		WeekWalk_2Controller.instance:openWeekWalk_2HeartView(arg_29_1, arg_29_2)

		return ViewName.WeekWalk_2HeartView
	elseif var_29_0.type == DungeonEnum.ChapterType.Season or var_29_0.type == DungeonEnum.ChapterType.SeasonRetail or var_29_0.type == DungeonEnum.ChapterType.SeasonSpecial then
		Activity104Controller.instance:openSeasonMainView()

		return ViewName.SeasonMainView
	elseif var_29_0.type == DungeonEnum.ChapterType.Season123 or var_29_0.type == DungeonEnum.ChapterType.Season123Retail then
		Season123Controller.instance:openMainViewFromFightScene()

		return Season123Controller.instance:getEpisodeListViewName()
	elseif var_29_0.id == HeroInvitationEnum.ChapterId then
		arg_29_0._lastChapterId = arg_29_1.chapterId

		DungeonModel.instance:changeCategory(var_29_0.type, false)
		HeroInvitationRpc.instance:sendGetHeroInvitationInfoRequest()
		ViewMgr.instance:openView(ViewName.HeroInvitationDungeonMapView, arg_29_1, arg_29_2)

		return ViewName.HeroInvitationDungeonMapView
	end

	arg_29_0._lastChapterId = arg_29_1.chapterId

	if arg_29_1.chapterId and not arg_29_1.episodeId then
		arg_29_1.episodeId = CharacterRecommedModel.instance:getChapterTradeEpisodeId(arg_29_1.chapterId)
	end

	DungeonModel.instance:changeCategory(var_29_0.type, false)
	ViewMgr.instance:openView(ViewName.DungeonMapView, arg_29_1, arg_29_2)

	return ViewName.DungeonMapView
end

function var_0_0.getDungeonChapterViewName(arg_30_0, arg_30_1)
	if arg_30_1 == HeroInvitationEnum.ChapterId then
		return ViewName.HeroInvitationDungeonMapView
	end

	return ViewName.DungeonMapView
end

function var_0_0.getDungeonLevelViewName(arg_31_0, arg_31_1)
	return ViewName.DungeonMapLevelView
end

function var_0_0.openDungeonCumulativeRewardsView(arg_32_0, arg_32_1, arg_32_2)
	ViewMgr.instance:openView(ViewName.DungeonCumulativeRewardsView, arg_32_1, arg_32_2)
end

function var_0_0.openDungeonLevelView(arg_33_0, arg_33_1, arg_33_2)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowDungeonMapLevelView) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.SkipShowDungeonMapLevelView, nil)

		return
	end

	local var_33_0 = arg_33_1[1]

	DungeonModel.instance.curLookEpisodeId = var_33_0.id

	ViewMgr.instance:openView(ViewName.DungeonMapLevelView, arg_33_1, arg_33_2)
end

function var_0_0.openDungeonMonsterView(arg_34_0, arg_34_1, arg_34_2)
	ViewMgr.instance:openView(ViewName.DungeonMonsterView, arg_34_1, arg_34_2)
end

function var_0_0.openDungeonRewardView(arg_35_0, arg_35_1, arg_35_2)
	ViewMgr.instance:openView(ViewName.DungeonRewardView, arg_35_1, arg_35_2)
end

function var_0_0.openDungeonElementRewardView(arg_36_0, arg_36_1, arg_36_2)
	ViewMgr.instance:openView(ViewName.DungeonElementRewardView, arg_36_1, arg_36_2)
end

function var_0_0.openDungeonStoryView(arg_37_0, arg_37_1, arg_37_2)
	ViewMgr.instance:openView(ViewName.DungeonStoryView, arg_37_1, arg_37_2)
end

function var_0_0.onStartLevelOrStoryChange(arg_38_0)
	DungeonModel.instance:startCheckUnlockChapter()
	arg_38_0:_onStartCheckUnlockContent()
end

function var_0_0.onEndLevelOrStoryChange(arg_39_0)
	DungeonModel.instance:endCheckUnlockChapter()
	arg_39_0:_onEndCheckUnlockContent()
end

function var_0_0._onStartCheckUnlockContent(arg_40_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	arg_40_0._hasAllPass = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)
end

function var_0_0._onEndCheckUnlockContent(arg_41_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_41_0 = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)

	if var_41_0 and var_41_0 ~= arg_41_0._hasAllPass then
		var_0_0.instance:showUnlockContentToast(DungeonModel.instance.curSendEpisodeId)
	end
end

function var_0_0.showUnlockContentToast(arg_42_0, arg_42_1)
	local var_42_0 = DungeonChapterUnlockItem.getUnlockContentList(arg_42_1, true)

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if DungeonConfig.instance:getChapterCO(lua_episode.configDict[arg_42_1].chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
			GameFacade.showToast(ToastEnum.IconId, iter_42_1)
		end
	end
end

function var_0_0.needShowDungeonView(arg_43_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_43_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_43_0 then
		local var_43_1 = DungeonConfig.instance:getChapterCO(var_43_0.chapterId)

		if var_43_1 and var_43_1.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightBackSkipDungeonView) then
			DungeonModel.instance.curSendEpisodeId = nil

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightBackSkipDungeonView, nil)

			return
		end

		if var_43_1.type == DungeonEnum.ChapterType.DreamTailNormal or var_43_1.type == DungeonEnum.ChapterType.DreamTailHard then
			return true
		end

		if TeachNoteModel.instance:isJumpEnter() then
			DungeonModel.instance.curSendEpisodeId = nil

			return
		end

		if var_43_0.type == DungeonEnum.EpisodeType.Dog then
			return
		end

		if var_43_0.type == DungeonEnum.EpisodeType.RoleStoryChallenge and not RoleStoryModel.instance:checkActStoryOpen() then
			return
		end

		return true
	end
end

function var_0_0.enterTeachNote(arg_44_0, arg_44_1)
	if not arg_44_1 then
		return nil
	end

	local var_44_0 = DungeonConfig.instance:getEpisodeCO(arg_44_1)

	if not var_44_0 then
		return nil
	end

	if DungeonConfig.instance:getChapterCO(var_44_0.chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
		return nil
	end

	if not TeachNoteModel.instance:isTeachNoteEnterFight() then
		return
	else
		if TeachNoteModel.instance:isDetailEnter() and DungeonModel.instance:hasPassLevel(arg_44_1) then
			return
		end

		DungeonModel.instance.curLookChapterId = var_44_0.chapterId
	end

	arg_44_0:enterDungeonView(true)

	if TeachNoteModel.instance:isTeachNoteChapter(DungeonModel.instance.curLookChapterId) then
		DungeonModel.instance.curSendEpisodeId = DungeonModel.instance.curLookEpisodeIdId

		if TeachNoteModel.instance:isTeachNoteEnterFight() then
			arg_44_0:openDungeonChapterView({
				chapterId = arg_44_0._lastChapterId
			}, true)

			if TeachNoteModel.instance:isDetailEnter() then
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteDetailView(arg_44_1)
			else
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteView(arg_44_1)
			end
		else
			if not arg_44_0._lastChapterId then
				arg_44_0._lastChapterId = 101
			end

			return arg_44_0:openDungeonChapterView({
				chapterId = arg_44_0._lastChapterId
			}, true)
		end
	else
		return arg_44_0:openDungeonChapterView({
			chapterId = DungeonModel.instance.curLookChapterId
		}, true)
	end
end

function var_0_0.enterSpecialEquipEpisode(arg_45_0, arg_45_1)
	if not arg_45_1 then
		return nil
	end

	local var_45_0 = DungeonConfig.instance:getEpisodeCO(arg_45_1)

	if not var_45_0 then
		return nil
	end

	if var_45_0.type ~= DungeonEnum.EpisodeType.SpecialEquip then
		return nil
	end

	local var_45_1 = DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId()
	local var_45_2 = DungeonConfig.instance:getChapterCO(var_45_1)
	local var_45_3 = var_45_2.type

	DungeonModel.instance:changeCategory(var_45_3, true)

	local var_45_4 = arg_45_0:enterDungeonView()

	if DungeonModel.instance:getChapterOpenTimeValid(var_45_2) then
		var_45_4 = arg_45_0:openDungeonChapterView({
			chapterId = var_45_1
		}, true)

		if DungeonMapModel.instance:isUnlockSpChapter(var_45_0.chapterId) then
			var_45_4 = arg_45_0:openDungeonEquipEntryView(var_45_0.chapterId)
		end
	end

	return var_45_4
end

function var_0_0.enterVerisonActivity(arg_46_0, arg_46_1)
	local var_46_0 = DungeonConfig.instance:getEpisodeCO(arg_46_1)

	if not var_46_0 then
		return nil
	end

	if var_46_0.type == DungeonEnum.EpisodeType.Meilanni then
		if MeilanniController.instance:activityIsEnd() then
			ViewMgr.instance:openView(ViewName.MainView)

			return ViewName.MainView
		end

		ViewMgr.instance:openView(ViewName.MainView)
		PermanentController.instance:jump2Activity(VersionActivityEnum.ActivityId.Act105)
		MeilanniController.instance:immediateOpenMeilanniMainView()
		MeilanniController.instance:openMeilanniView()

		return ViewName.MeilanniView
	end
end

function var_0_0.enterRoleStoryChallenge(arg_47_0, arg_47_1)
	local var_47_0 = DungeonConfig.instance:getEpisodeCO(arg_47_1)

	if not var_47_0 then
		return nil
	end

	if var_47_0.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
		RoleStoryController.instance:openRoleStoryDispatchMainView({
			1
		})

		return ViewName.RoleStoryDispatchMainView
	end

	if DungeonConfig.instance:getChapterCO(var_47_0.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		local var_47_1 = RoleStoryConfig.instance:getStoryIdByChapterId(var_47_0.chapterId)

		if not RoleStoryModel.instance:isInResident(var_47_1) then
			RoleStoryController.instance:openRoleStoryDispatchMainView({
				clickItem = true
			})

			return ViewName.DungeonMapView
		end
	end
end

function var_0_0.showDungeonView(arg_48_0)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_48_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.curSendEpisodeId = nil

	local var_48_1 = arg_48_0:enterSpecialEquipEpisode(var_48_0)

	if var_48_1 then
		return var_48_1
	end

	local var_48_2 = arg_48_0:enterTeachNote(var_48_0)

	if var_48_2 then
		return var_48_2
	end

	local var_48_3 = arg_48_0:enterVerisonActivity(var_48_0)

	if var_48_3 then
		return var_48_3
	end

	local var_48_4 = arg_48_0:enterRoleStoryChallenge(var_48_0)

	if var_48_4 then
		return var_48_4
	end

	local var_48_5 = arg_48_0:enterFairyLandView(var_48_0)

	if var_48_5 then
		return var_48_5
	end

	local var_48_6 = arg_48_0:enterBossStoryView(var_48_0)

	if var_48_6 then
		return var_48_6
	end

	local var_48_7 = arg_48_0:enterTowerView(var_48_0)

	if var_48_7 then
		return var_48_7
	end

	local var_48_8 = var_48_0 and DungeonConfig.instance:getElementEpisode(var_48_0)
	local var_48_9 = false

	if var_48_8 then
		DungeonMapModel.instance.lastElementBattleId = var_48_0
		var_48_0 = var_48_8
		var_48_9 = true
	end

	DungeonModel.instance.lastSendEpisodeId = var_48_0

	local var_48_10 = DungeonConfig.instance:getEpisodeCO(var_48_0)

	if var_48_10 then
		local var_48_11 = DungeonConfig.instance:getChapterCO(var_48_10.chapterId)

		if var_48_11 and var_48_11.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if var_48_11.type == DungeonEnum.ChapterType.Explore then
			return arg_48_0:enterDungeonView()
		end

		local var_48_12 = var_48_11.type

		if var_48_12 == DungeonEnum.ChapterType.Hard then
			var_48_12 = DungeonEnum.ChapterType.Normal
		end

		DungeonModel.instance:changeCategory(var_48_12, true)

		local var_48_13 = arg_48_0:enterDungeonView()

		if DungeonModel.instance:getChapterOpenTimeValid(var_48_11) then
			var_48_13 = arg_48_0:openDungeonChapterView({
				chapterId = var_48_11.id
			}, true)

			if DungeonModel.instance.curSendEpisodePass or GuideController.instance:isGuiding() then
				-- block empty
			elseif not var_48_9 and arg_48_0:_showLevelView(var_48_12) then
				var_48_13 = var_0_0.instance:generateLevelViewParam(var_48_10, nil)
			end
		end

		return var_48_13
	end
end

function var_0_0._showLevelView(arg_49_0, arg_49_1)
	return arg_49_1 ~= DungeonEnum.ChapterType.WeekWalk and arg_49_1 ~= DungeonEnum.ChapterType.Season and arg_49_1 ~= DungeonEnum.ChapterType.WeekWalk_2
end

function var_0_0.onReceiveEndDungeonReply(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_1 ~= 0 then
		return
	end

	local var_50_0 = {
		dataList = arg_50_2.firstBonus
	}

	if arg_50_0:isStoryDungeonType(arg_50_2.episodeId) and #arg_50_2.firstBonus > 0 then
		MaterialRpc.instance:onReceiveMaterialChangePush(arg_50_1, var_50_0)
	end
end

function var_0_0.isStoryDungeonType(arg_51_0, arg_51_1)
	local var_51_0 = DungeonConfig.instance:getEpisodeCO(arg_51_1)

	if var_51_0 and var_51_0.type == DungeonEnum.EpisodeType.Story then
		return true
	end

	return false
end

function var_0_0.getEpisodeName(arg_52_0)
	local var_52_0 = arg_52_0.chapterId
	local var_52_1 = lua_chapter.configDict[var_52_0]
	local var_52_2 = arg_52_0.id
	local var_52_3 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_52_0, var_52_2)

	if arg_52_0.type == DungeonEnum.EpisodeType.Sp then
		return "SP-" .. var_52_3
	else
		return (string.format("%s-%s", var_52_1.chapterIndex, var_52_3))
	end
end

function var_0_0.openDungeonChangeMapStatusView(arg_53_0, arg_53_1)
	ViewMgr.instance:openView(ViewName.DungeonChangeMapStatusView, arg_53_1)
end

function var_0_0.openPutCubeGameView(arg_54_0, arg_54_1)
	ViewMgr.instance:openView(ViewName.PutCubeGameView, arg_54_1)
end

function var_0_0.openOuijaGameView(arg_55_0, arg_55_1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleOuijaView, arg_55_1)
end

function var_0_0.queryBgm(arg_56_0, arg_56_1)
	local var_56_0, var_56_1, var_56_2, var_56_3, var_56_4 = DungeonModel.instance:getChapterListTypes()

	if var_56_3 then
		arg_56_1:setClearPauseBgm(true)

		return AudioBgmEnum.Layer.DungeonWeekWalk
	end

	arg_56_1:setClearPauseBgm(false)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music, AudioEnum.UI.Stop_UIMusic)

	return AudioBgmEnum.Layer.Dungeon
end

function var_0_0.enterFairyLandView(arg_57_0, arg_57_1)
	if DungeonModel.instance.curSendEpisodePass and (arg_57_1 == 10712 or arg_57_1 == 718) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FairyLand) then
		if DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
			return
		end

		arg_57_0:enterDungeonView()

		local var_57_0 = DungeonConfig.instance:getEpisodeCO(arg_57_1)
		local var_57_1 = DungeonConfig.instance:getChapterCO(var_57_0.chapterId)

		arg_57_0:openDungeonChapterView({
			chapterId = var_57_1.id
		}, true)
		FairyLandController.instance:openFairyLandView()

		if not FairyLandModel.instance:isFinishFairyLand() then
			return ViewName.FairyLandView
		end
	end
end

function var_0_0.enterBossStoryView(arg_58_0, arg_58_1)
	local var_58_0 = DungeonConfig.instance:getEpisodeCO(arg_58_1)

	if var_58_0 and var_58_0.chapterId == DungeonEnum.ChapterId.BossStory then
		local var_58_1 = 11023

		DungeonModel.instance.lastSendEpisodeId = var_58_1

		arg_58_0:enterDungeonView()

		local var_58_2 = DungeonConfig.instance:getEpisodeCO(var_58_1)
		local var_58_3 = DungeonConfig.instance:getChapterCO(var_58_2.chapterId)
		local var_58_4 = arg_58_0:openDungeonChapterView({
			chapterId = var_58_3.id
		}, true)

		if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) then
			return var_58_4
		end

		return VersionActivity2_8DungeonBossController.instance:openVersionActivity2_8BossStoryEnterView()
	end
end

function var_0_0.enterTowerView(arg_59_0, arg_59_1)
	local var_59_0 = DungeonConfig.instance:getEpisodeCO(arg_59_1)

	if not var_59_0 then
		return nil
	end

	local var_59_1

	if var_59_0.type == DungeonEnum.EpisodeType.TowerPermanent or var_59_0.type == DungeonEnum.EpisodeType.TowerDeep then
		var_59_1 = {
			jumpId = TowerEnum.JumpId.TowerPermanent
		}
	end

	if var_59_0.type == DungeonEnum.EpisodeType.TowerBoss then
		var_59_1 = {
			jumpId = TowerEnum.JumpId.TowerBoss
		}

		local var_59_2 = TowerModel.instance:getRecordFightParam()

		var_59_1.towerId = var_59_2 and var_59_2.towerId

		local var_59_3 = TowerModel.instance:getFightFinishParam()

		if var_59_3 and var_59_3.towerType == TowerEnum.TowerType.Boss then
			var_59_1.passLayerId = var_59_3 and var_59_3.layerId
		end
	end

	if var_59_0.type == DungeonEnum.EpisodeType.TowerLimited then
		var_59_1 = {
			jumpId = TowerEnum.JumpId.TowerLimited
		}
	end

	if var_59_0.type == DungeonEnum.EpisodeType.TowerBossTeach then
		var_59_1 = {
			jumpId = TowerEnum.JumpId.TowerBossTeach
		}

		local var_59_4 = TowerModel.instance:getRecordFightParam()

		var_59_1.towerId = var_59_4 and var_59_4.towerId
	end

	if var_59_1 then
		TowerModel.instance:clearFightFinishParam()
		DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
		arg_59_0:enterDungeonView()
		TowerController.instance:openMainView(var_59_1)

		return ViewName.TowerMainView
	end
end

function var_0_0.closePreviewChapterDungeonMapViewActEnd(arg_60_0, arg_60_1)
	if arg_60_1 ~= ViewName.DungeonMapView then
		return true
	end

	local var_60_0 = DungeonModel.instance.curLookChapterId

	if not var_60_0 then
		return false
	end

	local var_60_1 = DungeonConfig.instance:getChapterCO(var_60_0)

	if var_60_1 and var_60_1.eaActivityId ~= 0 and not DungeonMainStoryModel.instance:isPreviewChapter(var_60_0) then
		return true
	end

	return false
end

function var_0_0.closePreviewChapterViewActEnd(arg_61_0, arg_61_1)
	local var_61_0 = DungeonConfig.instance:getChapterCO(arg_61_1)

	if not (var_61_0 and var_61_0.eaActivityId ~= 0) then
		return false
	end

	if var_61_0.eaActivityId ~= arg_61_0 then
		return false
	end

	if DungeonMainStoryModel.instance:isPreviewChapter(arg_61_1) then
		return false
	end

	return true
end

function var_0_0.checkEpisodeFiveHero(arg_62_0)
	local var_62_0 = DungeonConfig.instance:getEpisodeCO(arg_62_0)
	local var_62_1 = var_62_0 and lua_chapter.configDict[var_62_0.chapterId]

	if not (var_62_1 and (var_62_1.type == DungeonEnum.ChapterType.Normal or var_62_1.type == DungeonEnum.ChapterType.Hard or var_62_1.type == DungeonEnum.ChapterType.Simple)) then
		return false
	end

	local var_62_2 = var_62_0 and lua_battle.configDict[var_62_0.battleId]

	if var_62_2 and var_62_2.roleNum == ModuleEnum.FiveHeroEnum.MaxHeroNum then
		return true
	end

	return false
end

function var_0_0.saveFiveHeroGroupData(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	local var_63_0 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(var_63_0.fightGroup, arg_63_0.clothId, arg_63_0:getMainList(), arg_63_0:getSubList(), arg_63_0:getAllHeroEquips(), arg_63_0:getAllHeroActivity104Equips())

	local var_63_1 = ModuleEnum.HeroGroupSnapshotType.FiveHero
	local var_63_2 = 1

	if arg_63_1 == ModuleEnum.HeroGroupType.General then
		var_63_1 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
		var_63_2 = HeroGroupSnapshotModel.instance:getCurGroupId()
	end

	if var_63_1 and var_63_2 then
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_63_1, var_63_2, var_63_0, arg_63_3, arg_63_4)
	else
		logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", var_63_1, var_63_2))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
