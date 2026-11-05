-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/context/ArcadeSurvivorGameTriggerContext.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.context.ArcadeSurvivorGameTriggerContext", package.seeall)

local ArcadeSurvivorGameTriggerContext = class("ArcadeSurvivorGameTriggerContext")

function ArcadeSurvivorGameTriggerContext:ctor(triggerPoint, triggerPointParam, caster, ...)
	self._triggerPoint = triggerPoint
	self._triggerPointWithParam = ArcadeSurvivorGameHelper.getTriggerPointWithParamKey(triggerPoint, triggerPointParam)
	self._caster = caster
	self._hitterList = {}
	self._hitterDict = {}
	self._passPlayerPlans = {}
	self._delayMovePlans = {}

	self:onCtor(...)
end

function ArcadeSurvivorGameTriggerContext:onCtor(...)
	return
end

function ArcadeSurvivorGameTriggerContext:checkTriggerPointWithParam(triggerPointWithParam)
	return self._triggerPointWithParam == triggerPointWithParam
end

function ArcadeSurvivorGameTriggerContext:addHitter(hitter)
	if not hitter then
		return
	end

	local hitterEntityType = hitter:getEntityType()
	local hitterUid = hitter:getUid()
	local typeDict = self._hitterDict[hitterEntityType]

	if not typeDict then
		typeDict = {}
		self._hitterDict[hitterEntityType] = typeDict
	end

	if typeDict[hitterUid] then
		return
	end

	typeDict[hitterUid] = true
	self._hitterList[#self._hitterList + 1] = hitter
end

function ArcadeSurvivorGameTriggerContext:setDelayMovePlan(effectId, plan)
	self._delayMovePlans[effectId] = plan
end

function ArcadeSurvivorGameTriggerContext:setHaveHitTarget(isHave)
	self._isHaveHitTarget = isHave
end

function ArcadeSurvivorGameTriggerContext:setAllowDeadCaster(allowDeadCaster)
	self._allowDeadCaster = allowDeadCaster
end

function ArcadeSurvivorGameTriggerContext:clearHitterList()
	self._hitterList = {}
	self._hitterDict = {}
end

function ArcadeSurvivorGameTriggerContext:getTriggerPoint()
	return self._triggerPoint
end

function ArcadeSurvivorGameTriggerContext:getTriggerPointWithParam()
	return self._triggerPointWithParam
end

function ArcadeSurvivorGameTriggerContext:getCaster()
	return self._caster
end

function ArcadeSurvivorGameTriggerContext:getPassPlayerPlan(axisType)
	local plan = self._passPlayerPlans[axisType]

	if not plan then
		plan = ArcadeSurvivorGameHelper.createPassPlayerPlan(self._caster, axisType) or false
		self._passPlayerPlans[axisType] = plan
	end

	return plan
end

function ArcadeSurvivorGameTriggerContext:getDelayMovePlan(effectId)
	return self._delayMovePlans[effectId]
end

function ArcadeSurvivorGameTriggerContext:getHitterList()
	return self._hitterList
end

function ArcadeSurvivorGameTriggerContext:getIsHaveHitTarget()
	return self._isHaveHitTarget
end

function ArcadeSurvivorGameTriggerContext:getAllowDeadCaster()
	return self._allowDeadCaster == true
end

return ArcadeSurvivorGameTriggerContext
