-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitChangeGrid.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitChangeGrid", package.seeall)

local ArcadeSurvivorGameHitChangeGrid = class("ArcadeSurvivorGameHitChangeGrid", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitChangeGrid:onCtor(params)
	self._floorId = tonumber(params[1])
end

function ArcadeSurvivorGameHitChangeGrid:_onHit(context, caster, targetList, gridIdDict)
	for _, targetMO in ipairs(targetList) do
		local gridX, gridY = targetMO:getGridPos()

		ArcadeSurvivorGameController.instance:replaceFloor(self._floorId, gridX, gridY)
	end
end

return ArcadeSurvivorGameHitChangeGrid
