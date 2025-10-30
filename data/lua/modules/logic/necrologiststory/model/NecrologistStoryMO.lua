﻿-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryMO.lua

module("modules.logic.necrologiststory.model.NecrologistStoryMO", package.seeall)

local NecrologistStoryMO = pureTable("NecrologistStoryMO")

function NecrologistStoryMO:ctor()
	self.id = nil
	self.mainSection = 0
end

function NecrologistStoryMO:init(id)
	self.id = id
	self.config = NecrologistStoryConfig.instance:getPlotGroupCo(id)
end

function NecrologistStoryMO:initData()
	self._isAuto = false
	self.situationValueDict = {}

	local storyGroup = NecrologistStoryConfig.instance:getStoryListByGroupId(self.id)

	self._storyGroup = storyGroup
	self._stepIndexDict = {}
	self._skipNum = 0

	if not storyGroup then
		return
	end

	self:setSection(self.mainSection)
end

function NecrologistStoryMO:setSection(sectionId)
	self._sectionId = sectionId
	self._storyList = self._storyGroup[self._sectionId]
	self._stepCount = #self._storyList
	self._stepIndex = self._stepIndexDict[self._sectionId] or 0
	self._stepIndexDict[self._sectionId] = self._stepIndex
end

function NecrologistStoryMO:getStoryList()
	return self._storyList, self._stepIndex
end

function NecrologistStoryMO:isEmptyStory()
	return self._storyGroup == nil
end

function NecrologistStoryMO:isStoryFinish()
	if self:isEmptyStory() then
		return true
	end

	if self._sectionId ~= 0 then
		return false
	end

	return self._stepIndex >= self._stepCount
end

function NecrologistStoryMO:isNextStepNeedDelay()
	if not self:getIsAuto() then
		return false
	end

	local stepIndex = self._stepIndex
	local stepCount = self._stepCount
	local storyList = self._storyList
	local sectionId = self._sectionId

	if stepCount <= stepIndex then
		sectionId = self.mainSection
		storyList = self._storyGroup[sectionId]
		stepCount = #storyList
		stepIndex = self._stepIndexDict[sectionId] or 0
	end

	stepIndex = stepIndex + 1

	local isStoryFinish = sectionId == 0 and stepCount <= stepIndex

	if isStoryFinish then
		return false
	end

	local storyConfig = storyList[stepIndex]

	if not storyConfig then
		return false
	end

	if storyConfig.type == "control" then
		local controlTypes = string.splitToNumber(storyConfig.addControl, "|")

		for _, controlType in ipairs(controlTypes) do
			if NecrologistStoryEnum.NeedDelayControlType[controlType] ~= nil then
				return true
			end
		end

		return false
	end

	local needDelayType = NecrologistStoryEnum.NeedDelayType[storyConfig.type]

	return needDelayType ~= nil
end

function NecrologistStoryMO:runNextStep()
	if self._stepIndex >= self._stepCount then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSectionEnd, self._sectionId)
		self:setSection(self.mainSection)
	end

	self._stepIndex = self._stepIndex + 1
	self._stepIndexDict[self._sectionId] = self._stepIndex
end

function NecrologistStoryMO:getCurStoryConfig()
	local storyConfig = self._storyList[self._stepIndex]

	return storyConfig
end

function NecrologistStoryMO:addSituationValue(key, value)
	local oldValue = self:getSituationValue(key)

	self.situationValueDict[key] = oldValue + value
end

function NecrologistStoryMO:getSituationValue(key)
	local value = self.situationValueDict[key] or 0

	return value
end

function NecrologistStoryMO:saveSituation()
	local storyMo = NecrologistStoryModel.instance:getGameMO(self.config.storyId)
	local tab = {}

	for key, value in pairs(self.situationValueDict) do
		tab[key] = value
	end

	storyMo:setPlotSituationTab(self.id, tab)
end

function NecrologistStoryMO:compareSituationValue(compareStr)
	local func = NecrologistStoryHelper.loadSituationFunc(compareStr)

	if not func then
		return false
	end

	local storyMo = NecrologistStoryModel.instance:getGameMO(self.config.storyId)
	local dict = self:getSituationGlobalData()

	setfenv(func, dict)

	local result, resultSection = pcall(func)

	if result then
		return resultSection or 0
	else
		logError("执行表达式错误" .. compareStr)

		return nil
	end
end

function NecrologistStoryMO:getSituationGlobalData()
	local storyMo = NecrologistStoryModel.instance:getGameMO(self.config.storyId)
	local data = storyMo:getPlotSituationTab(self.id)

	for key, value in pairs(self.situationValueDict) do
		data[key] = data[key] + value
	end

	return data
end

function NecrologistStoryMO:getIsAuto()
	return self._isAuto
end

function NecrologistStoryMO:setIsAuto(isAuto)
	if self._isAuto == isAuto then
		return
	end

	self._isAuto = isAuto

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnAutoChange)
end

function NecrologistStoryMO:onSkip()
	self._skipNum = self._skipNum + 1
end

function NecrologistStoryMO:getSkipNum()
	return self._skipNum
end

function NecrologistStoryMO:markSpecial(plotId)
	local key = string.format("mark_%s", plotId)

	self:addSituationValue(key, 1)
end

function NecrologistStoryMO:getStatParam(isReview)
	local param = {
		heroStoryId = self.config.storyId,
		plotGroup = self.id,
		skipNum = self:getSkipNum(),
		entrance = isReview and StatEnum.HeroStoryEntrance.Review or StatEnum.HeroStoryEntrance.Normal
	}

	return param
end

return NecrologistStoryMO
