-- chunkname: @modules/logic/gm/view/GMFightEnterViewContainer.lua

module("modules.logic.gm.view.GMFightEnterViewContainer", package.seeall)

local GMFightEnterViewContainer = class("GMFightEnterViewContainer", BaseViewContainer)

function GMFightEnterViewContainer:buildViews()
	local leftScrollParam = ListScrollParam.New()

	leftScrollParam.scrollGOPath = "leftviewport"
	leftScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	leftScrollParam.prefabUrl = "leftviewport/item"
	leftScrollParam.cellClass = GMFightEnterLeftItem
	leftScrollParam.scrollDir = ScrollEnum.ScrollDirV
	leftScrollParam.lineCount = 1
	leftScrollParam.cellWidth = 350
	leftScrollParam.cellHeight = 100
	leftScrollParam.cellSpaceH = 0
	leftScrollParam.cellSpaceV = 0
	leftScrollParam.startSpace = 0

	local rightScrollParam = ListScrollParam.New()

	rightScrollParam.scrollGOPath = "rightviewport"
	rightScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	rightScrollParam.prefabUrl = "rightviewport/item"
	rightScrollParam.cellClass = GMFightEnterRightItem
	rightScrollParam.scrollDir = ScrollEnum.ScrollDirV
	rightScrollParam.lineCount = 1
	rightScrollParam.cellWidth = 1000
	rightScrollParam.cellHeight = 100
	rightScrollParam.cellSpaceH = 0
	rightScrollParam.cellSpaceV = 0
	rightScrollParam.startSpace = 0

	local views = {}

	table.insert(views, LuaListScrollView.New(GMFightEnterLeftModel.instance, leftScrollParam))
	table.insert(views, LuaListScrollView.New(GMFightEnterFightModel.instance, rightScrollParam))
	table.insert(views, GMFightEnterView.New())

	return views
end

function GMFightEnterViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return GMFightEnterViewContainer
