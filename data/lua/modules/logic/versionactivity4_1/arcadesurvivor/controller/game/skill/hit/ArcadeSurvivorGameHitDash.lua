-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitDash.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitDash", package.seeall)

local ArcadeSurvivorGameHitDash = class("ArcadeSurvivorGameHitDash", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitDash:onCtor(params)
	self._distance = tonumber(params[1])
end

function ArcadeSurvivorGameHitDash:_onHit(context, caster, targetList, gridIdDict)
	local newGridX, newGridY

	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()
		local direction = targetMO:getDirection()
		local changeX = (ArcadeSurvivorEnum.DirChangeGridX[direction] or 0) * self._distance
		local changeY = (ArcadeSurvivorEnum.DirChangeGridY[direction] or 0) * self._distance
		local gridX, gridY = targetMO:getGridPos()

		newGridX = gridX + changeX
		newGridY = gridY + changeY

		ArcadeSurvivorGameController.instance:forceMoveEntity(entityType, uid, newGridX, newGridY, true)
	end
end

return ArcadeSurvivorGameHitDash
