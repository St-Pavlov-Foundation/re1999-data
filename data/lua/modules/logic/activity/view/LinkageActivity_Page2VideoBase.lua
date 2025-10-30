-- chunkname: @modules/logic/activity/view/LinkageActivity_Page2VideoBase.lua

module("modules.logic.activity.view.LinkageActivity_Page2VideoBase", package.seeall)

local LinkageActivity_Page2VideoBase = class("LinkageActivity_Page2VideoBase", RougeSimpleItemBase)
local csRect = UnityEngine.Rect

function LinkageActivity_Page2VideoBase:ctor(...)
	self:__onInit()
	LinkageActivity_Page2VideoBase.super.ctor(self, ...)

	self.__videoPath = false
	self._uvRect = {
		w = 1,
		h = 1,
		x = 0,
		y = 0
	}
	self._isNeedLoadingCover = false
end

function LinkageActivity_Page2VideoBase:getAssetItem_VideoLoadingPng()
	local c = self:_assetGetViewContainer()

	return c:getAssetItem_VideoLoadingPng()
end

function LinkageActivity_Page2VideoBase:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "_rewindFrameTimer")
	FrameTimerController.onDestroyViewMember(self, "_playFrameTimer")

	if self._videoPlayer then
		self._videoPlayer:Clear()
	end

	LinkageActivity_Page2VideoBase.super.onDestroyView(self)
	self:__onDispose()
end

function LinkageActivity_Page2VideoBase:actId()
	local p = self:_assetGetParent()

	return p:actId()
end

function LinkageActivity_Page2VideoBase:getLinkageActivityCO()
	local p = self:_assetGetParent()

	return p:getLinkageActivityCO()
end

local kBias = 5

function LinkageActivity_Page2VideoBase:createVideoPlayer(go)
	local targetTrans = go.transform
	local maskW = recthelper.getWidth(targetTrans)
	local maskH = recthelper.getHeight(targetTrans)

	self._videoPlayer, self._displayUGUI, self._videoGo = AvProMgr.instance:getVideoPlayer(go)

	local uIBgSelfAdapter = self._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

	if uIBgSelfAdapter then
		uIBgSelfAdapter.enabled = false
	end

	local curTrans = self._videoGo.transform
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
end

function LinkageActivity_Page2VideoBase:setDisplayUGUITextureRect(x, y, w, h)
	self._uvRect = {
		x = x or 0,
		y = y or 0,
		w = w or 1,
		h = h or 1
	}

	if self._displayUGUI then
		self:_refreshDisplayUGUITextureRect()
	end
end

function LinkageActivity_Page2VideoBase:_refreshDisplayUGUITextureRect(isReset)
	if isReset then
		self._displayUGUI.uvRect = csRect.New(0, 0, 1, 1)
	else
		self._displayUGUI.uvRect = csRect.New(self._uvRect.x, self._uvRect.y, self._uvRect.w, self._uvRect.h)
	end

	self._displayUGUI:SetVerticesDirty()
end

function LinkageActivity_Page2VideoBase:loadVideo(videoPath, isRewindPause)
	if self.__videoPath == videoPath then
		return
	end

	FrameTimerController.onDestroyViewMember(self, "_playFrameTimer")
	self:_loadVideo(videoPath)
	FrameTimerController.onDestroyViewMember(self, "_rewindFrameTimer")

	if isRewindPause then
		self._videoPlayer:Play(self._displayUGUI, videoPath, false)

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

function LinkageActivity_Page2VideoBase:_loadVideo(videoPath)
	if self._isNeedLoadingCover then
		self:_refreshLoadingCover()
		self:_setActive_LoadingCover(true)
	end

	self.__videoPath = videoPath

	self._videoPlayer:LoadMedia(videoPath)
end

function LinkageActivity_Page2VideoBase:play(audioId, isLooping)
	assert(self.__videoPath, "please called 'loadVideo' first!!")

	if not self:_isPlaying() then
		self:_play(audioId, isLooping)
	else
		self:_rewind(false)
		self:_play(audioId, isLooping)
	end
end

function LinkageActivity_Page2VideoBase:stop(stopAudioId)
	FrameTimerController.onDestroyViewMember(self, "_playFrameTimer")
	FrameTimerController.onDestroyViewMember(self, "_rewindFrameTimer")

	if stopAudioId then
		AudioMgr.instance:trigger(stopAudioId)
	end

	self:_rewind(true)
end

function LinkageActivity_Page2VideoBase:_play(audioId, isLooping)
	FrameTimerController.onDestroyViewMember(self, "_playFrameTimer")

	if not self:_canPlay() then
		self._playFrameTimer = FrameTimerController.instance:register(function()
			if not self:_canPlay() then
				return
			end

			FrameTimerController.onDestroyViewMember(self, "_playFrameTimer")
			self:_onPlay(audioId, isLooping)
		end, nil, 9, 9)

		self._playFrameTimer:Start()
	else
		self:_onPlay(audioId, isLooping)
	end
end

function LinkageActivity_Page2VideoBase:_onPlay(audioId, isLooping)
	if self._isNeedLoadingCover then
		self:_setActive_LoadingCover(false)
	end

	self._videoPlayer:Play(self._displayUGUI, isLooping)

	if audioId then
		AudioMgr.instance:trigger(audioId)
	end
end

function LinkageActivity_Page2VideoBase:_rewind(isPause)
	self._videoPlayer:Rewind(isPause)
end

function LinkageActivity_Page2VideoBase:_canPlay()
	return self._videoPlayer:CanPlay()
end

function LinkageActivity_Page2VideoBase:_isPlaying()
	return self._videoPlayer:IsPlaying()
end

function LinkageActivity_Page2VideoBase:_setActive_LoadingCover(isActive)
	self._displayUGUI.enabled = isActive

	self:_refreshDisplayUGUITextureRect(not isActive)
end

function LinkageActivity_Page2VideoBase:setIsNeedLoadingCover(isNeed)
	self._isNeedLoadingCover = isNeed

	if isNeed and self._displayUGUI then
		self:_refreshLoadingCover()
	end
end

function LinkageActivity_Page2VideoBase:_refreshLoadingCover()
	self._displayUGUI.NoDefaultDisplay = false
	self._displayUGUI.DefaultTexture = self:getAssetItem_VideoLoadingPng()
end

return LinkageActivity_Page2VideoBase
