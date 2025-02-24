module("modules.logic.activity.view.V2a6_WeekwalkHeart_FullViewContainer", package.seeall)

slot0 = class("V2a6_WeekwalkHeart_FullViewContainer", Activity189BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, V2a6_WeekwalkHeart_FullView.New())

	return slot1
end

function slot0.actId(slot0)
	return ActivityEnum.Activity.V2a6_WeekwalkHeart
end

return slot0
