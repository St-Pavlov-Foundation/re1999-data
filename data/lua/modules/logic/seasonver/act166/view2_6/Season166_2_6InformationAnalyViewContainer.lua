module("modules.logic.seasonver.act166.view2_6.Season166_2_6InformationAnalyViewContainer", package.seeall)

slot0 = class("Season166_2_6InformationAnalyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166_2_6InformationAnalyView.New())
	table.insert(slot1, Season166InformationCurrencyView.New())
	table.insert(slot1, Season166_2_6InformationAnalyRewardView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166InformationHelp)

		return {
			slot0.navigateView
		}
	end
end

return slot0
