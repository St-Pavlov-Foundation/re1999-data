-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_SettlementUnlockViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_SettlementUnlockViewContainer", package.seeall)

local Rouge2_SettlementUnlockViewContainer = class("Rouge2_SettlementUnlockViewContainer", BaseViewContainer)

function Rouge2_SettlementUnlockViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_SettlementUnlockView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.scrollGOPath = "#scroll_collection"
	scrollParam.prefabUrl = "#scroll_collection/Viewport/Content/#go_collectionitem"
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellClass = Rouge2_ResultCollectionListItem
	scrollParam.cellWidth = 160
	scrollParam.cellHeight = 160
	scrollParam.startSpace = 16
	scrollParam.endSpace = 0
	scrollParam.lineCount = 6
	scrollParam.cellSpaceH = 30
	scrollParam.cellSpaceV = 30

	table.insert(views, LuaListScrollView.New(Rouge2_ResultMaterialListModel.instance, scrollParam))

	return views
end

return Rouge2_SettlementUnlockViewContainer
