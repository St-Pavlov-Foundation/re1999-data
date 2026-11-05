-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitChangePosLater.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitChangePosLater", package.seeall)

local ArcadeSurvivorGameHitChangePosLater = class("ArcadeSurvivorGameHitChangePosLater", ArcadeSurvivorGameBaseDelayHit)

function ArcadeSurvivorGameHitChangePosLater:onCtor(params)
	self._delayTurn = tonumber(params[1])
	self._type = tonumber(params[2])
	self._x = tonumber(params[3])
	self._y = tonumber(params[4])
end

function ArcadeSurvivorGameHitChangePosLater:_onHit(context, caster, targetList, gridIdDict)
	local id = self:getId()
	local plan = self:_getMovePlan(context)

	context:setDelayMovePlan(id, plan)

	return ArcadeSurvivorGameBaseDelayHit._onHit(self, context, caster, targetList, gridIdDict)
end

function ArcadeSurvivorGameHitChangePosLater:_getMovePlan(context)
	return ArcadeSurvivorGameHelper.getChangePosPlan(context:getCaster(), self._type, self._x, self._y, context)
end

function ArcadeSurvivorGameHitChangePosLater:_onDelayHit(context, caster, targetList, gridIdDict)
	if not targetList or #targetList <= 0 then
		return
	end

	local id = self:getId()
	local plan = context:getDelayMovePlan(id)

	if plan then
		local moveEffectShowId = ArcadeSurvivorConfig.instance:getSkillEffectTriggerShowId(id)

		ArcadeSurvivorGameHelper.moveToWorldGrid(targetList, plan.x, plan.y, moveEffectShowId)
	end
end

return ArcadeSurvivorGameHitChangePosLater
