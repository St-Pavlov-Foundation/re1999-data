module("modules.logic.seasonver.act166.view.Season166HeroGroupEditViewContainer", package.seeall)

slot0 = class("Season166HeroGroupEditViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season166HeroGroupEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 472
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 35

	for slot6 = 1, 15 do
	end

	return {
		Season166HeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(Season166HeroGroupEditModel.instance, slot1, {
			[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
		}),
		slot0:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.getQuickEditScroll(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[2]
	slot1.cellClass = Season166HeroGroupQuickEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 472
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 35

	for slot6 = 1, 15 do
	end

	return LuaListScrollViewWithAnimator.New(Season166HeroGroupQuickEditModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
	})
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	slot0._navigateButtonView:setOverrideClose(slot0._overrideClose, slot0)

	return {
		slot0._navigateButtonView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

function slot0._overrideClose(slot0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.Season166HeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.Season166HeroGroupEditView, nil, true)
	end
end

function slot0._setHomeBtnVisible(slot0, slot1)
	slot0._navigateButtonView:setParam({
		true,
		slot1,
		false
	})
end

function slot0.playCloseTransition(slot0)
	slot0:onPlayCloseTransitionFinish()
end

return slot0
