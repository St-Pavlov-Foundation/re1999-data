﻿-- chunkname: @modules/logic/dungeon/model/DungeonMapModel.lua

module("modules.logic.dungeon.model.DungeonMapModel", package.seeall)

local DungeonMapModel = class("DungeonMapModel", BaseModel)

function DungeonMapModel:onInit()
	self:reInit()
end

function DungeonMapModel:reInit()
	self._mapIds = {}
	self._elements = {}
	self._rewardPointInfoList = {}
	self._curMap = nil
	self._dialogHistory = {}
	self._dialogIdHistory = {}
	self._equipSpChapters = {}
	self.lastElementBattleId = nil
	self.playAfterStory = nil
	self._finishElements = {}
	self.focusEpisodeTweenDuration = nil
	self.directFocusElement = nil
	self.preloadMapCfg = nil
	self._puzzleStatusMap = nil
	self._mapInteractiveItemVisible = nil
	self._focusElementId = nil
	self._elementRecordInfos = {}
end

function DungeonMapModel:setFocusElementId(elementId)
	self._focusElementId = elementId
end

function DungeonMapModel:getFocusElementId()
	return self._focusElementId
end

function DungeonMapModel:addDialog(type, text, speaker, audio)
	table.insert(self._dialogHistory, {
		type,
		text,
		speaker,
		audio
	})
end

function DungeonMapModel:getDialog()
	return self._dialogHistory
end

function DungeonMapModel:clearDialog()
	self._dialogHistory = {}
end

function DungeonMapModel:addDialogId(dialogId)
	table.insert(self._dialogIdHistory, dialogId)
end

function DungeonMapModel:getDialogId()
	return self._dialogIdHistory
end

function DungeonMapModel:clearDialogId()
	self._dialogIdHistory = {}
end

function DungeonMapModel:updateMapIds(values)
	for i, v in ipairs(values) do
		self._mapIds[v] = v
	end
end

function DungeonMapModel:mapIsUnlock(id)
	return self._mapIds[id]
end

function DungeonMapModel:getElementById(id)
	return self._elements[id]
end

function DungeonMapModel:addFinishedElement(id)
	self._finishElements[id] = true
end

function DungeonMapModel:addFinishedElements(list)
	for i, v in ipairs(list) do
		self._finishElements[v] = true
	end
end

function DungeonMapModel:elementIsFinished(id)
	return self._finishElements[id]
end

function DungeonMapModel:getNewElements()
	return self._newElements
end

function DungeonMapModel:clearNewElements()
	self._newElements = nil
end

function DungeonMapModel:setNewElements(values)
	self._newElements = values
end

function DungeonMapModel:addElements(values)
	for i, v in ipairs(values) do
		self._elements[v] = v
	end
end

function DungeonMapModel:removeElement(id)
	self._elements[id] = nil
end

function DungeonMapModel:getAllElements()
	return self._elements
end

function DungeonMapModel:getElements(mapId)
	local result = {}

	for i, v in pairs(self._elements) do
		local cfg = DungeonConfig.instance:getChapterMapElement(v)

		if VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(v) and DungeonConfig.instance:isActivity1_2Map(mapId) then
			table.insert(result, cfg)
		elseif cfg and cfg.mapId == mapId then
			local isShowElement = true

			if ToughBattleConfig.instance:isActEleCo(cfg) and not ToughBattleModel.instance:getActIsOnline() then
				isShowElement = false
			end

			if isShowElement then
				table.insert(result, cfg)
			end
		end
	end

	return result
end

function DungeonMapModel:initEquipSpChapters(info)
	self._equipSpChapters = {}

	for i, v in ipairs(info) do
		table.insert(self._equipSpChapters, v)
	end
end

function DungeonMapModel:updateEquipSpChapter(id, isDelete)
	if isDelete == false then
		table.insert(self._equipSpChapters, id)

		return
	end

	tabletool.removeValue(self._equipSpChapters, id)
	DungeonModel.instance:resetEpisodeInfoByChapterId(id)
end

function DungeonMapModel:getEquipSpChapters()
	return self._equipSpChapters
end

function DungeonMapModel:isUnlockSpChapter(chapterId)
	return tabletool.indexOf(self._equipSpChapters, chapterId)
end

function DungeonMapModel:updateRewardPoint(chapterId, value)
	local info = self:getRewardPointInfo(chapterId)

	if info then
		info:setRewardPoint(value)
	end
end

function DungeonMapModel:initRewardPointInfo(info)
	for i, v in ipairs(info) do
		local mo = RewardPointInfoMO.New()

		mo:init(v)

		self._rewardPointInfoList[mo.chapterId] = mo
	end
end

function DungeonMapModel:getTotalRewardPointProgress(chapterId)
	local cur, max = self:_getRewardPointProgress(chapterId)

	return cur, max
end

function DungeonMapModel:_getRewardPointProgress(chapterId)
	if not chapterId or chapterId <= 0 then
		return 0, 0
	end

	local rewardPointValue = DungeonMapModel.instance:getRewardPointValue(chapterId)
	local pointRewardCfg = DungeonConfig.instance:getChapterPointReward(chapterId)

	if not pointRewardCfg then
		local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

		return self:_getRewardPointProgress(chapterConfig.preChapter)
	end

	local lastConfig = pointRewardCfg[#pointRewardCfg]
	local maxNum = lastConfig.rewardPointNum
	local curNum = math.min(rewardPointValue, maxNum)

	return curNum, maxNum
end

function DungeonMapModel:getRewardPointInfo(chapterId)
	chapterId = 0

	return self._rewardPointInfoList[chapterId]
end

function DungeonMapModel:getRewardPointValue(chapterId)
	local pointRewardInfo = self:getRewardPointInfo(chapterId)

	return pointRewardInfo and pointRewardInfo.rewardPoint or 0
end

function DungeonMapModel:addRewardPoint(elementId)
	local elementConfig = lua_chapter_map_element.configDict[elementId]

	if elementConfig.rewardPoint <= 0 then
		return
	end

	local mapConfig = lua_chapter_map.configDict[elementConfig.mapId]
	local info = self:getRewardPointInfo(mapConfig.chapterId)

	info.rewardPoint = info.rewardPoint + elementConfig.rewardPoint
end

function DungeonMapModel:addPointRewardIds(list)
	for i, id in ipairs(list) do
		local config = lua_chapter_point_reward.configDict[id]
		local info = self:getRewardPointInfo(config.chapterId)

		table.insert(info.hasGetPointRewardIds, id)
	end
end

function DungeonMapModel:getUnfinishedTargetReward()
	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo()
	local targetReward

	for i, v in ipairs(lua_chapter_point_reward.configList) do
		if v.display > 0 then
			targetReward = v

			if pointRewardInfo.rewardPoint < targetReward.rewardPointNum or not tabletool.indexOf(pointRewardInfo.hasGetPointRewardIds, targetReward.id) then
				break
			end
		end
	end

	return targetReward
end

function DungeonMapModel:canGetAllRewardsList()
	local lastConfig = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList]
	local maxChapterId = lastConfig.chapterId
	local rewardList = DungeonMapModel.instance:canGetRewardsList(maxChapterId)

	return rewardList
end

function DungeonMapModel:canGetRewardsList(maxChapterId)
	local rewardList = {}

	for i = 101, maxChapterId do
		local rewards = DungeonMapModel.instance:canGetRewards(i)

		tabletool.addValues(rewardList, rewards)
	end

	return rewardList
end

function DungeonMapModel:canGetRewards(chapterId)
	local pointRewardInfo = self:getRewardPointInfo(chapterId)

	if not pointRewardInfo then
		return nil
	end

	local rewardPoint = pointRewardInfo.rewardPoint

	if rewardPoint <= 0 then
		return nil
	end

	local result = {}
	local rewards = DungeonConfig.instance:getChapterPointReward(chapterId)

	if not rewards then
		return result
	end

	for i, v in ipairs(rewards) do
		if v.rewardPointNum > 0 and rewardPoint >= v.rewardPointNum and not tabletool.indexOf(pointRewardInfo.hasGetPointRewardIds, v.id) then
			table.insert(result, v.id)
		end
	end

	return result
end

function DungeonMapModel:isUnFinishedElement(chapterId)
	local list = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)
	local map = DungeonConfig.instance:getChapterMapCfg(chapterId, 0)

	if self:_getMapElementsNum(map) > 0 then
		return true
	end

	for i, config in ipairs(list) do
		map = DungeonConfig.instance:getChapterMapCfg(config.chapterId, config.id)

		if self:_getMapElementsNum(map) > 0 then
			return true
		end
	end

	return false
end

function DungeonMapModel:_getMapElementsNum(map)
	if map and DungeonMapModel.instance:mapIsUnlock(map.id) then
		local elementsList = DungeonMapModel.instance:getElements(map.id)
		local count = 0

		for i, config in ipairs(elementsList) do
			if not string.nilorempty(config.effect) then
				count = count + 1
			end
		end

		return count
	end

	return 0
end

function DungeonMapModel:getChapterLastMap(chapterId, targetEpisodeId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)
	local curMap, isMatched

	for i, config in ipairs(episodeList) do
		local info = DungeonModel.instance:getEpisodeInfo(config.id)

		if info and info.isNew then
			local map = DungeonConfig.instance:getChapterMapCfg(chapterId, config.id)

			if map then
				curMap = map

				break
			end
		end

		isMatched = config.id == targetEpisodeId

		if not isMatched and DungeonModel.instance:hasPassLevelAndStory(config.id) then
			local map = DungeonConfig.instance:getChapterMapCfg(chapterId, config.id)

			if map then
				curMap = map
			end
		end
	end

	curMap = curMap or DungeonConfig.instance:getChapterMapCfg(chapterId, 0)

	return curMap
end

function DungeonMapModel:initMapPuzzleStatus(puzzleStatusList)
	self._puzzleStatusMap = {}

	if puzzleStatusList then
		for _, elementId in ipairs(puzzleStatusList) do
			self._puzzleStatusMap[elementId] = true
		end
	end
end

function DungeonMapModel:hasMapPuzzleStatus(elementId)
	return self._puzzleStatusMap ~= nil and self._puzzleStatusMap[elementId]
end

function DungeonMapModel:setPuzzleStatus(elementId)
	self._puzzleStatusMap = self._puzzleStatusMap or {}
	self._puzzleStatusMap[elementId] = true
end

function DungeonMapModel:setMapInteractiveItemVisible(value)
	self._mapInteractiveItemVisible = value
end

function DungeonMapModel:getMapInteractiveItemVisible()
	return self._mapInteractiveItemVisible
end

function DungeonMapModel:updateRecordInfos(recordInfos)
	if not recordInfos then
		return
	end

	for i, v in ipairs(recordInfos) do
		self:updateRecordInfo(v.elementId, v.record)
	end
end

function DungeonMapModel:updateRecordInfo(id, record)
	if not id or string.nilorempty(record) then
		return
	end

	self._elementRecordInfos[id] = record
end

function DungeonMapModel:getRecordInfo(id)
	return self._elementRecordInfos[id]
end

DungeonMapModel.instance = DungeonMapModel.New()

return DungeonMapModel
