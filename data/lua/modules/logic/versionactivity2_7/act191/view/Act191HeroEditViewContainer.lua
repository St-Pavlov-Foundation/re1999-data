module("modules.logic.versionactivity2_7.act191.view.Act191HeroEditViewContainer", package.seeall)

slot0 = class("Act191HeroEditViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/layout/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Act191HeroEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 440
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return {
		Act191HeroEditView.New(),
		LuaListScrollViewWithAnimator.New(Act191HeroEditListModel.instance, slot1, {
			[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
		}),
		slot0:getQuickEditScroll(),
		CommonRainEffectView.New("bg/go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.getQuickEditScroll(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/layout/#scroll_quickedit"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Act191HeroQuickEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 440
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return LuaListScrollViewWithAnimator.New(Act191HeroQuickEditListModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
	})
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0._navigateButtonView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

return slot0
