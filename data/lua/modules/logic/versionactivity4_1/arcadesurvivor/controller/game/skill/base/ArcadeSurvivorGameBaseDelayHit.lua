-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/base/ArcadeSurvivorGameBaseDelayHit.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.base.ArcadeSurvivorGameBaseDelayHit", package.seeall)

local ArcadeSurvivorGameBaseDelayHit = class("ArcadeSurvivorGameBaseDelayHit", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameBaseDelayHit:_onHit(context, caster, targetList, gridIdDict)
	local delayTurn = self:getDelayTurn()

	if not delayTurn or delayTurn <= 0 then
		logError(string.format("ArcadeSurvivorGameBaseDelayHit:_onHit error, invalid delayTurn:%s, effectId:%s", delayTurn, self:getId()))

		return
	end

	local needAlert = self:getNeedAlert()
	local frozenGridIdDict = tabletool.copy(gridIdDict)
	local skill = self:getSkill()
	local skillId = skill:getId()
	local skillUid = skill:getUid()
	local triggerIndex = self:getTriggerIndex()
	local effectIndex = self:getEffectIndex()
	local record = ArcadeSurvivorGameDelayHitRecord.New(skillId, skillUid, triggerIndex, context, delayTurn, frozenGridIdDict, needAlert, effectIndex)

	record.allowEmptyGrid = self:getAllowEmptyGrid()

	local result = ArcadeSurvivorGameController.instance:addDelayHit(record)

	return result, result == true
end

function ArcadeSurvivorGameBaseDelayHit:getDelayTurn()
	return self._delayTurn or 0
end

function ArcadeSurvivorGameBaseDelayHit:getAllowEmptyGrid()
	return false
end

function ArcadeSurvivorGameBaseDelayHit:getNeedAlert()
	return false
end

return ArcadeSurvivorGameBaseDelayHit
