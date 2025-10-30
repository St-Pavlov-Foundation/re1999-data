﻿-- chunkname: @modules/logic/seasonver/act123/view/Season123PickHeroViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123PickHeroViewContainer", package.seeall)

local Season123PickHeroViewContainer = class("Season123PickHeroViewContainer", BaseViewContainer)

function Season123PickHeroViewContainer:buildViews()
	return {
		Season123CheckCloseView.New(),
		Season123PickHeroView.New(),
		self:getScrollView(),
		Season123PickHeroDetailView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123PickHeroViewContainer:getScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123PickHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 440
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		local delayTime = math.ceil((i - 1) % 5) * 0.03

		animationDelayTimes[i] = delayTime
	end

	return LuaListScrollViewWithAnimator.New(Season123PickHeroModel.instance, scrollParam, animationDelayTimes)
end

function Season123PickHeroViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return Season123PickHeroViewContainer
