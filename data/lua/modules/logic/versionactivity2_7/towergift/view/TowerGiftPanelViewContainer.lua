module("modules.logic.versionactivity2_7.towergift.view.TowerGiftPanelViewContainer", package.seeall)

slot0 = class("TowerGiftPanelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerGiftPanelView.New())

	return slot1
end

return slot0
