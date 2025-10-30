﻿-- chunkname: @modules/logic/seasonver/act123/view2_1/component/Season123_2_1EntryCamera.lua

module("modules.logic.seasonver.act123.view2_1.component.Season123_2_1EntryCamera", package.seeall)

local Season123_2_1EntryCamera = class("Season123_2_1EntryCamera", UserDataDispose)

function Season123_2_1EntryCamera:init()
	self:__onInit()
	self:initCamera()
end

function Season123_2_1EntryCamera:dispose()
	self:killTween()
	self:__onDispose()
	MainCameraMgr.instance:addView(ViewName.Season123_2_1EntryView, nil, nil, nil)
end

function Season123_2_1EntryCamera:initCamera()
	if self._isInitCamera then
		return
	end

	self._isInitCamera = true
	self._seasonSize = SeasonEntryEnum.CameraSize
	self._seasonScale = 1

	MainCameraMgr.instance:addView(ViewName.Season123_2_1EntryView, self.onScreenResize, self.resetCamera, self)
	self:onScreenResize()
end

function Season123_2_1EntryCamera:onScreenResize()
	self:killTween()

	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true
	camera.orthographicSize = self:getCurrentOrthographicSize()
end

function Season123_2_1EntryCamera:setScaleWithoutTween(scale)
	local camera = CameraMgr.instance:getMainCamera()

	self._seasonScale = scale
	camera.orthographicSize = self:getCurrentOrthographicSize()
end

function Season123_2_1EntryCamera:tweenToScale(targetScale, time, callback, callbackObj)
	self:killTween()

	self._seasonScale = targetScale
	self._isScaleTweening = true
	self._tweenScaleId = nil

	local curSize = self:getCurrentOrthographicSize()

	if curSize <= 0 then
		curSize = 0.1
	end

	local camera = CameraMgr.instance:getMainCamera()
	local curScale = camera.orthographicSize / curSize

	self._focusFinishCallback = callback
	self._focusFinishCallbackObj = callbackObj
	self._tweenScaleId = ZProj.TweenHelper.DOTweenFloat(camera.orthographicSize, curSize, time, self.onTweenSizeUpdate, self.onTweenFinish, self, nil, EaseType.OutCubic)
end

function Season123_2_1EntryCamera:killTween()
	self._isScaleTweening = false

	if self._tweenScaleId then
		ZProj.TweenHelper.KillById(self._tweenScaleId)

		self._tweenScaleId = nil
	end
end

function Season123_2_1EntryCamera:onTweenSizeUpdate(value)
	local camera = CameraMgr.instance:getMainCamera()

	if camera then
		camera.orthographicSize = value
	end
end

function Season123_2_1EntryCamera:onTweenFinish()
	if self._focusFinishCallback then
		self._focusFinishCallback(self._focusFinishCallbackObj)

		self._focusFinishCallback = nil
		self._focusFinishCallbackObj = nil
	end
end

function Season123_2_1EntryCamera:getCurrentOrthographicSize()
	local scale = GameUtil.getAdapterScale(true)

	return self._seasonSize * scale * self._seasonScale
end

return Season123_2_1EntryCamera
