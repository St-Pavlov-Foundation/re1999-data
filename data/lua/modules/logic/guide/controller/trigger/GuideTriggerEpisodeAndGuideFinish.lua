﻿-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEpisodeAndGuideFinish.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeAndGuideFinish", package.seeall)

local GuideTriggerEpisodeAndGuideFinish = class("GuideTriggerEpisodeAndGuideFinish", BaseGuideTrigger)

function GuideTriggerEpisodeAndGuideFinish:ctor(triggerKey)
	GuideTriggerEpisodeAndGuideFinish.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._checkStartGuide, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._checkStartGuide, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerEpisodeAndGuideFinish:assertGuideSatisfy(param, configParam)
	local paramSp = string.splitToNumber(configParam, "_")
	local configEpisodeId = paramSp[1]
	local configGuideId = paramSp[2]
	local episodeMO = DungeonModel.instance:getEpisodeInfo(configEpisodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(configEpisodeId)
	local episodeFinish = false

	if episodeCO and episodeMO and episodeMO.star > DungeonEnum.StarType.None then
		episodeFinish = episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)
	end

	local guideFinish = GuideModel.instance:isGuideFinish(configGuideId)

	return episodeFinish and guideFinish
end

function GuideTriggerEpisodeAndGuideFinish:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerEpisodeAndGuideFinish:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerEpisodeAndGuideFinish
