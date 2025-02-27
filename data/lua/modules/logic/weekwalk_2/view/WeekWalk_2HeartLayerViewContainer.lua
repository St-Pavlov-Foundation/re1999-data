module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerViewContainer", package.seeall)

slot0 = class("WeekWalk_2HeartLayerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, WeekWalk_2HeartLayerView.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	slot0.helpView = HelpShowView.New()

	slot0.helpView:setHelpId(HelpEnum.HelpId.WeekWalk_2HeartLayerOnce)
	table.insert(slot1, slot0.helpView)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.WeekWalk_2HeartLayer)

		return {
			slot0.navigateView
		}
	end
end

return slot0
