module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleRecordViewContainer", package.seeall)

local var_0_0 = class("Role37PuzzleRecordViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_List"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#scroll_List/Viewport/Content/RecordItem"
	var_1_1.cellClass = PuzzleRecordViewItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1500
	var_1_1.cellHeight = 40
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 15
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(PuzzleRecordListModel.instance, var_1_1))
	table.insert(var_1_0, Role37PuzzleRecordView.New())

	return var_1_0
end

return var_0_0
