﻿-- chunkname: @modules/logic/roleactivity/model/RoleActivityModel.lua

module("modules.logic.roleactivity.model.RoleActivityModel", package.seeall)

local RoleActivityModel = class("RoleActivityModel", BaseModel)

function RoleActivityModel:onInit()
	self:reInit()
end

function RoleActivityModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = {}
	self.recordFightIndex = {}
end

function RoleActivityModel:initData(actId)
	if not self.lvlDataDic[actId] then
		self.lvlDataDic[actId] = {}

		local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(actId)

		for _, storyConfig in ipairs(storyConfigList) do
			self:_createLevelMo(actId, storyConfig)
		end

		local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(actId)

		for _, fightConfig in ipairs(fightConfigList) do
			self:_createLevelMo(actId, fightConfig)
		end
	end
end

function RoleActivityModel:_createLevelMo(actId, config)
	local mo = RoleActivityLevelMo.New()

	mo:init(config)

	self.lvlDataDic[actId][config.id] = mo
end

function RoleActivityModel:updateData(actId)
	local episodeDic = self.lvlDataDic[actId]

	for _, levelMo in pairs(episodeDic) do
		levelMo:update()
	end
end

function RoleActivityModel:isLevelUnlock(actId, episodeId)
	local lvlData = self.lvlDataDic[actId][episodeId]

	if not lvlData then
		logError(episodeId .. "data is null")

		return
	end

	return lvlData.isUnlock
end

function RoleActivityModel:isLevelPass(actId, episodeId)
	local lvlData = self.lvlDataDic[actId][episodeId]

	if not lvlData then
		logError(episodeId .. "data is null")

		return
	end

	return lvlData.star > 0
end

function RoleActivityModel:checkFinishLevel(episodeId, star)
	for actId, episodeDic in pairs(self.lvlDataDic) do
		if episodeDic[episodeId] then
			local lvlData = episodeDic[episodeId]
			local enterConfig = RoleActivityConfig.instance:getActivityEnterInfo(actId)

			if lvlData and lvlData.star == 0 and star > 0 then
				local chapterId = lvlData.config.chapterId

				if chapterId == enterConfig.storyGroupId then
					self.newFinishStoryLvlId = episodeId

					break
				end

				if chapterId == enterConfig.episodeGroupId then
					self.newFinishFightLvlId = episodeId
				end
			end

			break
		end
	end
end

function RoleActivityModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function RoleActivityModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function RoleActivityModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function RoleActivityModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function RoleActivityModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function RoleActivityModel:getEnterFightIndex()
	local fightIndex = self.recordFightIndex

	self.recordFightIndex = nil

	return fightIndex
end

RoleActivityModel.instance = RoleActivityModel.New()

return RoleActivityModel
