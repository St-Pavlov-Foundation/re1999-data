﻿-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapLevelViewContainer", package.seeall)

local VersionActivity1_2DungeonMapLevelViewContainer = class("VersionActivity1_2DungeonMapLevelViewContainer", BaseViewContainer)

function VersionActivity1_2DungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivity1_2DungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivity1_2DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity1_2DungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivity1_2DungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivity1_2DungeonMapLevelViewContainer:playCloseTransition()
	UIBlockMgr.instance:endBlock(self.viewName .. "ViewOpenAnim")
	TaskDispatcher.cancelTask(self._onOpenAnimDone, self)

	self._playCloseAnim = true

	UIBlockMgr.instance:startBlock(self.viewName .. "ViewCloseAnim")

	local player = SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity)

	player:Play("close", self._onCloseAnimDone, self)
	TaskDispatcher.runDelay(self._onCloseAnimDone, self, 2)
end

function VersionActivity1_2DungeonMapLevelViewContainer:_onCloseAnimDone()
	TaskDispatcher.cancelTask(self._onCloseAnimDone, self, 2)
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	self:onPlayCloseTransitionFinish()
end

function VersionActivity1_2DungeonMapLevelViewContainer:stopCloseViewTask()
	self.mapLevelView:cancelStartCloseTask()
end

return VersionActivity1_2DungeonMapLevelViewContainer
