﻿-- chunkname: @modules/logic/versionactivity3_0/enter/view/subview/VersionActivity3_0SubAnimatorComp.lua

module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0SubAnimatorComp", package.seeall)

local VersionActivity3_0SubAnimatorComp = class("VersionActivity3_0SubAnimatorComp", VersionActivitySubAnimatorComp)

function VersionActivity3_0SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity3_0SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity3_0SubAnimatorComp:playOpenAnim()
	local viewParam = self.view and self.view.viewParam

	if viewParam and viewParam.skipOpenAnim then
		self.animator:Play(UIAnimationName.Open, 0, 1)

		self.view.viewParam.skipOpenAnim = false

		self.viewContainer:markPlayedSubViewAnim()

		return
	end

	if self.viewContainer:getIsFirstPlaySubViewAnim() then
		self.viewContainer:markPlayedSubViewAnim()
	end

	if viewParam and viewParam.playVideo then
		self.animator.speed = 0

		self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	else
		self.animator.speed = 1

		self.animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function VersionActivity3_0SubAnimatorComp:onPlayVideoDone()
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
end

return VersionActivity3_0SubAnimatorComp
