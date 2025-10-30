-- chunkname: @modules/logic/story/view/actChapter/StoryActivityVideoItem.lua

module("modules.logic.story.view.actChapter.StoryActivityVideoItem", package.seeall)

local StoryActivityVideoItem = class("StoryActivityVideoItem")

function StoryActivityVideoItem:ctor(go)
	self.viewGO = go
end

function StoryActivityVideoItem:playVideo(name, co)
	if name then
		local videoArgs = string.split(name, ".")

		self._videoName = videoArgs[1]
	else
		self._videoName = nil
	end

	co = co or {}
	self._loop = co.loop
	self._videoStartCallback = co.startCallback
	self._videoStartCallbackObj = co.startCallbackObj
	self._videoOutCallback = co.outCallback
	self._videoOutCallbackObj = co.outCallbackObj
	self._audioId = co.audioId
	self._audioNoStopByFinish = co.audioNoStopByFinish

	if self._videoName then
		if not self._videoGo then
			self:_build()
		end

		self:_playVideo()
	else
		self:onVideoStart()
	end
end

function StoryActivityVideoItem:_build()
	self._videoGo = gohelper.create2d(self.viewGO, self._videoName)
	self._avProVideoPlayer = gohelper.onceAddComponent(self._videoGo, typeof(ZProj.AvProUGUIPlayer))
	self._displauUGUI = gohelper.onceAddComponent(self._videoGo, typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	self._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	self._avProVideoPlayer:AddDisplayUGUI(self._displauUGUI)
	self._avProVideoPlayer:SetEventListener(self._onVideoEvent, self)
	recthelper.setSize(self._videoGo.transform, 2592, 1080)
end

function StoryActivityVideoItem:_playVideo()
	gohelper.setActive(self._videoGo, true)

	local videoPath = langVideoUrl(self._videoName)

	self._avProVideoPlayer:LoadMedia(videoPath)
	StoryModel.instance:setSpecialVideoPlaying(self._videoName)
	TaskDispatcher.runDelay(self._startVideo, self, 0.1)

	if BootNativeUtil.isIOS() then
		TaskDispatcher.runRepeat(self._detectPause, self, 0.05)
	end
end

function StoryActivityVideoItem:_startVideo()
	self._avProVideoPlayer:Play(self._displauUGUI, self._loop)
end

function StoryActivityVideoItem:onVideoStart()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end

	if self._videoStartCallback then
		self._videoStartCallback(self._videoStartCallbackObj)
	end
end

function StoryActivityVideoItem:onVideoOut(isFinishPlay)
	self:hide(isFinishPlay)

	if self._videoOutCallback then
		self._videoOutCallback(self._videoOutCallbackObj)
	end
end

function StoryActivityVideoItem:_onVideoEvent(path, status, errorCode)
	if errorCode ~= AvProEnum.ErrorCode.None then
		self:hide(true)
	end

	if status == AvProEnum.PlayerStatus.FirstFrameReady then
		self:onVideoStart()
	end

	if status == AvProEnum.PlayerStatus.FinishedPlaying then
		self:onVideoOut(true)
	end
end

function StoryActivityVideoItem:hide(isFinishPlay)
	if self._avProVideoPlayer then
		self._avProVideoPlayer:Stop()
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(self._detectPause, self)
	end

	if isFinishPlay then
		if not self._audioNoStopByFinish then
			self:stopAudio()
		end
	else
		self:stopAudio()
	end

	gohelper.setActive(self._videoGo, false)
end

function StoryActivityVideoItem:_detectPause()
	if self._avProVideoPlayer:IsPaused() then
		self._avProVideoPlayer:Play()
	end
end

function StoryActivityVideoItem:stopAudio()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityVideoItem:onDestroy()
	if self._videoName then
		StoryModel.instance:setSpecialVideoEnd(self._videoName)
	end

	if self._avProVideoPlayer ~= nil then
		self._avProVideoPlayer:Clear()

		self._avProVideoPlayer = nil
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(self._detectPause, self)
	end

	if self._videoGo then
		gohelper.destroy(self._videoGo)

		self._videoGo = nil
	end

	self._videoOutCallback = nil
	self._videoOutCallbackObj = nil
	self._videoStartCallback = nil
	self._videoStartCallbackObj = nil

	self:stopAudio()
end

return StoryActivityVideoItem
