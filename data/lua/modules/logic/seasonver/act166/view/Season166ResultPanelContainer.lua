module("modules.logic.seasonver.act166.view.Season166ResultPanelContainer", package.seeall)

slot0 = class("Season166ResultPanelContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166ResultPanel.New())

	return slot1
end

return slot0
