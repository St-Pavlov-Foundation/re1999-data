﻿-- chunkname: @modules/logic/rouge2/start/view/Rouge2_DifficultySelectViewContainer.lua

module("modules.logic.rouge2.start.view.Rouge2_DifficultySelectViewContainer", package.seeall)

local Rouge2_DifficultySelectViewContainer = class("Rouge2_DifficultySelectViewContainer", BaseViewContainer)

function Rouge2_DifficultySelectViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_DifficultySelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Rouge2_DifficultySelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self.closeCallback, nil, nil, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_DifficultySelectViewContainer:closeCallback()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.BackEnterScene, Rouge2_OutsideEnum.SceneIndex.MainScene)
end

return Rouge2_DifficultySelectViewContainer
