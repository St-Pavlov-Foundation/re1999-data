-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitFlop.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitFlop", package.seeall)

local ArcadeSurvivorGameHitFlop = class("ArcadeSurvivorGameHitFlop", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitFlop:_onHit(context, caster, targetList, gridIdDict)
	local model = ArcadeSurvivorGameModel.instance
	local characterMO = model:getCharacterMO()

	if not caster or caster:getEntityType() ~= ArcadeSurvivorEnum.EntityType.Floor or not characterMO or not characterMO:getIsAlive() or characterMO:getIsOffBoard() then
		return
	end

	local isTarget = false

	for _, targetMO in ipairs(targetList or {}) do
		if targetMO == characterMO then
			isTarget = true

			break
		end
	end

	if not isTarget then
		return
	end

	local direction = characterMO:getTurnMoveDirection()
	local dx = ArcadeSurvivorEnum.DirChangeGridX[direction]
	local dy = ArcadeSurvivorEnum.DirChangeGridY[direction]

	if not dx or not dy or dx == 0 and dy == 0 then
		return
	end

	local gridX, gridY = characterMO:getGridPos()
	local floorLayer = ArcadeSurvivorGameEnum.EntityLayer.Floor
	local floorData = model:getEntityDataInGrid(gridX, gridY, floorLayer)
	local floorMO = floorData and model:getEntityMO(ArcadeSurvivorEnum.EntityType.Floor, floorData.uid)

	if floorMO ~= caster then
		return
	end

	local entityType, uid = characterMO:getEntityType(), characterMO:getUid()
	local sizeX, sizeY = characterMO:getSize()
	local skillId = self:getSkillId()
	local targetX, targetY = gridX, gridY

	while true do
		local nextX, nextY = targetX + dx, targetY + dy

		if not model:isCanPlaceEntity(entityType, uid, nextX, nextY, sizeX, sizeY) then
			break
		end

		local nextFloorData = model:getEntityDataInGrid(nextX, nextY, floorLayer)
		local nextFloor = nextFloorData and model:getEntityMO(ArcadeSurvivorEnum.EntityType.Floor, nextFloorData.uid)

		if not nextFloor or not nextFloor:getIsAlive() or not nextFloor:hasSkill(skillId) then
			break
		end

		targetX, targetY = nextX, nextY
	end

	if targetX ~= gridX or targetY ~= gridY then
		ArcadeSurvivorGameController.instance:moveEntity(entityType, uid, targetX, targetY, true)
	end
end

return ArcadeSurvivorGameHitFlop
