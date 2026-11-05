-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTMoveNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTMoveNode", package.seeall)

local ArcadeSurvivorEntityBTMoveNode = class("ArcadeSurvivorEntityBTMoveNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTMoveNode:_onTick()
	local mo = self:getMO()

	if not mo or not mo:getIsAlive() then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local targetGridX, targetGridY = mo:getNextMoveGrid()

	if not targetGridX or not targetGridY then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local isMoved = ArcadeSurvivorGameController.instance:moveEntity(mo:getEntityType(), mo:getUid(), targetGridX, targetGridY, true)

	if not isMoved then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Success
end

return ArcadeSurvivorEntityBTMoveNode
