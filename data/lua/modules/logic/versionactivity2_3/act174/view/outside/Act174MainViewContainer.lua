module("modules.logic.versionactivity2_3.act174.view.outside.Act174MainViewContainer", package.seeall)

slot0 = class("Act174MainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act174MainView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
