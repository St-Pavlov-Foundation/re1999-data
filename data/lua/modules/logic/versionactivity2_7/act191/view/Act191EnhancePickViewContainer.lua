module("modules.logic.versionactivity2_7.act191.view.Act191EnhancePickViewContainer", package.seeall)

slot0 = class("Act191EnhancePickViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act191EnhancePickView.New())

	return slot1
end

return slot0
