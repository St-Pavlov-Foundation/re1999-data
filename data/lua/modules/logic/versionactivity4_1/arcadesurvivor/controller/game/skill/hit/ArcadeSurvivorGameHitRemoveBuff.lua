-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitRemoveBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitRemoveBuff", package.seeall)

local ArcadeSurvivorGameHitRemoveBuff = class("ArcadeSurvivorGameHitRemoveBuff", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitRemoveBuff:onCtor(params)
	self._buffId = tonumber(params[1])
	self._count = tonumber(params[2])
end

function ArcadeSurvivorGameHitRemoveBuff:_onHit(context, caster, targetList, gridIdDict)
	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()

		ArcadeSurvivorGameController.instance:removeEntityBuff(entityType, uid, self._buffId, self._count)
	end
end

return ArcadeSurvivorGameHitRemoveBuff
