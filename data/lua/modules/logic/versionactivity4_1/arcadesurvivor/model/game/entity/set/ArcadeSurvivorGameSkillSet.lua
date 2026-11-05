-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/set/ArcadeSurvivorGameSkillSet.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.set.ArcadeSurvivorGameSkillSet", package.seeall)

local ArcadeSurvivorGameSkillSet = class("ArcadeSurvivorGameSkillSet", ArcadeSurvivorGameBaseSet)

function ArcadeSurvivorGameSkillSet:onCtor()
	self._skillStackDict = {}
	self._triggerPointWithParam2SkillList = {}
	self._skillUidSeed = 0
end

function ArcadeSurvivorGameSkillSet:_generateSkillUid()
	self._skillUidSeed = self._skillUidSeed + 1

	return self._skillUidSeed
end

function ArcadeSurvivorGameSkillSet:addSkill2Set(skillId, sourceType, sourceId)
	local skillCfg = ArcadeSurvivorConfig.instance:getSkillCfg(skillId, true)

	if not skillCfg then
		return
	end

	sourceType = sourceType or ArcadeSurvivorGameEnum.SkillSourceType.Normal

	if sourceType == ArcadeSurvivorGameEnum.SkillSourceType.Normal then
		sourceId = sourceId or ArcadeSurvivorGameEnum.Const.NoneSkillSourceId
	else
		local numSourceId = tonumber(sourceId)

		if not numSourceId or numSourceId <= 0 then
			logError(string.format("ArcadeSurvivorGameSkillSet:addSkill2Set error, invalid sourceId, skillId:%s sourceType:%s sourceId:%s", tostring(skillId), tostring(sourceType), tostring(sourceId)))

			return
		end

		sourceId = numSourceId
	end

	local stackList = GameUtil.tabletool_checkDictTable(self._skillStackDict, skillId)

	if sourceType ~= ArcadeSurvivorGameEnum.SkillSourceType.Collection then
		for _, skill in ipairs(stackList) do
			if self:_isSameSkillSource(skill, sourceType, sourceId) then
				return skill
			end
		end
	end

	local skillUid = self:_generateSkillUid()
	local skill = ArcadeSurvivorGameSkill.New(skillUid, skillId, sourceType, sourceId)

	stackList[#stackList + 1] = skill

	local triggerPointWithParamList = skill:getTriggerPointWithParamList()

	for _, triggerPointWithParam in ipairs(triggerPointWithParamList) do
		local list = GameUtil.tabletool_checkDictTable(self._triggerPointWithParam2SkillList, triggerPointWithParam)

		list[#list + 1] = skill
	end

	return skill
end

function ArcadeSurvivorGameSkillSet:_isSameSkillSource(skill, sourceType, sourceId)
	if skill:getSourceType() ~= sourceType then
		return false
	end

	if sourceType == ArcadeSurvivorGameEnum.SkillSourceType.Normal then
		return true
	end

	if sourceType == ArcadeSurvivorGameEnum.SkillSourceType.Buff then
		return skill:getSourceId() == sourceId
	end

	return false
end

function ArcadeSurvivorGameSkillSet:removeSkillInSet(skillId, sourceType, sourceId)
	local stackList = self._skillStackDict[skillId]

	if not stackList then
		return
	end

	local removedSkillDict = {}
	local affectedTriggerPointDict = {}
	local stackCount = #stackList

	for readIndex = 1, stackCount do
		local skill = stackList[readIndex]
		local isMatch = not sourceType or skill:getSourceType() == sourceType and (sourceId == nil or skill:getSourceId() == sourceId)

		if isMatch then
			removedSkillDict[skill] = true

			local triggerPointWithParamList = skill:getTriggerPointWithParamList()

			for _, triggerPointWithParam in ipairs(triggerPointWithParamList) do
				affectedTriggerPointDict[triggerPointWithParam] = true
			end
		end
	end

	local stackRetainCount = self:_compactArrayInPlace(stackList, removedSkillDict)

	for triggerPointWithParam in pairs(affectedTriggerPointDict) do
		local skillList = self._triggerPointWithParam2SkillList[triggerPointWithParam]

		self:_compactArrayInPlace(skillList, removedSkillDict)
	end

	if stackRetainCount <= 0 then
		self._skillStackDict[skillId] = nil
	end
end

function ArcadeSurvivorGameSkillSet:_compactArrayInPlace(array, removedValueDict)
	local arrayCount = #array
	local writeIndex = 1

	for readIndex = 1, arrayCount do
		local value = array[readIndex]

		if not removedValueDict[value] then
			if writeIndex ~= readIndex then
				array[writeIndex] = value
			end

			writeIndex = writeIndex + 1
		end
	end

	for index = arrayCount, writeIndex, -1 do
		array[index] = nil
	end

	return writeIndex - 1
end

function ArcadeSurvivorGameSkillSet:clearTriggerCounts()
	for _, stackList in pairs(self._skillStackDict) do
		for _, skill in ipairs(stackList) do
			skill:clearTriggerCounts()
		end
	end
end

function ArcadeSurvivorGameSkillSet:getTriggerSkillListInSet(triggerPointWithParam)
	return triggerPointWithParam and self._triggerPointWithParam2SkillList[triggerPointWithParam]
end

function ArcadeSurvivorGameSkillSet:getSkillStackListInSet(skillId)
	return self._skillStackDict[skillId]
end

function ArcadeSurvivorGameSkillSet:hasSkillInSet(skillId)
	local stackList = self._skillStackDict[skillId]

	if not stackList then
		return false
	end

	return #stackList > 0
end

function ArcadeSurvivorGameSkillSet:getSkillByUidInSet(skillId, skillUid)
	local stackList = self._skillStackDict[skillId]

	if not stackList then
		return
	end

	for _, stackSkill in ipairs(stackList) do
		if stackSkill:getUid() == skillUid then
			return stackSkill
		end
	end
end

function ArcadeSurvivorGameSkillSet:hasWaitDelayHitInSet(skillId)
	local stackList = self._skillStackDict[skillId]

	if not stackList then
		return false
	end

	for _, skill in ipairs(stackList) do
		if skill:getIsWaitDelayHit() then
			return true
		end
	end

	return false
end

function ArcadeSurvivorGameSkillSet:getSkillSourceCountMapListInSet()
	local result = {}

	for skillId, stackList in pairs(self._skillStackDict) do
		if stackList and #stackList > 0 then
			local sourceCountMap = {}

			for _, skill in ipairs(stackList) do
				local sourceType = skill:getSourceType()
				local sourceId = skill:getSourceId()
				local sourceIdDict = GameUtil.tabletool_checkDictTable(sourceCountMap, sourceType)

				sourceIdDict[sourceId] = (sourceIdDict[sourceId] or 0) + 1
			end

			result[#result + 1] = {
				skillId = skillId,
				sourceCountMap = sourceCountMap
			}
		end
	end

	return result
end

return ArcadeSurvivorGameSkillSet
