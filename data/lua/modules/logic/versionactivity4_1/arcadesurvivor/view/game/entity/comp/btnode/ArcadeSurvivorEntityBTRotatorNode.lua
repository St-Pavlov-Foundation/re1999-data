-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTRotatorNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTRotatorNode", package.seeall)

local ArcadeSurvivorEntityBTRotatorNode = class("ArcadeSurvivorEntityBTRotatorNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTRotatorNode:onCtor(param)
	self._curChildIndex = 1
end

function ArcadeSurvivorEntityBTRotatorNode:_onTick()
	local childCount = self:getChildNodeCount()

	if childCount <= 0 then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local childNode = self:getChildNode(self._curChildIndex)
	local status = childNode:tick()

	if status == ArcadeSurvivorGameEnum.BTNodeStatus.Running then
		return status
	end

	self._curChildIndex = self._curChildIndex % childCount + 1

	return status
end

function ArcadeSurvivorEntityBTRotatorNode:onAbort()
	local childNode = self:getChildNode(self._curChildIndex)

	if childNode then
		childNode:abort()
	end

	self._curChildIndex = 1
end

function ArcadeSurvivorEntityBTRotatorNode:_onReset()
	self._curChildIndex = 1
end

return ArcadeSurvivorEntityBTRotatorNode
