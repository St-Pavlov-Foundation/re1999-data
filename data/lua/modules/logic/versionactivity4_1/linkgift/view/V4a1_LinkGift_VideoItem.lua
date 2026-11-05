-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_VideoItem.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_VideoItem", package.seeall)

local V4a1_LinkGift_VideoItem = class("V4a1_LinkGift_VideoItem", LinkGiftVideoItemBase)

function V4a1_LinkGift_VideoItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_VideoItem:addEvents()
	return
end

function V4a1_LinkGift_VideoItem:removeEvents()
	return
end

local kVideoWidth = 1920
local kVideoHeight = 1080

V4a1_LinkGift_VideoItem.kVideoWidth = kVideoWidth
V4a1_LinkGift_VideoItem.kVideoHeight = kVideoHeight

function V4a1_LinkGift_VideoItem:ctor(...)
	V4a1_LinkGift_VideoItem.super.ctor(self, ...)
end

function V4a1_LinkGift_VideoItem:onDestroyView()
	local mo = self._mo

	if mo and mo.videoAudioStopId then
		AudioMgr.instance:trigger(mo.videoAudioStopId)
	end

	V4a1_LinkGift_VideoItem.super.onDestroyView(self)
end

function V4a1_LinkGift_VideoItem:setFullScreen(bFullScreen)
	return
end

function V4a1_LinkGift_VideoItem:resetFullscreenStretch()
	self:setFullscreenStretch(self:transform())
	self:setFullscreenStretch(self:videoTransform())
end

function V4a1_LinkGift_VideoItem:_editableInitView()
	V4a1_LinkGift_VideoItem.super._editableInitView(self)
	self:setIsNeedLoadingCover(false)
	self:createVideoPlayer(self.viewGO, "lgVideo", true, kVideoWidth, kVideoHeight)
	self:resetFullscreenStretch()
end

function V4a1_LinkGift_VideoItem:onUpdateMO(mo)
	V4a1_LinkGift_VideoItem.super.onUpdateMO(self, mo)

	local videoPath = mo.videoName

	self:loadVideo(videoPath)
	self:run()
end

function V4a1_LinkGift_VideoItem:run()
	if not self:_isPlaying() then
		self:play()
		self:resetFullscreenStretch()
	end
end

function V4a1_LinkGift_VideoItem:play()
	local mo = self._mo
	local audioId = mo.videoAudioId

	V4a1_LinkGift_VideoItem.super.play(self, audioId, true)
end

function V4a1_LinkGift_VideoItem:stop()
	local mo = self._mo
	local stopAudioId = mo.videoAudioStopId

	V4a1_LinkGift_VideoItem.super.stop(self, stopAudioId)
end

return V4a1_LinkGift_VideoItem
