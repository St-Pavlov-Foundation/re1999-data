module("modules.logic.tower.view.TowerHeroTrialViewContainer", package.seeall)

slot0 = class("TowerHeroTrialViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerHeroTrialView.New())

	return slot1
end

return slot0
