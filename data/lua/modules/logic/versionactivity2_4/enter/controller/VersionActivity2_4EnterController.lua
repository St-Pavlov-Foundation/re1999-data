﻿-- chunkname: @modules/logic/versionactivity2_4/enter/controller/VersionActivity2_4EnterController.lua

module("modules.logic.versionactivity2_4.enter.controller.VersionActivity2_4EnterController", package.seeall)

local VersionActivity2_4EnterController = class("VersionActivity2_4EnterController", BaseController)

function VersionActivity2_4EnterController:_internalOpenView(viewName, actId, customerOpenFunc, customerOpenFuncObj, viewParams, openCb, openCbObj)
	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	if customerOpenFunc then
		customerOpenFunc(customerOpenFuncObj, viewName, actId, viewParams)
	else
		ViewMgr.instance:openView(viewName, viewParams)

		if openCb then
			openCb(openCbObj)
		end
	end
end

function VersionActivity2_4EnterController:_internalOpenEnterView(viewName, actId, viewParams)
	local hasPlayedVideo = VersionActivityBaseController.instance:isPlayedActivityVideo(actId)

	if hasPlayedVideo then
		ViewMgr.instance:openView(viewName, viewParams)

		if self.openEnterViewCb then
			self.openEnterViewCb(self.openEnterViewCbObj)

			self.openEnterViewCb = nil
			self.openEnterViewCbObj = nil
		end
	else
		local activityMo = ActivityModel.instance:getActMO(actId)
		local storyId = activityMo and activityMo.config and activityMo.config.storyId

		if not storyId then
			storyId = 100010

			logError(string.format("act id %s dot config story id", storyId))
		end

		local storyParam = {
			isVersionActivityPV = true
		}
		local storyFinishParams = {
			actId = actId,
			viewName = viewName,
			viewParams = viewParams
		}

		StoryController.instance:playStory(storyId, storyParam, self._onFinishEnterStory, self, storyFinishParams)
	end
end

function VersionActivity2_4EnterController:_onFinishEnterStory(storyFinishParams)
	local enterViewActId = storyFinishParams.actId

	if not VersionActivityEnterHelper.checkCanOpen(enterViewActId) then
		return
	end

	self:_internalOpenEnterView(storyFinishParams.viewName, enterViewActId, storyFinishParams.viewParams)
end

function VersionActivity2_4EnterController:openVersionActivityEnterViewIfNotOpened(openCb, openCbObj, jumpActId, isDirectOpen)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_4EnterView) then
		if openCb then
			openCb(openCbObj)
		end
	else
		self:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	end
end

function VersionActivity2_4EnterController:directOpenVersionActivityEnterView(jumpActId)
	self:openVersionActivityEnterView(nil, nil, jumpActId, true)
end

function VersionActivity2_4EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivity2_4Enum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity2_4Enum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivity2_4Enum.EnterViewActSetting
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView
	end

	local viewName = ViewName.VersionActivity2_4EnterView

	self:_internalOpenView(viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
end

VersionActivity2_4EnterController.instance = VersionActivity2_4EnterController.New()

return VersionActivity2_4EnterController
