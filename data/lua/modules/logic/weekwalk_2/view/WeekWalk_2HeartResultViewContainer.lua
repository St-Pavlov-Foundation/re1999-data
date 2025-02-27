module("modules.logic.weekwalk_2.view.WeekWalk_2HeartResultViewContainer", package.seeall)

slot0 = class("WeekWalk_2HeartResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, WeekWalk_2HeartResultView.New())

	return slot1
end

return slot0
