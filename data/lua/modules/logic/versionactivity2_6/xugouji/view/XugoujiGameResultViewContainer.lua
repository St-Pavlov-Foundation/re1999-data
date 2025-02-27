module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameResultViewContainer", package.seeall)

slot0 = class("XugoujiGameResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._resultView = XugoujiGameResultView.New()

	table.insert(slot1, slot0._resultView)

	return slot1
end

return slot0
