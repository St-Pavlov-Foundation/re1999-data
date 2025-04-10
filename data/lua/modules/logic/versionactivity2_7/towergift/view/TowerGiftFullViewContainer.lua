module("modules.logic.versionactivity2_7.towergift.view.TowerGiftFullViewContainer", package.seeall)

slot0 = class("TowerGiftFullViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerGiftFullView.New())

	return slot1
end

return slot0
