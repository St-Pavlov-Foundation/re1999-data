-- chunkname: @modules/logic/gm/view/GMVideoPlayViewContainer.lua

module("modules.logic.gm.view.GMVideoPlayViewContainer", package.seeall)

local GMVideoPlayViewContainer = class("GMVideoPlayViewContainer", BaseViewContainer)

function GMVideoPlayViewContainer:buildViews()
	return {}
end

function GMVideoPlayViewContainer:onContainerInit()
	self._clickMask = gohelper.findChildClick(self.viewGO, "clickMask")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._videoGO = gohelper.findChild(self.viewGO, "#go_video")

	gohelper.setActive(self._btnSkip.gameObject, false)
	self._clickMask:AddClickListener(self._onClickMask, self)
	self._btnSkip:AddClickListener(self.closeThis, self)
end

function GMVideoPlayViewContainer:onContainerDestroy()
	self._clickMask:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self:_stopMovie()
end

function GMVideoPlayViewContainer:onContainerOpen()
	local videoName = self.viewParam

	if not self._videoPlayer then
		self._videoPlayer, self._displauUGUI, self._videoPlayerGO = AvProMgr.instance:getVideoPlayer(self._videoGO)

		local uiVideoAdapter = MonoHelper.addNoUpdateLuaComOnceToGo(self._videoPlayerGO, FullScreenVideoAdapter)

		self._videoPlayerGO = nil
	end

	self._videoPlayer:Play(self._displauUGUI, langVideoUrl(videoName), false, self._videoStatusUpdate, self)
end

function GMVideoPlayViewContainer:_onClickMask()
	gohelper.setActive(self._btnSkip.gameObject, true)
end

function GMVideoPlayViewContainer:_videoStatusUpdate(path, status, errorCode)
	if status == AvProEnum.PlayerStatus.FinishedPlaying then
		self:closeThis()
	end
end

function GMVideoPlayViewContainer:_stopMovie()
	if self._videoPlayer then
		self._videoPlayer:Stop()
		self._videoPlayer:Clear()

		self._videoPlayer = nil
	end
end

return GMVideoPlayViewContainer
