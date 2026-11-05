-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_RankViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_RankViewContainer", package.seeall)

local V3a2_BossRush_RankViewContainer = class("V3a2_BossRush_RankViewContainer", BaseViewContainer)

function V3a2_BossRush_RankViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_progress"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = BossRushEnum.ResPath.v3a2_bossrush_rankbonus
	scrollParam.cellClass = V3a2_BossRush_RankBonus
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 700
	scrollParam.cellSpaceH = 60
	scrollParam.startSpace = 50
	self._scrollview = LuaListScrollView.New(V3a2_BossRush_RankListModel.instance, scrollParam)

	table.insert(views, V3a2_BossRush_RankView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, self._scrollview)

	return views
end

function V3a2_BossRush_RankViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return V3a2_BossRush_RankViewContainer
