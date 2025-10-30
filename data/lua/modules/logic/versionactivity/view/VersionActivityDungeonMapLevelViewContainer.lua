﻿-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapLevelViewContainer", package.seeall)

local VersionActivityDungeonMapLevelViewContainer = class("VersionActivityDungeonMapLevelViewContainer", BaseViewContainer)

function VersionActivityDungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivityDungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivityDungeonMapLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	elseif tabContainerId == 2 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function VersionActivityDungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivityDungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivityDungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity)

	player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 2)
end

function VersionActivityDungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivityDungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivityDungeonMapLevelViewContainer:stopCloseViewTask()
	self.mapLevelView:cancelStartCloseTask()
end

return VersionActivityDungeonMapLevelViewContainer
