module("modules.logic.activity.view.V1a5_DoubleFestival_SignItem_SignViewContainer", package.seeall)

slot0 = class("V1a5_DoubleFestival_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function slot0.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = V1a5_DoubleFestival_SignItem
	slot1.scrollGOPath = "Root/#scroll_ItemList"
	slot1.cellWidth = 220
	slot1.cellHeight = 600
	slot1.cellSpaceH = -16
end

function slot0.onBuildViews(slot0)
	return {
		slot0:getMainView()
	}
end

return slot0
