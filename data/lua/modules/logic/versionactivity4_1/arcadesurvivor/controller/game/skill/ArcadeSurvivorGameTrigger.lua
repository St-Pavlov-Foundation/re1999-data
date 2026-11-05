-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/ArcadeSurvivorGameTrigger.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.ArcadeSurvivorGameTrigger", package.seeall)

local ArcadeSurvivorGameTrigger = class("ArcadeSurvivorGameTrigger")

function ArcadeSurvivorGameTrigger:ctor(skill, effectId, index)
	self._skill = skill

	local skillId = skill and skill:getId()

	self._skillId = skillId
	self._effectId = effectId
	self._index = index
	self._triggerPointWithParam = ArcadeSurvivorGameHelper.getTriggerPointWithParamKeyByEffectId(effectId)
	self._probability = ArcadeSurvivorConfig.instance:getSkillEffectTriggerRate(effectId)
	self._levelMaxTriggerCount = ArcadeSurvivorConfig.instance:getSkillEffectLevelMaxTriggerCount(effectId)
	self._triggerCount = 0
	self._condition = ArcadeSurvivorGameSkillFactory.createCondition(effectId)
	self._effectList = self:_createEffectList(skill, effectId, index)
end

function ArcadeSurvivorGameTrigger:_createEffectList(skill, effectId, triggerIndex)
	local effectList = {}
	local repeatDict = {}
	local currentEffectId = effectId

	while currentEffectId and currentEffectId ~= 0 and not repeatDict[currentEffectId] do
		repeatDict[currentEffectId] = true

		local effect = ArcadeSurvivorGameSkillFactory.createEffect(skill, currentEffectId, triggerIndex)

		if not effect then
			break
		end

		effect:setEffectIndex(#effectList + 1)

		effectList[#effectList + 1] = effect
		currentEffectId = ArcadeSurvivorConfig.instance:getSkillEffectSubEffect(currentEffectId)
	end

	return effectList
end

function ArcadeSurvivorGameTrigger:tryTrigger(context)
	local triggerPointWithParam = self:getTriggerPointWithParam()

	if string.nilorempty(triggerPointWithParam) then
		return
	end

	if self._levelMaxTriggerCount > 0 and self._triggerCount >= self._levelMaxTriggerCount then
		return
	end

	local isHitProb = true

	if self._probability and self._probability > 0 then
		isHitProb = math.random(ArcadeSurvivorEnum.Const.PermillageBase) <= self._probability
	end

	if not isHitProb then
		return
	end

	local isCondPass = true

	if self._condition then
		isCondPass = self._condition:isCondSuccess(context)
	end

	if not isCondPass then
		return
	end

	return self:triggerDirectly(context)
end

function ArcadeSurvivorGameTrigger:triggerDirectly(context)
	local triggerController = ArcadeSurvivorGameTriggerController.instance
	local caster = context and context.getCaster and context:getCaster()

	if triggerController:isTriggerChainActive(caster, self) then
		logNormal(string.format("ArcadeSurvivorGameTrigger:triggerDirectly trigger chain is active, skip, skillId:%s effectId:%s triggerIndex:%s triggerPointWithParam:%s", tostring(self._skillId), tostring(self._effectId), tostring(self._index), tostring(self:getTriggerPointWithParam())))

		return false
	end

	if triggerController:checkTriggerCount(self._skillId, self._effectId) then
		return false
	end

	triggerController:beginTriggerChain(caster, self)

	self._triggerCount = self._triggerCount + 1

	local hasHit, isWaitDelayHit = self:_hitEffectList(context, 1)

	triggerController:endTriggerChain(caster, self)

	return hasHit, isWaitDelayHit
end

function ArcadeSurvivorGameTrigger:triggerDelayHit(record)
	local effectIndex = record:getEffectIndex()
	local effectList = self:getEffectList()
	local effect = effectList and effectList[effectIndex]

	if not effect then
		logError(string.format("ArcadeSurvivorGameTrigger:triggerDelayHit error, effect is nil, skillId:%s effectId:%s triggerIndex:%s effectIndex:%s", self._skillId, self._effectId, self._index, tostring(effectIndex)))

		return false
	end

	local delayContext = record:getDelayContext()
	local gridIdDict = record:getGridIdDict()
	local hasDelayHit = effect:delayHit(delayContext, gridIdDict)

	if hasDelayHit == ArcadeSurvivorGameEnum.DelayHitResult.Retry then
		return hasDelayHit, true
	end

	if not hasDelayHit then
		return false
	end

	local _, isWaitDelayHit = self:_hitEffectList(delayContext, effectIndex + 1)

	return true, isWaitDelayHit
end

function ArcadeSurvivorGameTrigger:_hitEffectList(context, startIndex)
	local effectList = self:getEffectList()
	local effectCount = effectList and #effectList or 0
	local hasHit = false
	local isWaitDelayHit = false

	for index = startIndex, effectCount do
		local effect = effectList[index]
		local effectHasHit, effectIsWaitDelayHit = effect:hit(context)

		if not effectHasHit then
			break
		end

		hasHit = true
		isWaitDelayHit = isWaitDelayHit or effectIsWaitDelayHit

		if effectIsWaitDelayHit then
			break
		end
	end

	return hasHit, isWaitDelayHit
end

function ArcadeSurvivorGameTrigger:getSkillId()
	return self._skillId
end

function ArcadeSurvivorGameTrigger:getIndex()
	return self._index
end

function ArcadeSurvivorGameTrigger:getEffectList()
	return self._effectList
end

function ArcadeSurvivorGameTrigger:getTriggerPointWithParam()
	return self._triggerPointWithParam
end

function ArcadeSurvivorGameTrigger:clearTriggerCount()
	self._triggerCount = 0
end

return ArcadeSurvivorGameTrigger
