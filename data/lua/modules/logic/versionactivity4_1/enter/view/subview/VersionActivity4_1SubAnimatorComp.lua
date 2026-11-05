-- chunkname: @modules/logic/versionactivity4_1/enter/view/subview/VersionActivity4_1SubAnimatorComp.lua

module("modules.logic.versionactivity4_1.enter.view.subview.VersionActivity4_1SubAnimatorComp", package.seeall)

local VersionActivity4_1SubAnimatorComp = class("VersionActivity4_1SubAnimatorComp", VersionActivityFixedSubAnimatorComp)

function VersionActivity4_1SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity4_1SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity4_1SubAnimatorComp:playOpenAnim()
	if self.view.viewParam.skipOpenAnim then
		self.animator:Play(UIAnimationName.Open, 0, 1)

		self.view.viewParam.skipOpenAnim = false

		self.viewContainer:markPlayedSubViewAnim()

		return
	end

	if self.viewContainer:getIsFirstPlaySubViewAnim() then
		if self.view.viewParam.playVideo then
			self.viewContainer:markPlayedSubViewAnim()
			self.animator:Play("open1", 0, 0)

			self.animator.speed = 0

			self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
			self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
			self:addEventCb(VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		else
			self.viewContainer:markPlayedSubViewAnim()
			self.animator:Play("open1", 0, 0)

			self.animator.speed = 1
		end

		self:_playAudio(true)
	else
		self.animator:Play(UIAnimationName.Open, 0, 0)

		self.animator.speed = 1

		self:_playAudio(false)
	end
end

function VersionActivity4_1SubAnimatorComp:onPlayVideoDone()
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	if self.animator.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity4_1SubAnimatorComp:skipPlayVideo()
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	self:_playOpen1Anim()
end

function VersionActivity4_1SubAnimatorComp:_delayPlayOpen1Anim()
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	if self.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity4_1Enum.OpenAnimDelayTime)
end

function VersionActivity4_1SubAnimatorComp:_playOpen1Anim()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
end

function VersionActivity4_1SubAnimatorComp:_playAudio(isFirst)
	if not self.view.viewParam.isExitFight then
		if isFirst then
			AudioMgr.instance:trigger(AudioEnum4_1.EnterView.play_ui_atlantis_4_1_kv_open)
		else
			AudioMgr.instance:trigger(AudioEnum4_1.EnterView.play_ui_atlantis_4_1_kv_open2)
		end
	elseif not isFirst then
		AudioMgr.instance:trigger(AudioEnum4_1.EnterView.play_ui_atlantis_4_1_kv_open2)
	end
end

function VersionActivity4_1SubAnimatorComp:destroy()
	VersionActivity4_1SubAnimatorComp.super.destroy(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

return VersionActivity4_1SubAnimatorComp
