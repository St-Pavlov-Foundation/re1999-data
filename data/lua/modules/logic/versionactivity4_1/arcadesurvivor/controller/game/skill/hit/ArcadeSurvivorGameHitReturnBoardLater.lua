-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitReturnBoardLater.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitReturnBoardLater", package.seeall)

local ArcadeSurvivorGameHitReturnBoardLater = class("ArcadeSurvivorGameHitReturnBoardLater", ArcadeSurvivorGameBaseDelayHit)

function ArcadeSurvivorGameHitReturnBoardLater:onCtor(params)
	self._delayTurn, self._type = tonumber(params[1]), tonumber(params[2])
	self._x, self._y = tonumber(params[3]), tonumber(params[4])
end

function ArcadeSurvivorGameHitReturnBoardLater:_onHit(context, caster, targetList, gridIdDict)
	local plan = ArcadeSurvivorGameHelper.getChangePosPlan(caster, self._type, self._x, self._y, context)

	if not plan then
		return false, false
	end

	context:setDelayMovePlan(self:getId(), plan)

	return ArcadeSurvivorGameBaseDelayHit._onHit(self, context, caster, targetList, gridIdDict)
end

function ArcadeSurvivorGameHitReturnBoardLater:_onDelayHit(context, caster)
	local plan = context:getDelayMovePlan(self:getId())
	local result = ArcadeSurvivorGameController.instance:returnBoard(caster:getEntityType(), caster:getUid(), plan.x, plan.y)

	if not result then
		return ArcadeSurvivorGameEnum.DelayHitResult.Retry
	end
end

function ArcadeSurvivorGameHitReturnBoardLater:getAllowEmptyGrid()
	return true
end

return ArcadeSurvivorGameHitReturnBoardLater
