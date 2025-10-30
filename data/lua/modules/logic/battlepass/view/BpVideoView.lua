-- chunkname: @modules/logic/battlepass/view/BpVideoView.lua

module("modules.logic.battlepass.view.BpVideoView", package.seeall)

local BpVideoView = class("BpVideoView", BaseView)

function BpVideoView:onInitView()
	self._videoGo = gohelper.findChild(self.viewGO, "#go_video")
end

function BpVideoView:onOpen()
	self._videoPlayer, self._displauUGUI = AvProMgr.instance:getVideoPlayer(self._videoGo)

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_admission)
	self._videoPlayer:Play(self._displauUGUI, "videos/bp_open.mp4", false, self._videoStatusUpdate, self)
end

function BpVideoView:_videoStatusUpdate(path, status, errorCode)
	if status == AvProEnum.PlayerStatus.FinishedPlaying then
		if not ViewMgr.instance:isOpen(ViewName.BpChargeView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.closeThis, self)
			ViewMgr.instance:openView(ViewName.BpChargeView, {
				first = true
			})
		else
			self:closeThis()
		end
	end
end

function BpVideoView:onDestroyView()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.closeThis, self)

	if self._videoPlayer then
		self._videoPlayer:Stop()
		self._videoPlayer:Clear()

		self._videoPlayer = nil
	end
end

return BpVideoView
