﻿-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateOutsideModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateOutsideModel", package.seeall)

local EliminateOutsideModel = class("EliminateOutsideModel", BaseModel)

function EliminateOutsideModel:onInit()
	self:reInit()
end

function EliminateOutsideModel:reInit()
	self._selectedEpisodeId = nil
	self._selectedCharacterId = nil
	self._selectedPieceId = nil
	self._totalStar = 0
	self._gainedTaskId = {}
	self._chapterList = {}
	self._ownedWarChessCharacterId = {}
	self._ownedWarChessPieceId = {}
	self._episodeInfo = {}
end

function EliminateOutsideModel:initTaskInfo(totalStar, gainedTaskId)
	self._totalStar = totalStar
	self._gainedTaskId = {}

	for _, id in ipairs(gainedTaskId) do
		self._gainedTaskId[id] = id
	end
end

function EliminateOutsideModel:initMapInfo(ownedWarChessCharacterId, ownedWarChessPieceId, episodeInfo, unlockSlotId)
	self._ownedWarChessCharacterId = {}
	self._ownedWarChessPieceId = {}
	self._episodeInfo = {}
	self._unlockSlotNum = #unlockSlotId

	for _, id in ipairs(ownedWarChessCharacterId) do
		self._ownedWarChessCharacterId[id] = id
	end

	for _, id in ipairs(ownedWarChessPieceId) do
		self._ownedWarChessPieceId[id] = id
	end

	for _, v in ipairs(episodeInfo) do
		local mo = self._episodeInfo[v.id] or WarEpisodeInfo.New()

		mo:init(v)

		self._episodeInfo[v.id] = mo
	end

	self:_initChapterList()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.OnUpdateEpisodeInfo)
end

function EliminateOutsideModel:_initChapterList()
	self._chapterList = {}

	for i, v in ipairs(lua_eliminate_episode.configList) do
		local list = self._chapterList[v.chapterId] or {}

		self._chapterList[v.chapterId] = list

		local mo = self._episodeInfo[v.id] or WarEpisodeInfo.New()

		mo:initFromParam(v.id, mo.star or 0)

		self._episodeInfo[mo.id] = mo

		table.insert(list, mo)
	end
end

function EliminateOutsideModel:getChapterList()
	return self._chapterList
end

function EliminateOutsideModel:getUnlockSlotNum()
	return self._unlockSlotNum
end

function EliminateOutsideModel:getTotalStar()
	return self._totalStar
end

function EliminateOutsideModel:addGainedTask(taskId)
	if taskId == 0 then
		for i, config in ipairs(lua_eliminate_reward.configList) do
			if self._totalStar >= config.star then
				self._gainedTaskId[config.id] = config.id
			end
		end

		return
	end

	self._gainedTaskId[taskId] = taskId
end

function EliminateOutsideModel:gainedTask(taskId)
	return self._gainedTaskId[taskId] ~= nil
end

function EliminateOutsideModel:hasCharacter(characterId)
	return self._ownedWarChessCharacterId[characterId] ~= nil
end

function EliminateOutsideModel:hasChessPiece(pieceId)
	return self._ownedWarChessPieceId[pieceId] ~= nil
end

function EliminateOutsideModel:hasPassedEpisode(episodeId)
	local mo = self._episodeInfo[episodeId]

	return mo and mo.star > 0
end

EliminateOutsideModel.instance = EliminateOutsideModel.New()

return EliminateOutsideModel
