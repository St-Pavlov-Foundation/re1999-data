-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitAddBuffByColl.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitAddBuffByColl", package.seeall)

local ArcadeSurvivorGameHitAddBuffByColl = class("ArcadeSurvivorGameHitAddBuffByColl", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitAddBuffByColl:onCtor(params)
	self._perColl = tonumber(params[1])
	self._buffId = tonumber(params[2])
	self._count = tonumber(params[3]) or 0
end

function ArcadeSurvivorGameHitAddBuffByColl:_onHit(context, caster, targetList, gridIdDict)
	local totalCount = 0
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO and self._perColl then
		local collectionCount = characterMO:getCollectionCount()
		local addTimes = math.floor(collectionCount / self._perColl)

		totalCount = addTimes * self._count
	end

	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()

		ArcadeSurvivorGameController.instance:addBuff2Entity(entityType, uid, self._buffId, totalCount, caster)
	end
end

return ArcadeSurvivorGameHitAddBuffByColl
