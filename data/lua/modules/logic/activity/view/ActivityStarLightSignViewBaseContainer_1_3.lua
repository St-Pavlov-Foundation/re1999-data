module("modules.logic.activity.view.ActivityStarLightSignViewBaseContainer_1_3", package.seeall)

slot0 = class("ActivityStarLightSignViewBaseContainer_1_3", Activity101SignViewBaseContainer)

function slot0.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = ActivityStarLightSignItem_1_3
	slot1.scrollGOPath = "Root/#scroll_ItemList"
	slot1.cellWidth = 220
	slot1.cellHeight = 600
	slot1.cellSpaceH = -12
end

function slot0.onGetMainViewClassType(slot0)
	assert(false, "please override this function")
end

return slot0
