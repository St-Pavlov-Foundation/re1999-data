﻿-- chunkname: @modules/logic/commandstation/model/CommandStationMapModel.lua

module("modules.logic.commandstation.model.CommandStationMapModel", package.seeall)

local CommandStationMapModel = class("CommandStationMapModel", BaseModel)

function CommandStationMapModel:onInit()
	self:reInit()
end

function CommandStationMapModel:reInit()
	self._eventCategory = nil
	self._timeId = nil
	self._versionId = nil
	self._timelineIsCharacterMode = false
	self._characterId = nil
	self._preloadScene = nil
	self._preloadSceneLoader = nil
	self._preloadView = nil
end

function CommandStationMapModel:setVersionId(versionId)
	if versionId then
		CommandStationController.setSaveNumber(CommandStationEnum.PrefsKey.Version, versionId)
	end

	self._versionId = versionId
end

function CommandStationMapModel:getVersionId()
	if not self._versionId then
		local versionId = CommandStationController.getSaveNumber(CommandStationEnum.PrefsKey.Version)

		if versionId and lua_copost_version.configDict[versionId] then
			self._versionId = versionId
		end
	end

	return self._versionId or CommandStationEnum.AllVersion
end

function CommandStationMapModel:setEventCategory(eventCategory)
	self._eventCategory = eventCategory
end

function CommandStationMapModel:getEventCategory()
	return self._eventCategory
end

function CommandStationMapModel:getVersionTimeline(versionId)
	local timeline = CommandStationConfig.instance:getVersionTimeline(versionId)

	return self:checkTimeline(timeline)
end

function CommandStationMapModel:checkTimeline(timeline)
	local result = {}
	local firstTimeId

	for _, v in ipairs(timeline) do
		local timeIdList = {}

		for i, timeId in ipairs(v.timeId) do
			local episodeId = CommandStationConfig.instance:getTimePointEpisodeId(timeId)

			if DungeonModel.instance:hasPassLevelAndStory(episodeId) then
				table.insert(timeIdList, timeId)
			end

			firstTimeId = firstTimeId or timeId
		end

		if #timeIdList > 0 then
			table.insert(result, {
				id = v.id,
				timeId = timeIdList
			})
		end
	end

	return result, firstTimeId
end

function CommandStationMapModel:initTimeId()
	local result, resultString = pcall(self._internalInitTimeId, self)

	if not result then
		self:setVersionId(CommandStationEnum.AllVersion)
		self:setTimeId(CommandStationEnum.FirstTimeId)
		logError(string.format("CommandStationMapModel:initTimeId error:%s", resultString))
	end
end

function CommandStationMapModel:_internalInitTimeId()
	local timeline, firstTimeId = self:getVersionTimeline(self:getVersionId())
	local timeId = self._timeId or CommandStationController.getSaveNumber(CommandStationEnum.PrefsKey.TimeId)

	self._timeId = nil

	if timeId then
		local isFind = false

		for i, v in ipairs(timeline) do
			local index = tabletool.indexOf(v.timeId, timeId)

			if index then
				isFind = true

				break
			end
		end

		if not isFind then
			timeId = nil
		end
	end

	if not timeId then
		local firstTimeGroup = timeline[1]

		if firstTimeGroup then
			timeId = firstTimeGroup.timeId[1]
		end
	end

	timeId = timeId or firstTimeId
	self._timeId = timeId
end

function CommandStationMapModel:setTimeId(timeId)
	self._timeId = timeId

	if timeId then
		CommandStationController.setSaveNumber(CommandStationEnum.PrefsKey.TimeId, timeId)
	end
end

function CommandStationMapModel:getTimeId()
	return self._timeId
end

function CommandStationMapModel:getCurTimeIdScene()
	local timeId = self._timeId
	local timeGroupConfig = CommandStationConfig.instance:getTimeGroupByTimeId(timeId)
	local sceneId = timeGroupConfig.sceneId
	local sceneConfig = CommandStationConfig.instance:getSceneConfig(sceneId)

	return sceneConfig
end

function CommandStationMapModel:setTimelineCharacterMode(value)
	self._timelineCharacterMode = value
end

function CommandStationMapModel:isTimelineCharacterMode()
	return self._timelineCharacterMode
end

function CommandStationMapModel:setCharacterId(id)
	self._characterId = id
end

function CommandStationMapModel:getCharacterId()
	return self._characterId
end

function CommandStationMapModel:clearSceneInfo()
	self._sceneGo = nil

	self:clearSceneNodeList()
end

function CommandStationMapModel:clearSceneNodeList()
	if self._sceneNodeList then
		tabletool.clear(self._sceneNodeList)
	end
end

function CommandStationMapModel:setSceneGo(sceneGo)
	self:clearSceneInfo()

	self._sceneGo = sceneGo
	self._sceneNodeList = {}
end

function CommandStationMapModel:getSceneNode(name)
	local node = self._sceneNodeList[name]

	if gohelper.isNil(node) then
		node = UnityEngine.GameObject.New(tostring(name))

		gohelper.addChild(self._sceneGo, node)

		self._sceneNodeList[name] = node
	end

	return node
end

function CommandStationMapModel:setPreloadScene(loader, sceneGo)
	self._preloadScene = sceneGo
	self._preloadSceneLoader = loader
end

function CommandStationMapModel:getPreloadScene()
	return self._preloadScene
end

function CommandStationMapModel:getPreloadSceneLoader()
	return self._preloadSceneLoader
end

function CommandStationMapModel:setPreloadView(go)
	self._preloadView = go
end

function CommandStationMapModel:getPreloadView()
	return self._preloadView
end

CommandStationMapModel.instance = CommandStationMapModel.New()

return CommandStationMapModel
