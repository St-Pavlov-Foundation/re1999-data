-- chunkname: @modules/logic/versionactivity4_1/enter/view/VersionActivity4_1EnterBgmView.lua

module("modules.logic.versionactivity4_1.enter.view.VersionActivity4_1EnterBgmView", package.seeall)

local VersionActivity4_1EnterBgmView = class("VersionActivity4_1EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity4_1EnterBgmView:addEvents()
	VersionActivity4_1EnterBgmView.super.addEvents(self)
	self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self, LuaEventSystem.Low)
	self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self, LuaEventSystem.Low)
end

function VersionActivity4_1EnterBgmView:removeEvents()
	VersionActivity4_1EnterBgmView.super.removeEvents(self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
end

function VersionActivity4_1EnterBgmView:modifyBgm(actId)
	local enum = VersionActivityFixedHelper.getVersionActivityEnum()

	self._isMainAct = actId == enum.ActivityId.Dungeon

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._doModifyBgm, self)

	if not self.viewParam.isExitFight or not self.viewParam or not self.viewParam.playVideo or not self._isFirstOpenMainAct then
		self:_doModifyBgm()
	end
end

function VersionActivity4_1EnterBgmView:onPlayVideoDone()
	self:_doModifyBgm()
end

function VersionActivity4_1EnterBgmView:initActHandle()
	if not self.actHandleDict then
		self.actHandleDict = {}
	end
end

return VersionActivity4_1EnterBgmView
