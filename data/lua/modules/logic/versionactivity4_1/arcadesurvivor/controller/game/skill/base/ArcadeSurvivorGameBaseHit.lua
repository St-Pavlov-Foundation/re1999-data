-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/base/ArcadeSurvivorGameBaseHit.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.base.ArcadeSurvivorGameBaseHit", package.seeall)

local ArcadeSurvivorGameBaseHit = class("ArcadeSurvivorGameBaseHit")

function ArcadeSurvivorGameBaseHit:ctor(skill, effectId, triggerIndex)
	self._skill = skill

	local skillId = skill and skill:getId()

	self._skillId = skillId
	self._id = effectId
	self._triggerIndex = triggerIndex
	self._effectIndex = 0
	self._selector = ArcadeSurvivorGameSkillFactory.createSelector(effectId)

	local params = ArcadeSurvivorConfig.instance:getSkillEffectParam(effectId)

	self:onCtor(params)
end

function ArcadeSurvivorGameBaseHit:hit(context)
	local caster = context:getCaster()

	if not caster then
		return
	end

	if caster:getIsDead() and not context:getAllowDeadCaster() then
		return
	end

	local targetList, gridIdDict

	if self._selector then
		targetList, gridIdDict = self._selector:findByContext(context)
	end

	local isOk, isWaitDelayHit, applied = callWithCatch(self._onHit, self, context, caster, targetList, gridIdDict)

	if not isOk or applied == false then
		return false, false
	end

	local delayTurn = self:getDelayTurn()

	if delayTurn and delayTurn > 0 then
		self:_playEffectShow(caster)
		context:setHaveHitTarget(true)
	else
		self:_playEffectShow(caster, targetList, gridIdDict)

		if targetList and #targetList > 0 then
			context:setHaveHitTarget(true)
		end
	end

	if ArcadeSurvivorGameEnum.Const.PrintLog then
		self:_logHit()
	end

	return true, isWaitDelayHit
end

function ArcadeSurvivorGameBaseHit:delayHit(delayContext, gridIdDict)
	local caster = delayContext and delayContext:getCaster()

	if not caster or caster:getIsDead() then
		return false
	end

	local targetList = self._selector and self._selector:getTargetListInGrids(gridIdDict)
	local isOk, result = callWithCatch(self._onDelayHit, self, delayContext, caster, targetList, gridIdDict)

	if not isOk then
		return false
	end

	if result == ArcadeSurvivorGameEnum.DelayHitResult.Retry then
		return result
	end

	self:_playEffectShow(nil, targetList, gridIdDict)

	return true
end

function ArcadeSurvivorGameBaseHit:_playEffectShow(caster, hitterList, gridIdDict)
	local effectId = self:getId()
	local casterShowId = ArcadeSurvivorConfig.instance:getSkillEffectCasterShowId(effectId)
	local triggerShowId = ArcadeSurvivorConfig.instance:getSkillEffectTriggerShowId(effectId)
	local targetShowId = ArcadeSurvivorConfig.instance:getSkillEffectTargetShowId(effectId)
	local hasCasterShow = casterShowId and casterShowId ~= 0
	local hasTriggerShow = triggerShowId and triggerShowId ~= 0
	local hasTargetShow = targetShowId and targetShowId ~= 0

	if not hasCasterShow and not hasTriggerShow and not hasTargetShow then
		return
	end

	local casterX, casterY, casterDirection

	if caster then
		casterX, casterY = caster:getGridPos()
		casterDirection = caster:getDirection(true)

		if hasCasterShow then
			self:_playUnitShow(casterShowId, caster, casterDirection)
		end
	end

	if hasTriggerShow then
		local scene = ArcadeSurvivorGameController.instance:getGameScene()
		local effectMgr = scene and scene.effectMgr

		if effectMgr then
			effectMgr:playTriggerShow(triggerShowId, gridIdDict, casterX, casterY, casterDirection)
		end
	end

	if hasTargetShow and hitterList then
		local casterGridX, casterGridY

		if caster then
			casterGridX, casterGridY = caster:getGridPos()
		end

		for index = 1, #hitterList do
			local hitter = hitterList[index]
			local hitterGridX, hitterGridY = hitter:getGridPos()
			local hitterDirection = ArcadeSurvivorGameHelper.getDirectionGridFromGrid(casterGridX, casterGridY, hitterGridX, hitterGridY, true)

			self:_playUnitShow(targetShowId, hitter, hitterDirection)
		end
	end
end

function ArcadeSurvivorGameBaseHit:_playUnitShow(showId, unitMO, direction)
	local isValidShowId = showId and showId ~= 0

	if not unitMO or not isValidShowId then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local entityMgr = scene and scene.entityMgr

	if not entityMgr then
		return
	end

	local entityType = unitMO:getEntityType()
	local uid = unitMO:getUid()
	local entity = entityMgr:getEntity(entityType, uid)

	if not entity then
		return
	end

	entity:playShow(showId, direction)
end

function ArcadeSurvivorGameBaseHit:_logHit()
	return
end

function ArcadeSurvivorGameBaseHit:getId()
	return self._id
end

function ArcadeSurvivorGameBaseHit:getSkillId()
	return self._skillId
end

function ArcadeSurvivorGameBaseHit:getSkill()
	return self._skill
end

function ArcadeSurvivorGameBaseHit:getTriggerIndex()
	return self._triggerIndex
end

function ArcadeSurvivorGameBaseHit:setEffectIndex(effectIndex)
	self._effectIndex = effectIndex or 0
end

function ArcadeSurvivorGameBaseHit:getEffectIndex()
	return self._effectIndex
end

function ArcadeSurvivorGameBaseHit:onCtor(params)
	return
end

function ArcadeSurvivorGameBaseHit:_onHit(context, caster, targetList, gridIdDict)
	return
end

function ArcadeSurvivorGameBaseHit:_onDelayHit(context, caster, targetList, gridIdDict)
	return
end

function ArcadeSurvivorGameBaseHit:getDelayTurn()
	return
end

return ArcadeSurvivorGameBaseHit
