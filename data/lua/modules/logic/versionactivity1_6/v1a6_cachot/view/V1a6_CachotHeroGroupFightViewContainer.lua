module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupFightViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._heroGroupFightView = V1a6_CachotHeroGroupFightView.New()
	arg_1_0._heroGroupLayoutView = HeroGroupFightLayoutView.New()

	return {
		arg_1_0._heroGroupLayoutView,
		arg_1_0._heroGroupFightView,
		HeroGroupAnimView.New(),
		V1a6_CachotHeroGroupListView.New(),
		HeroGroupFightViewLevel.New(),
		HeroGroupFightViewRule.New(),
		HeroGroupInfoScrollView.New(),
		CheckActivityEndView.New(),
		V1a5HeroGroupBuildingView.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns")
	}
end

function var_0_0.getHeroGroupFightView(arg_2_0)
	return arg_2_0._heroGroupFightView
end

function var_0_0.beforeEnterFight(arg_3_0)
	return
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		local var_4_0 = arg_4_0:getHelpId()
		local var_4_1 = not arg_4_0:_checkHideHomeBtn()

		arg_4_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			var_4_1,
			var_4_0 ~= nil
		}, var_4_0, arg_4_0._closeCallback, nil, nil, arg_4_0)

		arg_4_0._navigateButtonsView:setCloseCheck(arg_4_0.defaultOverrideCloseCheck, arg_4_0)

		return {
			arg_4_0._navigateButtonsView
		}
	elseif arg_4_1 == 2 then
		local var_4_2 = CurrencyEnum.CurrencyType
		local var_4_3 = arg_4_0:_checkHidePowerCurrencyBtn() and {} or {
			var_4_2.Power
		}

		return {
			CurrencyView.New(var_4_3)
		}
	end
end

function var_0_0.getHelpId(arg_5_0)
	return HelpEnum.HelpId.Cachot1_6TotalHelp
end

function var_0_0._closeCallback(arg_6_0)
	arg_6_0:closeThis()

	if arg_6_0:handleVersionActivityCloseCall() then
		return
	end

	local var_6_0 = HeroGroupModel.instance.episodeId

	if DungeonConfig.instance:getEpisodeCO(var_6_0).type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreScene()
	else
		MainController.instance:enterMainScene(true, false)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(var_6_0, true)

			DungeonModel.instance.curSendEpisodeId = nil
		end
	end
end

function var_0_0.handleVersionActivityCloseCall(arg_7_0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function var_0_0._checkHideHomeBtn(arg_8_0)
	return true
end

var_0_0._hideHomeBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function var_0_0.checkShowHomeByEpisodeType(arg_9_0)
	local var_9_0 = HeroGroupModel.instance.episodeId
	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)

	return var_0_0._hideHomeBtnEpisodeType[var_9_1.type]
end

function var_0_0._checkHidePowerCurrencyBtn(arg_10_0)
	return (arg_10_0:checkHidePowerCurrencyBtnByEpisodeType())
end

var_0_0._hidePowerCurrencyBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function var_0_0.checkHidePowerCurrencyBtnByEpisodeType(arg_11_0)
	local var_11_0 = HeroGroupModel.instance.episodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)

	return var_0_0._hidePowerCurrencyBtnEpisodeType[var_11_1.type]
end

function var_0_0.setNavigateOverrideClose(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._navigateButtonsView:setOverrideClose(arg_12_1, arg_12_2)
end

function var_0_0.defaultOverrideCloseCheck(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = DungeonModel.instance.curSendChapterId

	if DungeonConfig.instance:getChapterCO(var_13_0).actId == VersionActivityEnum.ActivityId.Act109 then
		local function var_13_1()
			arg_13_1(arg_13_2)
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, var_13_1)

		return false
	end

	return true
end

function var_0_0.onContainerInit(arg_15_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_15_0.refreshHelpBtnIcon, arg_15_0)
end

function var_0_0.onContainerOpenFinish(arg_16_0)
	arg_16_0._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function var_0_0.onContainerDestroy(arg_17_0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_17_0.refreshHelpBtnIcon, arg_17_0)
end

function var_0_0.refreshHelpBtnIcon(arg_18_0)
	arg_18_0._navigateButtonsView:changerHelpId(arg_18_0:getHelpId())
end

return var_0_0
