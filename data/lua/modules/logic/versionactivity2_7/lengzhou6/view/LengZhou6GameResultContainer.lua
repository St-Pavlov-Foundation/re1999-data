module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameResultContainer", package.seeall)

slot0 = class("LengZhou6GameResultContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, LengZhou6GameResult.New())

	return slot1
end

return slot0
