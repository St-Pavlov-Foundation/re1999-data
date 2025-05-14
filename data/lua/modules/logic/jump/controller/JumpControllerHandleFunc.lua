module("modules.logic.jump.controller.JumpControllerHandleFunc", package.seeall)

local var_0_0 = JumpController

var_0_0.DefaultToastId = 0

function var_0_0.activateHandleFuncController()
	return
end

function var_0_0.defaultHandleFunc(arg_2_0, arg_2_1)
	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRoleStoryActivity(arg_3_0, arg_3_1)
	local var_3_0 = string.splitToNumber(arg_3_1, "#")
	local var_3_1 = ViewName.RoleStoryDispatchMainView

	table.insert(arg_3_0.waitOpenViewNames, var_3_1)

	if RoleStoryController.instance:openRoleStoryDispatchMainView(var_3_0) then
		return JumpEnum.JumpResult.Success
	end

	tabletool.removeValue(arg_3_0.waitOpenViewNames, var_3_1)

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToStoreView(arg_4_0, arg_4_1)
	local var_4_0 = string.splitToNumber(arg_4_1, "#")

	table.insert(arg_4_0.waitOpenViewNames, ViewName.StoreView)
	table.insert(arg_4_0.closeViewNames, ViewName.NormalStoreGoodsView)
	table.insert(arg_4_0.closeViewNames, ViewName.ChargeStoreGoodsView)
	table.insert(arg_4_0.remainViewNames, ViewName.StoreView)

	if ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
		table.insert(arg_4_0.remainViewNames, ViewName.DungeonView)
	end

	if #var_4_0 >= 2 then
		local var_4_1 = var_4_0[2]
		local var_4_2 = var_4_0[3]

		if (var_4_1 == StoreEnum.StoreId.Package or var_4_1 == StoreEnum.StoreId.RecommendPackage or var_4_1 == StoreEnum.StoreId.NormalPackage or var_4_1 == StoreEnum.StoreId.OneTimePackage or var_4_1 == StoreEnum.StoreId.VersionPackage) and var_4_2 then
			table.insert(arg_4_0.remainViewNames, ViewName.PackageStoreGoodsView)
		end

		StoreController.instance:openStoreView(var_4_1, var_4_2)
	else
		StoreController.instance:openStoreView()
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSummonView(arg_5_0, arg_5_1)
	local var_5_0 = string.splitToNumber(arg_5_1, "#")

	table.insert(arg_5_0.remainViewNames, ViewName.SummonADView)
	table.insert(arg_5_0.remainViewNames, ViewName.SummonView)

	if #var_5_0 >= 2 then
		local var_5_1 = var_5_0[2]

		SummonController.instance:jumpSummon(var_5_1)
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSummonViewGroup(arg_6_0, arg_6_1)
	local var_6_0 = string.splitToNumber(arg_6_1, "#")

	table.insert(arg_6_0.remainViewNames, ViewName.SummonADView)
	table.insert(arg_6_0.remainViewNames, ViewName.SummonView)

	if #var_6_0 >= 2 then
		local var_6_1 = var_6_0[2]

		SummonController.instance:jumpSummonByGroup(var_6_1)
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDungeonViewWithChapter(arg_7_0, arg_7_1)
	local var_7_0 = string.splitToNumber(arg_7_1, "#")

	table.insert(arg_7_0.waitOpenViewNames, ViewName.DungeonMapView)
	table.insert(arg_7_0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(arg_7_0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(arg_7_0.closeViewNames, ViewName.DungeonMapView)
	table.insert(arg_7_0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(arg_7_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(arg_7_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(arg_7_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_7_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_7_0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(arg_7_0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(arg_7_0.closeViewNames, ViewName.StoryView)
	table.insert(arg_7_0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

	local var_7_1 = var_7_0[2]
	local var_7_2 = DungeonConfig.instance:getChapterCO(var_7_1)

	if var_7_2 then
		local var_7_3 = var_7_2.type
		local var_7_4 = {
			chapterType = var_7_3,
			chapterId = var_7_1
		}
		local var_7_5 = DungeonController.instance:jumpDungeon(var_7_4)

		if var_7_5 and #var_7_5 > 0 then
			for iter_7_0, iter_7_1 in ipairs(var_7_5) do
				table.insert(arg_7_0.remainViewNames, iter_7_1)
			end

			table.insert(arg_7_0.remainViewNames, ViewName.DungeonView)
		end

		return JumpEnum.JumpResult.Success
	else
		logError("找不到章节配置, chapterId: " .. tostring(var_7_1))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDungeonViewWithEpisode(arg_8_0, arg_8_1)
	local var_8_0 = string.splitToNumber(arg_8_1, "#")

	table.insert(arg_8_0.waitOpenViewNames, ViewName.DungeonMapView)

	if var_8_0[3] ~= 1 then
		table.insert(arg_8_0.waitOpenViewNames, ViewName.DungeonMapLevelView)
	end

	table.insert(arg_8_0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(arg_8_0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(arg_8_0.closeViewNames, ViewName.DungeonMapView)
	table.insert(arg_8_0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(arg_8_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(arg_8_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(arg_8_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_8_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_8_0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(arg_8_0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(arg_8_0.closeViewNames, ViewName.StoryView)
	table.insert(arg_8_0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)
	table.insert(arg_8_0.closeViewNames, ViewName.InvestigateOpinionView)
	table.insert(arg_8_0.closeViewNames, ViewName.InvestigateView)

	for iter_8_0 in pairs(ActivityHelper.getJumpNeedCloseViewDict()) do
		table.insert(arg_8_0.closeViewNames, iter_8_0)
	end

	local var_8_1 = var_8_0[2]
	local var_8_2 = var_8_0[3] == 1
	local var_8_3 = DungeonConfig.instance:getEpisodeCO(var_8_1)

	if var_8_3 then
		local var_8_4 = var_8_3.chapterId
		local var_8_5 = DungeonConfig.instance:getChapterCO(var_8_4)

		if var_8_5 then
			local var_8_6 = var_8_5.type
			local var_8_7 = {
				chapterType = var_8_6,
				chapterId = var_8_4,
				episodeId = var_8_1,
				isNoShowMapLevel = var_8_2
			}
			local var_8_8 = DungeonController.instance:jumpDungeon(var_8_7)

			if var_8_8 and #var_8_8 > 0 then
				for iter_8_1, iter_8_2 in ipairs(var_8_8) do
					table.insert(arg_8_0.remainViewNames, iter_8_2)
				end

				table.insert(arg_8_0.remainViewNames, ViewName.DungeonView)
			else
				return JumpEnum.JumpResult.Fail
			end
		else
			logError("找不到章节配置, chapterId: " .. tostring(var_8_4))

			return JumpEnum.JumpResult.Fail
		end
	else
		logError("找不到关卡配置, episodeId: " .. tostring(var_8_1))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDungeonViewWithType(arg_9_0, arg_9_1)
	local var_9_0 = string.splitToNumber(arg_9_1, "#")[2] or JumpEnum.DungeonChapterType.Story
	local var_9_1 = {}

	if var_9_0 == JumpEnum.DungeonChapterType.Story then
		var_9_1.chapterType = DungeonEnum.ChapterType.Normal
	elseif var_9_0 == JumpEnum.DungeonChapterType.Gold then
		var_9_1.chapterType = DungeonEnum.ChapterType.Gold
	elseif var_9_0 == JumpEnum.DungeonChapterType.Resource then
		var_9_1.chapterType = DungeonEnum.ChapterType.Break
	elseif var_9_0 == JumpEnum.DungeonChapterType.Explore then
		var_9_1.chapterType = DungeonEnum.ChapterType.Explore
	elseif var_9_0 == JumpEnum.DungeonChapterType.WeekWalk then
		var_9_1.chapterType = DungeonEnum.ChapterType.WeekWalk

		if ViewMgr.instance:isOpen(ViewName.WeekWalkView) or ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
			ViewMgr.instance:closeView(ViewName.TaskView)
			ViewMgr.instance:closeView(ViewName.StoreView)
			ViewMgr.instance:closeView(ViewName.BpView)

			return JumpEnum.JumpResult.Success
		end
	elseif var_9_0 == JumpEnum.DungeonChapterType.RoleStory then
		var_9_1.chapterType = DungeonEnum.ChapterType.RoleStory
	end

	table.insert(arg_9_0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(arg_9_0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(arg_9_0.closeViewNames, ViewName.DungeonMapView)
	table.insert(arg_9_0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(arg_9_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(arg_9_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(arg_9_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_9_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_9_0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(arg_9_0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(arg_9_0.closeViewNames, ViewName.StoryView)
	table.insert(arg_9_0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

	local var_9_2 = DungeonController.instance:jumpDungeon(var_9_1)

	if var_9_2 and #var_9_2 > 0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			table.insert(arg_9_0.remainViewNames, iter_9_1)
		end

		table.insert(arg_9_0.remainViewNames, ViewName.DungeonView)
	else
		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToCharacterBackpackViewWithCharacter(arg_10_0, arg_10_1)
	table.insert(arg_10_0.waitOpenViewNames, ViewName.CharacterBackpackView)
	CharacterController.instance:enterCharacterBackpack(JumpEnum.CharacterBackpack.Character)
	table.insert(arg_10_0.remainViewNames, ViewName.CharacterBackpackView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToCharacterBackpackViewWithEquip(arg_11_0, arg_11_1)
	table.insert(arg_11_0.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.Equip)
	table.insert(arg_11_0.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToHeroGroupView(arg_12_0, arg_12_1)
	local var_12_0 = string.splitToNumber(arg_12_1, "#")[2]
	local var_12_1 = DungeonConfig.instance:getEpisodeCO(var_12_0)

	DungeonFightController.instance:enterFight(var_12_1.chapterId, var_12_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToBackpackView(arg_13_0, arg_13_1)
	table.insert(arg_13_0.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack()
	table.insert(arg_13_0.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToPlayerClothView(arg_14_0, arg_14_1)
	logError("废弃跳转到主角技能界面")

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToMainView(arg_15_0, arg_15_1)
	local var_15_0 = string.splitToNumber(arg_15_1, "#")[2]

	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()

	if var_15_0 == 1 then
		ViewMgr.instance:openView(ViewName.MainView)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToTaskView(arg_16_0, arg_16_1)
	local var_16_0 = string.splitToNumber(arg_16_1, "#")

	table.insert(arg_16_0.waitOpenViewNames, ViewName.TaskView)
	table.insert(arg_16_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_16_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_16_0.closeViewNames, ViewName.WeekWalkLayerView)

	local var_16_1

	if #var_16_0 >= 2 then
		var_16_1 = var_16_0[2]
	end

	TaskController.instance:enterTaskView(var_16_1)
	table.insert(arg_16_0.remainViewNames, ViewName.TaskView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRoomView(arg_17_0, arg_17_1)
	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRoomProductLineView(arg_18_0, arg_18_1)
	local var_18_0 = RoomController.instance:isRoomScene()

	if RoomController.instance:isEditMode() and var_18_0 then
		GameFacade.showToast(RoomEnum.Toast.RoomEditCanNotOpenProductionLevel)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_18_0.waitOpenViewNames, ViewName.RoomInitBuildingView)

	if not ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		if var_18_0 then
			RoomMapController.instance:openRoomInitBuildingView(0, {
				partId = 3
			})
			ViewMgr.instance:closeAllPopupViews({
				ViewName.RoomInitBuildingView,
				ViewName.RoomFormulaView,
				ViewName.RoomInventorySelectView
			})
		else
			RoomMapController.instance:openFormulaItemBuildingViewOutSide()
		end
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToTeachNoteView(arg_19_0, arg_19_1)
	table.insert(arg_19_0.waitOpenViewNames, ViewName.TeachNoteView)

	local var_19_0 = TeachNoteModel.instance:getJumpEpisodeId()

	TeachNoteController.instance:enterTeachNoteView(var_19_0, true)
	table.insert(arg_19_0.remainViewNames, ViewName.TeachNoteView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToEquipView(arg_20_0, arg_20_1)
	local var_20_0 = string.splitToNumber(arg_20_1, "#")

	table.insert(arg_20_0.waitOpenViewNames, ViewName.EquipView)

	local var_20_1 = var_20_0[2]

	if var_20_1 then
		local var_20_2 = {
			equipId = var_20_1
		}

		EquipController.instance:openEquipView(var_20_2)
		table.insert(arg_20_0.remainViewNames, ViewName.EquipView)
		table.insert(arg_20_0.remainViewNames, ViewName.GiftMultipleChoiceView)
	else
		logError("equip id cant be null ...")

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToHandbookView(arg_21_0, arg_21_1)
	local var_21_0 = string.splitToNumber(arg_21_1, "#")

	table.insert(arg_21_0.waitOpenViewNames, ViewName.HandbookView)
	table.insert(arg_21_0.closeViewNames, ViewName.HandBookCharacterSwitchView)
	table.insert(arg_21_0.closeViewNames, ViewName.HandbookEquipView)
	table.insert(arg_21_0.closeViewNames, ViewName.HandbookStoryView)
	table.insert(arg_21_0.closeViewNames, ViewName.HandbookCGDetailView)
	table.insert(arg_21_0.closeViewNames, ViewName.CharacterDataView)

	local var_21_1 = HandbookController.instance:jumpView(var_21_0)

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		table.insert(arg_21_0.remainViewNames, iter_21_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSocialView(arg_22_0, arg_22_1)
	local var_22_0 = string.splitToNumber(arg_22_1, "#")

	table.insert(arg_22_0.waitOpenViewNames, ViewName.SocialView)

	local var_22_1

	if var_22_0[2] then
		var_22_1 = {
			defaultTabIds = {
				[2] = var_22_0[2]
			}
		}
	end

	SocialController.instance:openSocialView(var_22_1)
	table.insert(arg_22_0.remainViewNames, ViewName.SocialView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToNoticeView(arg_23_0, arg_23_1)
	table.insert(arg_23_0.waitOpenViewNames, ViewName.NoticeView)
	NoticeController.instance:openNoticeView()
	table.insert(arg_23_0.remainViewNames, ViewName.NoticeView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSignInView(arg_24_0, arg_24_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_24_0.waitOpenViewNames, ViewName.SignInView)

	local var_24_0 = {}

	var_24_0.isBirthday = false

	SignInController.instance:openSignInDetailView(var_24_0)
	table.insert(arg_24_0.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSignInViewWithBirthDay(arg_25_0, arg_25_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_25_0.waitOpenViewNames, ViewName.SignInView)

	local var_25_0 = {}

	var_25_0.isBirthday = true

	SignInController.instance:openSignInDetailView(var_25_0)
	table.insert(arg_25_0.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSeasonMainView(arg_26_0, arg_26_1)
	local var_26_0 = Activity104Model.instance:getCurSeasonId()
	local var_26_1, var_26_2, var_26_3 = ActivityHelper.getActivityStatusAndToast(var_26_0)

	if var_26_1 ~= ActivityEnum.ActivityStatus.Normal then
		if var_26_2 then
			GameFacade.showToastWithTableParam(var_26_2, var_26_3)
		end

		return JumpEnum.JumpResult.Fail
	end

	local var_26_4 = string.splitToNumber(arg_26_1, "#")
	local var_26_5 = var_26_4 and var_26_4[2]

	if var_26_5 == Activity104Enum.JumpId.Discount and not Activity104Model.instance:isSpecialOpen() then
		GameFacade.showToast(ToastEnum.SeasonDiscountOpen)

		return JumpEnum.JumpResult.Fail
	end

	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(function()
		Activity104Controller.instance:openSeasonMainView({
			jumpId = var_26_5
		})
	end, nil, var_26_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToShow(arg_28_0, arg_28_1)
	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToBpView(arg_29_0, arg_29_1)
	table.insert(arg_29_0.waitOpenViewNames, ViewName.BpView)

	local var_29_0 = string.splitToNumber(arg_29_1, "#")
	local var_29_1 = tonumber(var_29_0[2]) == 1
	local var_29_2 = tonumber(var_29_0[3]) == 1

	BpController.instance:openBattlePassView(var_29_1, nil, var_29_2)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToActivityView(arg_30_0, arg_30_1)
	local var_30_0 = string.splitToNumber(arg_30_1, "#")
	local var_30_1 = var_30_0[2]
	local var_30_2 = ActivityHelper.getActivityVersion(var_30_1)
	local var_30_3 = _G[string.format("VersionActivity%sJumpHandleFunc", var_30_2)]

	if var_30_3 and var_30_3["jumpTo" .. var_30_1] then
		return var_30_3["jumpTo" .. var_30_1](arg_30_0, var_30_0)
	end

	local var_30_4 = var_0_0.JumpActViewToHandleFunc[var_30_1]

	if var_30_4 then
		return var_30_4(arg_30_0, var_30_1, var_30_0)
	end

	if var_30_1 == JumpEnum.ActIdEnum.Activity104 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_30_0.waitOpenViewNames, ViewName.SeasonMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity104Controller.instance:openSeasonMainView()
		end)
	elseif var_30_1 == JumpEnum.ActIdEnum.Act105 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:openVersionActivityEnterView()
	elseif var_30_1 == JumpEnum.ActIdEnum.Act106 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityController.instance:openActivityBeginnerView(arg_30_1)
	elseif var_30_1 == JumpEnum.ActIdEnum.Act107 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityStoreView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivityController.instance:openLeiMiTeBeiStoreView()
		end)
	elseif var_30_1 == JumpEnum.ActIdEnum.Act108 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_30_0.waitOpenViewNames, ViewName.MeilanniMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			MeilanniController.instance:openMeilanniMainView({
				checkStory = true
			})
		end)
	elseif var_30_1 == JumpEnum.ActIdEnum.Act109 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_30_0.waitOpenViewNames, ViewName.Activity109ChessEntry)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
		end)
	elseif var_30_1 == JumpEnum.ActIdEnum.Act111 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityPushBoxLevelView)
		PushBoxController.instance:enterPushBoxGame()
	elseif var_30_1 == JumpEnum.ActIdEnum.Act112 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityExchangeView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			ViewMgr.instance:openView(ViewName.VersionActivityExchangeView)
		end)
	elseif var_30_1 == JumpEnum.ActIdEnum.Act113 then
		table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			if #var_30_0 >= 3 then
				local var_36_0 = var_30_0[3]

				if var_36_0 == JumpEnum.LeiMiTeBeiSubJumpId.DungeonStoryMode then
					table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
					VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
				elseif var_36_0 == JumpEnum.LeiMiTeBeiSubJumpId.DungeonHardMode then
					table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)

					if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act113) then
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
					else
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)
					end
				elseif var_36_0 == JumpEnum.LeiMiTeBeiSubJumpId.LeiMiTeBeiStore then
					table.insert(arg_30_0.waitOpenViewNames, ViewName.ReactivityStoreView)
					ReactivityController.instance:openReactivityStoreView(var_30_1)
				else
					logWarn("not support subJumpId : " .. arg_30_1)
				end
			else
				table.insert(arg_30_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
				VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
			end
		end, nil, var_30_1)
	elseif var_30_1 == ActivityEnum.Activity.Work_SignView_1_8 or var_30_1 == ActivityEnum.Activity.V2a0_SummerSign or var_30_1 == ActivityEnum.Activity.V2a1_MoonFestival or var_30_1 == ActivityEnum.Activity.V2a2_RedLeafFestival_PanelView or var_30_1 == VersionActivity2_2Enum.ActivityId.LimitDecorate or var_30_1 == ActivityEnum.Activity.V2a2_TurnBack_H5 or var_30_1 == ActivityEnum.Activity.V2a2_SummonCustomPickNew or var_30_1 == ActivityEnum.Activity.V2a3_NewCultivationGift or var_30_1 == ActivityEnum.Activity.V2a7_Labor_Sign then
		if ActivityHelper.getActivityStatus(var_30_1, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(arg_30_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityModel.instance:setTargetActivityCategoryId(var_30_1)
		ActivityController.instance:openActivityBeginnerView()
	elseif var_30_1 == ActivityEnum.Activity.VersionActivity1_3Radio or var_30_1 == ActivityEnum.Activity.Activity1_9WarmUp or var_30_1 == ActivityEnum.Activity.V2a0_WarmUp or var_30_1 == ActivityEnum.Activity.V2a1_WarmUp or var_30_1 == ActivityEnum.Activity.V2a2_WarmUp or var_30_1 == ActivityEnum.Activity.V2a3_WarmUp or var_30_1 == ActivityEnum.Activity.V2a4_WarmUp or var_30_1 == ActivityEnum.Activity.V2a5_WarmUp or var_30_1 == ActivityEnum.Activity.V2a6_WarmUp or var_30_1 == ActivityEnum.Activity.V2a7_WarmUp then
		if ActivityHelper.getActivityStatus(var_30_1, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(arg_30_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		Activity125Model.instance:setSelectEpisodeId(var_30_1, 1)
		ActivityModel.instance:setTargetActivityCategoryId(var_30_1)
		ActivityController.instance:openActivityBeginnerView()
	else
		logWarn("not support actId : " .. arg_30_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToLeiMiTeBeiDungeonView(arg_37_0, arg_37_1)
	local var_37_0 = string.splitToNumber(arg_37_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_37_0) then
		logError("not found episode : " .. arg_37_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_37_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_37_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapLevelView)

	if ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113) then
		VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_37_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
				isJump = true,
				episodeId = var_37_0
			})
		end)
	else
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_37_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					isJump = true,
					episodeId = var_37_0
				})
			end)
		end)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToPushBox(arg_41_0, arg_41_1)
	return
end

function var_0_0.jumpToAct117(arg_42_0, arg_42_1, arg_42_2)
	table.insert(arg_42_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(arg_42_0.waitOpenViewNames, ViewName.ActivityTradeBargain)
	VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(Activity117Controller.openView, Activity117Controller.instance, arg_42_1)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct114(arg_43_0, arg_43_1, arg_43_2)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		local var_43_0 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId)

		Activity114Controller.instance:enterActivityFight(var_43_0.config.battleId)
	else
		table.insert(arg_43_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(arg_43_0.waitOpenViewNames, ViewName.Activity114View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function()
			local var_44_0

			if Activity114Model.instance.serverData.isEnterSchool then
				var_44_0 = {
					defaultTabIds = {
						[2] = Activity114Enum.TabIndex.MainView
					}
				}
			end

			ViewMgr.instance:openView(ViewName.Activity114View, var_44_0)
		end)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct119(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 == VersionActivity1_3Enum.ActivityId.Act307 then
		table.insert(arg_45_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
		table.insert(arg_45_0.waitOpenViewNames, ViewName.Activity1_3_119View)
		VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity1_3_119Controller.instance:openView()
		end)

		return JumpEnum.JumpResult.Success
	else
		table.insert(arg_45_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(arg_45_0.waitOpenViewNames, ViewName.Activity119View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function()
			Activity119Controller.instance:openAct119View()
		end)

		return JumpEnum.JumpResult.Success
	end
end

function var_0_0.jumpToAct1_2Shop(arg_48_0)
	table.insert(arg_48_0.waitOpenViewNames, ViewName.VersionActivity1_2StoreView)
	ViewMgr.instance:openView(ViewName.VersionActivity1_2StoreView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.ensureActStoryDone(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		if not VersionActivityBaseController.instance:isPlayedActivityVideo(iter_49_1) then
			local var_49_1 = ActivityConfig.instance:getActivityCo(iter_49_1).storyId

			if var_49_1 > 0 then
				table.insert(var_49_0, var_49_1)
			end
		end
	end

	if #var_49_0 > 0 then
		StoryController.instance:playStories(var_49_0, nil, arg_49_2, arg_49_3)
	else
		arg_49_2(arg_49_3)
	end
end

function var_0_0.jumpToAct1_2Dungeon(arg_50_0, arg_50_1, arg_50_2)
	table.insert(arg_50_0.waitOpenViewNames, ViewName.VersionActivity1_7EnterView)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_50_0.waitOpenViewNames, ViewName.VersionActivity1_2DungeonView)

		if #arg_50_2 >= 3 then
			local var_51_0 = arg_50_2[3]

			if var_51_0 == JumpEnum.Activity1_2DungeonJump.Shop then
				table.insert(arg_50_0.waitOpenViewNames, ViewName.ReactivityStoreView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, nil, var_51_0)
			elseif var_51_0 == JumpEnum.Activity1_2DungeonJump.Normal then
				VersionActivity1_2DungeonController.instance:openDungeonView()
			elseif var_51_0 == JumpEnum.Activity1_2DungeonJump.Hard then
				VersionActivity1_2DungeonController.instance:openDungeonView(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)
			elseif var_51_0 == JumpEnum.Activity1_2DungeonJump.Task then
				table.insert(arg_50_0.waitOpenViewNames, ViewName.ReactivityTaskView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, nil, var_51_0)
			elseif var_51_0 == JumpEnum.Activity1_2DungeonJump.Jump2Dungeon then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, arg_50_2[4], true)
			elseif var_51_0 == JumpEnum.Activity1_2DungeonJump.Jump2Camp then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, true)
			end
		else
			VersionActivity1_2DungeonController.instance:openDungeonView()
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToEnterView1_2(arg_52_0, arg_52_1, arg_52_2)
	table.insert(arg_52_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	VersionActivity1_2EnterController.instance:openVersionActivity1_2EnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToYaXianView(arg_53_0, arg_53_1, arg_53_2)
	table.insert(arg_53_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(arg_53_0.waitOpenViewNames, ViewName.YaXianMapView)
	arg_53_0:ensureActStoryDone({
		JumpEnum.ActIdEnum.EnterView1_2,
		arg_53_1
	}, function()
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()
		YaXianController.instance:openYaXianMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToEnterView1_3(arg_55_0, arg_55_1, arg_55_2)
	table.insert(arg_55_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Shop(arg_56_0, arg_56_1, arg_56_2)
	table.insert(arg_56_0.waitOpenViewNames, ViewName.ReactivityStoreView)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Dungeon(arg_57_0, arg_57_1, arg_57_2)
	table.insert(arg_57_0.closeViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #arg_57_2 >= 3 then
			local var_58_0 = arg_57_2[3]

			if var_58_0 == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(arg_57_0.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
			elseif var_58_0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(arg_57_0.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_3Dungeon) then
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard)
				end
			elseif var_58_0 == JumpEnum.Activity1_3DungeonJump.Daily then
				table.insert(arg_57_0.closeViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(arg_57_0.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, VersionActivity1_3DungeonEnum.DailyEpisodeId, nil, nil, {
					showDaily = true
				})
			elseif var_58_0 == JumpEnum.Activity1_3DungeonJump.Astrology then
				table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(arg_57_0.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function()
						VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
					end)
				end
			elseif var_58_0 == JumpEnum.Activity1_3DungeonJump.Buff then
				table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3BuffController.instance:openBuffView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function()
						VersionActivity1_3BuffController.instance:openBuffView()
					end)
				end
			else
				logWarn("not support subJumpId:" .. tostring(var_58_0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(arg_57_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
		end
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3DungeonView(arg_61_0, arg_61_1)
	local var_61_0 = string.splitToNumber(arg_61_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_61_0) then
		logError("not found episode : " .. arg_61_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_61_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_61_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_61_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
				isJump = true,
				episodeId = var_61_0
			})
		end)
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act304(arg_64_0, arg_64_1, arg_64_2)
	table.insert(arg_64_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if arg_64_2 and #arg_64_2 >= 3 then
		Activity122Model.instance:setCurEpisodeId(#arg_64_2[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_64_0.waitOpenViewNames, ViewName.Activity1_3ChessMapView)
		Activity1_3ChessController.instance:openMapView()
	end)
	ViewMgr.instance:closeAllPopupViews({
		ViewName.VersionActivity1_3EnterView,
		ViewName.Activity1_3ChessMapView
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act305(arg_66_0, arg_66_1, arg_66_2)
	table.insert(arg_66_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_66_0.waitOpenViewNames, ViewName.ArmMainView)
		ArmPuzzlePipeController.instance:openMainView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act306(arg_68_0, arg_68_1, arg_68_2)
	table.insert(arg_68_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if arg_68_2 and #arg_68_2 >= 3 then
		Activity120Model.instance:getCurEpisodeId(#arg_68_2[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_68_0.waitOpenViewNames, ViewName.JiaLaBoNaMapView)
		JiaLaBoNaController.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act125(arg_70_0, arg_70_1, arg_70_2)
	if not ActivityModel.instance:isActOnLine(arg_70_1) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_70_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
	table.insert(arg_70_0.closeViewNames, ViewName.MainThumbnailView)
	ActivityModel.instance:setTargetActivityCategoryId(arg_70_1)
	ActivityController.instance:openActivityBeginnerView(arg_70_2)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToTurnback(arg_71_0, arg_71_1)
	if not TurnbackModel.instance:isNewType() then
		if not TurnbackModel.instance:canShowTurnbackPop() then
			return JumpEnum.JumpResult.Fail
		end

		local var_71_0 = string.splitToNumber(arg_71_1, "#")
		local var_71_1 = {
			turnbackId = tonumber(var_71_0[2]),
			subModuleId = tonumber(var_71_0[3])
		}

		table.insert(arg_71_0.waitOpenViewNames, ViewName.TurnbackBeginnerView)
		TurnbackModel.instance:setCurTurnbackId(var_71_1.turnbackId)
		TurnbackModel.instance:setTargetCategoryId(var_71_1.subModuleId)
		TurnbackController.instance:openTurnbackBeginnerView(var_71_1)

		return JumpEnum.JumpResult.Success
	elseif ViewMgr.instance:isOpen(ViewName.TurnbackNewBeginnerView) then
		local var_71_2 = string.splitToNumber(arg_71_1, "#")
		local var_71_3 = {
			subModuleId = tonumber(var_71_2[3])
		}

		TurnbackModel.instance:setTargetCategoryId(var_71_3.subModuleId)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)

		return JumpEnum.JumpResult.Success
	end
end

function var_0_0.jumpToEnterView1_4(arg_72_0, arg_72_1, arg_72_2)
	table.insert(arg_72_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4DungeonStore(arg_73_0, arg_73_1, arg_73_2)
	table.insert(arg_73_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_73_0.waitOpenViewNames, ViewName.Activity129View)
		ViewMgr.instance:openView(ViewName.Activity129View, {
			actId = arg_73_1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Dungeon(arg_75_0, arg_75_1, arg_75_2)
	table.insert(arg_75_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_75_0.waitOpenViewNames, ViewName.VersionActivity1_4DungeonView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
			actId = arg_75_1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Task(arg_77_0, arg_77_1, arg_77_2)
	table.insert(arg_77_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_77_0.waitOpenViewNames, ViewName.VersionActivity1_4TaskView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4TaskView, {
			activityId = arg_77_1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role37(arg_79_0, arg_79_1, arg_79_2)
	table.insert(arg_79_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_79_0.waitOpenViewNames, ViewName.Activity130LevelView)
		Activity130Controller.instance:enterActivity130()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role6(arg_81_0, arg_81_1, arg_81_2)
	table.insert(arg_81_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_81_0.waitOpenViewNames, ViewName.Activity131LevelView)
		Activity131Controller.instance:enterActivity131()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role37Game(arg_83_0, arg_83_1)
	local var_83_0 = string.splitToNumber(arg_83_1, "#")
	local var_83_1 = {
		episodeId = tonumber(var_83_0[2])
	}

	if ViewMgr.instance:isOpen(ViewName.Activity130LevelView) then
		if Activity130Model.instance:isEpisodeUnlock(var_83_1.episodeId) then
			Activity130Controller.instance:dispatchEvent(Activity130Event.EnterEpisode, var_83_1.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity130Controller.instance:openActivity130GameView(var_83_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role6Game(arg_84_0, arg_84_1)
	local var_84_0 = string.splitToNumber(arg_84_1, "#")
	local var_84_1 = {
		episodeId = tonumber(var_84_0[2])
	}

	if ViewMgr.instance:isOpen(ViewName.Activity131LevelView) then
		if Activity131Model.instance:isEpisodeUnlock(var_84_1.episodeId) then
			Activity131Controller.instance:dispatchEvent(Activity131Event.EnterEpisode, var_84_1.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity131Controller.instance:openActivity131GameView(var_84_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAchievement(arg_85_0, arg_85_1)
	local var_85_0 = string.split(arg_85_1, "#")

	if #var_85_0 > 1 then
		AchievementJumpController.instance:jumpToAchievement(var_85_0)

		return JumpEnum.JumpResult.Success
	end

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToBossRush(arg_86_0, arg_86_1)
	local var_86_0 = string.splitToNumber(arg_86_1, "#")
	local var_86_1 = var_86_0[2]
	local var_86_2 = var_86_0[3]
	local var_86_3

	if var_86_1 then
		var_86_3 = {
			isOpenLevelDetail = true,
			stage = var_86_1,
			layer = var_86_2
		}
	end

	BossRushController.instance:openMainView(var_86_3)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5EnterView(arg_87_0, arg_87_1, arg_87_2)
	table.insert(arg_87_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5Dungeon(arg_88_0, arg_88_1, arg_88_2)
	table.insert(arg_88_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(arg_88_0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #arg_88_2 >= 3 then
			local var_89_0 = arg_88_2[3]

			if var_89_0 == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(arg_88_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
				VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
			elseif var_89_0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(arg_88_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_5Dungeon) then
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(var_89_0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(arg_88_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
			VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5DungeonStore(arg_90_0, arg_90_1, arg_90_2)
	table.insert(arg_90_0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_90_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(JumpEnum.ActIdEnum.Act1_5Dungeon)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5PeaceUluGame(arg_92_0, arg_92_1)
	table.insert(arg_92_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_92_0.waitOpenViewNames, ViewName.PeaceUluView)
		PeaceUluController.instance:openPeaceUluView(arg_92_1)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5SportNews(arg_94_0, arg_94_1)
	table.insert(arg_94_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_94_0.waitOpenViewNames, ViewName.SportsNewsView)
		SportsNewsController.instance:openSportsNewsMainView(arg_94_1)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5DungeonView(arg_96_0, arg_96_1)
	local var_96_0 = string.splitToNumber(arg_96_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_96_0) then
		logError("not found episode : " .. arg_96_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_96_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_96_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(nil, var_96_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapLevelView, {
				isJump = true,
				episodeId = var_96_0
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToActivity142(arg_99_0, arg_99_1)
	table.insert(arg_99_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_99_0.waitOpenViewNames, ViewName.Activity142MapView)
		Activity142Controller.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5AiZiLa(arg_101_0, arg_101_1)
	table.insert(arg_101_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	table.insert(arg_101_0.waitOpenViewNames, ViewName.AiZiLaMapView)
	AiZiLaController.instance:openMapView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6EnterView(arg_102_0, arg_102_1, arg_102_2)
	table.insert(arg_102_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)

	local var_102_0

	if #arg_102_2 >= 3 then
		var_102_0 = arg_102_2[3]
	end

	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_102_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6Dungeon(arg_103_0, arg_103_1, arg_103_2)
	table.insert(arg_103_0.closeViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	table.insert(arg_103_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #arg_103_2 >= 3 then
			local var_104_0 = arg_103_2[3]

			if var_104_0 == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(arg_103_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
				VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
			elseif var_104_0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(arg_103_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_6Dungeon) then
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(var_104_0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(arg_103_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6DungeonView(arg_105_0, arg_105_1)
	local var_105_0 = string.splitToNumber(arg_105_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_105_0) then
		logError("not found episode : " .. arg_105_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_105_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_105_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, var_105_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
				isJump = true,
				episodeId = var_105_0
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6DungeonStore(arg_108_0, arg_108_1, arg_108_2)
	table.insert(arg_108_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_108_0.waitOpenViewNames, ViewName.VersionActivity1_6StoreView)
		VersionActivity1_6EnterController.instance:openStoreView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6DungeonBoss(arg_110_0, arg_110_1, arg_110_2)
	table.insert(arg_110_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
		VersionActivity1_6DungeonController.instance:openDungeonBossView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6Rogue(arg_112_0, arg_112_1, arg_112_2)
	table.insert(arg_112_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, arg_112_1, false)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6QuNiang(arg_113_0, arg_113_1, arg_113_2)
	table.insert(arg_113_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_113_0.waitOpenViewNames, ViewName.ActQuNiangLevelView)
		ActQuNiangController.instance:enterActivity()
	end, nil, arg_113_1, false)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6GeTian(arg_115_0, arg_115_1, arg_115_2)
	table.insert(arg_115_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_115_0.waitOpenViewNames, ViewName.ActGeTianLevelView)
		ActGeTianController.instance:enterActivity()
	end, nil, arg_115_1, false)

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToAct1_9WarmUp(arg_117_0, arg_117_1, arg_117_2)
	table.insert(arg_117_0.waitOpenViewNames, ViewName.ActivityBeginnerView)

	local var_117_0 = arg_117_1

	ActivityModel.instance:setTargetActivityCategoryId(var_117_0)
	Activity125Model.instance:setSelectEpisodeId(var_117_0, 1)
	ActivityController.instance:openActivityBeginnerView(arg_117_1)
end

function var_0_0.jumpToVersionEnterView(arg_118_0, arg_118_1)
	local var_118_0 = string.splitToNumber(arg_118_1, "#")[2]

	if not var_118_0 then
		return JumpEnum.JumpResult.Fail
	end

	local var_118_1 = ActivityHelper.getActivityVersion(var_118_0)

	if not var_118_1 then
		return JumpEnum.JumpResult.Fail
	end

	local var_118_2 = string.format("VersionActivity%sEnterController", var_118_1)
	local var_118_3 = _G[var_118_2] or VersionActivityFixedEnterController

	if var_118_3 then
		var_118_3.instance:openVersionActivityEnterView(nil, nil, var_118_0)

		return JumpEnum.JumpResult.Success
	end

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToRougeMainView(arg_119_0, arg_119_1)
	RougeController.instance:openRougeMainView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRougeRewardView(arg_120_0, arg_120_1)
	table.insert(arg_120_0.waitOpenViewNames, ViewName.RougeMainView)
	table.insert(arg_120_0.waitOpenViewNames, ViewName.RougeRewardView)

	local var_120_0 = string.splitToNumber(arg_120_1, "#")
	local var_120_1 = var_120_0[2]
	local var_120_2 = var_120_0[3]

	RougeController.instance:openRougeMainView(nil, nil, function()
		ViewMgr.instance:openView(ViewName.RougeRewardView, {
			version = var_120_1,
			stage = var_120_2
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSeason123(arg_122_0, arg_122_1)
	local var_122_0 = Season123Model.instance:getCurSeasonId()
	local var_122_1 = string.splitToNumber(arg_122_1, "#")
	local var_122_2 = string.format("VersionActivity%sEnterController", Activity123Enum.SeasonVersionPrefix[var_122_0])

	if #var_122_1 > 1 and var_122_1[2] == Activity123Enum.JumpType.Stage and #var_122_1 > 2 then
		local var_122_3 = var_122_1[3]

		_G[var_122_2].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntryByJump, {
			actId = var_122_0,
			jumpId = Activity123Enum.JumpId.ForStage,
			jumpParam = {
				stage = var_122_3
			}
		}, var_122_0)

		return JumpEnum.JumpResult.Success
	end

	_G[var_122_2].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntry, Season123Controller.instance, var_122_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToPermanentMainView(arg_123_0, arg_123_1)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
	table.insert(arg_123_0.waitOpenViewNames, ViewName.DungeonView)
	DungeonController.instance:openDungeonView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToInvestigateView(arg_124_0, arg_124_1)
	table.insert(arg_124_0.waitOpenViewNames, ViewName.InvestigateView)
	table.insert(arg_124_0.closeViewNames, ViewName.InvestigateTaskView)
	InvestigateController.instance:openInvestigateView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToInvestigateOpinionTabView(arg_125_0, arg_125_1)
	local var_125_0 = string.splitToNumber(arg_125_1, "#")[2]
	local var_125_1 = lua_investigate_info.configDict[var_125_0]

	if not (var_125_1.episode == 0 or DungeonModel.instance:hasPassLevel(var_125_1.episode)) then
		GameFacade.showToast(ToastEnum.InvestigateTip1)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_125_0.waitOpenViewNames, ViewName.InvestigateOpinionTabView)
	InvestigateController.instance:jumpToInvestigateOpinionTabView(var_125_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDiceHeroLevelView(arg_126_0, arg_126_1)
	local var_126_0 = string.splitToNumber(arg_126_1, "#")[2]

	if not DiceHeroModel.instance.unlockChapterIds[var_126_0] then
		GameFacade.showToast(ToastEnum.DiceHeroLockChapter)

		return JumpEnum.JumpResult.Fail
	end

	local var_126_1 = DiceHeroConfig.instance:getLevelCo(var_126_0, 1)

	if not var_126_1 then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_126_0.waitOpenViewNames, ViewName.DiceHeroLevelView)
	ViewMgr.instance:openView(ViewName.DiceHeroLevelView, {
		chapterId = var_126_0,
		isInfinite = var_126_1.mode == 2
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToTowerView(arg_127_0, arg_127_1)
	local var_127_0 = string.splitToNumber(arg_127_1, "#")
	local var_127_1 = var_127_0[2]
	local var_127_2 = var_127_0[3]
	local var_127_3 = {
		towerType = var_127_1,
		towerId = var_127_2
	}

	TowerController.instance:jumpView(var_127_3)

	return JumpEnum.JumpResult.Success
end

var_0_0.JumpViewToHandleFunc = {
	[JumpEnum.JumpView.StoreView] = var_0_0.jumpToStoreView,
	[JumpEnum.JumpView.SummonView] = var_0_0.jumpToSummonView,
	[JumpEnum.JumpView.SummonViewGroup] = var_0_0.jumpToSummonViewGroup,
	[JumpEnum.JumpView.DungeonViewWithChapter] = var_0_0.jumpToDungeonViewWithChapter,
	[JumpEnum.JumpView.DungeonViewWithEpisode] = var_0_0.jumpToDungeonViewWithEpisode,
	[JumpEnum.JumpView.DungeonViewWithType] = var_0_0.jumpToDungeonViewWithType,
	[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = var_0_0.jumpToCharacterBackpackViewWithCharacter,
	[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = var_0_0.jumpToCharacterBackpackViewWithEquip,
	[JumpEnum.JumpView.HeroGroupView] = var_0_0.jumpToHeroGroupView,
	[JumpEnum.JumpView.BackpackView] = var_0_0.jumpToBackpackView,
	[JumpEnum.JumpView.PlayerClothView] = var_0_0.jumpToPlayerClothView,
	[JumpEnum.JumpView.MainView] = var_0_0.jumpToMainView,
	[JumpEnum.JumpView.TaskView] = var_0_0.jumpToTaskView,
	[JumpEnum.JumpView.RoomView] = var_0_0.jumpToRoomView,
	[JumpEnum.JumpView.RoomProductLineView] = var_0_0.jumpToRoomProductLineView,
	[JumpEnum.JumpView.TeachNoteView] = var_0_0.jumpToTeachNoteView,
	[JumpEnum.JumpView.EquipView] = var_0_0.jumpToEquipView,
	[JumpEnum.JumpView.HandbookView] = var_0_0.jumpToHandbookView,
	[JumpEnum.JumpView.SocialView] = var_0_0.jumpToSocialView,
	[JumpEnum.JumpView.NoticeView] = var_0_0.jumpToNoticeView,
	[JumpEnum.JumpView.SignInView] = var_0_0.jumpToSignInView,
	[JumpEnum.JumpView.SignInViewWithBirthDay] = var_0_0.jumpToSignInViewWithBirthDay,
	[JumpEnum.JumpView.SeasonMainView] = var_0_0.jumpToSeasonMainView,
	[JumpEnum.JumpView.Show] = var_0_0.jumpToShow,
	[JumpEnum.JumpView.BpView] = var_0_0.jumpToBpView,
	[JumpEnum.JumpView.ActivityView] = var_0_0.jumpToActivityView,
	[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = var_0_0.jumpToLeiMiTeBeiDungeonView,
	[JumpEnum.JumpView.Act1_3DungeonView] = var_0_0.jumpToAct1_3DungeonView,
	[JumpEnum.JumpView.PushBox] = var_0_0.jumpToPushBox,
	[JumpEnum.JumpView.Turnback] = var_0_0.jumpToTurnback,
	[JumpEnum.JumpView.Role37Game] = var_0_0.jumpToAct1_4Role37Game,
	[JumpEnum.JumpView.Role6Game] = var_0_0.jumpToAct1_4Role6Game,
	[JumpEnum.JumpView.Achievement] = var_0_0.jumpToAchievement,
	[JumpEnum.JumpView.RoleStoryActivity] = var_0_0.jumpToRoleStoryActivity,
	[JumpEnum.JumpView.BossRush] = var_0_0.jumpToBossRush,
	[JumpEnum.JumpView.Tower] = var_0_0.jumpToTowerView,
	[JumpEnum.JumpView.Challenge] = Act183JumpHelper.jumpToAct183,
	[JumpEnum.JumpView.V1a5Dungeon] = var_0_0.jumpToAct1_5DungeonView,
	[JumpEnum.JumpView.V1a6Dungeon] = var_0_0.jumpToAct1_6DungeonView,
	[JumpEnum.JumpView.Season123] = var_0_0.jumpToSeason123,
	[JumpEnum.JumpView.VersionEnterView] = var_0_0.jumpToVersionEnterView,
	[JumpEnum.JumpView.RougeMainView] = var_0_0.jumpToRougeMainView,
	[JumpEnum.JumpView.RougeRewardView] = var_0_0.jumpToRougeRewardView,
	[JumpEnum.JumpView.PermanentMainView] = var_0_0.jumpToPermanentMainView,
	[JumpEnum.JumpView.InvestigateView] = var_0_0.jumpToInvestigateView,
	[JumpEnum.JumpView.InvestigateOpinionTabView] = var_0_0.jumpToInvestigateOpinionTabView,
	[JumpEnum.JumpView.DiceHero] = var_0_0.jumpToDiceHeroLevelView
}
var_0_0.JumpActViewToHandleFunc = {
	[JumpEnum.ActIdEnum.Act117] = var_0_0.jumpToAct117,
	[JumpEnum.ActIdEnum.Act114] = var_0_0.jumpToAct114,
	[JumpEnum.ActIdEnum.Act119] = var_0_0.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_2Dungeon] = var_0_0.jumpToAct1_2Dungeon,
	[JumpEnum.ActIdEnum.Act1_2Shop] = var_0_0.jumpToAct1_2Shop,
	[JumpEnum.ActIdEnum.EnterView1_2] = var_0_0.jumpToEnterView1_2,
	[JumpEnum.ActIdEnum.YaXian] = var_0_0.jumpToYaXianView,
	[JumpEnum.ActIdEnum.EnterView1_3] = var_0_0.jumpToEnterView1_3,
	[JumpEnum.ActIdEnum.Act1_3Dungeon] = var_0_0.jumpToAct1_3Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Shop] = var_0_0.jumpToAct1_3Shop,
	[JumpEnum.ActIdEnum.Act1_3Act304] = var_0_0.jumpToAct1_3Act304,
	[JumpEnum.ActIdEnum.Act1_3Act305] = var_0_0.jumpToAct1_3Act305,
	[JumpEnum.ActIdEnum.Act1_3Act306] = var_0_0.jumpToAct1_3Act306,
	[JumpEnum.ActIdEnum.Act1_3Act307] = var_0_0.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_3Act125] = var_0_0.jumpToAct1_3Act125,
	[JumpEnum.ActIdEnum.EnterView1_4] = var_0_0.jumpToEnterView1_4,
	[JumpEnum.ActIdEnum.Act1_4DungeonStore] = var_0_0.jumpToAct1_4DungeonStore,
	[JumpEnum.ActIdEnum.Act1_4Dungeon] = var_0_0.jumpToAct1_4Dungeon,
	[JumpEnum.ActIdEnum.Act1_4Task] = var_0_0.jumpToAct1_4Task,
	[JumpEnum.ActIdEnum.Role37] = var_0_0.jumpToAct1_4Role37,
	[JumpEnum.ActIdEnum.Role6] = var_0_0.jumpToAct1_4Role6,
	[JumpEnum.ActIdEnum.EnterView1_5] = var_0_0.jumpToAct1_5EnterView,
	[JumpEnum.ActIdEnum.Act1_5Dungeon] = var_0_0.jumpToAct1_5Dungeon,
	[JumpEnum.ActIdEnum.Act1_5Shop] = var_0_0.jumpToAct1_5DungeonStore,
	[JumpEnum.ActIdEnum.Act1_5PeaceUlu] = var_0_0.jumpToAct1_5PeaceUluGame,
	[JumpEnum.ActIdEnum.Act1_5SportNews] = var_0_0.jumpToAct1_5SportNews,
	[JumpEnum.ActIdEnum.Activity142] = var_0_0.jumpToActivity142,
	[JumpEnum.ActIdEnum.Act1_5AiZiLa] = var_0_0.jumpToAct1_5AiZiLa,
	[JumpEnum.ActIdEnum.Act1_6EnterView] = var_0_0.jumpToAct1_6EnterView,
	[JumpEnum.ActIdEnum.Act1_6Dungeon] = var_0_0.jumpToAct1_6Dungeon,
	[JumpEnum.ActIdEnum.Act1_6DungeonStore] = var_0_0.jumpToAct1_6DungeonStore,
	[JumpEnum.ActIdEnum.Act1_6DungeonBossRush] = var_0_0.jumpToAct1_6DungeonBoss,
	[JumpEnum.ActIdEnum.Act1_6Rougue] = var_0_0.jumpToAct1_6Rogue,
	[JumpEnum.ActIdEnum.Act1_6QuNiang] = var_0_0.jumpToAct1_6QuNiang,
	[JumpEnum.ActIdEnum.Act1_6GeTian] = var_0_0.jumpToAct1_6GeTian,
	[JumpEnum.ActIdEnum.Act1_9WarmUp] = var_0_0.jumpToAct1_9WarmUp
}

return var_0_0
