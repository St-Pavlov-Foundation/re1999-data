module("modules.logic.versionactivity2_7.act191.view.Act191SettlementViewContainer", package.seeall)

slot0 = class("Act191SettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act191SettlementView.New())

	return slot1
end

return slot0
