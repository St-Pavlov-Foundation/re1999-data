-- chunkname: @modules/logic/story/view/StoryVideoItem.lua

module("modules.logic.story.view.StoryVideoItem", package.seeall)

local StoryVideoItem = class("StoryVideoItem")

function StoryVideoItem:init(go, name, co, startCallBack, startCallBackObj, playList)
	self.viewGO = go
	self._videoName = name
	self._videoCo = co
	self._loop = co.loop
	self._startCallBack = startCallBack
	self._startCallBackObj = startCallBackObj
	self._playList = playList

	self:_build()
end

function StoryVideoItem:pause(pause)
	if pause then
		self._playList:setPauseState(self._videoName, false)
	else
		self._playList:setPauseState(self._videoName, true)
	end
end

function StoryVideoItem:reset(go, co)
	self.viewGO = go
	self._videoCo = co
	self._loop = co.loop

	TaskDispatcher.cancelTask(self._playVideo, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playVideo()

		return
	end

	TaskDispatcher.runDelay(self._playVideo, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_build()
	local videoArgs = string.split(self._videoName, ".")

	self._videoName = videoArgs[1]

	if self._videoName == "xuzhangkaichangpv" and BootNativeUtil.isWindows() then
		local width, height = BootNativeUtil.getDisplayResolution()

		if height >= 2160 then
			self._videoName = "xuzhangkaichangpv_4k"
		elseif height >= 1440 then
			self._videoName = "xuzhangkaichangpv_2k"
		end
	end

	TaskDispatcher.cancelTask(self._playVideo, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playVideo()

		return
	end

	TaskDispatcher.runDelay(self._playVideo, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_playVideo()
	StoryModel.instance:setSpecialVideoPlaying(self._videoName)

	if self._playList then
		self._playList:buildAndStart(self._videoName, self._loop, self._startCallBack, self._startCallBackObj, self)
		self._playList:setParent(self.viewGO)
	end
end

function StoryVideoItem:destroyVideo(co)
	self._videoCo = co

	TaskDispatcher.cancelTask(self._playVideo, self)
	TaskDispatcher.cancelTask(self._realDestroy, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_realDestroy()

		return
	end

	TaskDispatcher.runDelay(self._realDestroy, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_realDestroy()
	self:onDestroy()
end

function StoryVideoItem:onDestroy()
	TaskDispatcher.cancelTask(self._realDestroy, self)
	TaskDispatcher.cancelTask(self._playVideo, self)
	StoryModel.instance:setSpecialVideoEnd(self._videoName)
	self._playList:stop(self._videoName)
end

return StoryVideoItem
