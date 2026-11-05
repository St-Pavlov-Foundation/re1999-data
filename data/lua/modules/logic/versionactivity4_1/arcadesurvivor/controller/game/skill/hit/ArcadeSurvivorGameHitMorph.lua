-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitMorph.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitMorph", package.seeall)

local ArcadeSurvivorGameHitMorph = class("ArcadeSurvivorGameHitMorph", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitMorph:onCtor(params)
	self._prefabName = params[1]
	self._sizeX = tonumber(params[2])
	self._sizeY = tonumber(params[3])
end

function ArcadeSurvivorGameHitMorph:_onHit(context, caster, targetList, gridIdDict)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	for _, targetMO in ipairs(targetList) do
		local gridX, gridY = targetMO:getGridPos()
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()
		local isCanPlace = ArcadeSurvivorGameModel.instance:isCanPlaceEntity(entityType, uid, gridX, gridY, self._sizeX, self._sizeY)

		if isCanPlace then
			targetMO:setSize(self._sizeX, self._sizeY)

			local entity = scene.entityMgr:getEntity(entityType, uid)

			if entity then
				entity:change2Prefab(self._prefabName)
			end

			ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.RefreshEntityIcon, entityType, uid)
		end
	end
end

return ArcadeSurvivorGameHitMorph
