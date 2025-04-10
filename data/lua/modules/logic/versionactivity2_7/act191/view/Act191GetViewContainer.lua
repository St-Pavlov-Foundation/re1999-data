module("modules.logic.versionactivity2_7.act191.view.Act191GetViewContainer", package.seeall)

slot0 = class("Act191GetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act191GetView.New())

	return slot1
end

return slot0
