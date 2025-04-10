module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandResultViewContainer", package.seeall)

slot0 = class("CooperGarlandResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CooperGarlandResultView.New())

	return slot1
end

return slot0
