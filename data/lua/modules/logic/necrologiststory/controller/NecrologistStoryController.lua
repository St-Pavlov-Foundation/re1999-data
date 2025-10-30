﻿-- chunkname: @modules/logic/necrologiststory/controller/NecrologistStoryController.lua

module("modules.logic.necrologiststory.controller.NecrologistStoryController", package.seeall)

local NecrologistStoryController = class("NecrologistStoryController", BaseController)

function NecrologistStoryController:onInit()
	return
end

function NecrologistStoryController:addConstEvents()
	return
end

function NecrologistStoryController:reInit()
	return
end

function NecrologistStoryController:openTipView(tagId, clickPosition)
	local viewParam = {}

	viewParam.tagId = tagId
	viewParam.clickPosition = clickPosition

	ViewMgr.instance:openView(ViewName.NecrologistStoryTipView, viewParam)
end

function NecrologistStoryController:closeGameView(storyId)
	if not storyId or storyId == 0 then
		return
	end

	local viewName = NecrologistStoryEnum.StoryId2GameView[storyId]

	if not viewName then
		return
	end

	ViewMgr.instance:closeView(viewName)
end

function NecrologistStoryController:openGameView(storyId)
	if not storyId or storyId == 0 then
		return
	end

	self._curStoryId = storyId

	local mo = RoleStoryModel.instance:getMoById(storyId)

	if not mo then
		return
	end

	if mo.hasUnlock then
		self:_onUnlockStory(0, 0)
	else
		HeroStoryRpc.instance:sendUnlocHeroStoryRequest(storyId, self._onUnlockStory, self)
	end
end

function NecrologistStoryController:_onUnlockStory(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	if not self._curStoryId then
		return
	end

	NecrologistStoryRpc.instance:sendGetNecrologistStoryRequest(self._curStoryId, self._openCurView, self)
end

function NecrologistStoryController:_openCurView(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	if not self._curStoryId then
		return
	end

	local viewName = NecrologistStoryEnum.StoryId2GameView[self._curStoryId]

	if not viewName then
		return
	end

	ViewMgr.instance:openView(viewName, {
		roleStoryId = self._curStoryId
	})
end

function NecrologistStoryController:openStoryView(storyGroupId, roleStoryId)
	ViewMgr.instance:openView(ViewName.NecrologistStoryView, {
		storyGroupId = storyGroupId,
		roleStoryId = roleStoryId
	})
end

function NecrologistStoryController:openTaskView(roleStoryId)
	ViewMgr.instance:openView(ViewName.NecrologistStoryTaskView, {
		roleStoryId = roleStoryId
	})
end

function NecrologistStoryController:openReviewView(roleStoryId)
	ViewMgr.instance:openView(ViewName.NecrologistStoryReviewView, {
		roleStoryId = roleStoryId
	})
end

function NecrologistStoryController:openCgUnlockView(roleStoryId)
	ViewMgr.instance:openView(ViewName.NecrologistStoryReviewView, {
		cgUnlock = true,
		roleStoryId = roleStoryId
	})
end

function NecrologistStoryController:getNecrologistStoryActivityRed(storyId)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.NecrologistStoryTask, storyId)
end

NecrologistStoryController.instance = NecrologistStoryController.New()

return NecrologistStoryController
