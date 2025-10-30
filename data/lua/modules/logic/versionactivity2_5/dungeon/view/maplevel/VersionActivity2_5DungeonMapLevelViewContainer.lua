﻿-- chunkname: @modules/logic/versionactivity2_5/dungeon/view/maplevel/VersionActivity2_5DungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity2_5.dungeon.view.maplevel.VersionActivity2_5DungeonMapLevelViewContainer", package.seeall)

local VersionActivity2_5DungeonMapLevelViewContainer = class("VersionActivity2_5DungeonMapLevelViewContainer", BaseViewContainer)
local TIME_OUT = 2

function VersionActivity2_5DungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivity2_5DungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivity2_5DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_5DungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivity2_5DungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivity2_5DungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = self.mapLevelView.animatorPlayer

	if player then
		player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	end

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, TIME_OUT)
end

function VersionActivity2_5DungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivity2_5DungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivity2_5DungeonMapLevelViewContainer:stopCloseViewTask()
	return
end

return VersionActivity2_5DungeonMapLevelViewContainer
