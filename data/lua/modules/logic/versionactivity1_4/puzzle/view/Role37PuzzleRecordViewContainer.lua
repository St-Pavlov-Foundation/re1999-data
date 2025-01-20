module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleRecordViewContainer", package.seeall)

slot0 = class("Role37PuzzleRecordViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_List"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#scroll_List/Viewport/Content/RecordItem"
	slot2.cellClass = PuzzleRecordViewItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1500
	slot2.cellHeight = 40
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 15
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(PuzzleRecordListModel.instance, slot2))
	table.insert(slot1, Role37PuzzleRecordView.New())

	return slot1
end

return slot0
