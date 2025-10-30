﻿-- chunkname: @modules/logic/versionactivity3_2/enter/view/subview/VersionActivity3_2SubAnimatorComp.lua

module("modules.logic.versionactivity3_2.enter.view.subview.VersionActivity3_2SubAnimatorComp", package.seeall)

local VersionActivity3_2SubAnimatorComp = class("VersionActivity3_2SubAnimatorComp", VersionActivityFixedSubAnimatorComp)

function VersionActivity3_2SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity3_2SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity3_2SubAnimatorComp:playOpenAnim()
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
	else
		self.animator:Play(UIAnimationName.Open, 0, 0)

		self.animator.speed = 1
	end
end

function VersionActivity3_2SubAnimatorComp:onPlayVideoDone()
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	if self.animator.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_2SubAnimatorComp:_delayPlayOpen1Anim()
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	if self.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, 4)
end

function VersionActivity3_2SubAnimatorComp:_playOpen1Anim()
	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
end

function VersionActivity3_2SubAnimatorComp:destroy()
	VersionActivity3_2SubAnimatorComp.super.destroy(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

return VersionActivity3_2SubAnimatorComp
