﻿-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/maplevel/VersionActivity1_8DungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity1_8.dungeon.view.maplevel.VersionActivity1_8DungeonMapLevelViewContainer", package.seeall)

local VersionActivity1_8DungeonMapLevelViewContainer = class("VersionActivity1_8DungeonMapLevelViewContainer", BaseViewContainer)
local TIME_OUT = 2

function VersionActivity1_8DungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivity1_8DungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivity1_8DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity1_8DungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivity1_8DungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivity1_8DungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = self.mapLevelView.animatorPlayer

	if player then
		player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	end

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, TIME_OUT)
end

function VersionActivity1_8DungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivity1_8DungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivity1_8DungeonMapLevelViewContainer:stopCloseViewTask()
	return
end

return VersionActivity1_8DungeonMapLevelViewContainer
