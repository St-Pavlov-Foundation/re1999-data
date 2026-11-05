-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitReturnBoard.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitReturnBoard", package.seeall)

local ArcadeSurvivorGameHitReturnBoard = class("ArcadeSurvivorGameHitReturnBoard", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitReturnBoard:onCtor(params)
	self._type, self._x, self._y = tonumber(params[1]), tonumber(params[2]), tonumber(params[3])
end

function ArcadeSurvivorGameHitReturnBoard:_onHit(context, caster)
	local plan = ArcadeSurvivorGameHelper.getChangePosPlan(caster, self._type, self._x, self._y)
	local result = plan and ArcadeSurvivorGameController.instance:returnBoard(caster:getEntityType(), caster:getUid(), plan.x, plan.y)

	return false, result == true
end

return ArcadeSurvivorGameHitReturnBoard
