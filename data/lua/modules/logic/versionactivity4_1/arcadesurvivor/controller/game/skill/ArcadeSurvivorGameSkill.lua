-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/ArcadeSurvivorGameSkill.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.ArcadeSurvivorGameSkill", package.seeall)

local ArcadeSurvivorGameSkill = class("ArcadeSurvivorGameSkill")

function ArcadeSurvivorGameSkill:ctor(skillUid, skillId, sourceType, sourceId)
	self._uid = skillUid
	self._id = skillId
	self._sourceType = sourceType or ArcadeSurvivorGameEnum.SkillSourceType.Normal

	if self._sourceType == ArcadeSurvivorGameEnum.SkillSourceType.Normal then
		sourceId = sourceId or ArcadeSurvivorGameEnum.Const.NoneSkillSourceId
	end

	self._sourceId = sourceId
	self._isWaitDelayHit = false
	self._triggerList = {}
	self._triggerPointWithParamDict = {}

	local effectIdList = ArcadeSurvivorConfig.instance:getSkillEffectIdList(self._id)

	for i = 1, #effectIdList do
		local effectId = effectIdList[i]
		local trigger = ArcadeSurvivorGameTrigger.New(self, effectId, i)

		self._triggerList[#self._triggerList + 1] = trigger

		local triggerPointWithParam = trigger:getTriggerPointWithParam()
		local list = GameUtil.tabletool_checkDictTable(self._triggerPointWithParamDict, triggerPointWithParam)

		list[#list + 1] = trigger
	end
end

function ArcadeSurvivorGameSkill:activeCast(context)
	self._isWaitDelayHit = false

	local triggerList = self._triggerPointWithParamDict[ArcadeSurvivorGameEnum.TriggerPoint.None]

	if not triggerList or #triggerList <= 0 then
		return false
	end

	local hasTrigger = false
	local hasWaitDelayHit = false
	local triggerCount = #triggerList

	for index = 1, triggerCount do
		local trigger = triggerList[index]
		local hasHit, isWaitDelayHit = trigger:triggerDirectly(context)

		hasTrigger = hasTrigger or hasHit
		hasWaitDelayHit = hasWaitDelayHit or isWaitDelayHit
	end

	self:setWaitDelayHit(hasWaitDelayHit)

	if hasTrigger then
		ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnCollectionSkillTrigger, self:getCollectionId())
	end

	return hasTrigger
end

function ArcadeSurvivorGameSkill:tryTriggerCast(triggerPointWithParam, context)
	local triggerList = triggerPointWithParam and self._triggerPointWithParamDict[triggerPointWithParam]

	if not triggerList or #triggerList <= 0 then
		return
	end

	local hasTrigger = false

	context:setHaveHitTarget()

	for _, trigger in ipairs(triggerList) do
		local hasHit = trigger:tryTrigger(context)

		hasTrigger = hasTrigger or hasHit
	end

	if hasTrigger and context:getIsHaveHitTarget() then
		ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnCollectionSkillTrigger, self:getCollectionId())
	end

	return hasTrigger
end

function ArcadeSurvivorGameSkill:skillDelayHit(record)
	local triggerIndex = record:getTriggerIndex()
	local trigger = self._triggerList[triggerIndex]

	if not trigger then
		logError(string.format("ArcadeSurvivorGameSkill:skillDelayHit error, can't find trigger, skillId:%s triggerIndex:%s", self._id, triggerIndex))

		return false
	end

	local hasHit, isWaitDelayHit = trigger:triggerDelayHit(record)

	if isWaitDelayHit then
		self:setWaitDelayHit(true)
	end

	return hasHit, isWaitDelayHit
end

function ArcadeSurvivorGameSkill:setWaitDelayHit(waitDelayHit)
	self._isWaitDelayHit = waitDelayHit
end

function ArcadeSurvivorGameSkill:clearTriggerCounts()
	for _, trigger in ipairs(self._triggerList) do
		trigger:clearTriggerCount()
	end
end

function ArcadeSurvivorGameSkill:getId()
	return self._id
end

function ArcadeSurvivorGameSkill:getUid()
	return self._uid
end

function ArcadeSurvivorGameSkill:getIsWaitDelayHit()
	return self._isWaitDelayHit
end

function ArcadeSurvivorGameSkill:getCollectionId()
	if self._sourceType ~= ArcadeSurvivorGameEnum.SkillSourceType.Collection then
		return
	end

	return self._sourceId
end

function ArcadeSurvivorGameSkill:getSourceType()
	return self._sourceType
end

function ArcadeSurvivorGameSkill:getSourceId()
	return self._sourceId
end

function ArcadeSurvivorGameSkill:getTriggerPointWithParamList()
	if not self._triggerPointWithParamList then
		self._triggerPointWithParamList = {}

		for triggerPointWithParam, _ in pairs(self._triggerPointWithParamDict) do
			self._triggerPointWithParamList[#self._triggerPointWithParamList + 1] = triggerPointWithParam
		end
	end

	return self._triggerPointWithParamList
end

return ArcadeSurvivorGameSkill
