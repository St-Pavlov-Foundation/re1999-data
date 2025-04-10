module("modules.logic.versionactivity2_7.towergift.view.CharacterDestinyStoneUpViewContainer", package.seeall)

slot0 = class("CharacterDestinyStoneUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._stoneView = CharacterDestinyStoneUpView.New()

	table.insert(slot1, slot0._stoneView)
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
