-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/LinkGiftVideoItemBase.lua

module("modules.logic.versionactivity4_1.linkgift.view.LinkGiftVideoItemBase", package.seeall)

local LinkGiftVideoItemBase = class("LinkGiftVideoItemBase", RougeSimpleItemBase)
local csRect = UnityEngine.Rect

function LinkGiftVideoItemBase:ctor(...)
	self:__onInit()
	LinkGiftVideoItemBase.super.ctor(self, ...)

	self.__videoPath = false
	self._uvRect = {
		w = 1,
		h = 1,
		x = 0,
		y = 0
	}
	self._isNeedLoadingCover = false
end

function LinkGiftVideoItemBase:_rewind(isPause)
	self._videoPlayer:rewind(isPause)
end

function LinkGiftVideoItemBase:_canPlay()
	return self._videoPlayer:canPlay()
end

function LinkGiftVideoItemBase:_isPlaying()
	return self._videoPlayer:isPlaying()
end

function LinkGiftVideoItemBase:_isFinished()
	return self._videoPlayer:isFinished()
end

function LinkGiftVideoItemBase:_isPaused()
	return self._videoPlayer:isPaused()
end

function LinkGiftVideoItemBase:_continue()
	return self._videoPlayer:continue()
end

function LinkGiftVideoItemBase:_getTimeRange()
	return self._videoPlayer:getTimeRange(0, 0, 0)
end

function LinkGiftVideoItemBase:_getStartTime()
	local startTime, duration, curTime = self:_getTimeRange()

	return startTime
end

function LinkGiftVideoItemBase:_getDuration()
	local startTime, duration, curTime = self:_getTimeRange()

	return duration
end

function LinkGiftVideoItemBase:_getCurTime()
	local startTime, duration, curTime = self:_getTimeRange()

	return curTime
end

function LinkGiftVideoItemBase:_getEndTime(optDtSec)
	optDtSec = optDtSec or 0

	local startTime, duration, curTime = self:_getTimeRange()
	local endTime = duration - curTime + optDtSec

	return endTime
end

function LinkGiftVideoItemBase:videoGo()
	return self._videoGo
end

function LinkGiftVideoItemBase:videoTransform()
	return self._videoTrans
end

function LinkGiftVideoItemBase:getAssetItem_VideoLoadingPng()
	local c = self:_assetGetViewContainer()

	return c:getAssetItem_VideoLoadingPng()
end

function LinkGiftVideoItemBase:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "_rewindFrameTimer")

	if self._videoPlayer then
		self._videoPlayer:clear()
	end

	LinkGiftVideoItemBase.super.onDestroyView(self)
	self:__onDispose()
end

local kBias = 5
local kType_UIBgSelfAdapter = typeof(ZProj.UIBgSelfAdapter)

function LinkGiftVideoItemBase:createVideoPlayer(go, optName, optLoopping, optWidth, optHeight)
	local targetTrans = go.transform
	local maskW = recthelper.getWidth(targetTrans)
	local maskH = recthelper.getHeight(targetTrans)

	self._videoPlayer, self._videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(go, optName, optLoopping, optWidth, optHeight)
	self._videoTrans = self._videoGo.transform

	self._videoPlayer:setPlayOnAwake(true)

	local uIBgSelfAdapter = self._videoGo:GetComponent(kType_UIBgSelfAdapter)

	if uIBgSelfAdapter then
		uIBgSelfAdapter.enabled = false
	end

	if self._videoPlayer:isAvproVideo() then
		local curTrans = self._videoTrans
		local videoW = recthelper.getWidth(curTrans)
		local videoH = math.max(1, recthelper.getHeight(curTrans))
		local aspect = videoW / videoH

		if maskH <= maskW then
			videoH = maskH
			videoW = maskH * aspect
		else
			videoW = maskW
			videoH = maskW / aspect
		end

		recthelper.setSize(curTrans, videoW + kBias, videoH + kBias)
	else
		self:setFullscreenStretch(self._videoTrans)
	end
end

function LinkGiftVideoItemBase:setDisplayUGUITextureRect(x, y, w, h)
	self._uvRect = {
		x = x or 0,
		y = y or 0,
		w = w or 1,
		h = h or 1
	}

	if self._videoPlayer then
		self:_refreshDisplayUGUITextureRect()
	end
end

function LinkGiftVideoItemBase:_refreshDisplayUGUITextureRect(isReset)
	local rect

	if isReset then
		rect = csRect.New(0, 0, 1, 1)
	else
		rect = csRect.New(self._uvRect.x, self._uvRect.y, self._uvRect.w, self._uvRect.h)
	end

	self._videoPlayer:setUVRect(rect)
	self._videoPlayer:setVerticesDirty()
end

function LinkGiftVideoItemBase:loadVideo(videoPath, isRewindPause)
	if self.__videoPath == videoPath then
		return
	end

	self:_loadVideo(videoPath)
	FrameTimerController.onDestroyViewMember(self, "_rewindFrameTimer")

	if isRewindPause then
		self._videoPlayer:play(videoPath, false)

		self._rewindFrameTimer = FrameTimerController.instance:register(function()
			if not self:_canPlay() then
				return
			end

			self:_refreshDisplayUGUITextureRect(true)
			self:_rewind(true)
			FrameTimerController.onDestroyViewMember(self, "_rewindFrameTimer")
		end, nil, 5, 3)

		self._rewindFrameTimer:Start()
	end
end

function LinkGiftVideoItemBase:_loadVideo(videoPath)
	if self._isNeedLoadingCover then
		self:_refreshLoadingCover()
		self:_setActive_LoadingCover(true)
	end

	self.__videoPath = videoPath

	self._videoPlayer:loadMedia(videoPath)
end

function LinkGiftVideoItemBase:play(audioId, isLooping)
	assert(self.__videoPath, "please called 'loadVideo' first!!")

	if not self:_isPlaying() then
		self:_play(audioId, isLooping)
	else
		self:_rewind(false)
		self:_play(audioId, isLooping)
	end
end

function LinkGiftVideoItemBase:stop(stopAudioId)
	FrameTimerController.onDestroyViewMember(self, "_rewindFrameTimer")

	if stopAudioId then
		AudioMgr.instance:trigger(stopAudioId)
	end

	self:_rewind(true)
end

function LinkGiftVideoItemBase:_play(audioId, isLooping)
	self._videoPlayer:play(self.__videoPath, isLooping)

	if audioId then
		AudioMgr.instance:trigger(audioId)
	end
end

function LinkGiftVideoItemBase:_setActive_LoadingCover(isActive)
	self._videoPlayer:setUGUIState(isActive)
	self:_refreshDisplayUGUITextureRect(not isActive)
end

function LinkGiftVideoItemBase:setIsNeedLoadingCover(isNeed)
	self._isNeedLoadingCover = isNeed

	if isNeed and self._videoPlayer then
		self:_refreshLoadingCover()
	end
end

function LinkGiftVideoItemBase:_refreshLoadingCover()
	self._videoPlayer:setNoDefaultDisplayState(false)
	self._videoPlayer:setDisplayUGUITexture(self:getAssetItem_VideoLoadingPng())
end

function LinkGiftVideoItemBase:calcFullScreenWidthHeight(bScaleFill)
	return
end

return LinkGiftVideoItemBase
