-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitPushback.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitPushback", package.seeall)

local ArcadeSurvivorGameHitPushback = class("ArcadeSurvivorGameHitPushback", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitPushback:onCtor(params)
	self._distance = tonumber(params[1])
end

function ArcadeSurvivorGameHitPushback:_onHit(context, caster, targetList, gridIdDict)
	local centerGridX, centerGridY = self._selector:getCenterGridPos()

	if not centerGridX or not centerGridY then
		return
	end

	local newGridX, newGridY

	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()
		local gridX, gridY = targetMO:getGridPos()
		local relDir = ArcadeSurvivorGameHelper.getDirectionGridFromGrid(centerGridX, centerGridY, gridX, gridY, true)
		local changeX = (ArcadeSurvivorEnum.DirChangeGridX[relDir] or 0) * self._distance
		local changeY = (ArcadeSurvivorEnum.DirChangeGridY[relDir] or 0) * self._distance

		newGridX = gridX + changeX
		newGridY = gridY + changeY

		ArcadeSurvivorGameController.instance:forceMoveEntity(entityType, uid, newGridX, newGridY, true)
	end
end

return ArcadeSurvivorGameHitPushback
