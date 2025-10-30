﻿-- chunkname: @modules/logic/seasonver/act123/view/Season123CardPackageViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123CardPackageViewContainer", package.seeall)

local Season123CardPackageViewContainer = class("Season123CardPackageViewContainer", BaseViewContainer)

function Season123CardPackageViewContainer:buildViews()
	self:buildScrollViews()

	return {
		Season123CardPackageView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123CardPackageViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navigateButtonsView:setHelpId(HelpEnum.HelpId.Season1_7CardGetViewHelp)

		return {
			navigateButtonsView
		}
	end
end

function Season123CardPackageViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_cardget/mask/#scroll_cardget"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123CardPackageItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 204
	scrollParam.cellHeight = 290
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 50
	scrollParam.frameUpdateMs = 100

	local delayTimes = {}

	for i = 1, 15 do
		local delayTime = math.ceil(i / 5) * 0.06

		delayTimes[i] = delayTime
	end

	self.scrollView = LuaListScrollViewWithAnimator.New(Season123CardPackageModel.instance, scrollParam, delayTimes)
end

return Season123CardPackageViewContainer
