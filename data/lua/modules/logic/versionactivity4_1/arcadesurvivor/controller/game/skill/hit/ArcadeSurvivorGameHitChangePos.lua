-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitChangePos.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitChangePos", package.seeall)

local ArcadeSurvivorGameHitChangePos = class("ArcadeSurvivorGameHitChangePos", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitChangePos:onCtor(params)
	self._type = tonumber(params[1])
	self._x = tonumber(params[2])
	self._y = tonumber(params[3])
end

function ArcadeSurvivorGameHitChangePos:_onHit(context, caster, targetList, gridIdDict)
	if not targetList or #targetList <= 0 then
		return
	end

	local moveEffectShowId = ArcadeSurvivorConfig.instance:getSkillEffectTriggerShowId(self:getId())

	if self._type == ArcadeSurvivorGameEnum.ChangePosType.WorldGrid then
		ArcadeSurvivorGameHelper.moveToWorldGrid(targetList, self._x, self._y, moveEffectShowId)
	elseif self._type == ArcadeSurvivorGameEnum.ChangePosType.PlayerLocalGrid then
		ArcadeSurvivorGameHelper.moveToPlayLocalGrid(targetList, self._x, self._y, moveEffectShowId)
	elseif self._type == ArcadeSurvivorGameEnum.ChangePosType.PassPlayerAxis then
		ArcadeSurvivorGameHelper.movePassPlayerAxis(targetList, moveEffectShowId)
	elseif self._type == ArcadeSurvivorGameEnum.ChangePosType.PassPlayerCorner then
		ArcadeSurvivorGameHelper.movePassPlayerCorner(targetList, moveEffectShowId)
	elseif self._type == ArcadeSurvivorGameEnum.ChangePosType.PlayerOffsetGrid then
		ArcadeSurvivorGameHelper.moveToPlayerOffsetGrid(targetList, self._x, self._y, moveEffectShowId)
	else
		logError(string.format("ArcadeSurvivorGameHitChangePos:_onHit error type:%s", self._type))
	end
end

return ArcadeSurvivorGameHitChangePos
