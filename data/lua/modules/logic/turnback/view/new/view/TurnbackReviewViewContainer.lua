module("modules.logic.turnback.view.new.view.TurnbackReviewViewContainer", package.seeall)

slot0 = class("TurnbackReviewViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackReviewView.New())

	return slot1
end

return slot0
