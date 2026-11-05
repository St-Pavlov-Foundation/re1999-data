-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitSummon.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitSummon", package.seeall)

local ArcadeSurvivorGameHitSummon = class("ArcadeSurvivorGameHitSummon", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitSummon:onCtor(params)
	self._entityType = params[1]
	self._entityId = tonumber(params[2])
end

function ArcadeSurvivorGameHitSummon:_onHit(context, caster, targetList, gridIdDict)
	local cfg = ArcadeSurvivorHelper.getEntityCfg(self._entityType, self._entityId)

	if not cfg then
		return
	end

	local sizeX, sizeY = 0, 0

	if not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	if sizeX == 0 or sizeY == 0 then
		logError(string.format("ArcadeSurvivorGameHitSummon error, entity size is zero, entityType:%s id:%s", self._entityType, self._entityId))

		return
	end

	if targetList then
		for _, targetMO in ipairs(targetList) do
			local gridX, gridY = targetMO:getGridPos()
			local mo = ArcadeSurvivorGameController.instance:addEntityOne(self._entityType, self._entityId, gridX, gridY, sizeX, sizeY)

			if mo and caster and caster:getIsAlive() then
				mo:setSummon(caster)
			end
		end
	end

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.SummonBegin
	local summonContext = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, caster)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, summonContext)
end

return ArcadeSurvivorGameHitSummon
