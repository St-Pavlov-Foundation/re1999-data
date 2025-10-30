﻿-- chunkname: @modules/logic/login/view/LoginVideoView.lua

module("modules.logic.login.view.LoginVideoView", package.seeall)

local LoginVideoView = class("LoginVideoView", BaseView)

function LoginVideoView:onInitView()
	self._goBgRoot = gohelper.findChild(self.viewGO, "#go_bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoginVideoView:_editableInitView()
	self._isShowVideo = LoginPageController.instance:isShowLoginVideo()
end

function LoginVideoView:onOpenFinish()
	self._isShowVideo = false

	local pageCfg = LoginPageController.instance:getCurPageCfg()

	self._videoName = pageCfg and pageCfg.video

	if not string.nilorempty(self._videoName) then
		self._isShowVideo = true

		LoginController.instance:dispatchEvent(LoginEvent.OnLoginBgLoaded)
	end

	if self._isShowVideo and not self._videoPlayer then
		self._videoPlayer, self._displayUGUI, self._videoGo = AvProMgr.instance:getVideoPlayer(self.viewGO, "voideplayer")

		gohelper.setSiblingAfter(self._videoGo, self._goBgRoot)
		self:play()
		self:addEventCb(self.viewContainer, LoginEvent.OnLoginVideoSwitch, self._playByPath, self)

		local bgAdapter = self._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

		if bgAdapter then
			bgAdapter.enabled = false
		end
	end
end

function LoginVideoView:onDestroyView()
	if self._videoPlayer then
		self._videoPlayer:Stop()
		self._videoPlayer:Clear()

		self._videoPlayer = nil
		self._videoGo = nil
	end
end

function LoginVideoView:play()
	local videlPath = CommonConfig.instance:getConstStr(ConstEnum.LoginViewVideoPathId)

	self:_playByPath(langVideoUrl(videlPath))
end

function LoginVideoView:_playByPath(videoPath)
	if not videoPath or string.nilorempty(videoPath) or self._curPlayVideoPath == videoPath then
		return
	end

	if self._videoPlayer then
		self._curPlayVideoPath = videoPath

		self._videoPlayer:Play(self._displayUGUI, videoPath, true, self._videoStatusUpdate, self)
	end
end

function LoginVideoView:_videoStatusUpdate(path, status, errorCode)
	if (status == AvProEnum.PlayerStatus.Error or errorCode ~= AvProEnum.ErrorCode.None) and not gohelper.isNil(self._videoGo) then
		gohelper.setActive(self._videoGo, false)
	end
end

return LoginVideoView
