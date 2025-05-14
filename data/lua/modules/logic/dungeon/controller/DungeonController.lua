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

function var_0_0._onGuideUnlockNewChapter(arg_11_0, arg_11_1)
	arg_11_1 = tonumber(arg_11_1)

	if arg_11_1 ~= 101 then
		DungeonModel.instance.unlockNewChapterId = arg_11_1
		DungeonModel.instance.chapterTriggerNewChapter = false

		return
	end

	local var_11_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ChapterUnlockEffect)

	if not string.nilorempty(var_11_0) then
		TaskDispatcher.runDelay(function()
			var_0_0.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
		end, nil, 0)

		return
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ChapterUnlockEffect, "1")

	DungeonModel.instance.chapterTriggerNewChapter = true
	DungeonModel.instance.unlockNewChapterId = arg_11_1
end

function var_0_0._onSetResScrollPos(arg_13_0, arg_13_1)
	DungeonModel.instance.resScrollPosX = arg_13_1
end

function var_0_0._onFocusEpisode(arg_14_0, arg_14_1)
	DungeonModel.instance:setLastSendEpisodeId(tonumber(arg_14_1))
end

function var_0_0.enterDungeonView(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 then
		DungeonModel.instance:initModel()
	end

	local var_15_0 = {
		fromMainView = arg_15_2
	}

	return arg_15_0:openDungeonView(var_15_0, false)
end

function var_0_0.jumpDungeon(arg_16_0, arg_16_1)
	local var_16_0 = {}

	if not arg_16_1 then
		return var_16_0
	end

	local var_16_1 = arg_16_1.chapterType
	local var_16_2 = arg_16_1.chapterId
	local var_16_3 = arg_16_1.episodeId

	DungeonModel.instance.lastSendEpisodeId = var_16_3

	if not var_16_1 then
		return var_16_0
	end

	local var_16_4

	if var_16_1 == DungeonEnum.ChapterType.Hard then
		local var_16_5 = DungeonConfig.instance:getEpisodeCO(var_16_3)

		if not var_16_5 then
			logError("不能直接跳困难章节,可以配合困难关卡跳转")

			return var_16_0
		end

		local var_16_6 = DungeonConfig.instance:getEpisodeCO(var_16_5.preEpisode)

		if not var_16_6 then
			return var_16_0
		end

		var_16_1, var_16_2, var_16_3 = DungeonConfig.instance:getChapterCO(var_16_6.chapterId).type, var_16_6.chapterId, var_16_6.id
		var_16_4 = true
	end

	if var_16_1 == DungeonEnum.ChapterType.Newbie then
		logError("不能跳新手章节")

		return var_16_0
	end

	DungeonModel.instance:changeCategory(var_16_1)

	if not DungeonConfig.instance:getChapterCO(var_16_2) then
		table.insert(var_16_0, ViewName.DungeonView)
		arg_16_0:openDungeonView(nil)

		return var_16_0
	end

	if DungeonModel.instance:chapterIsLock(var_16_2) then
		table.insert(var_16_0, ViewName.DungeonView)
		arg_16_0:openDungeonView(nil)

		return var_16_0
	end

	local var_16_7 = {
		chapterId = var_16_2,
		episodeId = var_16_3
	}

	table.insert(var_16_0, arg_16_0:getDungeonChapterViewName(var_16_2))

	local var_16_8 = var_16_3 and DungeonConfig.instance:getEpisodeCO(var_16_3)

	if not var_16_8 then
		arg_16_0:openDungeonChapterView(var_16_7)

		return var_16_0
	end

	DungeonModel.instance.curLookChapterId = var_16_2

	local var_16_9 = arg_16_0:jumpChapterAndLevel(var_16_2, var_16_8, var_16_7, var_16_4, arg_16_1.isNoShowMapLevel)

	if var_16_9 then
		table.insert(var_16_0, var_16_9)
	end

	return var_16_0
end

function var_0_0.jumpChapterAndLevel(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = arg_17_0:generateLevelViewParam(arg_17_2, arg_17_4, true)
	local var_17_1 = {}
	local var_17_2 = {}

	arg_17_3 = arg_17_3 or {}
	arg_17_3.notOpenHelp = true
	DungeonModel.instance.jumpEpisodeId = arg_17_3.episodeId

	function var_17_2.openFunction()
		arg_17_0:openDungeonChapterView(arg_17_3, true)
	end

	var_17_2.waitOpenViewName = arg_17_0:getDungeonChapterViewName(arg_17_1)

	table.insert(var_17_1, var_17_2)

	if not arg_17_5 then
		local var_17_3 = {
			openFunction = function()
				arg_17_0:generateLevelViewParam(arg_17_2, arg_17_4)
			end
		}

		table.insert(var_17_1, var_17_3)
	end

	module_views_preloader.DungeonChapterAndLevelView(function()
		OpenMultiView.openView(var_17_1)
	end, arg_17_1, var_17_0)

	return var_17_0
end

function var_0_0.generateLevelViewParam(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0
	local var_21_1 = DungeonModel.instance:getEpisodeInfo(arg_21_1.id) or nil

	if not var_21_1 then
		return var_21_0
	end

	local var_21_2, var_21_3 = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)
	local var_21_4 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(DungeonModel.instance.curLookChapterId, arg_21_1.id)

	return (arg_21_0:enterLevelView({
		arg_21_1,
		var_21_1,
		var_21_2,
		var_21_4,
		arg_21_2,
		true
	}, arg_21_3))
end

function var_0_0.enterLevelView(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0
	local var_22_1 = arg_22_1[1]

	if not var_22_1 then
		logError("找不到配置")

		return var_22_0
	end

	if DungeonModel.isBattleEpisode(var_22_1) then
		if not arg_22_2 then
			var_0_0.instance:openDungeonLevelView(arg_22_1)
		end

		var_22_0 = arg_22_0:getDungeonLevelViewName(var_22_1.chapterId)
	elseif var_22_1.type == DungeonEnum.EpisodeType.Story then
		if not arg_22_2 then
			var_0_0.instance:openDungeonLevelView(arg_22_1)
		end

		var_22_0 = arg_22_0:getDungeonLevelViewName(var_22_1.chapterId)
	elseif var_22_1.type == DungeonEnum.EpisodeType.Decrypt and (arg_22_2 or true) then
		var_22_0 = ViewName.DungeonPuzzleChangeColorView
	end

	return var_22_0
end

function var_0_0.canJumpDungeonType(arg_23_0, arg_23_1)
	local var_23_0 = true
	local var_23_1 = DungeonEnum.ChapterType.Normal

	if arg_23_1 == JumpEnum.DungeonChapterType.Gold then
		var_23_1 = DungeonEnum.ChapterType.Gold
		var_23_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon)
	elseif arg_23_1 == JumpEnum.DungeonChapterType.Resource then
		var_23_1 = DungeonEnum.ChapterType.Break
		var_23_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon)
	elseif arg_23_1 == JumpEnum.DungeonChapterType.WeekWalk then
		var_23_1 = DungeonEnum.ChapterType.WeekWalk
		var_23_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk)
	elseif arg_23_1 == JumpEnum.DungeonChapterType.Explore then
		var_23_1 = DungeonEnum.ChapterType.Explore
		var_23_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore)
	end

	if var_23_0 and DungeonModel.instance:getChapterListOpenTimeValid(var_23_1) then
		return true
	end

	return false
end

function var_0_0.canJumpDungeonChapter(arg_24_0, arg_24_1)
	local var_24_0 = DungeonConfig.instance:getChapterCO(arg_24_1)

	if not var_24_0 then
		return false
	end

	local var_24_1 = var_24_0.type
	local var_24_2 = JumpEnum.DungeonChapterType.Story
	local var_24_3 = true

	if var_24_1 == DungeonEnum.ChapterType.Gold or var_24_1 == DungeonEnum.ChapterType.Exp or var_24_1 == DungeonEnum.ChapterType.Equip then
		var_24_2 = JumpEnum.DungeonChapterType.Gold

		if var_24_1 == DungeonEnum.ChapterType.Gold then
			var_24_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)
		elseif var_24_1 == DungeonEnum.ChapterType.Exp then
			var_24_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)
		elseif var_24_1 == DungeonEnum.ChapterType.Equip then
			var_24_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)
		elseif var_24_1 == DungeonEnum.ChapterType.Buildings then
			var_24_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)
		end
	elseif var_24_1 == DungeonEnum.ChapterType.Break then
		var_24_2 = JumpEnum.DungeonChapterType.Resource
	end

	if arg_24_0:canJumpDungeonType(var_24_2) and var_24_3 and not DungeonModel.instance:chapterIsLock(arg_24_1) and DungeonModel.instance:getChapterOpenTimeValid(var_24_0) then
		return true
	end

	return false
end

function var_0_0.openDungeonEquipEntryView(arg_25_0, arg_25_1, arg_25_2)
	ViewMgr.instance:openView(ViewName.DungeonEquipEntryView, arg_25_1, arg_25_2)

	return ViewName.DungeonEquipEntryView
end

function var_0_0.openDungeonView(arg_26_0, arg_26_1, arg_26_2)
	ViewMgr.instance:openView(ViewName.DungeonView, arg_26_1, arg_26_2)

	return ViewName.DungeonView
end

function var_0_0.openDungeonMapTaskView(arg_27_0, arg_27_1, arg_27_2)
	ViewMgr.instance:openView(ViewName.DungeonMapTaskView, arg_27_1, arg_27_2)

	return ViewName.DungeonMapTaskView
end

function var_0_0.openDungeonChapterView(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 and arg_28_1.chapterId then
		DungeonModel.instance.curLookChapterId = arg_28_1.chapterId
	end

	local var_28_0 = DungeonConfig.instance:getChapterCO(arg_28_1.chapterId)

	if var_28_0.type == DungeonEnum.ChapterType.WeekWalk then
		WeekWalkController.instance:openWeekWalkView(arg_28_1, arg_28_2)

		return ViewName.WeekWalkView
	elseif var_28_0.type == DungeonEnum.ChapterType.WeekWalk_2 then
		WeekWalk_2Controller.instance:openWeekWalk_2HeartView(arg_28_1, arg_28_2)

		return ViewName.WeekWalk_2HeartView
	elseif var_28_0.type == DungeonEnum.ChapterType.Season or var_28_0.type == DungeonEnum.ChapterType.SeasonRetail or var_28_0.type == DungeonEnum.ChapterType.SeasonSpecial then
		Activity104Controller.instance:openSeasonMainView()

		return ViewName.SeasonMainView
	elseif var_28_0.type == DungeonEnum.ChapterType.Season123 or var_28_0.type == DungeonEnum.ChapterType.Season123Retail then
		Season123Controller.instance:openMainViewFromFightScene()

		return Season123Controller.instance:getEpisodeListViewName()
	elseif var_28_0.id == HeroInvitationEnum.ChapterId then
		arg_28_0._lastChapterId = arg_28_1.chapterId

		DungeonModel.instance:changeCategory(var_28_0.type, false)
		HeroInvitationRpc.instance:sendGetHeroInvitationInfoRequest()
		ViewMgr.instance:openView(ViewName.HeroInvitationDungeonMapView, arg_28_1, arg_28_2)

		return ViewName.HeroInvitationDungeonMapView
	end

	arg_28_0._lastChapterId = arg_28_1.chapterId

	DungeonModel.instance:changeCategory(var_28_0.type, false)
	ViewMgr.instance:openView(ViewName.DungeonMapView, arg_28_1, arg_28_2)

	return ViewName.DungeonMapView
end

function var_0_0.getDungeonChapterViewName(arg_29_0, arg_29_1)
	if arg_29_1 == HeroInvitationEnum.ChapterId then
		return ViewName.HeroInvitationDungeonMapView
	end

	return ViewName.DungeonMapView
end

function var_0_0.getDungeonLevelViewName(arg_30_0, arg_30_1)
	return ViewName.DungeonMapLevelView
end

function var_0_0.openDungeonCumulativeRewardsView(arg_31_0, arg_31_1, arg_31_2)
	ViewMgr.instance:openView(ViewName.DungeonCumulativeRewardsView, arg_31_1, arg_31_2)
end

function var_0_0.openDungeonLevelView(arg_32_0, arg_32_1, arg_32_2)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowDungeonMapLevelView) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.SkipShowDungeonMapLevelView, nil)

		return
	end

	local var_32_0 = arg_32_1[1]

	DungeonModel.instance.curLookEpisodeId = var_32_0.id

	ViewMgr.instance:openView(ViewName.DungeonMapLevelView, arg_32_1, arg_32_2)
end

function var_0_0.openDungeonMonsterView(arg_33_0, arg_33_1, arg_33_2)
	ViewMgr.instance:openView(ViewName.DungeonMonsterView, arg_33_1, arg_33_2)
end

function var_0_0.openDungeonRewardView(arg_34_0, arg_34_1, arg_34_2)
	ViewMgr.instance:openView(ViewName.DungeonRewardView, arg_34_1, arg_34_2)
end

function var_0_0.openDungeonElementRewardView(arg_35_0, arg_35_1, arg_35_2)
	ViewMgr.instance:openView(ViewName.DungeonElementRewardView, arg_35_1, arg_35_2)
end

function var_0_0.openDungeonStoryView(arg_36_0, arg_36_1, arg_36_2)
	ViewMgr.instance:openView(ViewName.DungeonStoryView, arg_36_1, arg_36_2)
end

function var_0_0.onStartLevelOrStoryChange(arg_37_0)
	DungeonModel.instance:startCheckUnlockChapter()
	arg_37_0:_onStartCheckUnlockContent()
end

function var_0_0.onEndLevelOrStoryChange(arg_38_0)
	DungeonModel.instance:endCheckUnlockChapter()
	arg_38_0:_onEndCheckUnlockContent()
end

function var_0_0._onStartCheckUnlockContent(arg_39_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	arg_39_0._hasAllPass = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)
end

function var_0_0._onEndCheckUnlockContent(arg_40_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_40_0 = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)

	if var_40_0 and var_40_0 ~= arg_40_0._hasAllPass then
		var_0_0.instance:showUnlockContentToast(DungeonModel.instance.curSendEpisodeId)
	end
end

function var_0_0.showUnlockContentToast(arg_41_0, arg_41_1)
	local var_41_0 = DungeonChapterUnlockItem.getUnlockContentList(arg_41_1, true)

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		if DungeonConfig.instance:getChapterCO(lua_episode.configDict[arg_41_1].chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
			GameFacade.showToast(ToastEnum.IconId, iter_41_1)
		end
	end
end

function var_0_0.needShowDungeonView(arg_42_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_42_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_42_0 then
		local var_42_1 = DungeonConfig.instance:getChapterCO(var_42_0.chapterId)

		if var_42_1 and var_42_1.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightBackSkipDungeonView) then
			DungeonModel.instance.curSendEpisodeId = nil

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightBackSkipDungeonView, nil)

			return
		end

		if var_42_1.type == DungeonEnum.ChapterType.DreamTailNormal or var_42_1.type == DungeonEnum.ChapterType.DreamTailHard then
			return true
		end

		if TeachNoteModel.instance:isJumpEnter() then
			DungeonModel.instance.curSendEpisodeId = nil

			return
		end

		if var_42_0.type == DungeonEnum.EpisodeType.Dog then
			return
		end

		if var_42_0.type == DungeonEnum.EpisodeType.RoleStoryChallenge and not RoleStoryModel.instance:checkActStoryOpen() then
			return
		end

		return true
	end
end

function var_0_0.enterTeachNote(arg_43_0, arg_43_1)
	if not arg_43_1 then
		return nil
	end

	local var_43_0 = DungeonConfig.instance:getEpisodeCO(arg_43_1)

	if not var_43_0 then
		return nil
	end

	if DungeonConfig.instance:getChapterCO(var_43_0.chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
		return nil
	end

	if not TeachNoteModel.instance:isTeachNoteEnterFight() then
		return
	else
		if TeachNoteModel.instance:isDetailEnter() and DungeonModel.instance:hasPassLevel(arg_43_1) then
			return
		end

		DungeonModel.instance.curLookChapterId = var_43_0.chapterId
	end

	arg_43_0:enterDungeonView(true)

	if TeachNoteModel.instance:isTeachNoteChapter(DungeonModel.instance.curLookChapterId) then
		DungeonModel.instance.curSendEpisodeId = DungeonModel.instance.curLookEpisodeIdId

		if TeachNoteModel.instance:isTeachNoteEnterFight() then
			arg_43_0:openDungeonChapterView({
				chapterId = arg_43_0._lastChapterId
			}, true)

			if TeachNoteModel.instance:isDetailEnter() then
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteDetailView(arg_43_1)
			else
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteView(arg_43_1)
			end
		else
			if not arg_43_0._lastChapterId then
				arg_43_0._lastChapterId = 101
			end

			return arg_43_0:openDungeonChapterView({
				chapterId = arg_43_0._lastChapterId
			}, true)
		end
	else
		return arg_43_0:openDungeonChapterView({
			chapterId = DungeonModel.instance.curLookChapterId
		}, true)
	end
end

function var_0_0.enterSpecialEquipEpisode(arg_44_0, arg_44_1)
	if not arg_44_1 then
		return nil
	end

	local var_44_0 = DungeonConfig.instance:getEpisodeCO(arg_44_1)

	if not var_44_0 then
		return nil
	end

	if var_44_0.type ~= DungeonEnum.EpisodeType.SpecialEquip then
		return nil
	end

	local var_44_1 = DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId()
	local var_44_2 = DungeonConfig.instance:getChapterCO(var_44_1)
	local var_44_3 = var_44_2.type

	DungeonModel.instance:changeCategory(var_44_3, true)

	local var_44_4 = arg_44_0:enterDungeonView()

	if DungeonModel.instance:getChapterOpenTimeValid(var_44_2) then
		var_44_4 = arg_44_0:openDungeonChapterView({
			chapterId = var_44_1
		}, true)

		if DungeonMapModel.instance:isUnlockSpChapter(var_44_0.chapterId) then
			var_44_4 = arg_44_0:openDungeonEquipEntryView(var_44_0.chapterId)
		end
	end

	return var_44_4
end

function var_0_0.enterVerisonActivity(arg_45_0, arg_45_1)
	local var_45_0 = DungeonConfig.instance:getEpisodeCO(arg_45_1)

	if not var_45_0 then
		return nil
	end

	if var_45_0.type == DungeonEnum.EpisodeType.Meilanni then
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

function var_0_0.enterRoleStoryChallenge(arg_46_0, arg_46_1)
	local var_46_0 = DungeonConfig.instance:getEpisodeCO(arg_46_1)

	if not var_46_0 then
		return nil
	end

	if var_46_0.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
		RoleStoryController.instance:openRoleStoryDispatchMainView({
			1
		})

		return ViewName.RoleStoryDispatchMainView
	end

	if DungeonConfig.instance:getChapterCO(var_46_0.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		local var_46_1 = RoleStoryConfig.instance:getStoryIdByChapterId(var_46_0.chapterId)

		if not RoleStoryModel.instance:isInResident(var_46_1) then
			RoleStoryController.instance:openRoleStoryDispatchMainView({
				clickItem = true
			})

			return ViewName.DungeonMapView
		end
	end
end

function var_0_0.showDungeonView(arg_47_0)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_47_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.curSendEpisodeId = nil

	local var_47_1 = arg_47_0:enterSpecialEquipEpisode(var_47_0)

	if var_47_1 then
		return var_47_1
	end

	local var_47_2 = arg_47_0:enterTeachNote(var_47_0)

	if var_47_2 then
		return var_47_2
	end

	local var_47_3 = arg_47_0:enterVerisonActivity(var_47_0)

	if var_47_3 then
		return var_47_3
	end

	local var_47_4 = arg_47_0:enterRoleStoryChallenge(var_47_0)

	if var_47_4 then
		return var_47_4
	end

	local var_47_5 = arg_47_0:enterFairyLandView(var_47_0)

	if var_47_5 then
		return var_47_5
	end

	local var_47_6 = arg_47_0:enterTowerView(var_47_0)

	if var_47_6 then
		return var_47_6
	end

	local var_47_7 = var_47_0 and DungeonConfig.instance:getElementEpisode(var_47_0)
	local var_47_8 = false

	if var_47_7 then
		DungeonMapModel.instance.lastElementBattleId = var_47_0
		var_47_0 = var_47_7
		var_47_8 = true
	end

	DungeonModel.instance.lastSendEpisodeId = var_47_0

	local var_47_9 = DungeonConfig.instance:getEpisodeCO(var_47_0)

	if var_47_9 then
		local var_47_10 = DungeonConfig.instance:getChapterCO(var_47_9.chapterId)

		if var_47_10 and var_47_10.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if var_47_10.type == DungeonEnum.ChapterType.Explore then
			return arg_47_0:enterDungeonView()
		end

		local var_47_11 = var_47_10.type

		if var_47_11 == DungeonEnum.ChapterType.Hard then
			var_47_11 = DungeonEnum.ChapterType.Normal
		end

		DungeonModel.instance:changeCategory(var_47_11, true)

		local var_47_12 = arg_47_0:enterDungeonView()

		if DungeonModel.instance:getChapterOpenTimeValid(var_47_10) then
			var_47_12 = arg_47_0:openDungeonChapterView({
				chapterId = var_47_10.id
			}, true)

			if DungeonModel.instance.curSendEpisodePass or GuideController.instance:isGuiding() then
				-- block empty
			elseif not var_47_8 and arg_47_0:_showLevelView(var_47_11) then
				var_47_12 = var_0_0.instance:generateLevelViewParam(var_47_9, nil)
			end
		end

		return var_47_12
	end
end

function var_0_0._showLevelView(arg_48_0, arg_48_1)
	return arg_48_1 ~= DungeonEnum.ChapterType.WeekWalk and arg_48_1 ~= DungeonEnum.ChapterType.Season and arg_48_1 ~= DungeonEnum.ChapterType.WeekWalk_2
end

function var_0_0.onReceiveEndDungeonReply(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 ~= 0 then
		return
	end

	local var_49_0 = {
		dataList = arg_49_2.firstBonus
	}

	if arg_49_0:isStoryDungeonType(arg_49_2.episodeId) and #arg_49_2.firstBonus > 0 then
		MaterialRpc.instance:onReceiveMaterialChangePush(arg_49_1, var_49_0)
	end
end

function var_0_0.isStoryDungeonType(arg_50_0, arg_50_1)
	local var_50_0 = DungeonConfig.instance:getEpisodeCO(arg_50_1)

	if var_50_0 and var_50_0.type == DungeonEnum.EpisodeType.Story then
		return true
	end

	return false
end

function var_0_0.getEpisodeName(arg_51_0)
	local var_51_0 = arg_51_0.chapterId
	local var_51_1 = lua_chapter.configDict[var_51_0]
	local var_51_2 = arg_51_0.id
	local var_51_3 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_51_0, var_51_2)

	if arg_51_0.type == DungeonEnum.EpisodeType.Sp then
		return "SP-" .. var_51_3
	else
		return (string.format("%s-%s", var_51_1.chapterIndex, var_51_3))
	end
end

function var_0_0.openDungeonChangeMapStatusView(arg_52_0, arg_52_1)
	ViewMgr.instance:openView(ViewName.DungeonChangeMapStatusView, arg_52_1)
end

function var_0_0.openPutCubeGameView(arg_53_0, arg_53_1)
	ViewMgr.instance:openView(ViewName.PutCubeGameView, arg_53_1)
end

function var_0_0.openOuijaGameView(arg_54_0, arg_54_1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleOuijaView, arg_54_1)
end

function var_0_0.queryBgm(arg_55_0, arg_55_1)
	local var_55_0, var_55_1, var_55_2, var_55_3, var_55_4 = DungeonModel.instance:getChapterListTypes()

	if var_55_3 then
		arg_55_1:setClearPauseBgm(true)

		return AudioBgmEnum.Layer.DungeonWeekWalk
	end

	arg_55_1:setClearPauseBgm(false)

	return AudioBgmEnum.Layer.Dungeon
end

function var_0_0.enterFairyLandView(arg_56_0, arg_56_1)
	if DungeonModel.instance.curSendEpisodePass and (arg_56_1 == 10712 or arg_56_1 == 718) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FairyLand) then
		if DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
			return
		end

		arg_56_0:enterDungeonView()

		local var_56_0 = DungeonConfig.instance:getEpisodeCO(arg_56_1)
		local var_56_1 = DungeonConfig.instance:getChapterCO(var_56_0.chapterId)

		arg_56_0:openDungeonChapterView({
			chapterId = var_56_1.id
		}, true)
		FairyLandController.instance:openFairyLandView()

		if not FairyLandModel.instance:isFinishFairyLand() then
			return ViewName.FairyLandView
		end
	end
end

function var_0_0.enterTowerView(arg_57_0, arg_57_1)
	local var_57_0 = DungeonConfig.instance:getEpisodeCO(arg_57_1)

	if not var_57_0 then
		return nil
	end

	local var_57_1

	if var_57_0.type == DungeonEnum.EpisodeType.TowerPermanent then
		var_57_1 = {
			jumpId = TowerEnum.JumpId.TowerPermanent
		}
	end

	if var_57_0.type == DungeonEnum.EpisodeType.TowerBoss then
		var_57_1 = {
			jumpId = TowerEnum.JumpId.TowerBoss
		}

		local var_57_2 = TowerModel.instance:getRecordFightParam()

		var_57_1.towerId = var_57_2 and var_57_2.towerId

		local var_57_3 = TowerModel.instance:getFightFinishParam()

		if var_57_3 and var_57_3.towerType == TowerEnum.TowerType.Boss then
			var_57_1.passLayerId = var_57_3 and var_57_3.layerId
		end
	end

	if var_57_0.type == DungeonEnum.EpisodeType.TowerLimited then
		var_57_1 = {
			jumpId = TowerEnum.JumpId.TowerLimited
		}
	end

	if var_57_0.type == DungeonEnum.EpisodeType.TowerBossTeach then
		var_57_1 = {
			jumpId = TowerEnum.JumpId.TowerBossTeach
		}

		local var_57_4 = TowerModel.instance:getRecordFightParam()

		var_57_1.towerId = var_57_4 and var_57_4.towerId
	end

	if var_57_1 then
		TowerModel.instance:clearFightFinishParam()
		DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
		arg_57_0:enterDungeonView()
		TowerController.instance:openMainView(var_57_1)

		return ViewName.TowerMainView
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
