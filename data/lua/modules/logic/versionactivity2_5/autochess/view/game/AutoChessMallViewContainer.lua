module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallViewContainer", package.seeall)

slot0 = class("AutoChessMallViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessMallView.New())

	return slot1
end

return slot0
