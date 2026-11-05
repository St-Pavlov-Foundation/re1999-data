-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/reward/ArcadeSurvivorRewardViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.reward.ArcadeSurvivorRewardViewContainer", package.seeall)

local ArcadeSurvivorRewardViewContainer = class("ArcadeSurvivorRewardViewContainer", BaseViewContainer)

function ArcadeSurvivorRewardViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Left/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = ArcadeSurvivorRewardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 268
	scrollParam1.cellHeight = 700
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 2
	self.scrollView = LuaListScrollViewWithAnimator.New(ArcadeSurvivorRewardListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, ArcadeSurvivorRewardView.New())

	return views
end

function ArcadeSurvivorRewardViewContainer:getScrollView()
	return self.scrollView
end

return ArcadeSurvivorRewardViewContainer
