﻿-- chunkname: @modules/logic/versionactivity2_1/dungeon/controller/VersionActivity2_1DungeonController.lua

module("modules.logic.versionactivity2_1.dungeon.controller.VersionActivity2_1DungeonController", package.seeall)

local VersionActivity2_1DungeonController = class("VersionActivity2_1DungeonController", BaseController)

function VersionActivity2_1DungeonController:onInit()
	return
end

function VersionActivity2_1DungeonController:reInit()
	VersionActivityDungeonBaseController.instance:clearChapterIdLastSelectEpisodeId()
end

function VersionActivity2_1DungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity2_1DungeonController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_1TaskView)
end

function VersionActivity2_1DungeonController:openStoreView()
	local actId = VersionActivity2_1Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivity2_1DungeonController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_1StoreView)
end

function VersionActivity2_1DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self.dungeonMapViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.openMapViewCallback = callback
	self.openMapViewCallbackObj = callbackObj

	VersionActivity2_1DungeonModel.instance:init()

	self.hasReceivedTaskInfo = false

	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._onReceiveTaskInfoReply, self)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity2_1Enum.ActivityId.Dungeon)
end

function VersionActivity2_1DungeonController:_onReceiveTaskInfoReply()
	self.hasReceivedTaskInfo = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity2_1DungeonController:_internalOpenVersionActivityDungeonMapView()
	if not self.hasReceivedTaskInfo then
		return
	end

	self.hasReceivedTaskInfo = false

	if not self.dungeonMapViewParam.episodeId then
		local unFinishEpisodeId = VersionActivity2_1DungeonModel.instance:getUnFinishElementEpisodeId()
		local unfinishStoryElementList = VersionActivity2_1DungeonModel.instance:getUnFinishStoryElements()
		local unfinishStoryEpisodeId

		if unfinishStoryElementList and #unfinishStoryElementList > 0 then
			unfinishStoryEpisodeId = DungeonConfig.instance:getEpisodeByElement(unfinishStoryElementList[1])
		end

		if unfinishStoryEpisodeId then
			self.dungeonMapViewParam.episodeId = unfinishStoryEpisodeId
		elseif unFinishEpisodeId > 0 then
			self.dungeonMapViewParam.episodeId = unFinishEpisodeId
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapView, self.dungeonMapViewParam)
end

function VersionActivity2_1DungeonController:onVersionActivityDungeonMapViewOpen()
	if not self.openMapViewCallback then
		return
	end

	self.openMapViewCallback(self.openMapViewCallbackObj)

	self.openMapViewCallback = nil
	self.openMapViewCallbackObj = nil
end

local function prefabKeyAddActId(key)
	if string.nilorempty(key) then
		return key
	end

	local result = string.format("2_0Dungeon_%s_%s", VersionActivity2_1Enum.ActivityId.Dungeon, key)

	return result
end

function VersionActivity2_1DungeonController:savePlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(uniqueKey, value)
	else
		GameUtil.playerPrefsSetStringByUserId(uniqueKey, value)
	end
end

function VersionActivity2_1DungeonController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	if isNumber then
		value = GameUtil.playerPrefsGetNumberByUserId(uniqueKey, value)
	else
		value = GameUtil.playerPrefsGetStringByUserId(uniqueKey, value)
	end

	return value
end

function VersionActivity2_1DungeonController:loadDictFromStr(jsonStr)
	local result = {}

	if not string.nilorempty(jsonStr) then
		result = cjson.decode(jsonStr)
	end

	return result
end

VersionActivity2_1DungeonController.instance = VersionActivity2_1DungeonController.New()

return VersionActivity2_1DungeonController
