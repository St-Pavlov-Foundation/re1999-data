﻿-- chunkname: @modules/logic/survival/view/rewardinherit/SurvivalRewardInheritViewContainer.lua

module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritViewContainer", package.seeall)

local SurvivalRewardInheritViewContainer = class("SurvivalRewardInheritViewContainer", BaseViewContainer)

function SurvivalRewardInheritViewContainer:buildViews()
	local views = {
		SurvivalRewardInheritView.New()
	}

	return views
end

function SurvivalRewardInheritViewContainer:buildTabViews(tabContainerId)
	return
end

function SurvivalRewardInheritViewContainer:onContainerOpenFinish()
	return
end

return SurvivalRewardInheritViewContainer
