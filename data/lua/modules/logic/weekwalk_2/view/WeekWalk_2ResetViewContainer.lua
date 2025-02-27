module("modules.logic.weekwalk_2.view.WeekWalk_2ResetViewContainer", package.seeall)

slot0 = class("WeekWalk_2ResetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "top_left"))
	table.insert(slot1, WeekWalk_2ResetView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.WeekWalkReset)

	return {
		slot0._navigateButtonView
	}
end

return slot0
