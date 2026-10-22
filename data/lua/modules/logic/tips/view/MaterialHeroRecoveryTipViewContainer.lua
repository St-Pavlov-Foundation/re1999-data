-- chunkname: @modules/logic/tips/view/MaterialHeroRecoveryTipViewContainer.lua

module("modules.logic.tips.view.MaterialHeroRecoveryTipViewContainer", package.seeall)

local MaterialHeroRecoveryTipViewContainer = class("MaterialHeroRecoveryTipViewContainer", BaseViewContainer)

function MaterialHeroRecoveryTipViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/Right/layout2/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = IconMgrConfig.UrlItemIcon
	scrollParam.cellClass = CommonItemIcon
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 204
	scrollParam.cellHeight = 204

	table.insert(views, MaterialHeroRecoveryTipView.New())
	table.insert(views, LuaListScrollView.New(MaterialHeroRecoveryTipListModel.instance, scrollParam))

	return views
end

return MaterialHeroRecoveryTipViewContainer
