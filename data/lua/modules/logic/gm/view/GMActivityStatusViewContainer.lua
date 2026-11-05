-- chunkname: @modules/logic/gm/view/GMActivityStatusViewContainer.lua

module("modules.logic.gm.view.GMActivityStatusViewContainer", package.seeall)

local GMActivityStatusViewContainer = class("GMActivityStatusViewContainer", BaseViewContainer)

function GMActivityStatusViewContainer:buildViews()
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "view/scroll"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listScrollParam.prefabUrl = "view/scroll/item"
	listScrollParam.cellClass = GMActivityStatusItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 800
	listScrollParam.cellHeight = 120
	listScrollParam.cellSpaceH = 0
	listScrollParam.cellSpaceV = 0

	return {
		GMActivityStatusView.New(),
		LuaListScrollView.New(GMActivityStatusModel.instance, listScrollParam)
	}
end

return GMActivityStatusViewContainer
