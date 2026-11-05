-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitAddBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitAddBuff", package.seeall)

local ArcadeSurvivorGameHitAddBuff = class("ArcadeSurvivorGameHitAddBuff", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitAddBuff:onCtor(params)
	self._buffId = tonumber(params[1])
	self._count = tonumber(params[2])
end

function ArcadeSurvivorGameHitAddBuff:_onHit(context, caster, targetList, gridIdDict)
	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()

		ArcadeSurvivorGameController.instance:addBuff2Entity(entityType, uid, self._buffId, self._count, caster)
	end
end

return ArcadeSurvivorGameHitAddBuff
