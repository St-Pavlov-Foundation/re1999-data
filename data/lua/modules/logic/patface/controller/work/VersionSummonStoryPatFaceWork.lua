-- chunkname: @modules/logic/patface/controller/work/VersionSummonStoryPatFaceWork.lua

module("modules.logic.patface.controller.work.VersionSummonStoryPatFaceWork", package.seeall)

local VersionSummonStoryPatFaceWork = class("VersionSummonStoryPatFaceWork", PatFaceWorkBase)

function VersionSummonStoryPatFaceWork:patStory()
	if StoryModel.instance:isStoryHasPlayed(800008) then
		self:onPlayPatStoryFinish()

		return
	end

	local storyId = self._patStoryId

	if StoryModel.instance:isStoryHasPlayed(storyId) then
		self:onPlayPatStoryFinish()

		return
	end

	StoryController.instance:playStory(storyId, nil, self.onPlayPatStoryFinish, self)
end

return VersionSummonStoryPatFaceWork
