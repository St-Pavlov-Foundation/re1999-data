module("modules.logic.rouge.dlc.101.view.RougeLimiterViewContainer", package.seeall)

slot0 = class("RougeLimiterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeLimiterView.New())
	table.insert(slot1, RougeLimiterDebuffTipsView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_LeftTop"))
	table.insert(slot1, RougeLimiterViewEmblemComp.New("#go_RightTop"))

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
