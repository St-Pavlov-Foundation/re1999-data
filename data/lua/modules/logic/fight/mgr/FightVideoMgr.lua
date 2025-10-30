-- chunkname: @modules/logic/fight/mgr/FightVideoMgr.lua

module("modules.logic.fight.mgr.FightVideoMgr", package.seeall)

local FightVideoMgr = class("FightVideoMgr")
local VideoPrefabPath = "ui/viewres/fight/fightvideo.prefab"

function FightVideoMgr:ctor()
	self._avProVideoPlayer = nil
	self._displauUGUI = nil
	self._mediaPlayer = nil
	self._videoName = nil
	self._isPlaying = false
	self._callback = nil
	self._callbackObj = nil
	self._prefabLoader = nil
end

function FightVideoMgr:init()
	self:_checkVideCopatible()
end

function FightVideoMgr:dispose()
	self:stop()
end

function FightVideoMgr:_checkVideCopatible()
	if self._videoCopatible ~= SettingsModel.instance:getVideoCompatible() then
		self:stop()

		if self._avProVideoPlayer then
			self._avProVideoPlayer:Clear()

			self._avProVideoPlayer = nil
			self._mediaPlayer = nil
			self._displauUGUI = nil
		end

		if self._prefabLoader then
			self._prefabLoader:dispose()

			self._prefabLoader = nil
		end

		if self._videoRootGO then
			gohelper.destroy(self._videoRootGO)

			self._videoRootGO = nil
		end
	end
end

function FightVideoMgr:isSameVideo(videoPath)
	return videoPath == self._videoName
end

function FightVideoMgr:play(videoPath, callback, callbackObj)
	if string.nilorempty(videoPath) then
		logError("video path is nil")

		return
	end

	self._pause = false
	self._videoName = videoPath
	self._callback = callback
	self._callbackObj = callbackObj

	if self._videoRootGO then
		self:_playVideo()
	else
		self._videoCopatible = SettingsModel.instance:getVideoCompatible()
		self._prefabLoader = MultiAbLoader.New()

		self._prefabLoader:addPath(AvProMgr.instance:getFightUrl())
		self._prefabLoader:startLoad(self._onVideoPrefabLoaded, self)
	end

	FightController.instance:dispatchEvent(FightEvent.OnPlayVideo, videoPath)
end

function FightVideoMgr:_onVideoPrefabLoaded(loader)
	local uiLayer = ViewMgr.instance:getUILayer(UILayerName.PopUp)

	self._videoRootGO = gohelper.clone(loader:getFirstAssetItem():GetResource(), uiLayer, "FightVideo")

	local videoGO = gohelper.findChild(self._videoRootGO, "FightVideo")

	self._displauUGUI = gohelper.onceAddComponent(videoGO, typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	self._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
	self._avProVideoPlayer = gohelper.onceAddComponent(videoGO, typeof(ZProj.AvProUGUIPlayer))

	self._avProVideoPlayer:AddDisplayUGUI(self._displauUGUI)

	self._mediaPlayer = gohelper.onceAddComponent(videoGO, typeof(RenderHeads.Media.AVProVideo.MediaPlayer))

	self:_playVideo()
end

function FightVideoMgr:_playVideo()
	self:stop()

	self._isPlaying = true

	if self._avProVideoPlayer then
		gohelper.setActive(self._videoRootGO, true)

		local videoPath = langVideoUrl(self._videoName)

		self._avProVideoPlayer:LoadMedia(videoPath)
		self._avProVideoPlayer:Play(self._displauUGUI, false)

		self._mediaPlayer.PlaybackRate = FightModel.instance:getSpeed() * Time.timeScale

		if self._pause then
			self:pause()
		end
	end
end

function FightVideoMgr:stop()
	if self._isPlaying then
		self._pause = false
		self._isPlaying = false

		self:_stopVideo()
	end
end

function FightVideoMgr:pause()
	if self._avProVideoPlayer then
		gohelper.setActive(self._videoRootGO, false)
	else
		self._pause = true
	end
end

function FightVideoMgr:isPause()
	return self._pause
end

function FightVideoMgr:continue(resName)
	if self._videoName == resName and self._isPlaying then
		self._pause = false

		if self._avProVideoPlayer then
			gohelper.setActive(self._videoRootGO, true)
		end
	end
end

function FightVideoMgr:_stopVideo()
	if self._avProVideoPlayer then
		self._avProVideoPlayer:Stop()
		self._mediaPlayer:CloseMedia()
		gohelper.setActive(self._videoRootGO, false)
	end
end

FightVideoMgr.instance = FightVideoMgr.New()

return FightVideoMgr
