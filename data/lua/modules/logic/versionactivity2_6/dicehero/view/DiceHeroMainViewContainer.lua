module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroMainViewContainer", package.seeall)

slot0 = class("DiceHeroMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DiceHeroMainView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return slot0
