module("modules.logic.activity.view.V1a4_Role_SignItem_SignViewContainer", package.seeall)

slot0 = class("V1a4_Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function slot0.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = V1a4_Role_SignItem
	slot1.scrollGOPath = "Root/#scroll_ItemList"
	slot1.cellWidth = 220
	slot1.cellHeight = 600
	slot1.cellSpaceH = -16
end

return slot0
