module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessForcePickViewContainer", package.seeall)

slot0 = class("AutoChessForcePickViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessForcePickView.New())

	return slot1
end

return slot0
