﻿-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaEquipViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipViewContainer", package.seeall)

local AiZiLaEquipViewContainer = class("AiZiLaEquipViewContainer", BaseViewContainer)

function AiZiLaEquipViewContainer:buildViews()
	local views = {}

	self._equipView = AiZiLaEquipView.New()

	table.insert(views, self._equipView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AiZiLaEquipViewContainer:onContainerClickModalMask()
	return
end

function AiZiLaEquipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local home = true

		if ViewMgr.instance:isOpen(ViewName.AiZiLaGameView) then
			home = false
		end

		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			home,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return AiZiLaEquipViewContainer
